From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Nov 2009 11:20:52 -0800
Subject: [PATCH 05/10] omap: mailbox: remove disable_/enable_mbox_irq in isr
In-Reply-To: <20091118191852.31148.93980.stgit@localhost>
References: <20091118191852.31148.93980.stgit@localhost>
Message-ID: <20091118192052.31148.94100.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

No need to handle it in isr, since irq won't happen during isr.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mailbox.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 13ca236..b49bb29 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -209,8 +209,6 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 	mbox_msg_t msg;
 	struct request_queue *q = mbox->rxq->queue;
 
-	disable_mbox_irq(mbox, IRQ_RX);
-
 	while (!mbox_fifo_empty(mbox)) {
 		rq = blk_get_request(q, WRITE, GFP_ATOMIC);
 		if (unlikely(!rq))
@@ -226,7 +224,6 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 
 	/* no more messages in the fifo. clear IRQ source. */
 	ack_mbox_irq(mbox, IRQ_RX);
-	enable_mbox_irq(mbox, IRQ_RX);
 nomem:
 	schedule_work(&mbox->rxq->work);
 }
