From: lorenx4@gmail.com (Lorenzo Nava)
Date: Mon, 29 Jun 2015 19:10:45 +0200
Subject: [PATCH v4] arm DMA: Fix allocation from CMA for coherent DMA
Message-ID: <1435597845-19811-1-git-send-email-lorenx4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows the use of CMA for DMA coherent memory allocation.
At the moment if the input parameter "is_coherent" is set to true
the allocation is not made using the CMA, which I think is not the
desired behaviour.

Signed-off-by: Lorenzo Nava <lorenx4@xxxxxxxx>
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
 arch/arm/mm/dma-mapping.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7e7583d..7d4bcf5 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -645,14 +645,18 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
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
@@ -680,9 +684,14 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
 {
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
+	pgprot_t prot;
 	void *memory;
 
+	if (attrs == NULL)
+		 prot  = PAGE_KERNEL;
+	else
+		 prot  = __get_dma_pgprot(attrs, PAGE_KERNEL);
+
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
 		return memory;
 
@@ -735,12 +744,12 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 
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
