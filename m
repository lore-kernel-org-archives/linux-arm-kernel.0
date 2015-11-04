From: robin.murphy@arm.com (Robin Murphy)
Date: Wed,  4 Nov 2015 13:23:52 +0000
Subject: [PATCH] arm64/dma-mapping: Fix sizes in __iommu_{alloc,free}_attrs
Message-ID: <74bd0f4e1ecda45febc55c6c6fe0d3d616c283d0.1446643360.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iommu-dma layer does its own size-alignment for coherent DMA
allocations based on IOMMU page sizes, but we still need to consider
CPU page sizes for the cases where a non-cacheable CPU mapping is
created. Whilst everything on the alloc/map path seems to implicitly
align things enough to make it work, some functions used by the
corresponding unmap/free path do not, which leads to problems freeing
odd-sized allocations. Either way it's something we really should be
handling explicitly, so do that to make both paths suitably robust.

Reported-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

This is based on Joerg's current master branch as the code hasn't
landed yet, but I guess since it's now mid-merge we'll probably be
taking it through arm64 at -rc1.

Robin.

 arch/arm64/mm/dma-mapping.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 6320361..5de6171 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -552,10 +552,14 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 {
 	bool coherent = is_device_dma_coherent(dev);
 	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
+	size_t iosize = size;
 	void *addr;
 
 	if (WARN(!dev, "cannot create IOMMU mapping for unknown device\n"))
 		return NULL;
+
+	size = PAGE_ALIGN(size);
+
 	/*
 	 * Some drivers rely on this, and we probably don't want the
 	 * possibility of stale kernel data being read by devices anyway.
@@ -566,7 +570,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		struct page **pages;
 		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
 
-		pages = iommu_dma_alloc(dev, size, gfp, ioprot,	handle,
+		pages = iommu_dma_alloc(dev, iosize, gfp, ioprot, handle,
 					flush_page);
 		if (!pages)
 			return NULL;
@@ -574,7 +578,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
 					      __builtin_return_address(0));
 		if (!addr)
-			iommu_dma_free(dev, pages, size, handle);
+			iommu_dma_free(dev, pages, iosize, handle);
 	} else {
 		struct page *page;
 		/*
@@ -591,7 +595,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		if (!addr)
 			return NULL;
 
-		*handle = iommu_dma_map_page(dev, page, 0, size, ioprot);
+		*handle = iommu_dma_map_page(dev, page, 0, iosize, ioprot);
 		if (iommu_dma_mapping_error(dev, *handle)) {
 			if (coherent)
 				__free_pages(page, get_order(size));
@@ -606,6 +610,9 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 			       dma_addr_t handle, struct dma_attrs *attrs)
 {
+	size_t iosize = size;
+
+	size = PAGE_ALIGN(size);
 	/*
 	 * @cpu_addr will be one of 3 things depending on how it was allocated:
 	 * - A remapped array of pages from iommu_dma_alloc(), for all
@@ -617,17 +624,17 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	 * Hence how dodgy the below logic looks...
 	 */
 	if (__in_atomic_pool(cpu_addr, size)) {
-		iommu_dma_unmap_page(dev, handle, size, 0, NULL);
+		iommu_dma_unmap_page(dev, handle, iosize, 0, NULL);
 		__free_from_pool(cpu_addr, size);
 	} else if (is_vmalloc_addr(cpu_addr)){
 		struct vm_struct *area = find_vm_area(cpu_addr);
 
 		if (WARN_ON(!area || !area->pages))
 			return;
-		iommu_dma_free(dev, area->pages, size, &handle);
+		iommu_dma_free(dev, area->pages, iosize, &handle);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else {
-		iommu_dma_unmap_page(dev, handle, size, 0, NULL);
+		iommu_dma_unmap_page(dev, handle, iosize, 0, NULL);
 		__free_pages(virt_to_page(cpu_addr), get_order(size));
 	}
 }
-- 
1.9.1
