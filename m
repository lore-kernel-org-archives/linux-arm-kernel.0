From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 01 Apr 2015 17:06:20 +0100
Subject: [PATCH] ARM: move reboot code to arch/arm/kernel/reboot.c
Message-ID: <E1YdL9o-0007ou-IE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move shutdown and reboot related code to a separate file, out of
process.c.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Subsequent to the previous patch fixing hibernation, this one separates
out the reboot code to its own file, and cleans up the function
prototype in hibernate.c.

 arch/arm/kernel/Makefile    |   2 +-
 arch/arm/kernel/hibernate.c |   1 -
 arch/arm/kernel/process.c   | 148 ------------------------------------------
 arch/arm/kernel/reboot.c    | 155 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/reboot.h    |   1 +
 5 files changed, 157 insertions(+), 150 deletions(-)
 create mode 100644 arch/arm/kernel/reboot.c

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 24ad4fd1cd1f..ba5f83226011 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -16,7 +16,7 @@ CFLAGS_REMOVE_return_address.o = -pg
 # Object file lists.
 
 obj-y		:= elf.o entry-common.o irq.o opcodes.o \
-		   process.o ptrace.o return_address.o \
+		   process.o ptrace.o reboot.o return_address.o \
 		   setup.o signal.o sigreturn_codes.o \
 		   stacktrace.o sys_arm.o time.o traps.o
 
diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
index cfb354ff2a60..a71501ff6f18 100644
--- a/arch/arm/kernel/hibernate.c
+++ b/arch/arm/kernel/hibernate.c
@@ -100,7 +100,6 @@ static u64 resume_stack[PAGE_SIZE/2/sizeof(u64)] __nosavedata;
  */
 int swsusp_arch_resume(void)
 {
-	extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
 	call_with_stack(arch_restore_image, 0,
 		resume_stack + ARRAY_SIZE(resume_stack));
 	return 0;
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index d14d38b860f8..f192a2a41719 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -17,12 +17,9 @@
 #include <linux/stddef.h>
 #include <linux/unistd.h>
 #include <linux/user.h>
-#include <linux/delay.h>
-#include <linux/reboot.h>
 #include <linux/interrupt.h>
 #include <linux/kallsyms.h>
 #include <linux/init.h>
-#include <linux/cpu.h>
 #include <linux/elfcore.h>
 #include <linux/pm.h>
 #include <linux/tick.h>
@@ -31,10 +28,7 @@
 #include <linux/random.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/leds.h>
-#include <linux/reboot.h>
 
-#include <asm/cacheflush.h>
-#include <asm/idmap.h>
 #include <asm/processor.h>
 #include <asm/thread_notify.h>
 #include <asm/stacktrace.h>
@@ -42,7 +36,6 @@
 #include <asm/mach/time.h>
 #include <asm/tls.h>
 #include <asm/vdso.h>
-#include "reboot.h"
 
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
@@ -61,74 +54,6 @@ static const char *isa_modes[] __maybe_unused = {
   "ARM" , "Thumb" , "Jazelle", "ThumbEE"
 };
 
-extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
-typedef void (*phys_reset_t)(unsigned long);
-
-/*
- * A temporary stack to use for CPU reset. This is static so that we
- * don't clobber it with the identity mapping. When running with this
- * stack, any references to the current task *will not work* so you
- * should really do as little as possible before jumping to your reset
- * code.
- */
-static u64 soft_restart_stack[16];
-
-static void __soft_restart(void *addr)
-{
-	phys_reset_t phys_reset;
-
-	/* Take out a flat memory mapping. */
-	setup_mm_for_reboot();
-
-	/* Clean and invalidate caches */
-	flush_cache_all();
-
-	/* Turn off caching */
-	cpu_proc_fin();
-
-	/* Push out any further dirty data, and ensure cache is empty */
-	flush_cache_all();
-
-	/* Switch to the identity mapping. */
-	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
-	phys_reset((unsigned long)addr);
-
-	/* Should never get here. */
-	BUG();
-}
-
-void _soft_restart(unsigned long addr, bool disable_l2)
-{
-	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
-
-	/* Disable interrupts first */
-	raw_local_irq_disable();
-	local_fiq_disable();
-
-	/* Disable the L2 if we're the last man standing. */
-	if (disable_l2)
-		outer_disable();
-
-	/* Change to the new stack and continue with the reset. */
-	call_with_stack(__soft_restart, (void *)addr, (void *)stack);
-
-	/* Should never get here. */
-	BUG();
-}
-
-void soft_restart(unsigned long addr)
-{
-	_soft_restart(addr, num_online_cpus() == 1);
-}
-
-/*
- * Function pointers to optional machine specific functions
- */
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
-
-void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
-
 /*
  * This is our default idle handler.
  */
@@ -173,79 +98,6 @@ void arch_cpu_idle_dead(void)
 }
 #endif
 
-/*
- * Called by kexec, immediately prior to machine_kexec().
- *
- * This must completely disable all secondary CPUs; simply causing those CPUs
- * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
- * kexec'd kernel to use any and all RAM as it sees fit, without having to
- * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
- * functionality embodied in disable_nonboot_cpus() to achieve this.
- */
-void machine_shutdown(void)
-{
-	disable_nonboot_cpus();
-}
-
-/*
- * Halting simply requires that the secondary CPUs stop performing any
- * activity (executing tasks, handling interrupts). smp_send_stop()
- * achieves this.
- */
-void machine_halt(void)
-{
-	local_irq_disable();
-	smp_send_stop();
-
-	local_irq_disable();
-	while (1);
-}
-
-/*
- * Power-off simply requires that the secondary CPUs stop performing any
- * activity (executing tasks, handling interrupts). smp_send_stop()
- * achieves this. When the system power is turned off, it will take all CPUs
- * with it.
- */
-void machine_power_off(void)
-{
-	local_irq_disable();
-	smp_send_stop();
-
-	if (pm_power_off)
-		pm_power_off();
-}
-
-/*
- * Restart requires that the secondary CPUs stop performing any activity
- * while the primary CPU resets the system. Systems with a single CPU can
- * use soft_restart() as their machine descriptor's .restart hook, since that
- * will cause the only available CPU to reset. Systems with multiple CPUs must
- * provide a HW restart implementation, to ensure that all CPUs reset at once.
- * This is required so that any code running after reset on the primary CPU
- * doesn't have to co-ordinate with other CPUs to ensure they aren't still
- * executing pre-reset code, and using RAM that the primary CPU's code wishes
- * to use. Implementing such co-ordination would be essentially impossible.
- */
-void machine_restart(char *cmd)
-{
-	local_irq_disable();
-	smp_send_stop();
-
-	if (arm_pm_restart)
-		arm_pm_restart(reboot_mode, cmd);
-	else
-		do_kernel_restart(cmd);
-
-	/* Give a grace period for failure to restart of 1s */
-	mdelay(1000);
-
-	/* Whoops - the platform was unable to reboot. Tell the user! */
-	printk("Reboot failed -- System halted\n");
-	local_irq_disable();
-	while (1);
-}
-
 void __show_regs(struct pt_regs *regs)
 {
 	unsigned long flags;
diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
new file mode 100644
index 000000000000..1a4d232796be
--- /dev/null
+++ b/arch/arm/kernel/reboot.c
@@ -0,0 +1,155 @@
+/*
+ *  Copyright (C) 1996-2000 Russell King - Converted to ARM.
+ *  Original Copyright (C) 1995  Linus Torvalds
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
+
+#include <asm/cacheflush.h>
+#include <asm/idmap.h>
+
+#include "reboot.h"
+
+typedef void (*phys_reset_t)(unsigned long);
+
+/*
+ * Function pointers to optional machine specific functions
+ */
+void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+
+/*
+ * A temporary stack to use for CPU reset. This is static so that we
+ * don't clobber it with the identity mapping. When running with this
+ * stack, any references to the current task *will not work* so you
+ * should really do as little as possible before jumping to your reset
+ * code.
+ */
+static u64 soft_restart_stack[16];
+
+static void __soft_restart(void *addr)
+{
+	phys_reset_t phys_reset;
+
+	/* Take out a flat memory mapping. */
+	setup_mm_for_reboot();
+
+	/* Clean and invalidate caches */
+	flush_cache_all();
+
+	/* Turn off caching */
+	cpu_proc_fin();
+
+	/* Push out any further dirty data, and ensure cache is empty */
+	flush_cache_all();
+
+	/* Switch to the identity mapping. */
+	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
+	phys_reset((unsigned long)addr);
+
+	/* Should never get here. */
+	BUG();
+}
+
+void _soft_restart(unsigned long addr, bool disable_l2)
+{
+	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
+
+	/* Disable interrupts first */
+	raw_local_irq_disable();
+	local_fiq_disable();
+
+	/* Disable the L2 if we're the last man standing. */
+	if (disable_l2)
+		outer_disable();
+
+	/* Change to the new stack and continue with the reset. */
+	call_with_stack(__soft_restart, (void *)addr, (void *)stack);
+
+	/* Should never get here. */
+	BUG();
+}
+
+void soft_restart(unsigned long addr)
+{
+	_soft_restart(addr, num_online_cpus() == 1);
+}
+
+/*
+ * Called by kexec, immediately prior to machine_kexec().
+ *
+ * This must completely disable all secondary CPUs; simply causing those CPUs
+ * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
+ * kexec'd kernel to use any and all RAM as it sees fit, without having to
+ * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
+ * functionality embodied in disable_nonboot_cpus() to achieve this.
+ */
+void machine_shutdown(void)
+{
+	disable_nonboot_cpus();
+}
+
+/*
+ * Halting simply requires that the secondary CPUs stop performing any
+ * activity (executing tasks, handling interrupts). smp_send_stop()
+ * achieves this.
+ */
+void machine_halt(void)
+{
+	local_irq_disable();
+	smp_send_stop();
+
+	local_irq_disable();
+	while (1);
+}
+
+/*
+ * Power-off simply requires that the secondary CPUs stop performing any
+ * activity (executing tasks, handling interrupts). smp_send_stop()
+ * achieves this. When the system power is turned off, it will take all CPUs
+ * with it.
+ */
+void machine_power_off(void)
+{
+	local_irq_disable();
+	smp_send_stop();
+
+	if (pm_power_off)
+		pm_power_off();
+}
+
+/*
+ * Restart requires that the secondary CPUs stop performing any activity
+ * while the primary CPU resets the system. Systems with a single CPU can
+ * use soft_restart() as their machine descriptor's .restart hook, since that
+ * will cause the only available CPU to reset. Systems with multiple CPUs must
+ * provide a HW restart implementation, to ensure that all CPUs reset at once.
+ * This is required so that any code running after reset on the primary CPU
+ * doesn't have to co-ordinate with other CPUs to ensure they aren't still
+ * executing pre-reset code, and using RAM that the primary CPU's code wishes
+ * to use. Implementing such co-ordination would be essentially impossible.
+ */
+void machine_restart(char *cmd)
+{
+	local_irq_disable();
+	smp_send_stop();
+
+	if (arm_pm_restart)
+		arm_pm_restart(reboot_mode, cmd);
+	else
+		do_kernel_restart(cmd);
+
+	/* Give a grace period for failure to restart of 1s */
+	mdelay(1000);
+
+	/* Whoops - the platform was unable to reboot. Tell the user! */
+	printk("Reboot failed -- System halted\n");
+	local_irq_disable();
+	while (1);
+}
diff --git a/arch/arm/kernel/reboot.h b/arch/arm/kernel/reboot.h
index c87f05816d6b..bf7a0b1f076e 100644
--- a/arch/arm/kernel/reboot.h
+++ b/arch/arm/kernel/reboot.h
@@ -1,6 +1,7 @@
 #ifndef REBOOT_H
 #define REBOOT_H
 
+extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
 extern void _soft_restart(unsigned long addr, bool disable_l2);
 
 #endif
-- 
1.8.3.1
