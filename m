From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 26 Sep 2013 17:06:35 +0200
Subject: [PATCH 2/3] dma: mxs-dma: Track number of irqs for callback
In-Reply-To: <1380207996-27257-1-git-send-email-mpa@pengutronix.de>
References: <1380207996-27257-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1380207996-27257-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is one tasklet scheduled for all interrupts between two
mxs_dma_tasklet calls for one channel. With more than one interrupts,
the tasklet is only called once.

Using low latency audio playback, can lead to problems. When using
sound/soc/soc-dmaengine-pcm.c, the dmaengine_pcm_dma_complete relies on
being called for each interrupt that occures. This function is the
callback which is called from the mxs-dma driver in mxs_dma_tasklet.
This can cause wrong position counters and can lead to a wrong DMA
buffer offset. In this situation the DMA engine and pcm lib may write
and read from the same buffer segment.

This patch adds a locked per-channel irq counter and calls the callback
function in a loop for irq-counter times.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/dma/mxs-dma.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index bfca8dc..13c7d83 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -115,6 +115,8 @@ struct mxs_dma_chan {
 	int				desc_count;
 	enum dma_status			status;
 	unsigned int			flags;
+	unsigned int			nr_irqs;
+	spinlock_t			lock;
 #define MXS_DMA_SG_LOOP			(1 << 0)
 };
 
@@ -267,9 +269,21 @@ static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 static void mxs_dma_tasklet(unsigned long data)
 {
 	struct mxs_dma_chan *mxs_chan = (struct mxs_dma_chan *) data;
+	unsigned long flags;
 
+	spin_lock_irqsave(&mxs_chan->lock, flags);
+
+	/*
+	 * Some DMA users need exactly one call for each interrupt generated.
+	 * This loop calls the callback nr_irqs times.
+	 */
 	if (mxs_chan->desc.callback)
-		mxs_chan->desc.callback(mxs_chan->desc.callback_param);
+		for (; mxs_chan->nr_irqs; --mxs_chan->nr_irqs)
+			mxs_chan->desc.callback(mxs_chan->desc.callback_param);
+	else
+		mxs_chan->nr_irqs = 0;
+
+	spin_unlock_irqrestore(&mxs_chan->lock, flags);
 }
 
 static int mxs_dma_irq_to_chan(struct mxs_dma_engine *mxs_dma, int irq)
@@ -290,6 +304,7 @@ static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
 	u32 completed;
 	u32 err;
 	int chan = mxs_dma_irq_to_chan(mxs_dma, irq);
+	unsigned long flags;
 
 	if (chan < 0)
 		return IRQ_NONE;
@@ -344,6 +359,13 @@ static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
 	if (mxs_chan->status == DMA_SUCCESS)
 		dma_cookie_complete(&mxs_chan->desc);
 
+	/*
+	 * Increase the number of irqs we saw for this channel.
+	 */
+	spin_lock_irqsave(&mxs_chan->lock, flags);
+	++mxs_chan->nr_irqs;
+	spin_unlock_irqrestore(&mxs_chan->lock, flags);
+
 	/* schedule tasklet on this channel */
 	tasklet_schedule(&mxs_chan->tasklet);
 
@@ -385,6 +407,8 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
 	/* the descriptor is ready */
 	async_tx_ack(&mxs_chan->desc);
 
+	spin_lock_init(&mxs_chan->lock);
+
 	return 0;
 
 err_clk:
-- 
1.8.4.rc3
