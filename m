From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 14 Apr 2015 15:53:09 -0700
Subject: [PATCH 6/7] selftests/x86: install tests
Message-ID: <1429051989-14821-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set TEST_PROGS so that the required binaries are installed. Skip the install
and test case when ARCH != x86.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/x86/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 7be67a0..1abe3f6 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -24,6 +24,10 @@ all_32: check_build32 $(BINARIES_32)
 
 all_64: $(BINARIES_64)
 
+include ../lib.mk
+
+TEST_PROGS := $(BINARIES_32) $(BINARIES_64) run_x86_tests.sh
+
 $(TARGETS_C_BOTHBITS:%=%_32): %_32: %.c
 ifeq ($(ARCH),x86)
 	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
@@ -52,6 +56,12 @@ check_build32:
 	  exit 1;							\
 	fi
 
+install:
+ifneq ($(ARCH),x86)
+echo "Not an x86 target, can't install x86 tests"
+override EMIT_TESTS :=  echo "echo \"selftests: run_x86_tests.sh [SKIP]\""
+endif
+
 run_tests:
 	./run_x86_tests.sh
 
-- 
2.1.0
