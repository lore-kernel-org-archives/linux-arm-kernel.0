From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 22 Aug 2012 10:20:53 -0000
Subject: [RFC 1/4] ARM: dma-mapping: Refactor out to introduce
 __alloc_fill_pages
In-Reply-To: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
References: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1345630830-9586-2-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__alloc_fill_pages() allocates power of 2 page number allocation at
most repeatedly.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |   40 ++++++++++++++++++++++++++++------------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7dc61ed..aec0c06 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -988,19 +988,10 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 	spin_unlock_irqrestore(&mapping->lock, flags);
 }
 
-static struct page **__iommu_alloc_buffer(struct device *dev, size_t size, gfp_t gfp)
+static int __alloc_fill_pages(struct page ***ppages, int count, gfp_t gfp)
 {
-	struct page **pages;
-	int count = size >> PAGE_SHIFT;
-	int array_size = count * sizeof(struct page *);
 	int i = 0;
-
-	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, gfp);
-	else
-		pages = vzalloc(array_size);
-	if (!pages)
-		return NULL;
+	struct page **pages = *ppages;
 
 	while (count) {
 		int j, order = __fls(count);
@@ -1022,11 +1013,36 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size, gfp_t
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
+	if (array_size <= PAGE_SIZE)
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
+error:
 	if (array_size <= PAGE_SIZE)
 		kfree(pages);
 	else
-- 
1.7.5.4
