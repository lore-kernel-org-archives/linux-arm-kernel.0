From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 27 Jan 2014 15:23:23 +0100
Subject: [PATCH 1/2] dmaengine: at_hdmac: remove the call to issue_pending
 from tx_status
In-Reply-To: <cover.1390832343.git.nicolas.ferre@atmel.com>
References: <cover.1390832343.git.nicolas.ferre@atmel.com>
Message-ID: <5c82568028640530b39e52155f87fdcd51ebbc48.1390832343.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Triggering the dmaengine from tx_status call seems awkward.
If data are remaining in the DMA FIFO, the normal operations
should drain them anyway.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index e2c04dc81e2a..b28759b6d1ca 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -268,8 +268,6 @@ static struct at_desc *atc_get_current_descriptors(struct at_dma_chan *atchan,
 static int atc_get_bytes_left(struct dma_chan *chan)
 {
 	struct at_dma_chan      *atchan = to_at_dma_chan(chan);
-	struct at_dma           *atdma = to_at_dma(chan->device);
-	int	chan_id = atchan->chan_common.chan_id;
 	struct at_desc *desc_first = atc_first_active(atchan);
 	struct at_desc *desc_cur;
 	int ret = 0, count = 0;
@@ -311,11 +309,6 @@ static int atc_get_bytes_left(struct dma_chan *chan)
 				<< (desc_first->tx_width);
 		ret = atchan->remain_desc - count;
 	}
-	/*
-	 * Check fifo empty.
-	 */
-	if (!(dma_readl(atdma, CHSR) & AT_DMA_EMPT(chan_id)))
-		atc_issue_pending(chan);
 
 out:
 	return ret;
-- 
1.8.2.2
