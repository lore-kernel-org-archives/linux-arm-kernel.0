From: tyler.baker@linaro.org (Tyler Baker)
Date: Mon, 20 Apr 2015 16:15:43 -0700
Subject: [PATCH v3 6/8] selftest/x86: have no dependency on all when cross
 building
Message-ID: <1429571743-27740-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the CROSS_COMPILE is set remove all's dependency on all_32 and all_64.

Cc: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/x86/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index be93945..a5ca38b 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -7,15 +7,21 @@ BINARIES_64 := $(TARGETS_C_BOTHBITS:%=%_64)
 
 CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
 
+all:
+
 UNAME_M := $(shell uname -m)
 
+ifeq ($(CROSS_COMPILE),)
 # Always build 32-bit tests
 all: all_32
-
 # If we're on a 64-bit host, build 64-bit tests as well
 ifeq ($(UNAME_M),x86_64)
 all: all_64
 endif
+else
+# No dependency on all when cross building
+all:
+endif
 
 all_32: check_build32 $(BINARIES_32)
 
-- 
2.1.4
