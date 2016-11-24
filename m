From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu, 24 Nov 2016 16:10:24 +0000
Subject: [kvm-unit-tests PATCH v7 02/11] run_tests: allow disabling of timeouts
In-Reply-To: <20161124161033.11456-1-alex.bennee@linaro.org>
References: <20161124161033.11456-1-alex.bennee@linaro.org>
Message-ID: <20161124161033.11456-3-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certainly during development of the tests and MTTCG there are times when
the timeout just gets in the way.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 run_tests.sh         | 8 ++++++--
 scripts/runtime.bash | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/run_tests.sh b/run_tests.sh
index b88c36f..4f2e5cb 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -13,10 +13,11 @@ function usage()
 {
 cat <<EOF
 
-Usage: $0 [-g group] [-a accel] [-h] [-v]
+Usage: $0 [-g group] [-a accel] [-t] [-h] [-v]
 
     -g: Only execute tests in the given group
     -a: Force acceleration mode (tcg/kvm)
+    -t: disable timeouts
     -h: Output this help text
     -v: Enables verbose mode
 
@@ -29,7 +30,7 @@ EOF
 RUNTIME_arch_run="./$TEST_DIR/run"
 source scripts/runtime.bash
 
-while getopts "g:a:hv" opt; do
+while getopts "g:a:thv" opt; do
     case $opt in
         g)
             only_group=$OPTARG
@@ -37,6 +38,9 @@ while getopts "g:a:hv" opt; do
         a)
             force_accel=$OPTARG
             ;;
+        t)
+            no_timeout="yes"
+            ;;
         h)
             usage
             exit
diff --git a/scripts/runtime.bash b/scripts/runtime.bash
index 578cf32..968ff6d 100644
--- a/scripts/runtime.bash
+++ b/scripts/runtime.bash
@@ -79,6 +79,10 @@ function run()
         accel=$force_accel
     fi
 
+    if [ "$no_timeout" = "yes" ]; then
+        timeout=""
+    fi
+
     if [ -n "$arch" ] && [ "$arch" != "$ARCH" ]; then
         echo "`SKIP` $1 ($arch only)"
         return 2
-- 
2.10.1
