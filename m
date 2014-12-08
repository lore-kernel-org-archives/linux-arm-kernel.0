From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 8 Dec 2014 17:59:46 +0800
Subject: [PATCH V3] mm:add VM_BUG_ON_PAGE() for page_mapcount()
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E688B313F9@CNBJMBX05.corpusers.net>
References: <010b01d012ca$05244060$0f6cc120$@alibaba-inc.com>
 <35FD53F367049845BC99AC72306C23D103E688B313F9@CNBJMBX05.corpusers.net>
Message-ID: <35FD53F367049845BC99AC72306C23D103E688B313FA@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add VM_BUG_ON_PAGE() for slab page,
because _mapcount is an union with slab struct in struct page,
avoid access _mapcount if this page is a slab page.
Also remove the unneeded bracket.

Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
---
 include/linux/mm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b464611..a117527 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -449,7 +449,8 @@ static inline void page_mapcount_reset(struct page *page)
 
 static inline int page_mapcount(struct page *page)
 {
-	return atomic_read(&(page)->_mapcount) + 1;
+	VM_BUG_ON_PAGE(PageSlab(page), page);
+	return atomic_read(&page->_mapcount) + 1;
 }
 
 static inline int page_count(struct page *page)
-- 
2.1.3
