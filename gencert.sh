#!/bin/sh
set -e
# macOS's LibreSSL doesn't come with a openssl.crf that supports the ca command
# you could copy the config file, or you could just use Homebrew's OpenSSL
OPENSSL="/usr/local/Cellar/openssl@3/3.0.7/bin/openssl"
rm -r demoCA || true
mkdir -p demoCA/newcerts || true
echo 01 > demoCA/serial
touch demoCA/index.txt
"$OPENSSL" req -newkey rsa:1024 -keyout key.pem -out req.pem -sha256 -nodes -subj "/C=CA/ST=BC/O=Worth Doing Badly/CN=Worth Doing Badly DDI"
"$OPENSSL" ca -batch -selfsign -keyfile key.pem -in req.pem -out cert.pem -startdate 070416225531Z -enddate 140416225531Z