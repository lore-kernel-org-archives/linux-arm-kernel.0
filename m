From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 11 Sep 2015 15:49:47 +0800
Subject: [PATCH] arm64: dma-mapping: check whether cma area is initialized or
 not
Message-ID: <1441957787-5526-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CMA is turned on and CMA size is set to zero, kernel should
behave as if CMA was not enabled at compile time.
Every dma allocation should check existence of cma area
before requesting memory.

Arm has done this by commit e464ef16c4f0 ("arm: dma-mapping: add
checking cma area initialized"), also do this for arm64.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 0bcc4bc..99224dc 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -100,7 +100,7 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
 	if (IS_ENABLED(CONFIG_ZONE_DMA) &&
 	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
 		flags |= GFP_DMA;
-	if (IS_ENABLED(CONFIG_DMA_CMA) && (flags & __GFP_WAIT)) {
+	if (dev_get_cma_area(dev) && (flags & __GFP_WAIT)) {
 		struct page *page;
 		void *addr;
 
-- 
2.5.1
