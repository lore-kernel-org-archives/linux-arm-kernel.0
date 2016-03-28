From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 28 Mar 2016 14:32:11 +0800
Subject: [PATCH v2 1/2] dma/iommu: Add pgsize_bitmap confirmation in
 __iommu_dma_alloc_pages
Message-ID: <1459146732-15620-1-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently __iommu_dma_alloc_pages assumes that all the IOMMU support
the granule of PAGE_SIZE. It call alloc_page to try allocating memory
in the last time. Fortunately the mininum pagesize in all the
current IOMMU is SZ_4K, so this works well.

But there may be a case in which the mininum granule of IOMMU may be
larger than PAGE_SIZE, then it will abort as the IOMMU cann't map the
discontinuous memory within a granule. For example, the pgsize_bitmap
of the IOMMU only has SZ_16K while the PAGE_SIZE is SZ_4K, then we
have to prepare SZ_16K continuous memory at least for each a granule
iommu mapping.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>

---
v2:
 -rebase on v4.6-rc1.
 -add a new patch([1/2] add pgsize_bitmap) here.

 drivers/iommu/dma-iommu.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 72d6182..75ce71e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -190,11 +190,13 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
 	kvfree(pages);
 }
 
-static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
+static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp,
+					     unsigned long pgsize_bitmap)
 {
 	struct page **pages;
 	unsigned int i = 0, array_size = count * sizeof(*pages);
-	unsigned int order = MAX_ORDER;
+	int min_order = get_order(1 << __ffs(pgsize_bitmap));
+	int order = MAX_ORDER;
 
 	if (array_size <= PAGE_SIZE)
 		pages = kzalloc(array_size, GFP_KERNEL);
@@ -213,13 +215,16 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
 		/*
 		 * Higher-order allocations are a convenience rather
 		 * than a necessity, hence using __GFP_NORETRY until
-		 * falling back to single-page allocations.
+		 * falling back to min size allocations.
 		 */
-		for (order = min_t(unsigned int, order, __fls(count));
-		     order > 0; order--) {
-			page = alloc_pages(gfp | __GFP_NORETRY, order);
+		for (order = min_t(int, order, __fls(count));
+		     order >= min_order; order--) {
+			page = alloc_pages((order == min_order) ? gfp :
+					   gfp | __GFP_NORETRY, order);
 			if (!page)
 				continue;
+			if (!order)
+				break;
 			if (PageCompound(page)) {
 				if (!split_huge_page(page))
 					break;
@@ -229,8 +234,6 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
 				break;
 			}
 		}
-		if (!page)
-			page = alloc_page(gfp);
 		if (!page) {
 			__iommu_dma_free_pages(pages, i);
 			return NULL;
@@ -292,7 +295,8 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size,
 
 	*handle = DMA_ERROR_CODE;
 
-	pages = __iommu_dma_alloc_pages(count, gfp);
+	pages = __iommu_dma_alloc_pages(count, gfp,
+					domain->ops->pgsize_bitmap);
 	if (!pages)
 		return NULL;
 
-- 
1.8.1.1.dirty
