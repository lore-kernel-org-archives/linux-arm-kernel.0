From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 30 Jun 2014 12:11:36 -0700
Subject: [RFC PATCH 3/6] arm: Support restart through restart notifier call
 chain
In-Reply-To: <1404155499-21177-1-git-send-email-linux@roeck-us.net>
References: <1404155499-21177-1-git-send-email-linux@roeck-us.net>
Message-ID: <1404155499-21177-4-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel core now supports a notifier call chain for system
restart functions.

With this change, the arm_pm_restart callback is now optional,
so check if it is set before calling it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/kernel/process.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 81ef686..93765f2 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -32,6 +32,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/leds.h>
 #include <linux/reboot.h>
+#include <linux/watchdog.h>
 
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
@@ -230,7 +231,10 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	smp_send_stop();
 
-	arm_pm_restart(reboot_mode, cmd);
+	if (arm_pm_restart)
+		arm_pm_restart(reboot_mode, cmd);
+
+	blocking_notifier_call_chain(&restart_notifier_list, reboot_mode, cmd);
 
 	/* Give a grace period for failure to restart of 1s */
 	mdelay(1000);
-- 
1.9.1
