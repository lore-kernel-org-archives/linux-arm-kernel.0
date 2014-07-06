From: linux@roeck-us.net (Guenter Roeck)
Date: Sun,  6 Jul 2014 16:38:16 -0700
Subject: [PATCH v2 3/7] arm: Support restart through restart notifier call
 chain
In-Reply-To: <1404689900-27421-1-git-send-email-linux@roeck-us.net>
References: <1404689900-27421-1-git-send-email-linux@roeck-us.net>
Message-ID: <1404689900-27421-4-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel core now supports a notifier call chain for system
restart functions.

With this change, the arm_pm_restart callback is now optional,
so check if it is set before calling it. Only call the notifier
functions if arm_pm_restart is not set.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Only call notifier call chain if arm_pm_restart is not set
    Do not include linux/watchdog.h

 arch/arm/kernel/process.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 81ef686..5108e45 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -230,7 +230,11 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	smp_send_stop();
 
-	arm_pm_restart(reboot_mode, cmd);
+	if (arm_pm_restart)
+		arm_pm_restart(reboot_mode, cmd);
+	else
+		blocking_notifier_call_chain(&restart_notifier_list,
+					     reboot_mode, cmd);
 
 	/* Give a grace period for failure to restart of 1s */
 	mdelay(1000);
-- 
1.9.1
