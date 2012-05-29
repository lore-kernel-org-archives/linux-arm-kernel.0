From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:45:41 +0100
Subject: [RFC 31/34] dmaengine: PL08x: fix tx_status function to return
 correct residue
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIzl-00070v-B1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we're converted to use the generic vchan support, we can fix
the residue return from tx_status to be compliant with dmaengine.  This
returns the number of bytes remaining for the _specified_ cookie, not
the number of bytes in all pending transfers on the channel.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   61 +++++++++++++++++++++++++--------------------
 1 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 2b9fe0e..a8f2b20 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -466,10 +466,8 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_phy_chan *ch;
 	struct pl08x_txd *txd;
-	unsigned long flags;
 	size_t bytes = 0;
 
-	spin_lock_irqsave(&plchan->vc.lock, flags);
 	ch = plchan->phychan;
 	txd = plchan->at;
 
@@ -509,27 +507,6 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 		}
 	}
 
-	/* Sum up all queued transactions */
-	if (!list_empty(&plchan->vc.desc_issued)) {
-		struct pl08x_txd *txdi;
-		list_for_each_entry(txdi, &plchan->vc.desc_issued, vd.node) {
-			struct pl08x_sg *dsg;
-			list_for_each_entry(dsg, &txd->dsg_list, node)
-				bytes += dsg->len;
-		}
-	}
-
-	if (!list_empty(&plchan->vc.desc_submitted)) {
-		struct pl08x_txd *txdi;
-		list_for_each_entry(txdi, &plchan->vc.desc_submitted, vd.node) {
-			struct pl08x_sg *dsg;
-			list_for_each_entry(dsg, &txd->dsg_list, node)
-				bytes += dsg->len;
-		}
-	}
-
-	spin_unlock_irqrestore(&plchan->vc.lock, flags);
-
 	return bytes;
 }
 
@@ -1164,23 +1141,53 @@ static enum dma_status pl08x_dma_tx_status(struct dma_chan *chan,
 		dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+	struct virt_dma_desc *vd;
+	unsigned long flags;
 	enum dma_status ret;
+	size_t bytes = 0;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_SUCCESS)
 		return ret;
 
 	/*
+	 * There's no point calculating the residue if there's
+	 * no txstate to store the value.
+	 */
+	if (!txstate) {
+		if (plchan->state == PL08X_CHAN_PAUSED)
+			ret = DMA_PAUSED;
+		return ret;
+	}
+
+	spin_lock_irqsave(&plchan->vc.lock, flags);
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret != DMA_SUCCESS) {
+		vd = vchan_find_desc(&plchan->vc, cookie);
+		if (vd) {
+			/* On the issued list, so hasn't been processed yet */
+			struct pl08x_txd *txd = to_pl08x_txd(&vd->tx);
+			struct pl08x_sg *dsg;
+
+			list_for_each_entry(dsg, &txd->dsg_list, node)
+				bytes += dsg->len;
+		} else {
+			bytes = pl08x_getbytes_chan(plchan);
+		}
+	}
+	spin_unlock_irqrestore(&plchan->vc.lock, flags);
+
+	/*
 	 * This cookie not complete yet
 	 * Get number of bytes left in the active transactions and queue
 	 */
-	dma_set_residue(txstate, pl08x_getbytes_chan(plchan));
+	dma_set_residue(txstate, bytes);
 
-	if (plchan->state == PL08X_CHAN_PAUSED)
-		return DMA_PAUSED;
+	if (plchan->state == PL08X_CHAN_PAUSED && ret == DMA_IN_PROGRESS)
+		ret = DMA_PAUSED;
 
 	/* Whether waiting or running, we're in progress */
-	return DMA_IN_PROGRESS;
+	return ret;
 }
 
 /* PrimeCell DMA extension */
-- 
1.7.4.4
