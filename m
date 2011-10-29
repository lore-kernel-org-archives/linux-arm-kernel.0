From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 29 Oct 2011 11:21:08 +0100
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <1319813059-8914-2-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
Message-ID: <20111029102108.GY19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2011 at 03:43:29PM +0100, Will Deacon wrote:
> arch_reset is a static inline function defined in mach/system.h and, as
> such, is a blocker for the single zImage work.
> 
> This patch introduces an arm_arch_reset function pointer to which
> platforms can assign their reset function rather than define it in the
> header file.

I think this is slightly the wrong approach.  We already have:

void (*arm_pm_restart)(char str, const char *cmd) = arm_machine_restart;
EXPORT_SYMBOL_GPL(arm_pm_restart);

so why do we need a new function pointer?  We could convert the bulk of
arm_machine_restart() to a library function (setup_restart()), moving
the failure to reboot into machine_restart().

This would then allow everyone to hook into the restart via the same
method irrespective of what they want, and if they want the old
'arch_reset' way, call setup_restart() themselves.

IOW, something like this:

 arch/arm/include/asm/system.h |    2 +-
 arch/arm/kernel/process.c     |   30 +++++++++++++++++-------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 984014b..62a3c3d 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -100,7 +100,7 @@ extern void __show_regs(struct pt_regs *);
 extern int __pure cpu_architecture(void);
 extern void cpu_init(void);
 
-void arm_machine_restart(char mode, const char *cmd);
+void setup_restart(char mode);
 extern void (*arm_pm_restart)(char str, const char *cmd);
 
 #define UDBG_UNDEFINED	(1 << 0)
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index fd08140..ba91ec4 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -92,7 +92,7 @@ static int __init hlt_setup(char *__unused)
 __setup("nohlt", nohlt_setup);
 __setup("hlt", hlt_setup);
 
-void arm_machine_restart(char mode, const char *cmd)
+void setup_restart(char mode)
 {
 	/* Disable interrupts first */
 	local_irq_disable();
@@ -113,19 +113,15 @@ void arm_machine_restart(char mode, const char *cmd)
 
 	/* Push out any further dirty data, and ensure cache is empty */
 	flush_cache_all();
+}
+EXPORT_SYMBOL_GPL(setup_restart);
 
-	/*
-	 * Now call the architecture specific reboot code.
-	 */
-	arch_reset(mode, cmd);
+static void default_restart(char mode, const char *cmd)
+{
+	setup_restart(mode);
 
-	/*
-	 * Whoops - the architecture was unable to reboot.
-	 * Tell the user!
-	 */
-	mdelay(1000);
-	printk("Reboot failed -- System halted\n");
-	while (1);
+	/* Now call the architecture specific reboot code. */
+	arch_reset(mode, cmd);
 }
 
 /*
@@ -134,7 +130,7 @@ void arm_machine_restart(char mode, const char *cmd)
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
-void (*arm_pm_restart)(char str, const char *cmd) = arm_machine_restart;
+void (*arm_pm_restart)(char mode, const char *cmd) = default_restart;
 EXPORT_SYMBOL_GPL(arm_pm_restart);
 
 static void do_nothing(void *unused)
@@ -250,7 +246,15 @@ void machine_power_off(void)
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
