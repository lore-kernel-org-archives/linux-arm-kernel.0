From: ohaugan@codeaurora.org (Olav Haugan)
Date: Sat, 10 Jun 2017 12:41:10 -0700
Subject: [PATCH] arm64/dma-mapping: Fix null-pointer check
Message-ID: <20170610194110.27712-1-ohaugan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current null-pointer check in __dma_alloc_coherent and
__dma_free_coherent is pretty much useless since we are dereferencing
the pointer before checking for null.
Check for null-pointer before the actual dereferencing of the pointer.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 arch/arm64/mm/dma-mapping.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3216e098c058..a4b65773711d 100644
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
@@ -149,6 +140,11 @@ static void *__dma_alloc(struct device *dev, size_t size,
 	bool coherent = is_device_dma_coherent(dev);
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, false);
 
+	if (!dev) {
+		WARN_ONCE(1, "Use an actual device structure for DMA allocation\n");
+		return NULL;
+	}
+
 	size = PAGE_ALIGN(size);
 
 	if (!coherent && !gfpflags_allow_blocking(flags)) {
@@ -192,8 +188,13 @@ static void __dma_free(struct device *dev, size_t size,
 		       void *vaddr, dma_addr_t dma_handle,
 		       unsigned long attrs)
 {
-	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
+	void *swiotlb_addr;
 
+	if (!dev) {
+		WARN_ONCE(1, "Use an actual device structure for DMA free\n");
+		return;
+	}
+	swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
 	size = PAGE_ALIGN(size);
 
 	if (!is_device_dma_coherent(dev)) {
-- 
2.13.0
