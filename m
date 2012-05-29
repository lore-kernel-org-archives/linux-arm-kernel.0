From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:45:21 +0100
Subject: [RFC 30/34] dmaengine: PL08x: convert to use vchan done list
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIzR-00070l-78@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert to use the virtual dma channel done list, tasklet, and
descriptor freeing.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |  135 ++++++++++++++++++---------------------------
 1 files changed, 54 insertions(+), 81 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index eb556c5..2b9fe0e 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -160,16 +160,16 @@ struct pl08x_sg {
 /**
  * struct pl08x_txd - wrapper for struct dma_async_tx_descriptor
  * @vd: virtual DMA descriptor
- * @node: node for txd list for channels
  * @dsg_list: list of children sg's
  * @llis_bus: DMA memory address (physical) start for the LLIs
  * @llis_va: virtual memory address start for the LLIs
  * @cctl: control reg values for current txd
  * @ccfg: config reg values for current txd
+ * @done: this marks completed descriptors, which should not have their
+ *   mux released.
  */
 struct pl08x_txd {
 	struct virt_dma_desc vd;
-	struct list_head node;
 	struct list_head dsg_list;
 	dma_addr_t llis_bus;
 	struct pl08x_lli *llis_va;
@@ -180,6 +180,7 @@ struct pl08x_txd {
 	 * trigger this txd.  Other registers are in llis_va[0].
 	 */
 	u32 ccfg;
+	bool done;
 };
 
 /**
@@ -204,11 +205,9 @@ enum pl08x_dma_chan_state {
  * struct pl08x_dma_chan - this structure wraps a DMA ENGINE channel
  * @vc: wrappped virtual channel
  * @phychan: the physical channel utilized by this channel, if there is one
- * @tasklet: tasklet scheduled by the IRQ to handle actual work etc
  * @name: name of channel
  * @cd: channel platform data
  * @runtime_addr: address for RX/TX according to the runtime config
- * @done_list: list of completed transactions
  * @at: active transaction on this channel
  * @lock: a lock for this channel data
  * @host: a pointer to the host (internal use)
@@ -220,11 +219,9 @@ enum pl08x_dma_chan_state {
 struct pl08x_dma_chan {
 	struct virt_dma_chan vc;
 	struct pl08x_phy_chan *phychan;
-	struct tasklet_struct tasklet;
 	const char *name;
 	const struct pl08x_channel_data *cd;
 	struct dma_slave_config cfg;
-	struct list_head done_list;
 	struct pl08x_txd *at;
 	struct pl08x_driver_data *host;
 	enum pl08x_dma_chan_state state;
@@ -1077,6 +1074,52 @@ static void pl08x_free_txd(struct pl08x_driver_data *pl08x,
 	kfree(txd);
 }
 
+static void pl08x_unmap_buffers(struct pl08x_txd *txd)
+{
+	struct device *dev = txd->vd.tx.chan->device->dev;
+	struct pl08x_sg *dsg;
+
+	if (!(txd->vd.tx.flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
+		if (txd->vd.tx.flags & DMA_COMPL_SRC_UNMAP_SINGLE)
+			list_for_each_entry(dsg, &txd->dsg_list, node)
+				dma_unmap_single(dev, dsg->src_addr, dsg->len,
+						DMA_TO_DEVICE);
+		else {
+			list_for_each_entry(dsg, &txd->dsg_list, node)
+				dma_unmap_page(dev, dsg->src_addr, dsg->len,
+						DMA_TO_DEVICE);
+		}
+	}
+	if (!(txd->vd.tx.flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
+		if (txd->vd.tx.flags & DMA_COMPL_DEST_UNMAP_SINGLE)
+			list_for_each_entry(dsg, &txd->dsg_list, node)
+				dma_unmap_single(dev, dsg->dst_addr, dsg->len,
+						DMA_FROM_DEVICE);
+		else
+			list_for_each_entry(dsg, &txd->dsg_list, node)
+				dma_unmap_page(dev, dsg->dst_addr, dsg->len,
+						DMA_FROM_DEVICE);
+	}
+}
+
+static void pl08x_desc_free(struct virt_dma_desc *vd)
+{
+	struct pl08x_txd *txd = to_pl08x_txd(&vd->tx);
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(vd->tx.chan);
+	struct pl08x_driver_data *pl08x = plchan->host;
+	unsigned long flags;
+
+	if (!plchan->slave)
+		pl08x_unmap_buffers(txd);
+
+	if (!txd->done)
+		pl08x_release_mux(plchan);
+
+	spin_lock_irqsave(&pl08x->lock, flags);
+	pl08x_free_txd(plchan->host, txd);
+	spin_unlock_irqrestore(&pl08x->lock, flags);
+}
+
 static void pl08x_free_txd_list(struct pl08x_driver_data *pl08x,
 				struct pl08x_dma_chan *plchan)
 {
@@ -1087,9 +1130,8 @@ static void pl08x_free_txd_list(struct pl08x_driver_data *pl08x,
 
 	while (!list_empty(&head)) {
 		txd = list_first_entry(&head, struct pl08x_txd, vd.node);
-		pl08x_release_mux(plchan);
 		list_del(&txd->vd.node);
-		pl08x_free_txd(pl08x, txd);
+		pl08x_desc_free(&txd->vd);
 	}
 }
 
@@ -1534,9 +1576,7 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		}
 		/* Dequeue jobs and free LLIs */
 		if (plchan->at) {
-			/* Killing this one off, release its mux */
-			pl08x_release_mux(plchan);
-			pl08x_free_txd(pl08x, plchan->at);
+			pl08x_desc_free(&plchan->at->vd);
 			plchan->at = NULL;
 		}
 		/* Dequeue jobs not yet fired as well */
@@ -1590,68 +1630,6 @@ static void pl08x_ensure_on(struct pl08x_driver_data *pl08x)
 	writel(PL080_CONFIG_ENABLE, pl08x->base + PL080_CONFIG);
 }
 
-static void pl08x_unmap_buffers(struct pl08x_txd *txd)
-{
-	struct device *dev = txd->vd.tx.chan->device->dev;
-	struct pl08x_sg *dsg;
-
-	if (!(txd->vd.tx.flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
-		if (txd->vd.tx.flags & DMA_COMPL_SRC_UNMAP_SINGLE)
-			list_for_each_entry(dsg, &txd->dsg_list, node)
-				dma_unmap_single(dev, dsg->src_addr, dsg->len,
-						DMA_TO_DEVICE);
-		else {
-			list_for_each_entry(dsg, &txd->dsg_list, node)
-				dma_unmap_page(dev, dsg->src_addr, dsg->len,
-						DMA_TO_DEVICE);
-		}
-	}
-	if (!(txd->vd.tx.flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
-		if (txd->vd.tx.flags & DMA_COMPL_DEST_UNMAP_SINGLE)
-			list_for_each_entry(dsg, &txd->dsg_list, node)
-				dma_unmap_single(dev, dsg->dst_addr, dsg->len,
-						DMA_FROM_DEVICE);
-		else
-			list_for_each_entry(dsg, &txd->dsg_list, node)
-				dma_unmap_page(dev, dsg->dst_addr, dsg->len,
-						DMA_FROM_DEVICE);
-	}
-}
-
-static void pl08x_tasklet(unsigned long data)
-{
-	struct pl08x_dma_chan *plchan = (struct pl08x_dma_chan *) data;
-	struct pl08x_driver_data *pl08x = plchan->host;
-	unsigned long flags;
-	LIST_HEAD(head);
-
-	spin_lock_irqsave(&plchan->vc.lock, flags);
-	list_splice_tail_init(&plchan->done_list, &head);
-	spin_unlock_irqrestore(&plchan->vc.lock, flags);
-
-	while (!list_empty(&head)) {
-		struct pl08x_txd *txd = list_first_entry(&head,
-						struct pl08x_txd, node);
-		dma_async_tx_callback callback = txd->vd.tx.callback;
-		void *callback_param = txd->vd.tx.callback_param;
-
-		list_del(&txd->node);
-
-		/* Don't try to unmap buffers on slave channels */
-		if (!plchan->slave)
-			pl08x_unmap_buffers(txd);
-
-		/* Free the descriptor */
-		spin_lock_irqsave(&plchan->vc.lock, flags);
-		pl08x_free_txd(pl08x, txd);
-		spin_unlock_irqrestore(&plchan->vc.lock, flags);
-
-		/* Callback to signal completion */
-		if (callback)
-			callback(callback_param);
-	}
-}
-
 static irqreturn_t pl08x_irq(int irq, void *dev)
 {
 	struct pl08x_driver_data *pl08x = dev;
@@ -1694,8 +1672,8 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 				 * reservation.
 				 */
 				pl08x_release_mux(plchan);
-				dma_cookie_complete(&tx->vd.tx);
-				list_add_tail(&tx->node, &plchan->done_list);
+				tx->done = true;
+				vchan_cookie_complete(&tx->vd);
 
 				/*
 				 * And start the next descriptor (if any),
@@ -1708,8 +1686,6 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 			}
 			spin_unlock(&plchan->vc.lock);
 
-			/* Schedule tasklet on this channel */
-			tasklet_schedule(&plchan->tasklet);
 			mask |= (1 << i);
 		}
 	}
@@ -1769,10 +1745,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 			 "initialize virtual channel \"%s\"\n",
 			 chan->name);
 
-		INIT_LIST_HEAD(&chan->done_list);
-		tasklet_init(&chan->tasklet, pl08x_tasklet,
-			     (unsigned long) chan);
-
+		chan->vc.desc_free = pl08x_desc_free;
 		vchan_init(&chan->vc, dmadev);
 	}
 	dev_info(&pl08x->adev->dev, "initialized %d virtual %s channels\n",
-- 
1.7.4.4
