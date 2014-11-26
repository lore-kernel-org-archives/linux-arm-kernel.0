From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 26 Nov 2014 15:14:55 +0530
Subject: [PATCH] dmaengine: pl330: Set residue in tx_status callback
Message-ID: <1416995095-13763-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fill txstate.residue with the amount of bytes remaining in the current
transfer if the transfer is not complete.  This will be of particular
use to i2s DMA transfers, providing more accurate hw_ptr values to ASoC.

I had taken the code from Dylan Reid <dgreid@chromium.org> patch from the
below link and modified according to the current dmaengine framework.
http://comments.gmane.org/gmane.linux.kernel.samsung-soc/23007

Cc: Dylan Reid <dgreid@chromium.org>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---

This patch has been tested for audio playback on exynos5420 peach-pit.

 drivers/dma/pl330.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index b7493d2..db880ae 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2182,11 +2182,74 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 	pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
 }
 
+static inline int
+pl330_src_addr_in_desc(struct dma_pl330_desc *desc, unsigned int sar)
+{
+	return ((desc->px.src_addr <= sar) &&
+		(sar <= (desc->px.src_addr + desc->px.bytes)));
+}
+
+static inline int
+pl330_dst_addr_in_desc(struct dma_pl330_desc *desc, unsigned int dar)
+{
+	return ((desc->px.dst_addr <= dar) &&
+		(dar <= (desc->px.dst_addr + desc->px.bytes)));
+}
+
 static enum dma_status
 pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 		 struct dma_tx_state *txstate)
 {
-	return dma_cookie_status(chan, cookie, txstate);
+	dma_addr_t sar, dar;
+	struct dma_pl330_chan *pch = to_pchan(chan);
+	void __iomem *regs = pch->dmac->base;
+	struct pl330_thread *thrd = pch->thread;
+	struct dma_pl330_desc *desc;
+	unsigned int residue = 0;
+	unsigned long flags;
+	bool first = true;
+	dma_cookie_t first_c, current_c;
+	dma_cookie_t used;
+	enum dma_status ret;
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE || !txstate)
+		return ret;
+
+	used = txstate->used;
+
+	spin_lock_irqsave(&pch->lock, flags);
+	sar = readl(regs + SA(thrd->id));
+	dar = readl(regs + DA(thrd->id));
+
+	list_for_each_entry(desc, &pch->work_list, node) {
+		if (desc->status == BUSY) {
+			current_c = desc->txd.cookie;
+			if (first) {
+				first_c = desc->txd.cookie;
+				first = false;
+			}
+
+			if (first_c < current_c)
+				residue += desc->px.bytes;
+			else {
+				if (desc->rqcfg.src_inc && pl330_src_addr_in_desc(desc, sar)) {
+					residue += desc->px.bytes;
+					residue -= sar - desc->px.src_addr;
+				} else if (desc->rqcfg.dst_inc && pl330_dst_addr_in_desc(desc, dar)) {
+					residue += desc->px.bytes;
+					residue -= dar - desc->px.dst_addr;
+				}
+			}
+		} else if (desc->status == PREP)
+			residue += desc->px.bytes;
+
+		if (desc->txd.cookie == used)
+			break;
+	}
+	spin_unlock_irqrestore(&pch->lock, flags);
+	dma_set_residue(txstate, residue);
+	return ret;
 }
 
 static void pl330_issue_pending(struct dma_chan *chan)
@@ -2631,7 +2694,7 @@ static int pl330_dma_device_slave_caps(struct dma_chan *dchan,
 	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	caps->cmd_pause = false;
 	caps->cmd_terminate = true;
-	caps->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	caps->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 
 	return 0;
 }
-- 
1.7.4.4
