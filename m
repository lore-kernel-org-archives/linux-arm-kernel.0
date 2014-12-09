From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Tue, 9 Dec 2014 14:39:23 +0800
Subject: [PATCH V3] fix build error for vm tools
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E688B313FD@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E688B313FC@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E688B313FD@CNBJMBX05.corpusers.net>
Message-ID: <35FD53F367049845BC99AC72306C23D103E688B313FF@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the build error when make like this:
make O=/xx/x vm

use $(OUTPUT) to generate to the right place.

Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
---
 tools/lib/api/Makefile |  2 +-
 tools/vm/Makefile      | 14 +++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 36c08b1..a1c598d 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -44,6 +44,6 @@ $(OUTPUT)%.o: %.S libapi_dirs
 	$(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<
 
 clean:
-	$(call QUIET_CLEAN, libapi) $(RM) $(LIB_OBJS) $(LIBFILE)
+	$(call QUIET_CLEAN, libapi) $(RM) $(LIB_OBJS) $(OUTPUT)$(LIBFILE)
 
 .PHONY: clean
diff --git a/tools/vm/Makefile b/tools/vm/Makefile
index 3d907da..7e3fc9f 100644
--- a/tools/vm/Makefile
+++ b/tools/vm/Makefile
@@ -1,22 +1,26 @@
 # Makefile for vm tools
 #
+include ../scripts/Makefile.include
 TARGETS=page-types slabinfo
 
 LIB_DIR = ../lib/api
-LIBS = $(LIB_DIR)/libapikfs.a
+LIBS = $(OUTPUT)../lib/api/libapikfs.a
 
 CC = $(CROSS_COMPILE)gcc
 CFLAGS = -Wall -Wextra -I../lib/
 LDFLAGS = $(LIBS)
 
+all: $(TARGETS)
 $(TARGETS): $(LIBS)
 
 $(LIBS):
-	make -C $(LIB_DIR)
+	$(call descend,../lib/api libapikfs.a)
 
 %: %.c
-	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
+	$(CC) $(CFLAGS) -o $(OUTPUT)$@ $< $(LDFLAGS)
 
 clean:
-	$(RM) page-types slabinfo
-	make -C $(LIB_DIR) clean
+	$(RM) $(OUTPUT)page-types $(OUTPUT)slabinfo
+	$(call descend,../lib/api clean)
+
+.PHONY: all clean
-- 
2.1.3
