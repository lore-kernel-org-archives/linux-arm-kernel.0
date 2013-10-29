From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Oct 2013 08:47:47 +0100
Subject: [PATCH v5 3/5] dma: mxs-dma: Fix channel reset hardware bug
In-Reply-To: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
References: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1383032869-12863-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is no official errata, but I noticed that the channel reset may
stop working if the DMA state engine is in the READ_FLUSH state.

This patch uses the channel debug1 register to wait for the DMA
statemachine to leave the READ_FLUSH state. After that we can continue
to reset the channel.

Tested on i.MX28.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/dma/mxs-dma.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 083e7f1..5302670 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -60,6 +60,7 @@
 	(((dma_is_apbh(d) && apbh_is_old(d)) ? 0x080 : 0x140) + (n) * 0x70)
 #define HW_APBHX_CHn_BAR(d, n) \
 	(((dma_is_apbh(d) && apbh_is_old(d)) ? 0x070 : 0x130) + (n) * 0x70)
+#define HW_APBX_CHn_DEBUG1(d, n) (0x150 + (n) * 0x70)
 
 /*
  * ccw bits definitions
@@ -204,12 +205,36 @@ static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
 	int chan_id = mxs_chan->chan.chan_id;
 
-	if (dma_is_apbh(mxs_dma) && apbh_is_old(mxs_dma))
+	if (dma_is_apbh(mxs_dma) && apbh_is_old(mxs_dma)) {
 		writel(1 << (chan_id + BP_APBH_CTRL0_RESET_CHANNEL),
 			mxs_dma->base + HW_APBHX_CTRL0 + STMP_OFFSET_REG_SET);
-	else
+	} else {
+		unsigned long elapsed = 0;
+		const unsigned long max_wait = 50000; /* 50ms */
+		void __iomem *reg_dbg1 = mxs_dma->base +
+				HW_APBX_CHn_DEBUG1(mxs_dma, chan_id);
+
+		/*
+		 * On i.MX28 APBX, the DMA channel can stop working if we reset
+		 * the channel while it is in READ_FLUSH (0x08) state.
+		 * We wait here until we leave the state. Then we trigger the
+		 * reset. Waiting a maximum of 50ms, the kernel shouldn't crash
+		 * because of this.
+		 */
+		while ((readl(reg_dbg1) & 0xf) == 0x8 && elapsed < max_wait) {
+			udelay(100);
+			elapsed += 100;
+		}
+
+		if (elapsed >= max_wait)
+			dev_err(&mxs_chan->mxs_dma->pdev->dev,
+					"Failed waiting for the DMA channel %d to leave state READ_FLUSH, trying to reset channel in READ_FLUSH state now\n",
+					chan_id);
+
+
 		writel(1 << (chan_id + BP_APBHX_CHANNEL_CTRL_RESET_CHANNEL),
 			mxs_dma->base + HW_APBHX_CHANNEL_CTRL + STMP_OFFSET_REG_SET);
+	}
 }
 
 static void mxs_dma_enable_chan(struct mxs_dma_chan *mxs_chan)
-- 
1.8.4.rc3
