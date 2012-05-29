From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:43:20 +0100
Subject: [RFC 24/34] dmaengine: PL08x: split the pend_list in two
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIxU-00070J-HB@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our behaviour wasn't correct; issue_pending is supposed to be called
before any submitted descriptors are available for processing by the
DMA engine.  Split the pend_list in two, one for submitted descriptors
and another list for issued descriptors.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   41 ++++++++++++++++++++++++++++-------------
 1 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 1eb5885..4788ec0 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -210,6 +210,7 @@ enum pl08x_dma_chan_state {
  * @cd: channel platform data
  * @runtime_addr: address for RX/TX according to the runtime config
  * @pend_list: queued transactions pending on this channel
+ * @issued_list: issued transactions for this channel
  * @done_list: list of completed transactions
  * @at: active transaction on this channel
  * @lock: a lock for this channel data
@@ -228,6 +229,7 @@ struct pl08x_dma_chan {
 	const struct pl08x_channel_data *cd;
 	struct dma_slave_config cfg;
 	struct list_head pend_list;
+	struct list_head issued_list;
 	struct list_head done_list;
 	struct pl08x_txd *at;
 	spinlock_t lock;
@@ -355,7 +357,7 @@ static void pl08x_start_next_txd(struct pl08x_dma_chan *plchan)
 	struct pl08x_txd *txd;
 	u32 val;
 
-	txd = list_first_entry(&plchan->pend_list, struct pl08x_txd, node);
+	txd = list_first_entry(&plchan->issued_list, struct pl08x_txd, node);
 	list_del(&txd->node);
 
 	plchan->at = txd;
@@ -518,6 +520,15 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 	}
 
 	/* Sum up all queued transactions */
+	if (!list_empty(&plchan->issued_list)) {
+		struct pl08x_txd *txdi;
+		list_for_each_entry(txdi, &plchan->issued_list, node) {
+			struct pl08x_sg *dsg;
+			list_for_each_entry(dsg, &txd->dsg_list, node)
+				bytes += dsg->len;
+		}
+	}
+
 	if (!list_empty(&plchan->pend_list)) {
 		struct pl08x_txd *txdi;
 		list_for_each_entry(txdi, &plchan->pend_list, node) {
@@ -984,16 +995,17 @@ static void pl08x_free_txd(struct pl08x_driver_data *pl08x,
 static void pl08x_free_txd_list(struct pl08x_driver_data *pl08x,
 				struct pl08x_dma_chan *plchan)
 {
-	struct pl08x_txd *txdi = NULL;
-	struct pl08x_txd *next;
+	LIST_HEAD(head);
+	struct pl08x_txd *txd;
 
-	if (!list_empty(&plchan->pend_list)) {
-		list_for_each_entry_safe(txdi,
-					 next, &plchan->pend_list, node) {
-			pl08x_release_mux(plchan);
-			list_del(&txdi->node);
-			pl08x_free_txd(pl08x, txdi);
-		}
+	list_splice_tail_init(&plchan->issued_list, &head);
+	list_splice_tail_init(&plchan->pend_list, &head);
+
+	while (!list_empty(&head)) {
+		txd = list_first_entry(&head, struct pl08x_txd, node);
+		pl08x_release_mux(plchan);
+		list_del(&txd->node);
+		pl08x_free_txd(pl08x, txd);
 	}
 }
 
@@ -1262,6 +1274,8 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 	unsigned long flags;
 
 	spin_lock_irqsave(&plchan->lock, flags);
+	list_splice_tail_init(&plchan->pend_list, &plchan->issued_list);
+
 	/* Something is already active, or we're waiting for a channel... */
 	if (plchan->at || plchan->state == PL08X_CHAN_WAITING) {
 		spin_unlock_irqrestore(&plchan->lock, flags);
@@ -1269,7 +1283,7 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 	}
 
 	/* Take the first element in the queue and execute it */
-	if (!list_empty(&plchan->pend_list)) {
+	if (!list_empty(&plchan->issued_list)) {
 		plchan->state = PL08X_CHAN_RUNNING;
 		pl08x_start_next_txd(plchan);
 	}
@@ -1648,9 +1662,9 @@ static void pl08x_tasklet(unsigned long data)
 	list_splice_tail_init(&plchan->done_list, &head);
 
 	/* If a new descriptor is queued, set it up plchan->at is NULL here */
-	if (!list_empty(&plchan->pend_list)) {
+	if (!list_empty(&plchan->issued_list)) {
 		pl08x_start_next_txd(plchan);
-	} else if (plchan->phychan_hold) {
+	} else if (!list_empty(&plchan->pend_list) || plchan->phychan_hold) {
 		/*
 		 * This channel is still in use - we have a new txd being
 		 * prepared and will soon be queued.  Don't give up the
@@ -1831,6 +1845,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 
 		spin_lock_init(&chan->lock);
 		INIT_LIST_HEAD(&chan->pend_list);
+		INIT_LIST_HEAD(&chan->issued_list);
 		INIT_LIST_HEAD(&chan->done_list);
 		tasklet_init(&chan->tasklet, pl08x_tasklet,
 			     (unsigned long) chan);
-- 
1.7.4.4
