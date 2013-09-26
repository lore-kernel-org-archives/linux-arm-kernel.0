From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 26 Sep 2013 17:06:36 +0200
Subject: [PATCH 3/3] dma: mxs-dma: Pause channel while prep_dma_cyclic
In-Reply-To: <1380207996-27257-1-git-send-email-mpa@pengutronix.de>
References: <1380207996-27257-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1380207996-27257-4-git-send-email-mpa@pengutronix.de>
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
index 13c7d83..bdde315 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -568,8 +568,8 @@ static struct dma_async_tx_descriptor *mxs_dma_prep_dma_cyclic(
 	if (mxs_chan->status == DMA_IN_PROGRESS)
 		return NULL;
 
-	mxs_chan->status = DMA_IN_PROGRESS;
-	mxs_chan->flags |= MXS_DMA_SG_LOOP;
+	mxs_dma_pause_chan(mxs_chan);
+	mxs_dma_reset_chan(mxs_chan);
 
 	if (num_periods > NUM_CCW) {
 		dev_err(mxs_dma->dma_device.dev,
@@ -609,6 +609,11 @@ static struct dma_async_tx_descriptor *mxs_dma_prep_dma_cyclic(
 
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
