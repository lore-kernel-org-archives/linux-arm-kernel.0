From: hao5781286@gmail.com (Axl-zhang)
Date: Wed, 2 Nov 2016 13:31:12 +0800
Subject: [PATCH v1] ARM:dmaengine:sun6i:fix the uninitialized value for v_lli
Message-ID: <20161102053112.GA8109@arx-xi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_pool_alloc does not initialize the value of the newly allocated
block for the v_lli, and the uninitilize value make the tests failed
which is on pine64 with dmatest.
we can fix it just change the "|=" to "=" for the v_lli->cfg.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 drivers/dma/sun6i-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 3835fcd..52b48eb 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -578,7 +578,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 
 	burst = convert_burst(8);
 	width = convert_buswidth(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	v_lli->cfg |= DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
+	v_lli->cfg = DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
 		DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
 		DMA_CHAN_CFG_DST_LINEAR_MODE |
 		DMA_CHAN_CFG_SRC_LINEAR_MODE |
-- 
2.7.4
