From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun,  5 Aug 2012 20:32:06 +0300
Subject: [PATCH] ARM: dma-mapping: fix atomic allocation alignment
Message-ID: <1344187926-22404-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The alignment mask is calculated incorrectly. Fixing the calculation
makes strange hangs/lockups disappear during the boot with Amstrad E3
and 3.6-rc1 kernel.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mm/dma-mapping.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 2cc77b7..0e0466d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -423,7 +423,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 	unsigned int pageno;
 	unsigned long flags;
 	void *ptr = NULL;
-	size_t align;
+	unsigned long align_mask;
 
 	if (!pool->vaddr) {
 		WARN(1, "coherent pool not initialised!\n");
@@ -435,11 +435,11 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 	 * small, so align them to their order in pages, minimum is a page
 	 * size. This helps reduce fragmentation of the DMA space.
 	 */
-	align = PAGE_SIZE << get_order(size);
+	align_mask = (1 << get_order(size)) - 1;
 
 	spin_lock_irqsave(&pool->lock, flags);
 	pageno = bitmap_find_next_zero_area(pool->bitmap, pool->nr_pages,
-					    0, count, (1 << align) - 1);
+					    0, count, align_mask);
 	if (pageno < pool->nr_pages) {
 		bitmap_set(pool->bitmap, pageno, count);
 		ptr = pool->vaddr + PAGE_SIZE * pageno;
-- 
1.7.2.5
