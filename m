From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:36:18 +0100
Subject: [RFC 03/34] dmaengine: virt-dma: add support for cyclic DMA periodic
 callbacks
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIqg-0006yu-5Z@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for cyclic DMA's periodic callbacks.  Drivers are expected
to call vchan_cyclic_callback() when a period has completed, which will
schedule the tasklet to make the callback into the driver.

As callbacks are made from tasklet context, it is important to realise
that we don't guarantee a callback for each completed period, but for
N completed periods where N may be greater than one.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/virt-dma.c |   19 +++++++++++++++----
 drivers/dma/virt-dma.h |   14 ++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index a8054fc..6f80432 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -59,17 +59,28 @@ EXPORT_SYMBOL_GPL(vchan_find_desc);
 static void vchan_complete(unsigned long arg)
 {
 	struct virt_dma_chan *vc = (struct virt_dma_chan *)arg;
+	struct virt_dma_desc *vd;
+	dma_async_tx_callback cb = NULL;
+	void *cb_data = NULL;
 	LIST_HEAD(head);
 
 	spin_lock_irq(&vc->lock);
 	list_splice_tail_init(&vc->desc_completed, &head);
+	vd = vc->cyclic;
+	if (vd) {
+		vc->cyclic = NULL;
+		cb = vd->tx.callback;
+		cb_data = vd->tx.callback_param;
+	}
 	spin_unlock_irq(&vc->lock);
 
+	if (cb)
+		cb(cb_data);
+
 	while (!list_empty(&head)) {
-		struct virt_dma_desc *vd = list_first_entry(&head,
-				struct virt_dma_desc, node);
-		dma_async_tx_callback cb = vd->tx.callback;
-		void *cb_data = vd->tx.callback_param;
+		vd = list_first_entry(&head, struct virt_dma_desc, node);
+		cb = vd->tx.callback;
+		cb_data = vd->tx.callback_param;
 
 		list_del(&vd->node);
 
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 44ec57e..85c19d6 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -32,6 +32,8 @@ struct virt_dma_chan {
 	struct list_head desc_submitted;
 	struct list_head desc_issued;
 	struct list_head desc_completed;
+
+	struct virt_dma_desc *cyclic;
 };
 
 static inline struct virt_dma_chan *to_virt_chan(struct dma_chan *chan)
@@ -92,6 +94,18 @@ static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
 }
 
 /**
+ * vchan_cyclic_callback - report the completion of a period
+ * vd: virtual descriptor
+ */
+static inline void vchan_cyclic_callback(struct virt_dma_desc *vd)
+{
+	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
+
+	vc->cyclic = vd;
+	tasklet_schedule(&vc->task);
+}
+
+/**
  * vchan_next_desc - peek at the next descriptor to be processed
  * vc: virtual channel to obtain descriptor from
  *
-- 
1.7.4.4
