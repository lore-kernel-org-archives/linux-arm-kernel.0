From: s-anna@ti.com (Suman Anna)
Date: Mon, 11 Feb 2013 22:57:11 -0600
Subject: [PATCH v2 12/13] mailbox: check for NULL nb in mailbox_put
In-Reply-To: <1360645032-9668-1-git-send-email-s-anna@ti.com>
References: <1360645032-9668-1-git-send-email-s-anna@ti.com>
Message-ID: <1360645032-9668-13-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mailbox_put function must check the notifier block for
NULL before trying to unregister it.

Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index eaaf87e..c38241a 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -473,7 +473,8 @@ EXPORT_SYMBOL(mailbox_get);
 
 void mailbox_put(struct mailbox *mbox, struct notifier_block *nb)
 {
-	blocking_notifier_chain_unregister(&mbox->notifier, nb);
+	if (nb)
+		blocking_notifier_chain_unregister(&mbox->notifier, nb);
 	mailbox_fini(mbox);
 }
 EXPORT_SYMBOL(mailbox_put);
-- 
1.8.1.2
