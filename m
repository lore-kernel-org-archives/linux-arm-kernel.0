From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Thu, 18 Feb 2010 00:48:55 -0600
Subject: [PATCH] Mailbox: new mutext lock for h/w mailbox configuration
Message-ID: <mailman.219.1266476985.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mailbox startup and shutdown are being executed against
a single H/W module, and a mailbox H/W module is totally
__independent__ of the registration of logical mailboxes.
So, an independent mutext should be used for startup and
shutdown.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 8136ee3..8ecb837 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -32,6 +32,7 @@ static struct omap_mbox *mboxes;
 static DEFINE_RWLOCK(mboxes_lock);
=20
 static int mbox_configured;
+static DEFINE_MUTEX(mbox_configured_lock);
=20
 /* Mailbox FIFO handle functions */
 static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
@@ -248,16 +249,16 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	struct omap_mbox_queue *mq;
=20
 	if (likely(mbox->ops->startup)) {
-		write_lock(&mboxes_lock);
+		mutex_lock(&mbox_configured_lock);
 		if (!mbox_configured)
 			ret =3D mbox->ops->startup(mbox);
=20
 		if (unlikely(ret)) {
-			write_unlock(&mboxes_lock);
+			mutex_unlock(&mbox_configured_lock);
 			return ret;
 		}
 		mbox_configured++;
-		write_unlock(&mboxes_lock);
+		mutex_unlock(&mbox_configured_lock);
 	}
=20
 	ret =3D request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
@@ -304,12 +305,12 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	mbox_queue_free(mbox->rxq);
=20
 	if (unlikely(mbox->ops->shutdown)) {
-		write_lock(&mboxes_lock);
+		mutex_lock(&mbox_configured_lock);
 		if (mbox_configured > 0)
 			mbox_configured--;
 		if (!mbox_configured)
 			mbox->ops->shutdown(mbox);
-		write_unlock(&mboxes_lock);
+		mutex_unlock(&mbox_configured_lock);
 	}
 }
=20
--=20
1.6.0.4
