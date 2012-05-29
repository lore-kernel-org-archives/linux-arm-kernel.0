From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:43:00 +0100
Subject: [RFC 23/34] dmaengine: PL08x: re-jig the starting of txds
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIxA-00070E-Dc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than code the de-queue of the txd several times, move that into
the start_txd function.  Rename this to better illustrate what it's
now doing, and call this function when starting a delayed memcpy().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   37 +++++++++++++++++--------------------
 1 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index e1922f3..1eb5885 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -347,20 +347,25 @@ static int pl08x_phy_channel_busy(struct pl08x_phy_chan *ch)
  * been set when the LLIs were constructed.  Poke them into the hardware
  * and start the transfer.
  */
-static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
-	struct pl08x_txd *txd)
+static void pl08x_start_next_txd(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_phy_chan *phychan = plchan->phychan;
-	struct pl08x_lli *lli = &txd->llis_va[0];
+	struct pl08x_lli *lli;
+	struct pl08x_txd *txd;
 	u32 val;
 
+	txd = list_first_entry(&plchan->pend_list, struct pl08x_txd, node);
+	list_del(&txd->node);
+
 	plchan->at = txd;
 
 	/* Wait for channel inactive */
 	while (pl08x_phy_channel_busy(phychan))
 		cpu_relax();
 
+	lli = &txd->llis_va[0];
+
 	dev_vdbg(&pl08x->adev->dev,
 		"WRITE channel %d: csrc=0x%08x, cdst=0x%08x, "
 		"clli=0x%08x, cctl=0x%08x, ccfg=0x%08x\n",
@@ -1265,15 +1270,8 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 
 	/* Take the first element in the queue and execute it */
 	if (!list_empty(&plchan->pend_list)) {
-		struct pl08x_txd *next;
-
-		next = list_first_entry(&plchan->pend_list,
-					struct pl08x_txd,
-					node);
-		list_del(&next->node);
 		plchan->state = PL08X_CHAN_RUNNING;
-
-		pl08x_start_txd(plchan, next);
+		pl08x_start_next_txd(plchan);
 	}
 
 	spin_unlock_irqrestore(&plchan->lock, flags);
@@ -1651,14 +1649,7 @@ static void pl08x_tasklet(unsigned long data)
 
 	/* If a new descriptor is queued, set it up plchan->at is NULL here */
 	if (!list_empty(&plchan->pend_list)) {
-		struct pl08x_txd *next;
-
-		next = list_first_entry(&plchan->pend_list,
-					struct pl08x_txd,
-					node);
-		list_del(&next->node);
-
-		pl08x_start_txd(plchan, next);
+		pl08x_start_next_txd(plchan);
 	} else if (plchan->phychan_hold) {
 		/*
 		 * This channel is still in use - we have a new txd being
@@ -1690,7 +1681,13 @@ static void pl08x_tasklet(unsigned long data)
 				BUG_ON(ret);
 				waiting->phychan_hold--;
 				waiting->state = PL08X_CHAN_RUNNING;
-				pl08x_issue_pending(&waiting->chan);
+				/*
+				 * Eww.  We know this isn't going to deadlock
+				 * but lockdep probably doens't.
+				 */
+				spin_lock(&waiting->lock);
+				pl08x_start_next_txd(waiting);
+				spin_unlock(&waiting->lock);
 				break;
 			}
 		}
-- 
1.7.4.4
