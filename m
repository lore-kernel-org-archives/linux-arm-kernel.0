From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 17 Apr 2015 15:01:49 -0700
Subject: [PATCH v2 6/8] selftest/x86: have no dependency on all when cross
 building
Message-ID: <1429308109-5133-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the CROSS_COMPILE is set have no dependency on all.

Cc: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/x86/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 57090ad..9962e10 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -9,13 +9,17 @@ CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
 
 UNAME_M := $(shell uname -m)
 
+ifeq ($(CROSS_COMPILE),)
 # Always build 32-bit tests
 all: all_32
-
 # If we're on a 64-bit host, build 64-bit tests as well
 ifeq ($(UNAME_M),x86_64)
 all: all_32 all_64
 endif
+else
+# No dependency on all when cross building
+all:
+endif
 
 all_32: check_build32 $(BINARIES_32)
 
-- 
2.1.4
