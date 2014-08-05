From: linux@roeck-us.net (Guenter Roeck)
Date: Mon,  4 Aug 2014 18:48:54 -0700
Subject: [PATCH v6 3/7] arm: Support restart through restart handler call chain
In-Reply-To: <1407203338-12915-1-git-send-email-linux@roeck-us.net>
References: <1407203338-12915-1-git-send-email-linux@roeck-us.net>
Message-ID: <1407203338-12915-4-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel core now supports a restart handler call chain for system
restart functions.

With this change, the arm_pm_restart callback is now optional, so check
if it is set before calling it. Only call the kernel restart handler
if arm_pm_restart is not set.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
v6: No change.
v5: Renamed restart function to do_kernel_restart
v4: No change.
v3: Use wrapper function to execute notifier call chain.
v2: Only call notifier call chain if arm_pm_restart is not set.
    Do not include linux/watchdog.h.

 arch/arm/kernel/process.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 81ef686..84ca0d5 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -230,7 +230,10 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	smp_send_stop();
 
-	arm_pm_restart(reboot_mode, cmd);
+	if (arm_pm_restart)
+		arm_pm_restart(reboot_mode, cmd);
+	else
+		do_kernel_restart(cmd);
 
 	/* Give a grace period for failure to restart of 1s */
 	mdelay(1000);
-- 
1.9.1
