From: zonque@gmail.com (Daniel Mack)
Date: Fri, 16 Aug 2013 19:05:06 +0200
Subject: [PATCH v4 3/4] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <1376672707-24527-1-git-send-email-zonque@gmail.com>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
Message-ID: <1376672707-24527-4-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to report the channel's residue, we walk the list of running
descriptors, look for those which match the cookie, and then try to find
the descriptor which defines upper and lower boundaries that embrace the
current transport pointer.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 0be99a6..b29b581 100644
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
@@ -759,6 +759,78 @@ static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
 	return ret;
 }
 
+static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
+				     dma_cookie_t cookie)
+{
+	struct mmp_pdma_desc_sw *sw;
+	u32 curr, residue = 0;
+	bool passed = false;
+	bool cyclic = chan->cyclic_first != NULL;
+
+	/*
+	 * If the channel does not have a phy pointer anymore, it has already
+	 * been completed. Therefore, its residue is 0.
+	 */
+	if (!chan->phy)
+		return 0;
+
+	if (chan->dir == DMA_DEV_TO_MEM)
+		curr = readl(chan->phy->base + DTADR(chan->phy->idx));
+	else
+		curr = readl(chan->phy->base + DSADR(chan->phy->idx));
+
+	list_for_each_entry(sw, &chan->chain_running, node) {
+		u32 start, end, len;
+
+		if (chan->dir == DMA_DEV_TO_MEM)
+			start = sw->desc.dtadr;
+		else
+			start = sw->desc.dsadr;
+
+		len = sw->desc.dcmd & DCMD_LENGTH;
+		end = start + len;
+
+		/*
+		 * 'passed' will be latched once we found the descriptor which
+		 * lies inside the boundaries of the curr pointer. All
+		 * descriptors that occur in the list _after_ we found that
+		 * partially handled descriptor are still to be processed and
+		 * are hence added to the residual bytes counter.
+		 */
+		if (passed) {
+			residue += len;
+		} else if (curr >= start && curr <= end) {
+			residue += end - curr;
+			passed = true;
+		}
+
+		/*
+		 * Descriptors that have the ENDIRQEN bit set mark the end of a
+		 * transaction chain, and the cookie assigned with it has been
+		 * returned previously from mmp_pdma_tx_submit().
+		 *
+		 * In case we have multiple transactions in the running chain,
+		 * and the cookie does not match the one the user asked us
+		 * about, reset the state variables and start over.
+		 *
+		 * This logic does not apply to cyclic transactions, where all
+		 * descriptors have the ENDIRQEN bit set, and for which we
+		 * can't have multiple transactions on one channel anyway.
+		 */
+		if (!cyclic && (sw->desc.dcmd & DCMD_ENDIRQEN)) {
+			if (sw->async_tx.cookie != cookie) {
+				residue = 0;
+				passed = false;
+			} else {
+				return residue;
+			}
+		}
+	}
+
+	/* We should only get here in case of cyclic transactions */
+	return residue;
+}
+
 static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
 			dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
@@ -768,6 +840,7 @@ static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
 
 	spin_lock_irqsave(&chan->desc_lock, flags);
 	ret = dma_cookie_status(dchan, cookie, txstate);
+	txstate->residue = mmp_pdma_residue(chan, cookie);
 	spin_unlock_irqrestore(&chan->desc_lock, flags);
 
 	return ret;
-- 
1.8.3.1
