From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:44:36 +0000
Subject: [PATCH 43/48] ARM: PL08x: rename 'desc_list' as 'pend_list'
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt8m-0003SC-Nx@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This 'desc_list' is actually a list of pending descriptors, so name
it after its function (pending list) rather than what it contains
(descriptors).

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   20 ++++++++++----------
 include/linux/amba/pl08x.h |    4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index fb469de..433b9e7 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -348,9 +348,9 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 	}
 
 	/* Sum up all queued transactions */
-	if (!list_empty(&plchan->desc_list)) {
+	if (!list_empty(&plchan->pend_list)) {
 		struct pl08x_txd *txdi;
-		list_for_each_entry(txdi, &plchan->desc_list, node) {
+		list_for_each_entry(txdi, &plchan->pend_list, node) {
 			bytes += txdi->len;
 		}
 	}
@@ -880,9 +880,9 @@ static void pl08x_free_txd_list(struct pl08x_driver_data *pl08x,
 	struct pl08x_txd *txdi = NULL;
 	struct pl08x_txd *next;
 
-	if (!list_empty(&plchan->desc_list)) {
+	if (!list_empty(&plchan->pend_list)) {
 		list_for_each_entry_safe(txdi,
-					 next, &plchan->desc_list, node) {
+					 next, &plchan->pend_list, node) {
 			list_del(&txdi->node);
 			pl08x_free_txd(pl08x, txdi);
 		}
@@ -1183,10 +1183,10 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 	}
 
 	/* Take the first element in the queue and execute it */
-	if (!list_empty(&plchan->desc_list)) {
+	if (!list_empty(&plchan->pend_list)) {
 		struct pl08x_txd *next;
 
-		next = list_first_entry(&plchan->desc_list,
+		next = list_first_entry(&plchan->pend_list,
 					struct pl08x_txd,
 					node);
 		list_del(&next->node);
@@ -1213,7 +1213,7 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 
 	spin_lock_irqsave(&plchan->lock, plchan->lockflags);
 
-	list_add_tail(&txd->node, &plchan->desc_list);
+	list_add_tail(&txd->node, &plchan->pend_list);
 
 	/*
 	 * See if we already have a physical channel allocated,
@@ -1571,10 +1571,10 @@ static void pl08x_tasklet(unsigned long data)
 	 * If a new descriptor is queued, set it up
 	 * plchan->at is NULL here
 	 */
-	if (!list_empty(&plchan->desc_list)) {
+	if (!list_empty(&plchan->pend_list)) {
 		struct pl08x_txd *next;
 
-		next = list_first_entry(&plchan->desc_list,
+		next = list_first_entry(&plchan->pend_list,
 					struct pl08x_txd,
 					node);
 		list_del(&next->node);
@@ -1736,7 +1736,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 		chan->lc = 0;
 
 		spin_lock_init(&chan->lock);
-		INIT_LIST_HEAD(&chan->desc_list);
+		INIT_LIST_HEAD(&chan->pend_list);
 		tasklet_init(&chan->tasklet, pl08x_tasklet,
 			     (unsigned long) chan);
 
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 4e9e718..08a9024 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -158,7 +158,7 @@ enum pl08x_dma_chan_state {
  * @runtime_direction: current direction of this channel according to
  * runtime config
  * @lc: last completed transaction on this channel
- * @desc_list: queued transactions pending on this channel
+ * @pend_list: queued transactions pending on this channel
  * @at: active transaction on this channel
  * @lockflags: sometimes we let a lock last between two function calls,
  * especially prep/submit, and then we need to store the IRQ flags
@@ -179,7 +179,7 @@ struct pl08x_dma_chan {
 	dma_addr_t runtime_addr;
 	enum dma_data_direction	runtime_direction;
 	dma_cookie_t lc;
-	struct list_head desc_list;
+	struct list_head pend_list;
 	struct pl08x_txd *at;
 	unsigned long lockflags;
 	spinlock_t lock;
-- 
1.6.2.5
