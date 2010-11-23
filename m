From: h-kanigeri2@ti.com (Hari Kanigeri)
Date: Tue, 23 Nov 2010 15:26:53 -0600
Subject: [PATCH v4 1/5] OMAP: mailbox: change full flag per mailbox queue
	instead of global
In-Reply-To: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
Message-ID: <1290547617-16640-2-git-send-email-h-kanigeri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fernando Guzman Lugo <x0095840@ti.com>

The variable rq_full flag is a global variable, so if there are multiple
mailbox users there will be conflicts. Now there is a full flag per
mailbox queue.

Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    1 +
 arch/arm/plat-omap/mailbox.c              |    9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 9976565..13f2ef3 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -48,6 +48,7 @@ struct omap_mbox_queue {
 	struct tasklet_struct	tasklet;
 	int	(*callback)(void *);
 	struct omap_mbox	*mbox;
+	bool full;
 };
 
 struct omap_mbox {
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index d2fafb8..48e161c 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -33,7 +33,6 @@
 
 static struct workqueue_struct *mboxd;
 static struct omap_mbox **mboxes;
-static bool rq_full;
 
 static int mbox_configured;
 static DEFINE_MUTEX(mbox_configured_lock);
@@ -148,6 +147,12 @@ static void mbox_rx_work(struct work_struct *work)
 
 		if (mq->callback)
 			mq->callback((void *)msg);
+		spin_lock_irq(&mq->lock);
+		if (mq->full) {
+			mq->full = false;
+			omap_mbox_enable_irq(mq->mbox, IRQ_RX);
+		}
+		spin_unlock_irq(&mq->lock);
 	}
 }
 
@@ -170,7 +175,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 	while (!mbox_fifo_empty(mbox)) {
 		if (unlikely(kfifo_avail(&mq->fifo) < sizeof(msg))) {
 			omap_mbox_disable_irq(mbox, IRQ_RX);
-			rq_full = true;
+			mq->full = true;
 			goto nomem;
 		}
 
-- 
1.7.0
