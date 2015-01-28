From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 16:00:11 +0100
Subject: [PATCH] ipmi: avoid gcc warning
Message-ID: <2457592.UIVPJ2WNL3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new harmless warning has come up on ARM builds with gcc-4.9:

drivers/char/ipmi/ipmi_msghandler.c: In function 'smi_send.isra.11':
include/linux/spinlock.h:372:95: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
  raw_spin_unlock_irqrestore(&lock->rlock, flags);
                                                                                               ^
drivers/char/ipmi/ipmi_msghandler.c:1490:16: note: 'flags' was declared here
  unsigned long flags;
                ^

This could be worked around by initializing the 'flags' variable, but it
seems better to rework the code to avoid this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 7ea0ed2b5be81 ("ipmi: Make the message handler easier to use for SMI interfaces")

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 6b65fa4e0c55..fb0f8eacd208 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1483,14 +1483,10 @@ static inline void format_lan_msg(struct ipmi_smi_msg   *smi_msg,
 	smi_msg->msgid = msgid;
 }
 
-static void smi_send(ipmi_smi_t intf, struct ipmi_smi_handlers *handlers,
-		     struct ipmi_smi_msg *smi_msg, int priority)
+static struct ipmi_smi_msg *smi_add_send_msg(ipmi_smi_t intf,
+					     struct ipmi_smi_msg *smi_msg,
+					     int priority)
 {
-	int run_to_completion = intf->run_to_completion;
-	unsigned long flags;
-
-	if (!run_to_completion)
-		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
 	if (intf->curr_msg) {
 		if (priority > 0)
 			list_add_tail(&smi_msg->link, &intf->hp_xmit_msgs);
@@ -1500,8 +1496,24 @@ static void smi_send(ipmi_smi_t intf, struct ipmi_smi_handlers *handlers,
 	} else {
 		intf->curr_msg = smi_msg;
 	}
-	if (!run_to_completion)
+
+	return smi_msg;
+}
+
+
+static void smi_send(ipmi_smi_t intf, struct ipmi_smi_handlers *handlers,
+		     struct ipmi_smi_msg *smi_msg, int priority)
+{
+	int run_to_completion = intf->run_to_completion;
+
+	if (run_to_completion) {
+		smi_msg = smi_add_send_msg(intf, smi_msg, priority);
+	} else {
+		unsigned long flags;
+		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+		smi_msg = smi_add_send_msg(intf, smi_msg, priority);
 		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+	}
 
 	if (smi_msg)
 		handlers->sender(intf->send_info, smi_msg);
