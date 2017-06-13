From: ohaugan@codeaurora.org (Olav Haugan)
Date: Tue, 13 Jun 2017 13:56:14 -0700
Subject: [PATCH v2] arm64/dma-mapping: Remove extraneous null-pointer checks
Message-ID: <20170613205614.15872-1-ohaugan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current null-pointer check in __dma_alloc_coherent and
__dma_free_coherent is not needed anymore since the
__dma_alloc/__dma_free functions won't be called if !dev (dummy ops will
be called instead).

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 arch/arm64/include/asm/dma-mapping.h | 2 --
 arch/arm64/mm/dma-mapping.c          | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 5392dbeffa45..f72779aad276 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -48,8 +48,6 @@ void arch_teardown_dma_ops(struct device *dev);
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
-	if (!dev)
-		return false;
 	return dev->archdata.dma_coherent;
 }
 
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3216e098c058..3e340b625436 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -95,11 +95,6 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
 				  unsigned long attrs)
 {
-	if (dev == NULL) {
-		WARN_ONCE(1, "Use an actual device structure for DMA allocation\n");
-		return NULL;
-	}
-
 	if (IS_ENABLED(CONFIG_ZONE_DMA) &&
 	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
 		flags |= GFP_DMA;
@@ -128,10 +123,6 @@ static void __dma_free_coherent(struct device *dev, size_t size,
 	bool freed;
 	phys_addr_t paddr = dma_to_phys(dev, dma_handle);
 
-	if (dev == NULL) {
-		WARN_ONCE(1, "Use an actual device structure for DMA allocation\n");
-		return;
-	}
 
 	freed = dma_release_from_contiguous(dev,
 					phys_to_page(paddr),
-- 
2.13.0
