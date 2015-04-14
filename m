From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 14 Apr 2015 15:51:34 -0700
Subject: [PATCH 3/7] selftests/breakpoints: emit skip and omit installation
 when tests are not compiled
Message-ID: <1429051894-14687-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The breakpoints test should only should be executed on x86 targets, so lets
emit a skip and omit the installation when ARCH != x86.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/breakpoints/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/Makefile b/tools/testing/selftests/breakpoints/Makefile
index 1822356..430b76d 100644
--- a/tools/testing/selftests/breakpoints/Makefile
+++ b/tools/testing/selftests/breakpoints/Makefile
@@ -8,7 +8,6 @@ ifeq ($(ARCH),x86_64)
 	ARCH := x86
 endif
 
-
 all:
 ifeq ($(ARCH),x86)
 	gcc breakpoint_test.c -o breakpoint_test
@@ -20,5 +19,11 @@ TEST_PROGS := breakpoint_test
 
 include ../lib.mk
 
+install:
+ifneq ($(ARCH),x86)
+echo "Not an x86 target, can't install breakpoints selftests"
+override EMIT_TESTS :=  echo "echo \"selftests: breakpoint_test [SKIP]\""
+endif
+
 clean:
 	rm -fr breakpoint_test
-- 
2.1.0
