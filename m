From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  1 Aug 2017 16:05:53 +0530
Subject: [PATCH v3 4/5] mailbox: bcm-flexrm-mailbox: Use bitmap instead of IDA
In-Reply-To: <1501583754-31969-1-git-send-email-anup.patel@broadcom.com>
References: <1501583754-31969-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1501583754-31969-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we are using IDA library for managing IDs
on a FlexRM ring. The IDA library dynamically allocates
memory for underlying data structures which can cause
potential locking issue when allocating/free IDs from
flexrm_new_request() and flexrm_process_completions().

To tackle this, we replace use of IDA with bitmap for
each FlexRM ring and also protect the bitmap with FlexRM
ring lock.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 46ad305..9873818 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -18,13 +18,13 @@
 #include <asm/barrier.h>
 #include <asm/byteorder.h>
 #include <linux/atomic.h>
+#include <linux/bitmap.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/err.h>
-#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
@@ -265,7 +265,6 @@ struct flexrm_ring {
 	cpumask_t irq_aff_hint;
 	unsigned int msi_timer_val;
 	unsigned int msi_count_threshold;
-	struct ida requests_ida;
 	struct brcm_message *requests[RING_MAX_REQ_COUNT];
 	void *bd_base;
 	dma_addr_t bd_dma_base;
@@ -277,6 +276,7 @@ struct flexrm_ring {
 	atomic_t msg_cmpl_count;
 	/* Protected members */
 	spinlock_t lock;
+	DECLARE_BITMAP(requests_bmap, RING_MAX_REQ_COUNT);
 	struct brcm_message *last_pending_msg;
 	u32 cmpl_read_offset;
 };
@@ -994,10 +994,10 @@ static int flexrm_new_request(struct flexrm_ring *ring,
 	msg->error = 0;
 
 	/* If no requests possible then save data pointer and goto done. */
-	reqid = ida_simple_get(&ring->requests_ida, 0,
-				RING_MAX_REQ_COUNT, GFP_KERNEL);
+	spin_lock_irqsave(&ring->lock, flags);
+	reqid = bitmap_find_free_region(ring->requests_bmap,
+					RING_MAX_REQ_COUNT, 0);
 	if (reqid < 0) {
-		spin_lock_irqsave(&ring->lock, flags);
 		if (batch_msg)
 			ring->last_pending_msg = batch_msg;
 		else
@@ -1005,13 +1005,16 @@ static int flexrm_new_request(struct flexrm_ring *ring,
 		spin_unlock_irqrestore(&ring->lock, flags);
 		return 0;
 	}
+	spin_unlock_irqrestore(&ring->lock, flags);
 	ring->requests[reqid] = msg;
 
 	/* Do DMA mappings for the message */
 	ret = flexrm_dma_map(ring->mbox->dev, msg);
 	if (ret < 0) {
 		ring->requests[reqid] = NULL;
-		ida_simple_remove(&ring->requests_ida, reqid);
+		spin_lock_irqsave(&ring->lock, flags);
+		bitmap_release_region(ring->requests_bmap, reqid, 0);
+		spin_unlock_irqrestore(&ring->lock, flags);
 		return ret;
 	}
 
@@ -1088,7 +1091,9 @@ static int flexrm_new_request(struct flexrm_ring *ring,
 	if (exit_cleanup) {
 		flexrm_dma_unmap(ring->mbox->dev, msg);
 		ring->requests[reqid] = NULL;
-		ida_simple_remove(&ring->requests_ida, reqid);
+		spin_lock_irqsave(&ring->lock, flags);
+		bitmap_release_region(ring->requests_bmap, reqid, 0);
+		spin_unlock_irqrestore(&ring->lock, flags);
 	}
 
 	return ret;
@@ -1163,7 +1168,9 @@ static int flexrm_process_completions(struct flexrm_ring *ring)
 
 		/* Release reqid for recycling */
 		ring->requests[reqid] = NULL;
-		ida_simple_remove(&ring->requests_ida, reqid);
+		spin_lock_irqsave(&ring->lock, flags);
+		bitmap_release_region(ring->requests_bmap, reqid, 0);
+		spin_unlock_irqrestore(&ring->lock, flags);
 
 		/* Unmap DMA mappings */
 		flexrm_dma_unmap(ring->mbox->dev, msg);
@@ -1414,7 +1421,6 @@ static void flexrm_shutdown(struct mbox_chan *chan)
 
 		/* Release reqid for recycling */
 		ring->requests[reqid] = NULL;
-		ida_simple_remove(&ring->requests_ida, reqid);
 
 		/* Unmap DMA mappings */
 		flexrm_dma_unmap(ring->mbox->dev, msg);
@@ -1424,6 +1430,9 @@ static void flexrm_shutdown(struct mbox_chan *chan)
 		mbox_chan_received_data(chan, msg);
 	}
 
+	/* Clear requests bitmap */
+	bitmap_zero(ring->requests_bmap, RING_MAX_REQ_COUNT);
+
 	/* Release IRQ */
 	if (ring->irq_requested) {
 		irq_set_affinity_hint(ring->irq, NULL);
@@ -1581,7 +1590,6 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 		ring->irq_requested = false;
 		ring->msi_timer_val = MSI_TIMER_VAL_MASK;
 		ring->msi_count_threshold = 0x1;
-		ida_init(&ring->requests_ida);
 		memset(ring->requests, 0, sizeof(ring->requests));
 		ring->bd_base = NULL;
 		ring->bd_dma_base = 0;
@@ -1590,6 +1598,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 		atomic_set(&ring->msg_send_count, 0);
 		atomic_set(&ring->msg_cmpl_count, 0);
 		spin_lock_init(&ring->lock);
+		bitmap_zero(ring->requests_bmap, RING_MAX_REQ_COUNT);
 		ring->last_pending_msg = NULL;
 		ring->cmpl_read_offset = 0;
 	}
@@ -1701,9 +1710,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 
 static int flexrm_mbox_remove(struct platform_device *pdev)
 {
-	int index;
 	struct device *dev = &pdev->dev;
-	struct flexrm_ring *ring;
 	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
 
 	mbox_controller_unregister(&mbox->controller);
@@ -1715,11 +1722,6 @@ static int flexrm_mbox_remove(struct platform_device *pdev)
 	dma_pool_destroy(mbox->cmpl_pool);
 	dma_pool_destroy(mbox->bd_pool);
 
-	for (index = 0; index < mbox->num_rings; index++) {
-		ring = &mbox->rings[index];
-		ida_destroy(&ring->requests_ida);
-	}
-
 	return 0;
 }
 
-- 
2.7.4
