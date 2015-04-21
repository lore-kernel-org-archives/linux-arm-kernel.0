From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 21 Apr 2015 15:51:33 -0700
Subject: [PATCH v4 4/7] selftest/x86: build both bitnesses
Message-ID: <1429656693-9937-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using uname with the processor flag option in some cases can yield 'unknown'
so lets use the machine flag option as it is deterministic. Add a dependency
for all_32 when building on a x86 64 bit host so that both bitnesses are
built in this case.

Cc: Andy Lutomirski <luto@amacapital.net>
Acked-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/x86/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index ddf6356..be93945 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -7,13 +7,13 @@ BINARIES_64 := $(TARGETS_C_BOTHBITS:%=%_64)
 
 CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
 
-UNAME_P := $(shell uname -p)
+UNAME_M := $(shell uname -m)
 
 # Always build 32-bit tests
 all: all_32
 
 # If we're on a 64-bit host, build 64-bit tests as well
-ifeq ($(shell uname -p),x86_64)
+ifeq ($(UNAME_M),x86_64)
 all: all_64
 endif
 
-- 
2.1.4
