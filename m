From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 22 Feb 2015 17:41:52 +0100
Subject: dmaengine, virt-dma and reusable transfers
Message-ID: <87bnkl7van.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell and Vinod,

I've made the patch in [1] in order to be able to reuse descriptors,
ie. resubmit completed transfers once they are completed.

As I'm not sure I understand all the dmaengine slave API, nor the virt-dma
fully, I'd like you to have an eye on it first.

Thanks for your time.

-- 
Robert

[1]
>From 74d7007efcc0e7bfa5d36b2934e5b4ad61e29022 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 22 Feb 2015 17:19:34 +0100
Subject: [PATCH] dmaengine: virt-dma: don't always free descriptor upon
 completion

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
the descriptors upon completion if DMA_PREP_CONTINUE flag is set in the
transfer.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/virt-dma.c | 7 +++++--
 drivers/dma/virt-dma.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index 6f80432..1e4fd18 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -83,8 +83,10 @@ static void vchan_complete(unsigned long arg)
 		cb_data = vd->tx.callback_param;
 
 		list_del(&vd->node);
-
-		vc->desc_free(vd);
+		if (vd->tx.flags & DMA_PREP_CONTINUE)
+			list_add(&vd->node, &vc->desc_submittable);
+		else
+			vc->desc_free(vd);
 
 		if (cb)
 			cb(cb_data);
@@ -108,6 +110,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
 	dma_cookie_init(&vc->chan);
 
 	spin_lock_init(&vc->lock);
+	INIT_LIST_HEAD(&vc->desc_submittable);
 	INIT_LIST_HEAD(&vc->desc_submitted);
 	INIT_LIST_HEAD(&vc->desc_issued);
 	INIT_LIST_HEAD(&vc->desc_completed);
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 181b952..3772032 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -29,6 +29,7 @@ struct virt_dma_chan {
 	spinlock_t lock;
 
 	/* protected by vc.lock */
+	struct list_head desc_submittable;
 	struct list_head desc_submitted;
 	struct list_head desc_issued;
 	struct list_head desc_completed;
@@ -134,6 +135,7 @@ static inline struct virt_dma_desc *vchan_next_desc(struct virt_dma_chan *vc)
 static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
 	struct list_head *head)
 {
+	list_splice_tail_init(&vc->desc_submittable, head);
 	list_splice_tail_init(&vc->desc_submitted, head);
 	list_splice_tail_init(&vc->desc_issued, head);
 	list_splice_tail_init(&vc->desc_completed, head);
-- 
2.1.0
