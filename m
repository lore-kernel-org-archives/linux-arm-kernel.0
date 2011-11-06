From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:32:54 +0000
Subject: [PATCH 4/7] ARM: restart: move reboot failure handing into
 machine_restart()
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6aU-0001N8-Ol@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the failure to reboot into machine_restart() to always catch
this condition, even if a platform decides to hook the restarting
via arm_pm_restart().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/process.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index fd08140..18f1c21 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -114,18 +114,8 @@ void arm_machine_restart(char mode, const char *cmd)
 	/* Push out any further dirty data, and ensure cache is empty */
 	flush_cache_all();
 
-	/*
-	 * Now call the architecture specific reboot code.
-	 */
+	/* Now call the architecture specific reboot code. */
 	arch_reset(mode, cmd);
-
-	/*
-	 * Whoops - the architecture was unable to reboot.
-	 * Tell the user!
-	 */
-	mdelay(1000);
-	printk("Reboot failed -- System halted\n");
-	while (1);
 }
 
 /*
@@ -250,7 +240,15 @@ void machine_power_off(void)
 void machine_restart(char *cmd)
 {
 	machine_shutdown();
+
 	arm_pm_restart(reboot_mode, cmd);
+
+	/* Give a grace period for failure to restart of 1s */
+	mdelay(1000);
+
+	/* Whoops - the platform was unable to reboot. Tell the user! */
+	printk("Reboot failed -- System halted\n");
+	while (1);
 }
 
 void __show_regs(struct pt_regs *regs)
-- 
1.7.4.4
