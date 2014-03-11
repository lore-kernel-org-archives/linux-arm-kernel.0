From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 11 Mar 2014 11:04:19 -0700
Subject: Query on patch to be upstream ?
In-Reply-To: <20140311121500.GH31104@arm.com>
Message-ID: <1394561059-29307-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With one caveat below, you can add

Tested-by: Laura Abbott <lauraa@codeaurora.org>

for "arm64: Implement coherent DMA API based on swiotlb"

Thanks,
Laura

-- 8< --
From: Laura Abbott <lauraa@codeaurora.org>
Date: Thu, 6 Mar 2014 21:05:41 -0800
Subject: [PATCH] arm64: Use custom mmap function for noncoherent dma ops

The non-coherent dma ops remap memory with appropriate attributes.
This remapped address cannot be used with virt_to_page which
dma_common_mmap uses. Implement a custom (but very similar) function
which correctly calculates the physical address and remaps to userspace.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/mm/dma-mapping.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index e923a5b..5ac7a14 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -194,9 +194,36 @@ static void arm64_swiotlb_sync_sg_for_device(struct device *dev,
 			       sg->length, dir);
 }
 
+int arm64_swiotlb_mmap(struct device *dev, struct vm_area_struct *vma,
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		 struct dma_attrs *attrs)
+{
+	int ret = -ENXIO;
+	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >>
+					PAGE_SHIFT;
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long pfn = dma_to_phys(dev, dma_addr) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
+
+	vma->vm_page_prot = pgprot_dmacoherent(vma->vm_page_prot);
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
 struct dma_map_ops noncoherent_swiotlb_dma_ops = {
 	.alloc = arm64_swiotlb_alloc_noncoherent,
 	.free = arm64_swiotlb_free_noncoherent,
+	.mmap = arm64_swiotlb_mmap,
 	.map_page = arm64_swiotlb_map_page,
 	.unmap_page = arm64_swiotlb_unmap_page,
 	.map_sg = arm64_swiotlb_map_sg_attrs,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
