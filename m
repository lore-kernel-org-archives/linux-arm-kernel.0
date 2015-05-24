From: lorenx4@gmail.com (Lorenzo Nava)
Date: Sun, 24 May 2015 21:30:57 +0200
Subject: [PATCH] arm DMA: Fix allocation from CMA for coherent DMA
Message-ID: <1432495857-10630-1-git-send-email-lorenx4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to allow the use of CMA for DMA coherent memory allocation.
At the moment if "is_coherent" is set to true the allocation can't use the CMA, which I think is not the desired behaviour.  

---
 arch/arm/mm/dma-mapping.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7e7583d..cc9382a 100644
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
-- 
1.7.10.4
