From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 23 Aug 2012 09:10:29 +0300
Subject: [v2 4/4] ARM: dma-mapping: IOMMU allocates pages from atomic_pool
 with GFP_ATOMIC
In-Reply-To: <1345702229-9539-1-git-send-email-hdoyu@nvidia.com>
References: <1345702229-9539-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1345702229-9539-5-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Makes use of the same atomic pool from DMA, and skips kernel page
mapping which can involve sleep'able operations at allocating a kernel
page table.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7ab016b..433312a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1063,7 +1063,6 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	struct page **pages;
 	int count = size >> PAGE_SHIFT;
 	int array_size = count * sizeof(struct page *);
-	int err;
 
 	if ((array_size <= PAGE_SIZE) || (gfp & GFP_ATOMIC))
 		pages = kzalloc(array_size, gfp);
@@ -1072,9 +1071,20 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	if (!pages)
 		return NULL;
 
-	err = __alloc_fill_pages(&pages, count, gfp);
-	if (err)
-		goto error
+	if (gfp & GFP_ATOMIC) {
+		struct page *page;
+		int i;
+		void *addr = __alloc_from_pool(size, &page);
+		if (!addr)
+			goto error;
+
+		for (i = 0; i < count; i++)
+			pages[i] = page + i;
+	} else {
+		int err = __alloc_fill_pages(&pages, count, gfp);
+		if (err)
+			goto error;
+	}
 
 	return pages;
 
@@ -1091,9 +1101,15 @@ static int __iommu_free_buffer(struct device *dev, struct page **pages, size_t s
 	int count = size >> PAGE_SHIFT;
 	int array_size = count * sizeof(struct page *);
 	int i;
+
+	if (__free_from_pool(page_address(pages[0]), size))
+		goto out;
+
 	for (i = 0; i < count; i++)
 		if (pages[i])
 			__free_pages(pages[i], 0);
+
+out:
 	if ((array_size <= PAGE_SIZE) ||
 	    __in_atomic_pool(page_address(pages[0]), size))
 		kfree(pages);
@@ -1221,6 +1237,9 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	if (*handle == DMA_ERROR_CODE)
 		goto err_buffer;
 
+	if (gfp & GFP_ATOMIC)
+		return page_address(pages[0]);
+
 	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
 		return pages;
 
@@ -1279,7 +1298,8 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		return;
 	}
 
-	if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs)) {
+	if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs) ||
+	    !__in_atomic_pool(cpu_addr, size)) {
 		unmap_kernel_range((unsigned long)cpu_addr, size);
 		vunmap(cpu_addr);
 	}
-- 
1.7.5.4
