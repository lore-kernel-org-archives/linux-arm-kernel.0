From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun,  6 Sep 2015 13:40:52 +0200
Subject: [PATCH 1/3] dmaengine: virt-dma: don't always free descriptor upon
 completion
Message-ID: <1441539654-19055-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch attempts to enhance the case of a transfer submitted multiple
times, and where the cost of creating the descriptors chain is not
negligible.

This happens with big video buffers (several megabytes, ie. several
thousands of linked descriptors in one scatter-gather list). In these
cases, a video driver would want to do :
 - tx = dmaengine_prep_slave_sg()
 - dma_engine_submit(tx);
 - dma_async_issue_pending()
 - wait for video completion
 - read video data (or not, skipping a frame is also possible)
 - dma_engine_submit(tx)
   => here, the descriptors chain recalculation will take time
   => the dma coherent allocation over and over might create holes in
      the dma pool, which is counter-productive.
 - dma_async_issue_pending()
 - etc ...

In order to cope with this case, virt-dma is modified to prevent freeing
the descriptors upon completion if DMA_CTRL_REUSE flag is set in the
transfer.

This patch is a respin of the former DMA_CTRL_ACK approach, which was
reverted due to a regression in audio drivers.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/virt-dma.c | 36 ++++++++++++++++++++++++++++++------
 drivers/dma/virt-dma.h | 15 ++++++++++++++-
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index 6f80432a3f0a..e33caa87cbbb 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -29,7 +29,7 @@ dma_cookie_t vchan_tx_submit(struct dma_async_tx_descriptor *tx)
 	spin_lock_irqsave(&vc->lock, flags);
 	cookie = dma_cookie_assign(tx);
 
-	list_add_tail(&vd->node, &vc->desc_submitted);
+	list_move_tail(&vd->node, &vc->desc_submitted);
 	spin_unlock_irqrestore(&vc->lock, flags);
 
 	dev_dbg(vc->chan.device->dev, "vchan %p: txd %p[%x]: submitted\n",
@@ -39,6 +39,23 @@ dma_cookie_t vchan_tx_submit(struct dma_async_tx_descriptor *tx)
 }
 EXPORT_SYMBOL_GPL(vchan_tx_submit);
 
+int vchan_tx_desc_free(struct dma_async_tx_descriptor *tx)
+{
+	struct virt_dma_chan *vc = to_virt_chan(tx->chan);
+	struct virt_dma_desc *vd = to_virt_desc(tx);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vc->lock, flags);
+	list_del(&vd->node);
+	spin_unlock_irqrestore(&vc->lock, flags);
+
+	dev_dbg(vc->chan.device->dev, "vchan %p: txd %p[%x]: freeing\n",
+		vc, vd, vd->tx.cookie);
+	vc->desc_free(vd);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vchan_tx_desc_free);
+
 struct virt_dma_desc *vchan_find_desc(struct virt_dma_chan *vc,
 	dma_cookie_t cookie)
 {
@@ -83,8 +100,10 @@ static void vchan_complete(unsigned long arg)
 		cb_data = vd->tx.callback_param;
 
 		list_del(&vd->node);
-
-		vc->desc_free(vd);
+		if (dmaengine_desc_test_reuse(&vd->tx))
+			list_add(&vd->node, &vc->desc_allocated);
+		else
+			vc->desc_free(vd);
 
 		if (cb)
 			cb(cb_data);
@@ -96,9 +115,13 @@ void vchan_dma_desc_free_list(struct virt_dma_chan *vc, struct list_head *head)
 	while (!list_empty(head)) {
 		struct virt_dma_desc *vd = list_first_entry(head,
 			struct virt_dma_desc, node);
-		list_del(&vd->node);
-		dev_dbg(vc->chan.device->dev, "txd %p: freeing\n", vd);
-		vc->desc_free(vd);
+		if (dmaengine_desc_test_reuse(&vd->tx)) {
+			list_move_tail(&vd->node, &vc->desc_allocated);
+		} else {
+			dev_dbg(vc->chan.device->dev, "txd %p: freeing\n", vd);
+			list_del(&vd->node);
+			vc->desc_free(vd);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(vchan_dma_desc_free_list);
@@ -108,6 +131,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
 	dma_cookie_init(&vc->chan);
 
 	spin_lock_init(&vc->lock);
+	INIT_LIST_HEAD(&vc->desc_allocated);
 	INIT_LIST_HEAD(&vc->desc_submitted);
 	INIT_LIST_HEAD(&vc->desc_issued);
 	INIT_LIST_HEAD(&vc->desc_completed);
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 181b95267866..a4156af93d88 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -29,6 +29,7 @@ struct virt_dma_chan {
 	spinlock_t lock;
 
 	/* protected by vc.lock */
+	struct list_head desc_allocated;
 	struct list_head desc_submitted;
 	struct list_head desc_issued;
 	struct list_head desc_completed;
@@ -55,10 +56,17 @@ static inline struct dma_async_tx_descriptor *vchan_tx_prep(struct virt_dma_chan
 	struct virt_dma_desc *vd, unsigned long tx_flags)
 {
 	extern dma_cookie_t vchan_tx_submit(struct dma_async_tx_descriptor *);
+	extern int vchan_tx_desc_free(struct dma_async_tx_descriptor *);
+	unsigned long flags;
 
 	dma_async_tx_descriptor_init(&vd->tx, &vc->chan);
 	vd->tx.flags = tx_flags;
 	vd->tx.tx_submit = vchan_tx_submit;
+	vd->tx.desc_free = vchan_tx_desc_free;
+
+	spin_lock_irqsave(&vc->lock, flags);
+	list_add_tail(&vd->node, &vc->desc_allocated);
+	spin_unlock_irqrestore(&vc->lock, flags);
 
 	return &vd->tx;
 }
@@ -122,7 +130,8 @@ static inline struct virt_dma_desc *vchan_next_desc(struct virt_dma_chan *vc)
 }
 
 /**
- * vchan_get_all_descriptors - obtain all submitted and issued descriptors
+ * vchan_get_all_descriptors - obtain all allocated, submitted and issued
+ *                             descriptors
  * vc: virtual channel to get descriptors from
  * head: list of descriptors found
  *
@@ -134,6 +143,7 @@ static inline struct virt_dma_desc *vchan_next_desc(struct virt_dma_chan *vc)
 static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
 	struct list_head *head)
 {
+	list_splice_tail_init(&vc->desc_allocated, head);
 	list_splice_tail_init(&vc->desc_submitted, head);
 	list_splice_tail_init(&vc->desc_issued, head);
 	list_splice_tail_init(&vc->desc_completed, head);
@@ -141,11 +151,14 @@ static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
 
 static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
 {
+	struct virt_dma_desc *vd;
 	unsigned long flags;
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&vc->lock, flags);
 	vchan_get_all_descriptors(vc, &head);
+	list_for_each_entry(vd, &head, node)
+		dmaengine_desc_clear_reuse(&vd->tx);
 	spin_unlock_irqrestore(&vc->lock, flags);
 
 	vchan_dma_desc_free_list(vc, &head);
-- 
2.1.4
