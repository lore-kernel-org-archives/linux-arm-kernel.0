From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  3 Feb 2016 23:15:05 +0100
Subject: [PATCH] mm/debug-pagealloc: add missing debug_pagealloc_enabled
Message-ID: <1454537757-3760706-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change to move the pagealloc logic broke the slab allocator
check when it's disabled at compile time:

mm/slab.c: In function 'is_debug_pagealloc_cache':
mm/slab.c:1608:29: error: implicit declaration of function 'debug_pagealloc_enabled' [-Werror=implicit-function-declaration]

This adds an inline helper to get it to work again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0a244aea1a61 ("mm/slab: clean up DEBUG_PAGEALLOC processing code")
---
 include/linux/mm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5d86eb2e8584..90d600ce56ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2242,6 +2242,7 @@ kernel_map_pages(struct page *page, int numpages, int enable)
 extern bool kernel_page_present(struct page *page);
 #endif /* CONFIG_HIBERNATION */
 #else
+static inline bool debug_pagealloc_enabled(void) { return 0; }
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable) {}
 #ifdef CONFIG_HIBERNATION
-- 
2.7.0
