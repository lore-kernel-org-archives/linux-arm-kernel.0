From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 31 Jan 2014 16:23:54 -0800
Subject: [PATCH] arm64: Align CMA sizes to PAGE_SIZE
Message-ID: <1391214234-23526-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_alloc_from_contiguous takes number of pages for a size.
Align up the dma size passed in to page size to avoid truncation
and allocation failures on sizes less than PAGE_SIZE.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/mm/dma-mapping.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 864b256..be2696e 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -44,6 +44,8 @@ static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
 		flags |= GFP_DMA32;
 	if (IS_ENABLED(CONFIG_CMA)) {
 		unsigned long pfn;
+
+		size = PAGE_ALIGN(size);
 		pfn = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
 							get_order(size));
 		if (!pfn)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
