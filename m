From: lorenx4@gmail.com (Lorenzo Nava)
Date: Tue, 30 Jun 2015 23:21:26 +0200
Subject: [PATCH v5] arm DMA: Fix allocation from CMA for coherent DMA
Message-ID: <1435699286-21245-1-git-send-email-lorenx4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows the use of CMA for DMA coherent memory allocation.
At the moment if the input parameter "is_coherent" is set to true
the allocation is not made using the CMA, which I think is not the
desired behaviour.

Signed-off-by: Lorenzo Nava <lorenx4@gmail.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Changes in v2:
 correct __arm_dma_free() according to __dma_alloc() allocation
---
Changes in v3:
 now __dma_alloc(), if 'is_coherent' is true, returns memory from CMA
 if there is no need for atomic allocation. If CMA is not available
 the function returns the result of __alloc_simple_buffer().
 __arm_dma_free() frees memory according to the new alloc function
 avoiding __dma_free_remap() for coherent DMA if CMA is not enable.
 arm_dma_alloc() mark pages as cacheable if attrs are set by default
 to NULL. If attrs is not NULL, attributes are preserved in the allocation.

 Coherent allocation tested on Xilinx Zynq processor.
---
Changes in v4:
 back to "if..else" code style for __dma_alloc()
 avoided unnecessary __free_from_pool() call in __arm_dma_free()
---
Changes in v5:
 changed coherent allocation attributes in arm_coherent_dma_alloc()
---
 arch/arm/mm/dma-mapping.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1ced8a0..8f3f173 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -648,14 +648,18 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	size = PAGE_ALIGN(size);
 	want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs);
 
-	if (is_coherent || nommu())
+	if (nommu())
+		addr = __alloc_simple_buffer(dev, size, gfp, &page);
+	else if (dev_get_cma_area(dev) && (gfp & __GFP_WAIT))
+		addr = __alloc_from_contiguous(dev, size, prot, &page,
+					       caller, want_vaddr);
+	else if (is_coherent)
 		addr = __alloc_simple_buffer(dev, size, gfp, &page);
 	else if (!(gfp & __GFP_WAIT))
 		addr = __alloc_from_pool(size, &page);
-	else if (!dev_get_cma_area(dev))
-		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller, want_vaddr);
 	else
-		addr = __alloc_from_contiguous(dev, size, prot, &page, caller, want_vaddr);
+		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page,
+					    caller, want_vaddr);
 
 	if (page)
 		*handle = pfn_to_dma(dev, page_to_pfn(page));
@@ -683,13 +687,12 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
 {
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	void *memory;
 
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
 		return memory;
 
-	return __dma_alloc(dev, size, handle, gfp, prot, true,
+	return __dma_alloc(dev, size, handle, gfp, PAGE_KERNEL, true,
 			   attrs, __builtin_return_address(0));
 }
 
@@ -753,12 +756,12 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 
 	size = PAGE_ALIGN(size);
 
-	if (is_coherent || nommu()) {
+	if (nommu()) {
 		__dma_free_buffer(page, size);
-	} else if (__free_from_pool(cpu_addr, size)) {
+	} else if (!is_coherent && __free_from_pool(cpu_addr, size)) {
 		return;
 	} else if (!dev_get_cma_area(dev)) {
-		if (want_vaddr)
+		if (want_vaddr && !is_coherent)
 			__dma_free_remap(cpu_addr, size);
 		__dma_free_buffer(page, size);
 	} else {
-- 
1.7.10.4
