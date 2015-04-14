From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 14 Apr 2015 15:52:58 -0700
Subject: [PATCH 5/7] selftests/x86: fix cross build logic
Message-ID: <1429051978-14778-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

x86 tests should not be built when ARCH != x86. Reused the logic from
breakpoints to determine when it's appropriate to build.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/x86/Makefile | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index f0a7918..7be67a0 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -7,31 +7,36 @@ BINARIES_64 := $(TARGETS_C_BOTHBITS:%=%_64)
 
 CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
 
-UNAME_P := $(shell uname -p)
-
-# Always build 32-bit tests
+# Taken from perf makefile
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
+ifeq ($(ARCH),i386)
+ARCH := x86
 all: all_32
-
+endif
+ifeq ($(ARCH),x86_64)
+ARCH := x86
 # If we're on a 64-bit host, build 64-bit tests as well
-ifeq ($(shell uname -p),x86_64)
-all: all_64
+all: all_32 all_64
 endif
 
 all_32: check_build32 $(BINARIES_32)
 
 all_64: $(BINARIES_64)
 
-clean:
-	$(RM) $(BINARIES_32) $(BINARIES_64)
-
-run_tests:
-	./run_x86_tests.sh
-
 $(TARGETS_C_BOTHBITS:%=%_32): %_32: %.c
+ifeq ($(ARCH),x86)
 	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
+else
+	echo "Not an x86 target, can't build x86 tests"
+endif
 
 $(TARGETS_C_BOTHBITS:%=%_64): %_64: %.c
+ifeq ($(ARCH),x86)
 	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
+else
+	echo "Not an x86 target, can't build x86 tests"
+endif
 
 check_build32:
 	@if ! $(CC) -m32 -o /dev/null trivial_32bit_program.c; then	\
@@ -46,3 +51,9 @@ check_build32:
 	  echo "  yum install glibc-devel.*i686";			\
 	  exit 1;							\
 	fi
+
+run_tests:
+	./run_x86_tests.sh
+
+clean:
+	$(RM) $(BINARIES_32) $(BINARIES_64)
-- 
2.1.0
