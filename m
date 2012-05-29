From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:42:00 +0100
Subject: [RFC 20/34] dmaengine: PL08x: convert to a list of completed
 descriptors
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIwC-000702-2j@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert PL08x to use a list of completed descriptors rather than
merely relying upon a single pointer.  This makes it possible to
schedule the tasklet for other purposes, and makes our behaviour
similar to virt-dma.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 3532833..93464ee 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -212,6 +212,7 @@ enum pl08x_dma_chan_state {
  * @cd: channel platform data
  * @runtime_addr: address for RX/TX according to the runtime config
  * @pend_list: queued transactions pending on this channel
+ * @done_list: list of completed transactions
  * @at: active transaction on this channel
  * @lock: a lock for this channel data
  * @host: a pointer to the host (internal use)
@@ -231,6 +232,7 @@ struct pl08x_dma_chan {
 	const struct pl08x_channel_data *cd;
 	struct dma_slave_config cfg;
 	struct list_head pend_list;
+	struct list_head done_list;
 	struct pl08x_txd *at;
 	spinlock_t lock;
 	struct pl08x_driver_data *host;
@@ -1663,18 +1665,11 @@ static void pl08x_tasklet(unsigned long data)
 {
 	struct pl08x_dma_chan *plchan = (struct pl08x_dma_chan *) data;
 	struct pl08x_driver_data *pl08x = plchan->host;
-	struct pl08x_txd *txd;
 	unsigned long flags;
+	LIST_HEAD(head);
 
 	spin_lock_irqsave(&plchan->lock, flags);
-
-	txd = plchan->at;
-	plchan->at = NULL;
-
-	if (txd) {
-		/* Update last completed */
-		dma_cookie_complete(&txd->tx);
-	}
+	list_splice_tail_init(&plchan->done_list, &head);
 
 	/* If a new descriptor is queued, set it up plchan->at is NULL here */
 	if (!list_empty(&plchan->pend_list)) {
@@ -1729,10 +1724,14 @@ static void pl08x_tasklet(unsigned long data)
 
 	spin_unlock_irqrestore(&plchan->lock, flags);
 
-	if (txd) {
+	while (!list_empty(&head)) {
+		struct pl08x_txd *txd = list_first_entry(&head,
+						struct pl08x_txd, node);
 		dma_async_tx_callback callback = txd->tx.callback;
 		void *callback_param = txd->tx.callback_param;
 
+		list_del(&txd->node);
+
 		/* Don't try to unmap buffers on slave channels */
 		if (!plchan->slave)
 			pl08x_unmap_buffers(txd);
@@ -1772,6 +1771,7 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 			/* Locate physical channel */
 			struct pl08x_phy_chan *phychan = &pl08x->phy_chans[i];
 			struct pl08x_dma_chan *plchan = phychan->serving;
+			struct pl08x_txd *tx;
 
 			if (!plchan) {
 				dev_err(&pl08x->adev->dev,
@@ -1780,6 +1780,15 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 				continue;
 			}
 
+			spin_lock(&plchan->lock);
+			tx = plchan->at;
+			if (tx) {
+				plchan->at = NULL;
+				dma_cookie_complete(&tx->tx);
+				list_add_tail(&tx->node, &plchan->done_list);
+			}
+			spin_unlock(&plchan->lock);
+
 			/* Schedule tasklet on this channel */
 			tasklet_schedule(&plchan->tasklet);
 			mask |= (1 << i);
@@ -1846,6 +1855,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 
 		spin_lock_init(&chan->lock);
 		INIT_LIST_HEAD(&chan->pend_list);
+		INIT_LIST_HEAD(&chan->done_list);
 		tasklet_init(&chan->tasklet, pl08x_tasklet,
 			     (unsigned long) chan);
 
-- 
1.7.4.4
