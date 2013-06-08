From: s-anna@ti.com (Suman Anna)
Date: Fri, 7 Jun 2013 20:57:51 -0500
Subject: [PATCH 3/7] omap: mailbox: call request_irq after mbox queues are
 allocated
Message-ID: <1370656671-41285-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP mailbox startup code is enabling the interrupt even before
any of the associated mailbox queues are allocated. Any pending
received mailbox message could cause a kernel panic as soon as
the interrupt is enabled due to the dereferencing of non-existing
mailbox queues within the ISR.

Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/plat-omap/mailbox.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 5fb4027..e1bd333 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -261,13 +261,6 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	}
 
 	if (!mbox->use_count++) {
-		ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
-							mbox->name, mbox);
-		if (unlikely(ret)) {
-			pr_err("failed to register mailbox interrupt:%d\n",
-									ret);
-			goto fail_request_irq;
-		}
 		mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
 		if (!mq) {
 			ret = -ENOMEM;
@@ -282,17 +275,24 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 		}
 		mbox->rxq = mq;
 		mq->mbox = mbox;
+		ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
+							mbox->name, mbox);
+		if (unlikely(ret)) {
+			pr_err("failed to register mailbox interrupt:%d\n",
+									ret);
+			goto fail_request_irq;
+		}
 
 		omap_mbox_enable_irq(mbox, IRQ_RX);
 	}
 	mutex_unlock(&mbox_configured_lock);
 	return 0;
 
+fail_request_irq:
+	mbox_queue_free(mbox->rxq);
 fail_alloc_rxq:
 	mbox_queue_free(mbox->txq);
 fail_alloc_txq:
-	free_irq(mbox->irq, mbox);
-fail_request_irq:
 	if (mbox->ops->shutdown)
 		mbox->ops->shutdown(mbox);
 	mbox->use_count--;
-- 
1.8.2
