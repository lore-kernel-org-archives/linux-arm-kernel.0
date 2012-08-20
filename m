From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 20 Aug 2012 09:52:05 +0200
Subject: [PATCH RFC] ARM: busy loop at the end of machine_power_off
Message-ID: <1345449125-23212-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When machine_power_off returns the kernel panics with

	Attempted to kill init!

. So let machine_power_off busy loop as machine_halt does, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
This is triggered when issuing

	poweroff

only if the machine sets the pm_power_off callback because the reboot
system call does

        if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
		cmd = LINUX_REBOOT_CMD_HALT;

So it might even be safe to call pm_power_off unconditionally in
machine_power_off.

Best regards
Uwe

 arch/arm/kernel/process.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 693b744..eda0846 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -256,6 +256,8 @@ void machine_power_off(void)
 	machine_shutdown();
 	if (pm_power_off)
 		pm_power_off();
+	local_irq_disable();
+	while (1);
 }
 
 void machine_restart(char *cmd)
-- 
1.7.10.4
