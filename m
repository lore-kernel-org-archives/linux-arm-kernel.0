From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue,  4 Feb 2014 15:08:57 -0800
Subject: [PATCHv2] arm64: Align CMA sizes to PAGE_SIZE
Message-ID: <1391555337-25380-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_alloc_from_contiguous takes number of pages for a size.
Align up the dma size passed in to page size to avoid truncation
and allocation failures on sizes less than PAGE_SIZE.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/mm/dma-mapping.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 45b5ab5..fbd7678 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -45,6 +45,7 @@ static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
 	if (IS_ENABLED(CONFIG_DMA_CMA)) {
 		struct page *page;
 
+		size = PAGE_ALIGN(size);
 		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
 							get_order(size));
 		if (!page)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
