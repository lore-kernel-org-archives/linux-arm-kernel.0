From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 12 Dec 2013 11:28:32 -0800
Subject: [PATCHv4 1/2] arm64: Warn on NULL device structure for dma APIs
In-Reply-To: <1386876513-7199-1-git-send-email-lauraa@codeaurora.org>
References: <1386876513-7199-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1386876513-7199-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although parts of the DMA apis may properly check for NULL devices,
there may be some places that don't. Rather than fix up all the
possible locations, just require a non-NULL device structure to be
used for allocating/freeing.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/mm/dma-mapping.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4bd7579..a496a3c 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -33,6 +33,11 @@ static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
 					  dma_addr_t *dma_handle, gfp_t flags,
 					  struct dma_attrs *attrs)
 {
+	if (dev == NULL) {
+		WARN(1, "Use an actual device structure for DMA allocation\n");
+		return NULL;
+	}
+
 	if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
 	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
 		flags |= GFP_DMA32;
@@ -43,6 +48,11 @@ static void arm64_swiotlb_free_coherent(struct device *dev, size_t size,
 					void *vaddr, dma_addr_t dma_handle,
 					struct dma_attrs *attrs)
 {
+	if (dev == NULL) {
+		WARN(1, "Use an actual device structure for DMA allocation\n");
+		return;
+	}
+
 	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
