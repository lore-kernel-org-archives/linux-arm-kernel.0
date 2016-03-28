From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 28 Mar 2016 14:32:12 +0800
Subject: [PATCH v2 2/2] arm64/dma-mapping: Add DMA_ATTR_ALLOC_SINGLE_PAGES
 support
In-Reply-To: <1459146732-15620-1-git-send-email-yong.wu@mediatek.com>
References: <1459146732-15620-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1459146732-15620-2-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes it is not worth for the iommu allocating big chunks.
Here we enable DMA_ATTR_ALLOC_SINGLE_PAGES which could help avoid
to allocate big chunks while iommu allocating buffer.

More information about this attribute, please check Doug's
commit df05c6f6e0bb ("ARM: 8506/1: common: DMA-mapping:
add DMA_ATTR_ALLOC_SINGLE_PAGES attribute")

Cc: Robin Murphy <robin.murphy@arm.com>
Suggested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>

---
 Our video driver may use this soon.

 arch/arm64/mm/dma-mapping.c |  4 ++--
 drivers/iommu/dma-iommu.c   | 12 +++++++++---
 include/linux/dma-iommu.h   |  4 ++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a6e757c..5b104fe 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -562,8 +562,8 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		struct page **pages;
 		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
 
-		pages = iommu_dma_alloc(dev, iosize, gfp, ioprot, handle,
-					flush_page);
+		pages = iommu_dma_alloc(dev, iosize, gfp, ioprot, attrs,
+					handle, flush_page);
 		if (!pages)
 			return NULL;
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 75ce71e..c77ef66 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -191,6 +191,7 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
 }
 
 static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp,
+					     struct dma_attrs *attrs,
 					     unsigned long pgsize_bitmap)
 {
 	struct page **pages;
@@ -205,6 +206,10 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp,
 	if (!pages)
 		return NULL;
 
+	/* Go straight to min_order if caller need SINGLE_PAGES */
+	if (dma_get_attr(DMA_ATTR_ALLOC_SINGLE_PAGES, attrs))
+		order = min_order;
+
 	/* IOMMU can map any pages, so himem can also be used here */
 	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
 
@@ -271,6 +276,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  * @size: Size of buffer in bytes
  * @gfp: Allocation flags
  * @prot: IOMMU mapping flags
+ * @attrs: DMA attributes flags
  * @handle: Out argument for allocated DMA handle
  * @flush_page: Arch callback which must ensure PAGE_SIZE bytes from the
  *		given VA/PA are visible to the given non-coherent device.
@@ -281,8 +287,8 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  * Return: Array of struct page pointers describing the buffer,
  *	   or NULL on failure.
  */
-struct page **iommu_dma_alloc(struct device *dev, size_t size,
-		gfp_t gfp, int prot, dma_addr_t *handle,
+struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
+		int prot, struct dma_attrs *attrs, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t))
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
@@ -295,7 +301,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size,
 
 	*handle = DMA_ERROR_CODE;
 
-	pages = __iommu_dma_alloc_pages(count, gfp,
+	pages = __iommu_dma_alloc_pages(count, gfp, attrs,
 					domain->ops->pgsize_bitmap);
 	if (!pages)
 		return NULL;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index fc48103..08d9603 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -38,8 +38,8 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
  * These implement the bulk of the relevant DMA mapping callbacks, but require
  * the arch code to take care of attributes and cache maintenance
  */
-struct page **iommu_dma_alloc(struct device *dev, size_t size,
-		gfp_t gfp, int prot, dma_addr_t *handle,
+struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
+		int prot, struct dma_attrs *attrs, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t));
 void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 		dma_addr_t *handle);
-- 
1.8.1.1.dirty
