From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Apr 2015 11:46:55 +0200
Subject: [PATCH] mempool: add missing include
Message-ID: <3302342.cNyRUGN06P@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a fix^3 for the mempool poisoning patch, which introduces
a compile-time error on some ARM randconfig builds:

mm/mempool.c: In function 'check_element':
mm/mempool.c:65:16: error: implicit declaration of function 'kmap_atomic' [-Werror=implicit-function-declaration]
   void *addr = kmap_atomic((struct page *)element);

The problem is clearly the missing declaration, and including
linux/highmem.h fixes it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: a3db5a8463b0db ("mm, mempool: poison elements backed by page allocator fix fix")

diff --git a/mm/mempool.c b/mm/mempool.c
index 05ad55e61264..5e7c4a871391 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/kasan.h>
+#include <linux/highmem.h>
 #include <linux/kmemleak.h>
 #include <linux/export.h>
 #include <linux/mempool.h>
