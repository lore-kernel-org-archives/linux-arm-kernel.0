From: x0095840@ti.com (Fernando Guzman Lugo)
Date: Fri, 12 Feb 2010 19:07:14 -0600
Subject: [PATCH] Mailbox: flush pending deferred works before freeing blk q=
Message-ID: <mailman.217.1266476890.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ueue

flush pending deferred works before freeing blk_queue to prevent
any attempt of access to blk_queue after it was freed

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index e6cc4b0..3e2f961 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -297,6 +297,8 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 static void omap_mbox_fini(struct omap_mbox *mbox)
 {
 	free_irq(mbox->irq, mbox);
+	tasklet_kill(&mbox->txq->tasklet);
+	flush_work(&mbox->rxq->work);
 	mbox_queue_free(mbox->txq);
 	mbox_queue_free(mbox->rxq);
=20
--=20
1.6.0.4
