From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 16 Feb 2016 15:14:25 +0100
Subject: [PATCH] ARM64: dma-mapping: fix IOMMU-based dma_mmap_atts()
 implementation
Message-ID: <1455632065-14620-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMMU-based DMA-mapping implementation doesn't support
dma_declare_coherent() based regions, so there is no point to call
dma_mmap_from_coherent() from __iommu_mmap_atts(). This patch removes
useless code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/mm/dma-mapping.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 331c4ca..573b1e6 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -636,14 +636,9 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 			      struct dma_attrs *attrs)
 {
 	struct vm_struct *area;
-	int ret;
 
 	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
 					     is_device_dma_coherent(dev));
-
-	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
 	area = find_vm_area(cpu_addr);
 	if (WARN_ON(!area || !area->pages))
 		return -ENXIO;
-- 
1.9.2
