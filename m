From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Oct 2013 08:47:45 +0100
Subject: [PATCH v5 1/5] dma: mxs-dma: Cleanup interrupt handler
In-Reply-To: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
References: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1383032869-12863-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA interrupt handler uses its controll registers to handle all
available channel interrupts it can find.

This patch changes it to handle only one interrupt by directly mapping
irq number to channel. It also includes a cleanup of the ctrl-register
usage.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/dma/mxs-dma.c | 96 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 7ab7cec..1d1b6e9 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/list.h>
 
 #include <asm/irq.h>
 
@@ -272,58 +273,81 @@ static void mxs_dma_tasklet(unsigned long data)
 		mxs_chan->desc.callback(mxs_chan->desc.callback_param);
 }
 
+static int mxs_dma_irq_to_chan(struct mxs_dma_engine *mxs_dma, int irq)
+{
+	int i;
+
+	for (i = 0; i != mxs_dma->nr_channels; ++i)
+		if (mxs_dma->mxs_chans[i].chan_irq == irq)
+			return i;
+
+	return -EINVAL;
+}
+
 static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
 {
 	struct mxs_dma_engine *mxs_dma = dev_id;
-	u32 stat1, stat2;
+	struct mxs_dma_chan *mxs_chan;
+	u32 completed;
+	u32 err;
+	int chan = mxs_dma_irq_to_chan(mxs_dma, irq);
+
+	if (chan < 0)
+		return IRQ_NONE;
 
 	/* completion status */
-	stat1 = readl(mxs_dma->base + HW_APBHX_CTRL1);
-	stat1 &= MXS_DMA_CHANNELS_MASK;
-	writel(stat1, mxs_dma->base + HW_APBHX_CTRL1 + STMP_OFFSET_REG_CLR);
+	completed = readl(mxs_dma->base + HW_APBHX_CTRL1);
+	completed = (completed >> chan) & 0x1;
+
+	/* Clear interrupt */
+	writel((1 << chan),
+			mxs_dma->base + HW_APBHX_CTRL1 + STMP_OFFSET_REG_CLR);
 
 	/* error status */
-	stat2 = readl(mxs_dma->base + HW_APBHX_CTRL2);
-	writel(stat2, mxs_dma->base + HW_APBHX_CTRL2 + STMP_OFFSET_REG_CLR);
+	err = readl(mxs_dma->base + HW_APBHX_CTRL2);
+	err &= (1 << (MXS_DMA_CHANNELS + chan)) | (1 << chan);
+
+	/*
+	 * error status bit is in the upper 16 bits, error irq bit in the lower
+	 * 16 bits. We transform it into a simpler error code:
+	 * err: 0x00 = no error, 0x01 = TERMINATION, 0x02 = BUS_ERROR
+	 */
+	err = (err >> (MXS_DMA_CHANNELS + chan)) + (err >> chan);
+
+	/* Clear error irq */
+	writel((1 << chan),
+			mxs_dma->base + HW_APBHX_CTRL2 + STMP_OFFSET_REG_CLR);
 
 	/*
 	 * When both completion and error of termination bits set at the
 	 * same time, we do not take it as an error.  IOW, it only becomes
-	 * an error we need to handle here in case of either it's (1) a bus
-	 * error or (2) a termination error with no completion.
+	 * an error we need to handle here in case of either it's a bus
+	 * error or a termination error with no completion. 0x01 is termination
+	 * error, so we can subtract err & completed to get the real error case.
 	 */
-	stat2 = ((stat2 >> MXS_DMA_CHANNELS) & stat2) | /* (1) */
-		(~(stat2 >> MXS_DMA_CHANNELS) & stat2 & ~stat1); /* (2) */
-
-	/* combine error and completion status for checking */
-	stat1 = (stat2 << MXS_DMA_CHANNELS) | stat1;
-	while (stat1) {
-		int channel = fls(stat1) - 1;
-		struct mxs_dma_chan *mxs_chan =
-			&mxs_dma->mxs_chans[channel % MXS_DMA_CHANNELS];
-
-		if (channel >= MXS_DMA_CHANNELS) {
-			dev_dbg(mxs_dma->dma_device.dev,
-				"%s: error in channel %d\n", __func__,
-				channel - MXS_DMA_CHANNELS);
-			mxs_chan->status = DMA_ERROR;
-			mxs_dma_reset_chan(mxs_chan);
-		} else {
-			if (mxs_chan->flags & MXS_DMA_SG_LOOP)
-				mxs_chan->status = DMA_IN_PROGRESS;
-			else
-				mxs_chan->status = DMA_COMPLETE;
-		}
+	err -= err & completed;
 
-		stat1 &= ~(1 << channel);
+	mxs_chan = &mxs_dma->mxs_chans[chan];
 
-		if (mxs_chan->status == DMA_COMPLETE)
-			dma_cookie_complete(&mxs_chan->desc);
-
-		/* schedule tasklet on this channel */
-		tasklet_schedule(&mxs_chan->tasklet);
+	if (err) {
+		dev_dbg(mxs_dma->dma_device.dev,
+			"%s: error in channel %d\n", __func__,
+			chan);
+		mxs_chan->status = DMA_ERROR;
+		mxs_dma_reset_chan(mxs_chan);
+	} else {
+		if (mxs_chan->flags & MXS_DMA_SG_LOOP)
+			mxs_chan->status = DMA_IN_PROGRESS;
+		else
+			mxs_chan->status = DMA_COMPLETE;
 	}
 
+	if (mxs_chan->status == DMA_COMPLETE)
+		dma_cookie_complete(&mxs_chan->desc);
+
+	/* schedule tasklet on this channel */
+	tasklet_schedule(&mxs_chan->tasklet);
+
 	return IRQ_HANDLED;
 }
 
-- 
1.8.4.rc3
