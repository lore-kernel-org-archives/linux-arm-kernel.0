From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 8 Dec 2014 15:47:47 +0800
Subject: [PATCH] mm:add VM_BUG_ON() for page_mapcount()
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E688B313F1@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E688B313EE@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E688B313F1@CNBJMBX05.corpusers.net>
Message-ID: <35FD53F367049845BC99AC72306C23D103E688B313F5@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add VM_BUG_ON() for slab page,
because _mapcount is an union with slab struct in struct page,
avoid access _mapcount if this page is a slab page.
Also remove the unneeded bracket.

Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
---
 include/linux/mm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 11b65cf..34124c4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -373,7 +373,8 @@ static inline void reset_page_mapcount(struct page *page)
 
 static inline int page_mapcount(struct page *page)
 {
-	return atomic_read(&(page)->_mapcount) + 1;
+	VM_BUG_ON(PageSlab(page));
+	return atomic_read(&page->_mapcount) + 1;
 }
 
 static inline int page_count(struct page *page)
-- 
2.1.3
