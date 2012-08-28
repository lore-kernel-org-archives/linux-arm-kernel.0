From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 28 Aug 2012 08:13:04 +0300
Subject: [v4 4/4] ARM: dma-mapping: IOMMU allocates pages from atomic_pool
 with GFP_ATOMIC
In-Reply-To: <1346130784-23571-1-git-send-email-hdoyu@nvidia.com>
References: <1346130784-23571-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1346130784-23571-5-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of the same atomic pool as DMA does, and skip a kernel page
mapping which can involve sleep'able operations at allocating a kernel
page table.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4ef2d7b..f5024f9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1309,6 +1309,34 @@ static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
 	return NULL;
 }
 
+static void *__iommu_alloc_atomic(struct device *dev, size_t size,
+				  dma_addr_t *handle)
+{
+	struct page *page;
+	void *addr;
+
+	addr = __alloc_from_pool(size, &page);
+	if (!addr)
+		return NULL;
+
+	*handle = __iommu_create_mapping(dev, &page, size);
+	if (*handle == DMA_ERROR_CODE)
+		goto err_mapping;
+
+	return addr;
+
+err_mapping:
+	__free_from_pool(addr, size);
+	return NULL;
+}
+
+static void __iommu_free_atomic(struct device *dev, struct page **pages,
+				dma_addr_t handle, size_t size)
+{
+	__iommu_remove_mapping(dev, handle, size);
+	__free_from_pool(page_address(pages[0]), size);
+}
+
 static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
 {
@@ -1326,6 +1354,9 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	*handle = DMA_ERROR_CODE;
 	size = PAGE_ALIGN(size);
 
+	if (gfp & GFP_ATOMIC)
+		return __iommu_alloc_atomic(dev, size, handle);
+
 	pages = __iommu_alloc_buffer(dev, size, gfp);
 	if (!pages)
 		return NULL;
@@ -1392,6 +1423,11 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		return;
 	}
 
+	if (__in_atomic_pool(cpu_addr, size)) {
+		__iommu_free_atomic(dev, pages, handle, size);
+		return;
+	}
+
 	if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs)) {
 		unmap_kernel_range((unsigned long)cpu_addr, size);
 		vunmap(cpu_addr);
-- 
1.7.5.4
