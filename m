From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  1 Aug 2017 16:05:54 +0530
Subject: [PATCH v3 5/5] mailbox: bcm-flexrm-mailbox: Use txdone_ack instead of
 txdone_poll
In-Reply-To: <1501583754-31969-1-git-send-email-anup.patel@broadcom.com>
References: <1501583754-31969-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1501583754-31969-6-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, FlexRM driver uses txdone_poll method of Linux Mailbox
to model the send_data() callback. To achieve this, we have introduced
"last_pending_msg" pointer for each FlexRM ring which keeps track of
the message that did not fit in the FlexRM ring.

This patch updates FlexRM driver to use txdone_ack method instead of
txdone_poll method because txdone_poll is not efficient for FlexRM
and requires additional tracking in FlexRM driver.

Also, moving to txdone_ack method helps us remove "last_pending_msg"
pointer and last_tx_done() callback.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 61 +++---------------------------------
 1 file changed, 4 insertions(+), 57 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 9873818..ae61463 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -277,7 +277,6 @@ struct flexrm_ring {
 	/* Protected members */
 	spinlock_t lock;
 	DECLARE_BITMAP(requests_bmap, RING_MAX_REQ_COUNT);
-	struct brcm_message *last_pending_msg;
 	u32 cmpl_read_offset;
 };
 
@@ -997,15 +996,9 @@ static int flexrm_new_request(struct flexrm_ring *ring,
 	spin_lock_irqsave(&ring->lock, flags);
 	reqid = bitmap_find_free_region(ring->requests_bmap,
 					RING_MAX_REQ_COUNT, 0);
-	if (reqid < 0) {
-		if (batch_msg)
-			ring->last_pending_msg = batch_msg;
-		else
-			ring->last_pending_msg = msg;
-		spin_unlock_irqrestore(&ring->lock, flags);
-		return 0;
-	}
 	spin_unlock_irqrestore(&ring->lock, flags);
+	if (reqid < 0)
+		return -ENOSPC;
 	ring->requests[reqid] = msg;
 
 	/* Do DMA mappings for the message */
@@ -1018,17 +1011,6 @@ static int flexrm_new_request(struct flexrm_ring *ring,
 		return ret;
 	}
 
-	/* If last_pending_msg is already set then goto done with error */
-	spin_lock_irqsave(&ring->lock, flags);
-	if (ring->last_pending_msg)
-		ret = -ENOSPC;
-	spin_unlock_irqrestore(&ring->lock, flags);
-	if (ret < 0) {
-		dev_warn(ring->mbox->dev, "no space in ring %d\n", ring->num);
-		exit_cleanup = true;
-		goto exit;
-	}
-
 	/* Determine current HW BD read offset */
 	read_offset = readl_relaxed(ring->regs + RING_BD_READ_PTR);
 	val = readl_relaxed(ring->regs + RING_BD_START_ADDR);
@@ -1055,13 +1037,7 @@ static int flexrm_new_request(struct flexrm_ring *ring,
 			break;
 	}
 	if (count) {
-		spin_lock_irqsave(&ring->lock, flags);
-		if (batch_msg)
-			ring->last_pending_msg = batch_msg;
-		else
-			ring->last_pending_msg = msg;
-		spin_unlock_irqrestore(&ring->lock, flags);
-		ret = 0;
+		ret = -ENOSPC;
 		exit_cleanup = true;
 		goto exit;
 	}
@@ -1110,12 +1086,6 @@ static int flexrm_process_completions(struct flexrm_ring *ring)
 
 	spin_lock_irqsave(&ring->lock, flags);
 
-	/* Check last_pending_msg */
-	if (ring->last_pending_msg) {
-		msg = ring->last_pending_msg;
-		ring->last_pending_msg = NULL;
-	}
-
 	/*
 	 * Get current completion read and write offset
 	 *
@@ -1131,10 +1101,6 @@ static int flexrm_process_completions(struct flexrm_ring *ring)
 
 	spin_unlock_irqrestore(&ring->lock, flags);
 
-	/* If last_pending_msg was set then queue it back */
-	if (msg)
-		mbox_send_message(chan, msg);
-
 	/* For each completed request notify mailbox clients */
 	reqid = 0;
 	while (cmpl_read_offset != cmpl_write_offset) {
@@ -1345,9 +1311,6 @@ static int flexrm_startup(struct mbox_chan *chan)
 	val = CMPL_START_ADDR_VALUE(ring->cmpl_dma_base);
 	writel_relaxed(val, ring->regs + RING_CMPL_START_ADDR);
 
-	/* Ensure last pending message is cleared */
-	ring->last_pending_msg = NULL;
-
 	/* Completion read pointer will be same as HW write pointer */
 	ring->cmpl_read_offset =
 			readl_relaxed(ring->regs + RING_CMPL_WRITE_PTR);
@@ -1455,24 +1418,10 @@ static void flexrm_shutdown(struct mbox_chan *chan)
 	}
 }
 
-static bool flexrm_last_tx_done(struct mbox_chan *chan)
-{
-	bool ret;
-	unsigned long flags;
-	struct flexrm_ring *ring = chan->con_priv;
-
-	spin_lock_irqsave(&ring->lock, flags);
-	ret = (ring->last_pending_msg) ? false : true;
-	spin_unlock_irqrestore(&ring->lock, flags);
-
-	return ret;
-}
-
 static const struct mbox_chan_ops flexrm_mbox_chan_ops = {
 	.send_data	= flexrm_send_data,
 	.startup	= flexrm_startup,
 	.shutdown	= flexrm_shutdown,
-	.last_tx_done	= flexrm_last_tx_done,
 	.peek_data	= flexrm_peek_data,
 };
 
@@ -1599,7 +1548,6 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 		atomic_set(&ring->msg_cmpl_count, 0);
 		spin_lock_init(&ring->lock);
 		bitmap_zero(ring->requests_bmap, RING_MAX_REQ_COUNT);
-		ring->last_pending_msg = NULL;
 		ring->cmpl_read_offset = 0;
 	}
 
@@ -1671,8 +1619,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 
 	/* Initialize mailbox controller */
 	mbox->controller.txdone_irq = false;
-	mbox->controller.txdone_poll = true;
-	mbox->controller.txpoll_period = 1;
+	mbox->controller.txdone_poll = false;
 	mbox->controller.ops = &flexrm_mbox_chan_ops;
 	mbox->controller.dev = dev;
 	mbox->controller.num_chans = mbox->num_rings;
-- 
2.7.4
