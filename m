From: x0095840@ti.com (Fernando Guzman Lugo)
Date: Mon, 8 Feb 2010 13:35:40 -0600
Subject: [PATCH] Mailbox: disable mailbox interrupt when request queue
Message-ID: <mailman.220.1266477028.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when blk_get_request fails to get the request it is returning
without read the message from the mailbox fifo, then when it
leaves the isr and interruption is trigger again and again and
the workqueue which get elements from the request queue is never
executed and the kernel is stuck and shows a softlockup message.
Now the mailbox interrupt is disabled when request queue is full
and enabled when it pop a elememt form the request queue.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/mailbox.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 8ecb837..8d86b0b 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -30,6 +30,7 @@
=20
 static struct omap_mbox *mboxes;
 static DEFINE_RWLOCK(mboxes_lock);
+static bool rq_full;
=20
 static int mbox_configured;
 static DEFINE_MUTEX(mbox_configured_lock);
@@ -139,6 +140,10 @@ static void mbox_rx_work(struct work_struct *work)
 	while (1) {
 		spin_lock_irqsave(q->queue_lock, flags);
 		rq =3D blk_fetch_request(q);
+		if (rq_full) {
+			omap_mbox_enable_irq(mbox, IRQ_RX);
+			rq_full =3D false;
+		}
 		spin_unlock_irqrestore(q->queue_lock, flags);
 		if (!rq)
 			break;
@@ -176,8 +181,11 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox=
)
=20
 	while (!mbox_fifo_empty(mbox)) {
 		rq =3D blk_get_request(q, WRITE, GFP_ATOMIC);
-		if (unlikely(!rq))
+		if (unlikely(!rq)) {
+			omap_mbox_disable_irq(mbox, IRQ_RX);
+			rq_full =3D true;
 			goto nomem;
+		}
=20
 		msg =3D mbox_fifo_read(mbox);
=20
--=20
1.6.0.4
