From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Oct 2013 08:47:46 +0100
Subject: [PATCH v5 2/5] dma: mxs-dma: Report correct residue for cyclic DMA
In-Reply-To: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
References: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1383032869-12863-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the channel's buffer address register to calculate correct residue
value for tx_status.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/dma/mxs-dma.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 1d1b6e9..083e7f1 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -58,6 +58,8 @@
 	(((dma_is_apbh(d) && apbh_is_old(d)) ? 0x050 : 0x110) + (n) * 0x70)
 #define HW_APBHX_CHn_SEMA(d, n) \
 	(((dma_is_apbh(d) && apbh_is_old(d)) ? 0x080 : 0x140) + (n) * 0x70)
+#define HW_APBHX_CHn_BAR(d, n) \
+	(((dma_is_apbh(d) && apbh_is_old(d)) ? 0x070 : 0x130) + (n) * 0x70)
 
 /*
  * ccw bits definitions
@@ -623,8 +625,24 @@ static enum dma_status mxs_dma_tx_status(struct dma_chan *chan,
 			dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
 	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	u32 residue = 0;
+
+	if (mxs_chan->status == DMA_IN_PROGRESS &&
+			mxs_chan->flags & MXS_DMA_SG_LOOP) {
+		struct mxs_dma_ccw *last_ccw;
+		u32 bar;
+
+		last_ccw = &mxs_chan->ccw[mxs_chan->desc_count - 1];
+		residue = last_ccw->xfer_bytes + last_ccw->bufaddr;
+
+		bar = readl(mxs_dma->base +
+				HW_APBHX_CHn_BAR(mxs_dma, chan->chan_id));
+		residue -= bar;
+	}
 
-	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie, 0);
+	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
+			residue);
 
 	return mxs_chan->status;
 }
-- 
1.8.4.rc3
