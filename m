From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Thu, 24 Sep 2009 01:17:42 +0530
Subject: [PATCH 2/8] [ARM] U8500: adds secondary cpu support, local timers
Message-ID: <1253735262.21542.168.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

This adds entry point for the secondary CPU and
setup the infrastructure for the secondary CPU.
This also enables the local timer for U8500, whereas
this doesn't participate in the system tick.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
Reviewed-by: Alessandro Rubini <ru@gnudd.com>
Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/headsmp.S    |   38 ++++++++
 arch/arm/mach-ux500/localtimer.c |   28 ++++++
 arch/arm/mach-ux500/platsmp.c    |  181 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ux500/headsmp.S
 create mode 100644 arch/arm/mach-ux500/localtimer.c
 create mode 100644 arch/arm/mach-ux500/platsmp.c

diff --git a/arch/arm/mach-ux500/headsmp.S b/arch/arm/mach-ux500/headsmp.S
new file mode 100644
index 0000000..a6be2cd
--- /dev/null
+++ b/arch/arm/mach-ux500/headsmp.S
@@ -0,0 +1,38 @@
+/*
+ *  Copyright (c) 2009 ST-Ericsson
+ *	This file is based  ARM Realview platform
+ *  Copyright (c) 2003 ARM Limited
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__INIT
+
+/*
+ * U8500 specific entry point for secondary CPUs.
+ */
+ENTRY(u8500_secondary_startup)
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #15
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+	dsb
+pen:	ldr	r7, [r6]
+	cmp	r7, r0
+	bne	pen
+
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+
+1:	.long	.
+	.long	pen_release
diff --git a/arch/arm/mach-ux500/localtimer.c b/arch/arm/mach-ux500/localtimer.c
new file mode 100644
index 0000000..2288f6a
--- /dev/null
+++ b/arch/arm/mach-ux500/localtimer.c
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2008-2009 ST-Ericsson
+ * Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
+ *
+ * This file is heavily based on relaview platform, almost a copy.
+ *
+ * Copyright (C) 2002 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/clockchips.h>
+
+#include <asm/irq.h>
+#include <asm/smp_twd.h>
+#include <asm/localtimer.h>
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+void __cpuinit local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = IRQ_LOCALTIMER;
+	twd_timer_setup(evt);
+}
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
new file mode 100644
index 0000000..88dcb9e
--- /dev/null
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -0,0 +1,181 @@
+/*
+ * Copyright (C) 2002 ARM Ltd.
+ * Copyright (C) 2008 STMicroelctronics.
+ * Copyright (C) 2009 ST-Ericsson.
+ *	added support to boot from non volatile memory device
+ *		Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
+ *
+ * This file is based on arm realview platform
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+
+#include <asm/cacheflush.h>
+#include <asm/localtimer.h>
+#include <asm/smp_scu.h>
+#include <mach/hardware.h>
+
+extern void u8500_secondary_startup(void);
+
+/*
+ * control for which core is the next to come out of the secondary
+ * boot "holding pen"
+ */
+volatile int __cpuinitdata pen_release = -1;
+
+static unsigned int __init get_core_count(void)
+{
+	return scu_get_core_count(__io_address(U8500_SCU_BASE));
+}
+
+static DEFINE_SPINLOCK(boot_lock);
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	trace_hardirqs_off();
+
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_cpu_init(0, __io_address(U8500_GIC_CPU_BASE));
+
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	pen_release = -1;
+	smp_wmb();
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+
+	/*
+	 * set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 */
+	pen_release = cpu;
+	flush_cache_all();
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return pen_release != -1 ? -ENOSYS : 0;
+}
+
+static void __init wakeup_secondary(void)
+{
+	/* nobody is to be released from the pen yet */
+	pen_release = -1;
+
+	/*
+	 * write the address of secondary startup into the backup ram register
+	 * at offset 0x1FF4, then write the magic number 0xA1FEED01 to the
+	 * backup ram register at offset 0x1FF0, which is what boot rom code
+	 * is waiting for. This would wake up the secondary core from WFE
+	 */
+#define U8500_CPU1_JUMPADDR_OFFSET 0x1FF4
+	__raw_writel(virt_to_phys(u8500_secondary_startup),
+			(void __iomem *)U8500_BACKUPRAM0_VA_BASE +
+			U8500_CPU1_JUMPADDR_OFFSET);
+#define U8500_CPU1_WAKEMAGIC_OFFSET 0x1FF0
+	__raw_writel(0xA1FEED01,
+			(void __iomem *)U8500_BACKUPRAM0_VA_BASE +
+			U8500_CPU1_WAKEMAGIC_OFFSET);
+	mb();
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+void __init smp_init_cpus(void)
+{
+	unsigned int i, ncores = get_core_count();
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned int ncores = get_core_count();
+	unsigned int cpu = smp_processor_id();
+	int i;
+
+	/* sanity check */
+	if (ncores == 0) {
+		printk(KERN_ERR
+		       "U8500: strange CM count of 0? Default to 1\n");
+		ncores = 1;
+	}
+
+	if (ncores > NR_CPUS) {
+		printk(KERN_WARNING
+		       "U8500: no. of cores (%d) greater than configured "
+		       "maximum of %d - clipping\n",
+		       ncores, NR_CPUS);
+		ncores = NR_CPUS;
+	}
+
+	smp_store_cpu_info(cpu);
+
+	/*
+	 * are we trying to boot more cores than exist?
+	 */
+	if (max_cpus > ncores)
+		max_cpus = ncores;
+
+	/*
+	 * Initialise the present map, which describes the set of CPUs
+	 * actually populated at the present time.
+	 */
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+
+	if (max_cpus > 1) {
+		/*
+		 * Enable the local timer or broadcast device for the
+		 * boot CPU, but only if we have more than one CPU.
+		 */
+		percpu_timer_setup();
+		scu_enable(__io_address(U8500_SCU_BASE));
+		wakeup_secondary();
+	}
+}
-- 
1.6.3.GIT
