From: minchan@kernel.org (Minchan Kim)
Date: Fri, 11 May 2012 16:03:58 +0900
Subject: [PATCH] ARM: use common utility function in dma
Message-ID: <1336719838-11087-1-git-send-email-minchan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mm provides alloc_pages_exact so use it instead of open coded hack.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/arm/mm/dma-mapping.c |   23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b982602..98c9bbd 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -184,20 +184,12 @@ static void __dma_clear_buffer(struct page *page, size_t size)
  */
 static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gfp)
 {
-	unsigned long order = get_order(size);
-	struct page *page, *p, *e;
-
-	page = alloc_pages(gfp, order);
-	if (!page)
+	struct page *page;
+	void *addr = alloc_pages_exact(size, gfp);
+	if (!addr)
 		return NULL;
 
-	/*
-	 * Now split the huge page and free the excess pages
-	 */
-	split_page(page, order);
-	for (p = page + (size >> PAGE_SHIFT), e = page + (1 << order); p < e; p++)
-		__free_page(p);
-
+	page = virt_to_page(addr);
 	__dma_clear_buffer(page, size);
 
 	return page;
@@ -208,12 +200,7 @@ static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gf
  */
 static void __dma_free_buffer(struct page *page, size_t size)
 {
-	struct page *e = page + (size >> PAGE_SHIFT);
-
-	while (page < e) {
-		__free_page(page);
-		page++;
-	}
+	free_pages_exact(page_address(page), size);
 }
 
 #ifdef CONFIG_MMU
-- 
1.7.9.5
