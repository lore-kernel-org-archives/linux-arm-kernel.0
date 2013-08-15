From: zonque@gmail.com (Daniel Mack)
Date: Thu, 15 Aug 2013 09:44:07 +0200
Subject: [v4 1/2] dma: mmp_pdma: add support for residue reporting
Message-ID: <1376552648-4291-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to report the channel's residue, we walk the list of running
descriptors, look for those which match the cookie, and then try to find
the descriptor which defines upper and lower boundaries that embrace the
current transport pointer.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
v3 -> v4:
	* consider multiple transactions on a channel, and look up
	  the cookie in the queued descriptors (suggested by Chao Xie)

v2 -> v3:
	* walk the list of all descriptors to support real scattered
	  lists (suggested by Russell King)

v1 -> v2:
	* rebased

 drivers/dma/mmp_pdma.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 579f79a..50df0b3 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -28,8 +28,8 @@
 #define DALGN		0x00a0
 #define DINT		0x00f0
 #define DDADR		0x0200
-#define DSADR		0x0204
-#define DTADR		0x0208
+#define DSADR(n)	(0x0204 + ((n) << 4))
+#define DTADR(n)	(0x0208 + ((n) << 4))
 #define DCMD		0x020c
 
 #define DCSR_RUN	(1 << 31)	/* Run Bit (read / write) */
@@ -666,6 +666,43 @@ static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
 	return ret;
 }
 
+static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
+				     dma_cookie_t cookie)
+{
+	struct mmp_pdma_desc_sw *sw;
+	u32 curr, residue = 0;
+	bool passed = false;
+
+	if (chan->dir == DMA_DEV_TO_MEM)
+		curr = readl(chan->phy->base + DTADR(chan->phy->idx));
+	else
+		curr = readl(chan->phy->base + DSADR(chan->phy->idx));
+
+	list_for_each_entry(sw, &chan->chain_running, node) {
+		u32 start, end, len;
+
+		if (sw->async_tx.cookie != cookie)
+			continue;
+
+		if (chan->dir == DMA_DEV_TO_MEM)
+			start = sw->desc.dtadr;
+		else
+			start = sw->desc.dsadr;
+
+		len = sw->desc.dcmd & DCMD_LENGTH;
+		end = start + len;
+
+		if (passed) {
+			residue += len;
+		} else if (curr >= start && curr <= end) {
+			residue += end - curr;
+			passed = true;
+		}
+	}
+
+	return residue;
+}
+
 static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
 			dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
@@ -675,6 +712,7 @@ static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
 
 	spin_lock_irqsave(&chan->desc_lock, flags);
 	ret = dma_cookie_status(dchan, cookie, txstate);
+	txstate->residue = mmp_pdma_residue(chan, cookie);
 	spin_unlock_irqrestore(&chan->desc_lock, flags);
 
 	return ret;
-- 
1.8.3.1
