#!/bin/bash -ex

export HOME=/home/ec2-user
yum update -y
yum install -y gcc libxml2 libxml2-devel libxslt libxslt-devel
yum install -y ruby-devel sqlite-devel
yum install -y gcc-c++
yum install -y ImageMagick-devel ImageMagick-c++-devel
yum install -y patch
gem install bundler
curl -o /tmp/spl11.tar.gz https://s3.amazonaws.com/us-east-1-aws-training/self-paced-lab-11/rails-app/spl11v2.tar.gz
tar xfz /tmp/spl11.tar.gz -C /home/ec2-user/
cd /home/ec2-user/spl11/
gem install io-console
/usr/local/bin/bundle update rdoc
/usr/local/bin/bundle install
/usr/local/bin/bundle exec bin/rake db:migrate
cat > /home/ec2-user/spl11/tmp/creds.yml << EOF
region: us-west1
bucket_name: 12.3.medialab
table_name: 12.3.medialab
EOF
/usr/local/bin/bundle exec bin/rails s -b 0.0.0.0 -p 80
