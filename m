From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 30 Jul 2012 10:29:52 +0200
Subject: [PATCH] ARM: dma-mapping: add more sanity checks in arm_dma_mmap()
Message-ID: <1343636992-19774-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some sanity checks and forbid mmaping of buffers into vma areas larger
than allocated dma buffer.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f906d5f..a2881c9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -611,16 +611,22 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 {
 	int ret = -ENXIO;
 #ifdef CONFIG_MMU
+	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long pfn = dma_to_pfn(dev, dma_addr);
+	unsigned long off = vma->vm_pgoff;
+
 	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
 
 	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
-	ret = remap_pfn_range(vma, vma->vm_start,
-			      pfn + vma->vm_pgoff,
-			      vma->vm_end - vma->vm_start,
-			      vma->vm_page_prot);
+	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      pfn + off,
+				      vma->vm_end - vma->vm_start,
+				      vma->vm_page_prot);
+	}
 #endif	/* CONFIG_MMU */
 
 	return ret;
-- 
1.7.1.569.g6f426
