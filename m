From: s-anna@ti.com (Suman Anna)
Date: Fri, 7 Jun 2013 20:57:44 -0500
Subject: [PATCH 2/7] omap: mailbox: check for NULL nb in mailbox_put
Message-ID: <1370656664-41250-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mailbox_put function must check the notifier block for
NULL before trying to unregister it.

Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/plat-omap/mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 42377ef..5fb4027 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -356,7 +356,8 @@ EXPORT_SYMBOL(omap_mbox_get);
 
 void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb)
 {
-	blocking_notifier_chain_unregister(&mbox->notifier, nb);
+	if (nb)
+		blocking_notifier_chain_unregister(&mbox->notifier, nb);
 	omap_mbox_fini(mbox);
 }
 EXPORT_SYMBOL(omap_mbox_put);
-- 
1.8.2
