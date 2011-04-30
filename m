From: robherring2@gmail.com (Rob Herring)
Date: Fri, 29 Apr 2011 21:08:09 -0500
Subject: [PATCH 02/10] ARM: ux500: convert to use common secondary pen code
In-Reply-To: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
Message-ID: <1304129297-6614-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-ux500/Kconfig            |    1 +
 arch/arm/mach-ux500/Makefile           |    2 +-
 arch/arm/mach-ux500/headsmp.S          |   37 ---------------
 arch/arm/mach-ux500/include/mach/smp.h |    4 +-
 arch/arm/mach-ux500/platsmp.c          |   79 +-------------------------------
 5 files changed, 5 insertions(+), 118 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/headsmp.S

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 5862601..ba5c78c 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -7,6 +7,7 @@ config UX500_SOC_COMMON
 	select HAS_MTU
 	select NOMADIK_GPIO
 	select ARM_ERRATA_753970
+	select SMP_COMMON_PEN if SMP
 
 menu "Ux500 SoC"
 
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index b549a8f..8c89d18 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-u8500uib.o \
 				board-mop500-pins.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
-obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+obj-$(CONFIG_SMP)		+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 obj-$(CONFIG_U5500_MODEM_IRQ)	+= modem-irq-db5500.o
diff --git a/arch/arm/mach-ux500/headsmp.S b/arch/arm/mach-ux500/headsmp.S
deleted file mode 100644
index 64fa451..0000000
--- a/arch/arm/mach-ux500/headsmp.S
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- *  Copyright (c) 2009 ST-Ericsson
- *	This file is based  ARM Realview platform
- *  Copyright (c) 2003 ARM Limited
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-	__INIT
-
-/*
- * U8500 specific entry point for secondary CPUs.
- */
-ENTRY(u8500_secondary_startup)
-	mrc	p15, 0, r0, c0, c0, 5
-	and	r0, r0, #15
-	adr	r4, 1f
-	ldmia	r4, {r5, r6}
-	sub	r4, r4, r5
-	add	r6, r6, r4
-pen:	ldr	r7, [r6]
-	cmp	r7, r0
-	bne	pen
-
-	/*
-	 * we've been released from the holding pen: secondary_stack
-	 * should now contain the SVC stack for this core
-	 */
-	b	secondary_startup
-
-1:	.long	.
-	.long	pen_release
diff --git a/arch/arm/mach-ux500/include/mach/smp.h b/arch/arm/mach-ux500/include/mach/smp.h
index ca2b15b..a99d674 100644
--- a/arch/arm/mach-ux500/include/mach/smp.h
+++ b/arch/arm/mach-ux500/include/mach/smp.h
@@ -11,8 +11,8 @@
 
 #include <asm/hardware/gic.h>
 
-/* This is required to wakeup the secondary core */
-extern void u8500_secondary_startup(void);
+#define boot_secondary pen_boot_secondary
+#define platform_secondary_init pen_secondary_init
 
 /*
  * We use IRQ1 as the IPI
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 4fff4d4..88f30b8 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -22,25 +22,6 @@
 #include <mach/hardware.h>
 #include <mach/setup.h>
 
-/*
- * control for which core is the next to come out of the secondary
- * boot "holding pen"
- */
-volatile int pen_release = -1;
-
-/*
- * Write pen_release in a way that is guaranteed to be visible to all
- * observers, irrespective of whether they're taking part in coherency
- * or not.  This is necessary for the hotplug code to work reliably.
- */
-static void write_pen_release(int val)
-{
-	pen_release = val;
-	smp_wmb();
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
-}
-
 static void __iomem *scu_base_addr(void)
 {
 	if (cpu_is_u5500())
@@ -53,64 +34,6 @@ static void __iomem *scu_base_addr(void)
 	return NULL;
 }
 
-static DEFINE_SPINLOCK(boot_lock);
-
-void __cpuinit platform_secondary_init(unsigned int cpu)
-{
-	/*
-	 * if any interrupts are already enabled for the primary
-	 * core (e.g. timer irq), then they will not have been enabled
-	 * for us: do so
-	 */
-	gic_secondary_init(0);
-
-	/*
-	 * let the primary processor know we're out of the
-	 * pen, then head off into the C entry point
-	 */
-	write_pen_release(-1);
-
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
-}
-
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
-{
-	unsigned long timeout;
-
-	/*
-	 * set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
-
-	/*
-	 * The secondary processor is waiting to be released from
-	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
-	 */
-	write_pen_release(cpu);
-
-	smp_cross_call(cpumask_of(cpu), 1);
-
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		if (pen_release == -1)
-			break;
-	}
-
-	/*
-	 * now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	spin_unlock(&boot_lock);
-
-	return pen_release != -1 ? -ENOSYS : 0;
-}
-
 static void __init wakeup_secondary(void)
 {
 	void __iomem *backupram;
@@ -129,7 +52,7 @@ static void __init wakeup_secondary(void)
 	 * is waiting for. This would wake up the secondary core from WFE
 	 */
 #define UX500_CPU1_JUMPADDR_OFFSET 0x1FF4
-	__raw_writel(virt_to_phys(u8500_secondary_startup),
+	__raw_writel(virt_to_phys(pen_secondary_startup),
 		     backupram + UX500_CPU1_JUMPADDR_OFFSET);
 
 #define UX500_CPU1_WAKEMAGIC_OFFSET 0x1FF0
-- 
1.7.1
