From: linux@roeck-us.net (Guenter Roeck)
Date: Mon,  6 Oct 2014 22:28:46 -0700
Subject: [PATCH 44/44] kernel: Remove pm_power_off
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Message-ID: <1412659726-29957-45-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No users of pm_power_off are left, so it is safe to remove the function.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/pm.h              |  1 -
 kernel/power/poweroff_handler.c | 10 +---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 45271b5..fce7645 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -31,7 +31,6 @@
 /*
  * Callbacks for platform drivers to implement.
  */
-extern void (*pm_power_off)(void);
 extern void (*pm_power_off_prepare)(void);
 
 /*
diff --git a/kernel/power/poweroff_handler.c b/kernel/power/poweroff_handler.c
index 96f59ef..01a3a39 100644
--- a/kernel/power/poweroff_handler.c
+++ b/kernel/power/poweroff_handler.c
@@ -20,12 +20,6 @@
 #include <linux/types.h>
 
 /*
- * If set, calling this function will power off the system immediately.
- */
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
-
-/*
  *	Notifier list for kernel code which wants to be called
  *	to power off the system.
  */
@@ -163,8 +157,6 @@ int register_poweroff_handler_simple(void (*handler)(void), int priority)
  */
 void do_kernel_poweroff(void)
 {
-	if (pm_power_off)
-		pm_power_off();
 	atomic_notifier_call_chain(&poweroff_handler_list, 0, NULL);
 }
 
@@ -175,6 +167,6 @@ void do_kernel_poweroff(void)
  */
 bool have_kernel_poweroff(void)
 {
-	return pm_power_off != NULL || poweroff_handler_list.head != NULL;
+	return poweroff_handler_list.head != NULL;
 }
 EXPORT_SYMBOL(have_kernel_poweroff);
-- 
1.9.1
