From: b32955@freescale.com (Huang Shijie)
Date: Fri, 2 Dec 2011 10:16:25 +0800
Subject: [PATCH v3] IMX/SDMA : save the real count for one DMA transaction.
Message-ID: <1322792185-4704-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we use the SDMA in the UART driver(such as imx6q), we will
meet one situation:
  Assume we set 64 bytes for the RX DMA buffer.
  The RX DMA buffer has received some data, but not full.
  An Aging DMA request will be received by the SDMA controller if we enable the
  IDDMAEN(UCR4[6]) in this case.

So the UART driver needs to know the count of the real received bytes,
and push them to upper layer.

Add two new fields to sdmac, and update the `residue` in sdma_tx_status().

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/dma/imx-sdma.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f993955..f09eb1e 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -268,6 +268,8 @@ struct sdma_channel {
 	struct dma_async_tx_descriptor	desc;
 	dma_cookie_t			last_completed;
 	enum dma_status			status;
+	unsigned int			chn_count;
+	unsigned int			chn_real_count;
 };
 
 #define IMX_DMA_SG_LOOP		(1 << 0)
@@ -503,6 +505,7 @@ static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
 	struct sdma_buffer_descriptor *bd;
 	int i, error = 0;
 
+	sdmac->chn_real_count = 0;
 	/*
 	 * non loop mode. Iterate over all descriptors, collect
 	 * errors and call callback function
@@ -512,6 +515,7 @@ static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
 
 		 if (bd->mode.status & (BD_DONE | BD_RROR))
 			error = -EIO;
+		 sdmac->chn_real_count += bd->mode.count;
 	}
 
 	if (error)
@@ -519,9 +523,9 @@ static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
 	else
 		sdmac->status = DMA_SUCCESS;
 
+	sdmac->last_completed = sdmac->desc.cookie;
 	if (sdmac->desc.callback)
 		sdmac->desc.callback(sdmac->desc.callback_param);
-	sdmac->last_completed = sdmac->desc.cookie;
 }
 
 static void mxc_sdma_handle_channel(struct sdma_channel *sdmac)
@@ -941,6 +945,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		goto err_out;
 	}
 
+	sdmac->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
 		int param;
@@ -957,6 +962,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		}
 
 		bd->mode.count = count;
+		sdmac->chn_count += count;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES) {
 			ret =  -EINVAL;
@@ -1119,7 +1125,8 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 
 	last_used = chan->cookie;
 
-	dma_set_tx_state(txstate, sdmac->last_completed, last_used, 0);
+	dma_set_tx_state(txstate, sdmac->last_completed, last_used,
+			sdmac->chn_count - sdmac->chn_real_count);
 
 	return sdmac->status;
 }
-- 
1.7.3.2
