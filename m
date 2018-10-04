From: nicolas.cavallari@green-communications.fr (Nicolas Cavallari)
Date: Thu,  4 Oct 2018 18:23:38 +0200
Subject: [RFC 1/2] reboot: Make restart_handler_list a blocking notifier chain.
In-Reply-To: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
References: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
Message-ID: <20181004162339.19493-2-nicolas.cavallari@green-communications.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many users of restart_handlers are sleeping in their callbacks.  Some
are doing infinite loops or calling driver code that may sleep or
perform operation on slow busses, like i2c.

This is not allowed in an atomic notifier chain, which is what
restart_handler_list currently is, so use a blocking notifier chain
instead.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 kernel/reboot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 8fb44dec9ad7..f0ba0008dbde 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -135,7 +135,7 @@ EXPORT_SYMBOL(devm_register_reboot_notifier);
  *	Notifier list for kernel code which wants to be called
  *	to restart the system.
  */
-static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
+static BLOCKING_NOTIFIER_HEAD(restart_handler_list);
 
 /**
  *	register_restart_handler - Register function to be called to reset
@@ -172,12 +172,12 @@ static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
  *	hardware is expected to register with low priority to ensure that
  *	it only runs if no other means to restart the system is available.
  *
- *	Currently always returns zero, as atomic_notifier_chain_register()
+ *	Currently always returns zero, as blocking_notifier_chain_register()
  *	always returns zero.
  */
 int register_restart_handler(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&restart_handler_list, nb);
+	return blocking_notifier_chain_register(&restart_handler_list, nb);
 }
 EXPORT_SYMBOL(register_restart_handler);
 
@@ -192,7 +192,7 @@ EXPORT_SYMBOL(register_restart_handler);
  */
 int unregister_restart_handler(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&restart_handler_list, nb);
+	return blocking_notifier_chain_unregister(&restart_handler_list, nb);
 }
 EXPORT_SYMBOL(unregister_restart_handler);
 
@@ -209,7 +209,7 @@ EXPORT_SYMBOL(unregister_restart_handler);
  */
 void do_kernel_restart(char *cmd)
 {
-	atomic_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
+	blocking_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
 }
 
 void migrate_to_reboot_cpu(void)
-- 
2.19.0
