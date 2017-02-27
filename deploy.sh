#!/bin/bash

set -e

if [[ "${TRAVIS_PULL_REQUEST}" == "false" ]]; then
  echo -e "Host github.com\n\tStrictHostKeyChecking no\nIdentityFile ~/.ssh/deploy.key\n" >> ~/.ssh/config
  openssl aes-256-cbc -k "$SERVER_KEY" -in deploy_key.enc -d -a -out deploy.key
  cp deploy.key ~/.ssh/
  chmod 600 ~/.ssh/deploy.key
  git config --global user.email "m@yyu.pw"
  git config --global user.name "Yoshimura Yuu"
  git add dist/shapeless-guide.pdf
  git commit -m "auto commit on travis $TRAVIS_JOB_NUMBER $TRAVIS_COMMIT [ci skip]"
  git push git@github.com:y-yu/shapeless-guide.git develop:develop
fi
