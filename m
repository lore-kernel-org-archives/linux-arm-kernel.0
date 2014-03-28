From: elder@linaro.org (Alex Elder)
Date: Fri, 28 Mar 2014 16:12:58 -0500
Subject: [RFC PATCH 5/7] ARM: versatile: kill off SMP support code
In-Reply-To: <1396041180-29897-1-git-send-email-elder@linaro.org>
References: <1396041180-29897-1-git-send-email-elder@linaro.org>
Message-ID: <1396041180-29897-6-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two users of the SMP support code under arch/arm/mach-versatile
are now using common code.  So a bunch of stuff under mach-versatile
can just go away.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/mach-vexpress/v2m.c                   |    1 -
 arch/arm/plat-versatile/Makefile               |    1 -
 arch/arm/plat-versatile/headsmp.S              |   41 -----------
 arch/arm/plat-versatile/include/plat/platsmp.h |   14 ----
 arch/arm/plat-versatile/platsmp.c              |   91 ------------------------
 5 files changed, 148 deletions(-)
 delete mode 100644 arch/arm/plat-versatile/headsmp.S
 delete mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h
 delete mode 100644 arch/arm/plat-versatile/platsmp.c

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 4f8b8cb..c2dc99b 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -35,7 +35,6 @@
 #include <mach/motherboard.h>
 
 #include <plat/sched_clock.h>
-#include <plat/platsmp.h>
 
 #include "core.h"
 
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index f88d448..d71d1b4 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -4,4 +4,3 @@ obj-$(CONFIG_PLAT_VERSATILE_CLOCK) += clock.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
 obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
 obj-$(CONFIG_PLAT_VERSATILE_SCHED_CLOCK) += sched-clock.o
-obj-$(CONFIG_SMP) += headsmp.o platsmp.o
diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
deleted file mode 100644
index 40f27e5..0000000
--- a/arch/arm/plat-versatile/headsmp.S
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- *  linux/arch/arm/plat-versatile/headsmp.S
- *
- *  Copyright (c) 2003 ARM Limited
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <asm/assembler.h>
-
-/*
- * Realview/Versatile Express specific entry point for secondary CPUs.
- * This provides a "holding pen" into which all secondary cores are held
- * until we're ready for them to initialise.
- */
-ENTRY(versatile_secondary_startup)
- ARM_BE8(setend	be)
-	mrc	p15, 0, r0, c0, c0, 5
-	bic	r0, #0xff000000
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
-	.align
-1:	.long	.
-	.long	pen_release
-ENDPROC(versatile_secondary_startup)
diff --git a/arch/arm/plat-versatile/include/plat/platsmp.h b/arch/arm/plat-versatile/include/plat/platsmp.h
deleted file mode 100644
index 50fb830..0000000
--- a/arch/arm/plat-versatile/include/plat/platsmp.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- *  linux/arch/arm/plat-versatile/include/plat/platsmp.h
- *
- *  Copyright (C) 2011 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-extern void versatile_secondary_startup(void);
-extern void versatile_secondary_init(unsigned int cpu);
-extern int  versatile_boot_secondary(unsigned int cpu, struct task_struct *idle);
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
deleted file mode 100644
index 53feb90..0000000
--- a/arch/arm/plat-versatile/platsmp.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- *  linux/arch/arm/plat-versatile/platsmp.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/jiffies.h>
-#include <linux/smp.h>
-
-#include <asm/cacheflush.h>
-#include <asm/smp_plat.h>
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
-	sync_cache_w(&pen_release);
-}
-
-static DEFINE_SPINLOCK(boot_lock);
-
-void versatile_secondary_init(unsigned int cpu)
-{
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
-int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
-{
-	unsigned long timeout;
-
-	/*
-	 * Set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
-
-	/*
-	 * This is really belt and braces; we hold unintended secondary
-	 * CPUs in the holding pen until we're ready for them.  However,
-	 * since we haven't sent them a soft interrupt, they shouldn't
-	 * be there.
-	 */
-	write_pen_release(cpu_logical_map(cpu));
-
-	/*
-	 * Send the secondary CPU a soft interrupt, thereby causing
-	 * the boot monitor to read the system wide flags register,
-	 * and branch to the address found there.
-	 */
-	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
-
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		smp_rmb();
-		if (pen_release == -1)
-			break;
-
-		udelay(10);
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
-- 
1.7.9.5
