From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 30 Sep 2013 15:13:41 +0200
Subject: [PATCH v2 2/3] dma: mxs-dma: Pause channel while prep_dma_cyclic
In-Reply-To: <1380546822-14034-1-git-send-email-mpa@pengutronix.de>
References: <1380546822-14034-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1380546822-14034-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using mxs-dma with pcm-dmaengine with small period-length can in some
cases lead to strange audio effects. This patch pauses the DMA channel
while preparing cyclic DMA commands. I tested with mx28 and
period-length of 160.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/dma/mxs-dma.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index bfca8dc..a696438 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -544,8 +544,8 @@ static struct dma_async_tx_descriptor *mxs_dma_prep_dma_cyclic(
 	if (mxs_chan->status == DMA_IN_PROGRESS)
 		return NULL;
 
-	mxs_chan->status = DMA_IN_PROGRESS;
-	mxs_chan->flags |= MXS_DMA_SG_LOOP;
+	mxs_dma_pause_chan(mxs_chan);
+	mxs_dma_reset_chan(mxs_chan);
 
 	if (num_periods > NUM_CCW) {
 		dev_err(mxs_dma->dma_device.dev,
@@ -585,6 +585,11 @@ static struct dma_async_tx_descriptor *mxs_dma_prep_dma_cyclic(
 
 		i++;
 	}
+	mxs_dma_resume_chan(mxs_chan);
+
+	mxs_chan->status = DMA_IN_PROGRESS;
+	mxs_chan->flags |= MXS_DMA_SG_LOOP;
+
 	mxs_chan->desc_count = i;
 
 	return &mxs_chan->desc;
-- 
1.8.4.rc3
