From: tyler.baker@linaro.org (Tyler Baker)
Date: Mon, 20 Apr 2015 16:15:58 -0700
Subject: [PATCH v3 7/8] selftest/x86: install tests
Message-ID: <1429571758-28009-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include lib.mk and set TEST_PROGS where appropriate. Skip the install and test
case when CROSS_COMPILE is not set.

Cc: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/x86/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index a5ca38b..d539b44 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -14,19 +14,28 @@ UNAME_M := $(shell uname -m)
 ifeq ($(CROSS_COMPILE),)
 # Always build 32-bit tests
 all: all_32
+# Install 32-bit tests
+TEST_PROGS += $(BINARIES_32) run_x86_tests.sh
 # If we're on a 64-bit host, build 64-bit tests as well
 ifeq ($(UNAME_M),x86_64)
 all: all_64
+# Install 64-bit tests
+TEST_PROGS += $(BINARIES_64)
 endif
 else
 # No dependency on all when cross building
 all:
+# Skip install and test case when not built
+override INSTALL_RULE :=
+override EMIT_TESTS :=  echo "echo \"selftests: run_x86_tests.sh [SKIP]\""
 endif
 
 all_32: check_build32 $(BINARIES_32)
 
 all_64: $(BINARIES_64)
 
+include ../lib.mk
+
 clean:
 	$(RM) $(BINARIES_32) $(BINARIES_64)
 
-- 
2.1.4
