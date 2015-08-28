From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 28 Aug 2015 10:36:58 +0200
Subject: [PATCH 1/2] ARM: dma-mapping: add missing range check in dma_mmap()
Message-ID: <1440751036-6585-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_mmap() function in IOMMU-based dma-mapping implementation lacked
a check for valid range of mmap parameters (offset and buffer size), what
might have caused access beyond the allocated buffer. This patch fixes
this issue.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: stable at vger.kernel.org  # v3.6+
---
 arch/arm/mm/dma-mapping.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index cba12f34ff77..67ae0f2ed983 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1413,12 +1413,17 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	unsigned long uaddr = vma->vm_start;
 	unsigned long usize = vma->vm_end - vma->vm_start;
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
 
 	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
 
 	if (!pages)
 		return -ENXIO;
 
+	if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
+		return -ENXIO;
+
 	do {
 		int ret = vm_insert_page(vma, uaddr, *pages++);
 		if (ret) {
-- 
1.9.2
