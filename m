From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu, 24 Nov 2016 16:10:23 +0000
Subject: [kvm-unit-tests PATCH v7 01/11] run_tests: allow forcing of
 acceleration mode
In-Reply-To: <20161124161033.11456-1-alex.bennee@linaro.org>
References: <20161124161033.11456-1-alex.bennee@linaro.org>
Message-ID: <20161124161033.11456-2-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While tests can be pegged to tcg it is useful to override this from time
to time, especially when testing correctness on real systems.
---
 run_tests.sh         | 8 ++++++--
 scripts/runtime.bash | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/run_tests.sh b/run_tests.sh
index 254129d..b88c36f 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -13,9 +13,10 @@ function usage()
 {
 cat <<EOF
 
-Usage: $0 [-g group] [-h] [-v]
+Usage: $0 [-g group] [-a accel] [-h] [-v]
 
     -g: Only execute tests in the given group
+    -a: Force acceleration mode (tcg/kvm)
     -h: Output this help text
     -v: Enables verbose mode
 
@@ -28,11 +29,14 @@ EOF
 RUNTIME_arch_run="./$TEST_DIR/run"
 source scripts/runtime.bash
 
-while getopts "g:hv" opt; do
+while getopts "g:a:hv" opt; do
     case $opt in
         g)
             only_group=$OPTARG
             ;;
+        a)
+            force_accel=$OPTARG
+            ;;
         h)
             usage
             exit
diff --git a/scripts/runtime.bash b/scripts/runtime.bash
index 11a40a9..578cf32 100644
--- a/scripts/runtime.bash
+++ b/scripts/runtime.bash
@@ -75,6 +75,10 @@ function run()
         return;
     fi
 
+    if [ -n "$force_accel" ]; then
+        accel=$force_accel
+    fi
+
     if [ -n "$arch" ] && [ "$arch" != "$ARCH" ]; then
         echo "`SKIP` $1 ($arch only)"
         return 2
-- 
2.10.1
