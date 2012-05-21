From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 21 May 2012 20:31:34 +0800
Subject: [PATCH 1/1] dma: imx-sdma: buf_tail should be initialize in prepare
 function
Message-ID: <1337603494-27464-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fix audio underrun issue. When SNDRV_PCM_TRIGGER_STOP
and SNDRV_PCM_TRIGGER_START, it calls prepare again. buf_tail
should be reset to zero.
So move buf_tail initialization into prepare function.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/dma/imx-sdma.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index a472a29..def08f7 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -814,8 +814,6 @@ static int sdma_request_channel(struct sdma_channel *sdmac)
 
 	init_completion(&sdmac->done);
 
-	sdmac->buf_tail = 0;
-
 	return 0;
 out:
 
@@ -924,6 +922,8 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 	sdmac->flags = 0;
 
+	sdmac->buf_tail = 0;
+
 	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
 			sg_len, channel);
 
@@ -1024,6 +1024,8 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->status = DMA_IN_PROGRESS;
 
+	sdmac->buf_tail = 0;
+
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 	sdmac->direction = direction;
 	ret = sdma_load_context(sdmac);
-- 
1.7.5.4
