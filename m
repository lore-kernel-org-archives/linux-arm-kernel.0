From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 23 Aug 2012 09:10:28 +0300
Subject: [v2 3/4] ARM: dma-mapping: Refactor out to introduce
 __alloc_fill_pages
In-Reply-To: <1345702229-9539-1-git-send-email-hdoyu@nvidia.com>
References: <1345702229-9539-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1345702229-9539-4-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__alloc_fill_pages() allocates power of 2 page number allocation at
most repeatedly.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |   50 ++++++++++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b64475a..7ab016b 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1022,20 +1022,11 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 	spin_unlock_irqrestore(&mapping->lock, flags);
 }
 
-static struct page **__iommu_alloc_buffer(struct device *dev, size_t size, gfp_t gfp)
+static int __alloc_fill_pages(struct page ***ppages, int count, gfp_t gfp)
 {
-	struct page **pages;
-	int count = size >> PAGE_SHIFT;
-	int array_size = count * sizeof(struct page *);
+	struct page **pages = *ppages;
 	int i = 0;
 
-	if ((array_size <= PAGE_SIZE) || (gfp & GFP_ATOMIC))
-		pages = kzalloc(array_size, gfp);
-	else
-		pages = vzalloc(array_size);
-	if (!pages)
-		return NULL;
-
 	while (count) {
 		int j, order = __fls(count);
 
@@ -1045,22 +1036,49 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size, gfp_t
 		if (!pages[i])
 			goto error;
 
-		if (order)
+		if (order) {
 			split_page(pages[i], order);
-		j = 1 << order;
-		while (--j)
-			pages[i + j] = pages[i] + j;
+			j = 1 << order;
+			while (--j)
+				pages[i + j] = pages[i] + j;
+		}
 
 		__dma_clear_buffer(pages[i], PAGE_SIZE << order);
 		i += 1 << order;
 		count -= 1 << order;
 	}
 
-	return pages;
+	return 0;
+
 error:
 	while (i--)
 		if (pages[i])
 			__free_pages(pages[i], 0);
+	return -ENOMEM;
+}
+
+static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
+					  gfp_t gfp)
+{
+	struct page **pages;
+	int count = size >> PAGE_SHIFT;
+	int array_size = count * sizeof(struct page *);
+	int err;
+
+	if ((array_size <= PAGE_SIZE) || (gfp & GFP_ATOMIC))
+		pages = kzalloc(array_size, gfp);
+	else
+		pages = vzalloc(array_size);
+	if (!pages)
+		return NULL;
+
+	err = __alloc_fill_pages(&pages, count, gfp);
+	if (err)
+		goto error
+
+	return pages;
+
+error:
 	if ((array_size <= PAGE_SIZE) || (gfp & GFP_ATOMIC))
 		kfree(pages);
 	else
-- 
1.7.5.4
