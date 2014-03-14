From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 14 Mar 2014 12:52:23 -0700
Subject: [PATCHv2 1/3] arm64: Implement custom mmap functions for dma mapping
In-Reply-To: <1394732716-11507-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <1394826745-24191-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current dma_ops do not specify an mmap function so maping
falls back to the default implementation. There are at least
two issues with using the default implementation:

1) The pgprot is always pgprot_noncached (strongly ordered)
memory even with coherent operations
2) dma_common_mmap calls virt_to_page on the remapped non-coherent
address which leads to invalid memory being mapped.

Fix both these issue by implementing a custom mmap function which
correctly accounts for remapped addresses and sets vm_pg_prot
appropriately.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/mm/dma-mapping.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index e923a5b..0cdd2f6 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -194,9 +194,52 @@ static void arm64_swiotlb_sync_sg_for_device(struct device *dev,
 			       sg->length, dir);
 }
 
+/* vma->vm_page_prot must be set appropriately before calling this function */
+static int __dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
+			     void *cpu_addr, dma_addr_t dma_addr, size_t size)
+{
+	int ret = -ENXIO;
+	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >>
+					PAGE_SHIFT;
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long pfn = dma_to_phys(dev, dma_addr) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
+
+	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      pfn + off,
+				      vma->vm_end - vma->vm_start,
+				      vma->vm_page_prot);
+	}
+
+	return ret;
+}
+
+static int arm64_swiotlb_mmap_noncoherent(struct device *dev,
+		struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		struct dma_attrs *attrs)
+{
+	vma->vm_page_prot = pgprot_dmacoherent(vma->vm_page_prot);
+	return __dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
+}
+
+static int arm64_swiotlb_mmap_coherent(struct device *dev,
+		struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		struct dma_attrs *attrs)
+{
+	/* Just use whatever page_prot attributes were specified */
+	return __dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
+}
+
 struct dma_map_ops noncoherent_swiotlb_dma_ops = {
 	.alloc = arm64_swiotlb_alloc_noncoherent,
 	.free = arm64_swiotlb_free_noncoherent,
+	.mmap = arm64_swiotlb_mmap_noncoherent,
 	.map_page = arm64_swiotlb_map_page,
 	.unmap_page = arm64_swiotlb_unmap_page,
 	.map_sg = arm64_swiotlb_map_sg_attrs,
@@ -213,6 +256,7 @@ EXPORT_SYMBOL(noncoherent_swiotlb_dma_ops);
 struct dma_map_ops coherent_swiotlb_dma_ops = {
 	.alloc = arm64_swiotlb_alloc_coherent,
 	.free = arm64_swiotlb_free_coherent,
+	.mmap = arm64_swiotlb_mmap_coherent,
 	.map_page = swiotlb_map_page,
 	.unmap_page = swiotlb_unmap_page,
 	.map_sg = swiotlb_map_sg_attrs,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
