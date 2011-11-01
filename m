From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 01 Nov 2011 16:09:29 +0000
Subject: [PATCH 4/5] ARM: restart: turn reboot setup code into a library
	function
In-Reply-To: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
Message-ID: <E1RLGu1-0005Ib-E4@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the failure to reboot into machine_restart() to always catch
this condition, and turn the bulk of arm_machine_restart() which is
required for soft-reboot modes into a library call.

This allows everyone to hook into the restart via the same method
via arm_pm_restart() irrespective of what they want, and if they
want the old 'arch_reset' way, call setup_restart() themselves.

Acked-by: Will Deacon <will.deacon@arm.com>
Tested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/process.c |   35 +++++++++++++++++++----------------
 1 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 62946c0..db8d836 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -92,12 +92,8 @@ static int __init hlt_setup(char *__unused)
 __setup("nohlt", nohlt_setup);
 __setup("hlt", hlt_setup);
 
-void arm_machine_restart(char mode, const char *cmd)
+static void setup_restart(void)
 {
-	/* Disable interrupts first */
-	local_irq_disable();
-	local_fiq_disable();
-
 	/*
 	 * Tell the mm system that we are going to reboot -
 	 * we may need it to insert some 1:1 mappings so that
@@ -113,19 +109,18 @@ void arm_machine_restart(char mode, const char *cmd)
 
 	/* Push out any further dirty data, and ensure cache is empty */
 	flush_cache_all();
+}
 
-	/*
-	 * Now call the architecture specific reboot code.
-	 */
-	arch_reset(mode, cmd);
+void arm_machine_restart(char mode, const char *cmd)
+{
+	/* Disable interrupts first */
+	local_irq_disable();
+	local_fiq_disable();
 
-	/*
-	 * Whoops - the architecture was unable to reboot.
-	 * Tell the user!
-	 */
-	mdelay(1000);
-	printk("Reboot failed -- System halted\n");
-	while (1);
+	setup_restart();
+
+	/* Now call the architecture specific reboot code. */
+	arch_reset(mode, cmd);
 }
 
 /*
@@ -250,7 +245,15 @@ void machine_power_off(void)
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
