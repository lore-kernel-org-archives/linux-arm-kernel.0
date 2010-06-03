From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Thu,  3 Jun 2010 09:34:09 +0300
Subject: [PATCH 01/10] Mailbox: free mailbox interrupt before freeing blk queue
In-Reply-To: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Message-ID: <1275546858-29507-2-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fernando Guzman Lugo <x0095840@ti.com>

Free interrupt before freeing blk_queue to avoid
any attempt of access to blk_queue after it was freed.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 08a2df7..252a586 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -298,11 +298,10 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 
 static void omap_mbox_fini(struct omap_mbox *mbox)
 {
+	free_irq(mbox->irq, mbox);
 	mbox_queue_free(mbox->txq);
 	mbox_queue_free(mbox->rxq);
 
-	free_irq(mbox->irq, mbox);
-
 	if (unlikely(mbox->ops->shutdown)) {
 		write_lock(&mboxes_lock);
 		if (mbox_configured > 0)
-- 
1.7.1.rc1
