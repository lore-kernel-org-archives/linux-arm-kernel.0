From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Oct 2013 08:47:49 +0100
Subject: [PATCH v5 5/5] dma: mxs-dma: Use semaphores for cyclic DMA
In-Reply-To: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
References: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1383032869-12863-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mxs dma channel hardware reset command is not reliable and can cause
a channel stall. The only way to fix the channel stall is a DMA engine
reset.

To avoid channel resets we use the hardware semaphore counter. For each
transmitted segment, the DMA channel will decrease the counter by one.
To use this mechanism with cyclic DMA, we need to increase the semaphore
counter with each completed DMA command in the interrupt handler. To
avoid any interruptions between the DMA transfers, the semaphore counter
is initialized with 2. This way the counter can be increased in the
interrupt handler without an influence on the transfer of the DMA
engine.

When disabling the channel, we stop increasing the semaphore counter in
the interrupt handler.

This patch was tested on i.MX28 with the SAIF DMA channel.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/dma/mxs-dma.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index f48f87f..ead4913 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -119,7 +119,9 @@ struct mxs_dma_chan {
 	int				desc_count;
 	enum dma_status			status;
 	unsigned int			flags;
+	bool				reset;
 #define MXS_DMA_SG_LOOP			(1 << 0)
+#define MXS_DMA_USE_SEMAPHORE		(1 << 1)
 };
 
 #define MXS_DMA_CHANNELS		16
@@ -205,7 +207,17 @@ static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
 	int chan_id = mxs_chan->chan.chan_id;
 
-	if (dma_is_apbh(mxs_dma) && apbh_is_old(mxs_dma)) {
+	/*
+	 * mxs dma channel resets can cause a channel stall. To recover from a
+	 * channel stall, we have to reset the whole DMA engine. To avoid this,
+	 * we use cyclic DMA with semaphores, that are enhanced in
+	 * mxs_dma_int_handler. To reset the channel, we can simply stop writing
+	 * into the semaphore counter.
+	 */
+	if (mxs_chan->flags & MXS_DMA_USE_SEMAPHORE &&
+			mxs_chan->flags & MXS_DMA_SG_LOOP) {
+		mxs_chan->reset = true;
+	} else if (dma_is_apbh(mxs_dma) && apbh_is_old(mxs_dma)) {
 		writel(1 << (chan_id + BP_APBH_CTRL0_RESET_CHANNEL),
 			mxs_dma->base + HW_APBHX_CTRL0 + STMP_OFFSET_REG_SET);
 	} else {
@@ -231,7 +243,6 @@ static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
 					"Failed waiting for the DMA channel %d to leave state READ_FLUSH, trying to reset channel in READ_FLUSH state now\n",
 					chan_id);
 
-
 		writel(1 << (chan_id + BP_APBHX_CHANNEL_CTRL_RESET_CHANNEL),
 			mxs_dma->base + HW_APBHX_CHANNEL_CTRL + STMP_OFFSET_REG_SET);
 	}
@@ -249,7 +260,16 @@ static void mxs_dma_enable_chan(struct mxs_dma_chan *mxs_chan)
 		mxs_dma->base + HW_APBHX_CHn_NXTCMDAR(mxs_dma, chan_id));
 
 	/* write 1 to SEMA to kick off the channel */
-	writel(1, mxs_dma->base + HW_APBHX_CHn_SEMA(mxs_dma, chan_id));
+	if (mxs_chan->flags & MXS_DMA_USE_SEMAPHORE &&
+			mxs_chan->flags & MXS_DMA_SG_LOOP) {
+		/* A cyclic DMA consists of at least 2 segments, so initialize
+		 * the semaphore with 2 so we have enough time to add 1 to the
+		 * semaphore if we need to */
+		writel(2, mxs_dma->base + HW_APBHX_CHn_SEMA(mxs_dma, chan_id));
+	} else {
+		writel(1, mxs_dma->base + HW_APBHX_CHn_SEMA(mxs_dma, chan_id));
+	}
+	mxs_chan->reset = false;
 }
 
 static void mxs_dma_disable_chan(struct mxs_dma_chan *mxs_chan)
@@ -365,14 +385,21 @@ static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
 		mxs_chan->status = DMA_ERROR;
 		mxs_dma_reset_chan(mxs_chan);
 	} else if (mxs_chan->status != DMA_COMPLETE) {
-		if (mxs_chan->flags & MXS_DMA_SG_LOOP)
+		if (mxs_chan->flags & MXS_DMA_SG_LOOP) {
 			mxs_chan->status = DMA_IN_PROGRESS;
-		else
+			if (mxs_chan->flags & MXS_DMA_USE_SEMAPHORE)
+				writel(1, mxs_dma->base +
+					HW_APBHX_CHn_SEMA(mxs_dma, chan));
+		} else {
 			mxs_chan->status = DMA_COMPLETE;
+		}
 	}
 
-	if (mxs_chan->status == DMA_COMPLETE)
+	if (mxs_chan->status == DMA_COMPLETE) {
+		if (mxs_chan->reset)
+			return IRQ_HANDLED;
 		dma_cookie_complete(&mxs_chan->desc);
+	}
 
 	/* schedule tasklet on this channel */
 	tasklet_schedule(&mxs_chan->tasklet);
@@ -576,6 +603,7 @@ static struct dma_async_tx_descriptor *mxs_dma_prep_dma_cyclic(
 
 	mxs_chan->status = DMA_IN_PROGRESS;
 	mxs_chan->flags |= MXS_DMA_SG_LOOP;
+	mxs_chan->flags |= MXS_DMA_USE_SEMAPHORE;
 
 	if (num_periods > NUM_CCW) {
 		dev_err(mxs_dma->dma_device.dev,
@@ -607,6 +635,7 @@ static struct dma_async_tx_descriptor *mxs_dma_prep_dma_cyclic(
 		ccw->bits |= CCW_IRQ;
 		ccw->bits |= CCW_HALT_ON_TERM;
 		ccw->bits |= CCW_TERM_FLUSH;
+		ccw->bits |= CCW_DEC_SEM;
 		ccw->bits |= BF_CCW(direction == DMA_DEV_TO_MEM ?
 				MXS_DMA_CMD_WRITE : MXS_DMA_CMD_READ, COMMAND);
 
-- 
1.8.4.rc3
