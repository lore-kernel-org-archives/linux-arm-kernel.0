From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Apr 2017 19:00:32 +0100
Subject: [PATCH] arm64: Fix the DMA mmap and get_sgtable API with
 DMA_ATTR_FORCE_CONTIGUOUS
Message-ID: <1493143232-2245-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While honouring the DMA_ATTR_FORCE_CONTIGUOUS on arm64 (commit
44176bb38fa4: "arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to
IOMMU"), the existing uses of dma_mmap_attrs() and dma_get_sgtable()
have been broken by passing a physically contiguous vm_struct with an
invalid pages pointer through the common iommu API.

Since the coherent allocation with DMA_ATTR_FORCE_CONTIGUOUS uses CMA,
this patch simply reuses the existing swiotlb logic for mmap and
get_sgtable.

Note that the current implementation of get_sgtable (both swiotlb and
iommu) is broken if dma_declare_coherent_memory() is used since such
memory does not have a corresponding struct page. To be addressed in a
separate patch.

Fixes: 44176bb38fa4 ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
Reported-by: Andrzej Hajda <a.hajda@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Here's my attempt of fixing this, though I'd like to wait for Robin's review
(who's currently on holiday until next week).

Not tested.

 arch/arm64/mm/dma-mapping.c | 65 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index f7b54019ef55..c9e53dec3695 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -308,24 +308,15 @@ static void __swiotlb_sync_sg_for_device(struct device *dev,
 				       sg->length, dir);
 }
 
-static int __swiotlb_mmap(struct device *dev,
-			  struct vm_area_struct *vma,
-			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			  unsigned long attrs)
+static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
+			      unsigned long pfn, size_t size)
 {
 	int ret = -ENXIO;
 	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >>
 					PAGE_SHIFT;
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long pfn = dma_to_phys(dev, dma_addr) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
 
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
-					     is_device_dma_coherent(dev));
-
-	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
 	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
 		ret = remap_pfn_range(vma, vma->vm_start,
 				      pfn + off,
@@ -336,19 +327,43 @@ static int __swiotlb_mmap(struct device *dev,
 	return ret;
 }
 
-static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
-				 void *cpu_addr, dma_addr_t handle, size_t size,
-				 unsigned long attrs)
+static int __swiotlb_mmap(struct device *dev,
+			  struct vm_area_struct *vma,
+			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
+			  unsigned long attrs)
+{
+	int ret;
+	unsigned long pfn = dma_to_phys(dev, dma_addr) >> PAGE_SHIFT;
+
+	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
+					     is_device_dma_coherent(dev));
+
+	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	return __swiotlb_mmap_pfn(vma, pfn, size);
+}
+
+static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
+				      struct page *page, size_t size)
 {
 	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 
 	if (!ret)
-		sg_set_page(sgt->sgl, phys_to_page(dma_to_phys(dev, handle)),
-			    PAGE_ALIGN(size), 0);
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
 
 	return ret;
 }
 
+static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
+				 void *cpu_addr, dma_addr_t handle, size_t size,
+				 unsigned long attrs)
+{
+	struct page *page = phys_to_page(dma_to_phys(dev, handle));
+
+	return __swiotlb_get_sgtable_page(sgt, page, size);
+}
+
 static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
 	if (swiotlb)
@@ -703,6 +718,15 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
+	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
+		/*
+		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
+		 * hence in the vmalloc space.
+		 */
+		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
+		return __swiotlb_mmap_pfn(vma, pfn, size);
+	}
+
 	area = find_vm_area(cpu_addr);
 	if (WARN_ON(!area || !area->pages))
 		return -ENXIO;
@@ -717,6 +741,15 @@ static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct vm_struct *area = find_vm_area(cpu_addr);
 
+	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
+		/*
+		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
+		 * hence in the vmalloc space.
+		 */
+		struct page *page = vmalloc_to_page(cpu_addr);
+		return __swiotlb_get_sgtable_page(sgt, page, size);
+	}
+
 	if (WARN_ON(!area || !area->pages))
 		return -ENXIO;
 
