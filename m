From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 21 Apr 2011 11:22:32 +0200
Subject: [PATCH] MXS DMA: enable CLKGATE before accessing registers
In-Reply-To: <9888fc5695f320d8b5e9a9014fe0c1a0eab24bb5.1303373126.git.LW@KARO-electronics.de>
References: <9888fc5695f320d8b5e9a9014fe0c1a0eab24bb5.1303373126.git.LW@KARO-electronics.de>
Message-ID: <dc6791e4e926902967a182107d4558d5e0a16381.1303373126.git.LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After calling mxs_dma_disable_chan() for a channel, that channel
becomes unusable because some controller registers can only be written
when the clock is enabled via CLKGATE.

Signed-off-by: Lothar Wa??mann <LW@KARO-electronics.de>
---
 drivers/dma/mxs-dma.c |   45 ++++++++++++++++++++++++---------------------
 1 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 5b9b66a..329405c 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -131,6 +131,23 @@ struct mxs_dma_engine {
 	int				irqmap[MXS_DMA_CHANNELS];
 };
 
+static inline void mxs_dma_clkgate(struct mxs_dma_chan *mxs_chan, int enable)
+{
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	int chan_id = mxs_chan->chan.chan_id;
+	int set_clr = enable ? MXS_CLR_ADDR : MXS_SET_ADDR;
+
+	/* enable apbh channel clock */
+	if (dma_is_apbh()) {
+		if (apbh_is_old())
+			writel(1 << (chan_id + BP_APBH_CTRL0_CLKGATE_CHANNEL),
+				mxs_dma->base + HW_APBHX_CTRL0 + set_clr);
+		else
+			writel(1 << chan_id,
+				mxs_dma->base + HW_APBHX_CTRL0 + set_clr);
+	}
+}
+
 static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
 {
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
@@ -149,38 +166,21 @@ static void mxs_dma_enable_chan(struct mxs_dma_chan *mxs_chan)
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
 	int chan_id = mxs_chan->chan.chan_id;
 
+	/* clkgate needs to be enabled before writing other registers */
+	mxs_dma_clkgate(mxs_chan, 1);
+
 	/* set cmd_addr up */
 	writel(mxs_chan->ccw_phys,
 		mxs_dma->base + HW_APBHX_CHn_NXTCMDAR(chan_id));
 
-	/* enable apbh channel clock */
-	if (dma_is_apbh()) {
-		if (apbh_is_old())
-			writel(1 << (chan_id + BP_APBH_CTRL0_CLKGATE_CHANNEL),
-				mxs_dma->base + HW_APBHX_CTRL0 + MXS_CLR_ADDR);
-		else
-			writel(1 << chan_id,
-				mxs_dma->base + HW_APBHX_CTRL0 + MXS_CLR_ADDR);
-	}
-
 	/* write 1 to SEMA to kick off the channel */
 	writel(1, mxs_dma->base + HW_APBHX_CHn_SEMA(chan_id));
 }
 
 static void mxs_dma_disable_chan(struct mxs_dma_chan *mxs_chan)
 {
-	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
-	int chan_id = mxs_chan->chan.chan_id;
-
 	/* disable apbh channel clock */
-	if (dma_is_apbh()) {
-		if (apbh_is_old())
-			writel(1 << (chan_id + BP_APBH_CTRL0_CLKGATE_CHANNEL),
-				mxs_dma->base + HW_APBHX_CTRL0 + MXS_SET_ADDR);
-		else
-			writel(1 << chan_id,
-				mxs_dma->base + HW_APBHX_CTRL0 + MXS_SET_ADDR);
-	}
+	mxs_dma_clkgate(mxs_chan, 0);
 
 	mxs_chan->status = DMA_SUCCESS;
 }
@@ -359,7 +359,10 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		goto err_clk;
 
+	/* clkgate needs to be enabled for reset to finish */
+	mxs_dma_clkgate(mxs_chan, 1);
 	mxs_dma_reset_chan(mxs_chan);
+	mxs_dma_clkgate(mxs_chan, 0);
 
 	dma_async_tx_descriptor_init(&mxs_chan->desc, chan);
 	mxs_chan->desc.tx_submit = mxs_dma_tx_submit;
-- 
1.5.6.5
