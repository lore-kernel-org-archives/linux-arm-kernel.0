From: yuehaibing@huawei.com (YueHaibing)
Date: Thu, 19 Jul 2018 22:09:55 +0800
Subject: [PATCH] net: mediatek: use dma_zalloc_coherent instead of
 allocator/memset
Message-ID: <20180719140955.19444-1-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dma_zalloc_coherent instead of dma_alloc_coherent
followed by memset 0.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index d8ebf0a..fbdb3e3 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1221,14 +1221,11 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 	if (!ring->buf)
 		goto no_tx_mem;
 
-	ring->dma = dma_alloc_coherent(eth->dev,
-					  MTK_DMA_SIZE * sz,
-					  &ring->phys,
-					  GFP_ATOMIC | __GFP_ZERO);
+	ring->dma = dma_zalloc_coherent(eth->dev, MTK_DMA_SIZE * sz,
+					&ring->phys, GFP_ATOMIC | __GFP_ZERO);
 	if (!ring->dma)
 		goto no_tx_mem;
 
-	memset(ring->dma, 0, MTK_DMA_SIZE * sz);
 	for (i = 0; i < MTK_DMA_SIZE; i++) {
 		int next = (i + 1) % MTK_DMA_SIZE;
 		u32 next_ptr = ring->phys + next * sz;
-- 
2.7.0
