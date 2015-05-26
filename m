From: lorenx4@gmail.com (Lorenzo Nava)
Date: Tue, 26 May 2015 20:55:30 +0200
Subject: [RFC PATCH v2] arm DMA: Fix allocation from CMA for coherent DMA
Message-ID: <1432666530-4210-1-git-send-email-lorenx4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows the use of CMA for DMA coherent memory allocation.
At the moment if "is_coherent" is set to true the allocation can't use the CMA, which I think is not the desired behaviour.

Changes in v2:
 correct __arm_dma_free() according to __dma_alloc() allocation

---
 arch/arm/mm/dma-mapping.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7e7583d..15643b9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -645,9 +645,9 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	size = PAGE_ALIGN(size);
 	want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs);
 
-	if (is_coherent || nommu())
+	if (nommu())
 		addr = __alloc_simple_buffer(dev, size, gfp, &page);
-	else if (!(gfp & __GFP_WAIT))
+	else if (!is_coherent && !(gfp & __GFP_WAIT))
 		addr = __alloc_from_pool(size, &page);
 	else if (!dev_get_cma_area(dev))
 		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller, want_vaddr);
@@ -735,7 +735,7 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 
 	size = PAGE_ALIGN(size);
 
-	if (is_coherent || nommu()) {
+	if (nommu()) {
 		__dma_free_buffer(page, size);
 	} else if (__free_from_pool(cpu_addr, size)) {
 		return;
-- 
1.7.10.4
