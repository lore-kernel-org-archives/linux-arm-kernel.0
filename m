From: x0095840@ti.com (Fernando Guzman Lugo)
Date: Fri, 12 Feb 2010 19:02:32 -0600
Subject: [PATCH] Mailbox: free mailbox interrupt before freeing blk queue
Message-ID: <mailman.216.1266476854.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Free interrupt before freeing blk_queue to avoid
any attempt of access to blk_queue after it was freed.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 8e90633..e6cc4b0 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -296,11 +296,10 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
=20
 static void omap_mbox_fini(struct omap_mbox *mbox)
 {
+	free_irq(mbox->irq, mbox);
 	mbox_queue_free(mbox->txq);
 	mbox_queue_free(mbox->rxq);
=20
-	free_irq(mbox->irq, mbox);
-
 	if (unlikely(mbox->ops->shutdown)) {
 		write_lock(&mboxes_lock);
 		if (mbox_configured > 0)
--=20
1.6.0.4
