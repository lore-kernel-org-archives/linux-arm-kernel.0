From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Nov 2017 16:32:04 +0200
Subject: [PATCH 02/10] dmaengine: virt-dma: Support for race free transfer
 termination
In-Reply-To: <20171114143212.8311-1-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
Message-ID: <20171114143212.8311-3-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even with the introduced vchan_synchronize() we can face race when
terminating a cyclic transfer.

If the terminate_all is called after the interrupt handler called
vchan_cyclic_callback(), but before the vchan_complete tasklet is called:
vc->cyclic is set to the cyclic descriptor, but the descriptor itself was
freed up in the driver's terminate_all() callback.
When the vhan_complete() is executed it will try to fetch the vc->cyclic
vdesc, but the pointer is pointing now to uninitialized memory leading to
(hard to reproduce) kernel crash.

In order to fix this, drivers should:
- call vchan_terminate_vdesc() from their terminate_all callback instead
calling their free_desc function to free up the descriptor.
- implement device_synchronize callback and call vchan_synchronize().

This way we can make sure that the descriptor is only going to be freed up
after the vchan_callback was executed in a safe manner.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/virt-dma.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 2edb05505102..b09b75ab0751 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -35,6 +35,7 @@ struct virt_dma_chan {
 	struct list_head desc_completed;
 
 	struct virt_dma_desc *cyclic;
+	struct virt_dma_desc *vd_terminated;
 };
 
 static inline struct virt_dma_chan *to_virt_chan(struct dma_chan *chan)
@@ -129,6 +130,25 @@ static inline void vchan_cyclic_callback(struct virt_dma_desc *vd)
 	tasklet_schedule(&vc->task);
 }
 
+/**
+ * vchan_terminate_vdesc - Disable pending cyclic callback
+ * @vd: virtual descriptor to be terminated
+ *
+ * vc.lock must be held by caller
+ */
+static inline void vchan_terminate_vdesc(struct virt_dma_desc *vd)
+{
+	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
+
+	/* free up stuck descriptor */
+	if (vc->vd_terminated)
+		vchan_vdesc_fini(vc->vd_terminated);
+
+	vc->vd_terminated = vd;
+	if (vc->cyclic == vd)
+		vc->cyclic = NULL;
+}
+
 /**
  * vchan_next_desc - peek at the next descriptor to be processed
  * @vc: virtual channel to obtain descriptor from
@@ -182,10 +202,20 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
  * Makes sure that all scheduled or active callbacks have finished running. For
  * proper operation the caller has to ensure that no new callbacks are scheduled
  * after the invocation of this function started.
+ * Free up the terminated cyclic descriptor to prevent memory leakage.
  */
 static inline void vchan_synchronize(struct virt_dma_chan *vc)
 {
+	unsigned long flags;
+
 	tasklet_kill(&vc->task);
+
+	spin_lock_irqsave(&vc->lock, flags);
+	if (vc->vd_terminated) {
+		vchan_vdesc_fini(vc->vd_terminated);
+		vc->vd_terminated = NULL;
+	}
+	spin_unlock_irqrestore(&vc->lock, flags);
 }
 
 #endif
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
