From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Tue, 9 Dec 2014 11:36:17 +0800
Subject: [PATCH] fix build error for vm tools
Message-ID: <35FD53F367049845BC99AC72306C23D103E688B313FC@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the build error when make like this:
make O=/xx/x vm

use $(OUTPUT) to generate to the right place.

Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
---
 tools/vm/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/vm/Makefile b/tools/vm/Makefile
index 3d907da..28d4bd9 100644
--- a/tools/vm/Makefile
+++ b/tools/vm/Makefile
@@ -1,9 +1,10 @@
 # Makefile for vm tools
 #
+include ../scripts/Makefile.include
 TARGETS=page-types slabinfo
 
 LIB_DIR = ../lib/api
-LIBS = $(LIB_DIR)/libapikfs.a
+LIBS = $(OUTPUT)../lib/api/libapikfs.a
 
 CC = $(CROSS_COMPILE)gcc
 CFLAGS = -Wall -Wextra -I../lib/
@@ -12,11 +13,11 @@ LDFLAGS = $(LIBS)
 $(TARGETS): $(LIBS)
 
 $(LIBS):
-	make -C $(LIB_DIR)
+	$(call descend,../lib/api libapikfs.a)
 
 %: %.c
-	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
+	$(CC) $(CFLAGS) -o $(OUTPUT)$@ $< $(LDFLAGS)
 
 clean:
-	$(RM) page-types slabinfo
+	$(RM) $(OUTPUT)page-types $(OUTPUT)slabinfo
 	make -C $(LIB_DIR) clean
-- 
2.1.3
