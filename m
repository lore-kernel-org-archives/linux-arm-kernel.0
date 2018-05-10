From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Thu, 10 May 2018 12:41:35 +0200
Subject: [PATCH] CNS3xxx: Add SMP support
Message-ID: <m3y3grssgw.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -3,6 +3,9 @@ menuconfig ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family"
 	depends on ARCH_MULTI_V6
 	select ARM_GIC
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD
+	select HAVE_SMP
 	help
 	  Support for Cavium Networks CNS3XXX platform.
 
--- a/arch/arm/mach-cns3xxx/Makefile
+++ b/arch/arm/mach-cns3xxx/Makefile
@@ -4,3 +4,4 @@ cns3xxx-y				+= core.o pm.o
 cns3xxx-$(CONFIG_ATAGS)			+= devices.o
 cns3xxx-$(CONFIG_PCI)			+= pcie.o
 cns3xxx-$(CONFIG_MACH_CNS3420VB)	+= cns3420vb.o
+cns3xxx-$(CONFIG_SMP)			+= platsmp.o headsmp.o
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -251,5 +251,6 @@ MACHINE_START(CNS3420VB, "Cavium Networks CNS3420 Validation Board")
 	.init_time	= cns3xxx_timer_init,
 	.init_machine	= cns3420_init,
 	.init_late      = cns3xxx_pcie_init_late,
+	.smp		= smp_ops(cns3xxx_smp_ops),
 	.restart	= cns3xxx_restart,
 MACHINE_END
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
+#include <asm/smp_twd.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -26,6 +27,8 @@
 #include "core.h"
 #include "pm.h"
 
+#define IRQ_LOCALTIMER 29
+
 static struct map_desc cns3xxx_io_desc[] __initdata = {
 	{
 		.virtual	= CNS3XXX_TC11MP_SCU_BASE_VIRT,
@@ -198,6 +201,15 @@ static struct irqaction cns3xxx_timer_irq = {
 	.handler	= cns3xxx_timer_interrupt,
 };
 
+static void __init cns3xxx_init_twd(void)
+{
+	static DEFINE_TWD_LOCAL_TIMER(cns3xx_twd_local_timer,
+		CNS3XXX_TC11MP_TWD_BASE,
+		IRQ_LOCALTIMER);
+
+	twd_local_timer_register(&cns3xx_twd_local_timer);
+}
+
 /*
  * Set up the clock source and clock events devices
  */
@@ -251,6 +263,7 @@ static void __init __cns3xxx_timer_init(unsigned int timer_irq)
 	setup_irq(timer_irq, &cns3xxx_timer_irq);
 
 	cns3xxx_clockevents_init(timer_irq);
+	cns3xxx_init_twd();
 }
 
 void __init cns3xxx_timer_init(void)
--- a/arch/arm/mach-cns3xxx/core.h
+++ b/arch/arm/mach-cns3xxx/core.h
@@ -13,6 +13,7 @@
 
 #include <linux/reboot.h>
 
+extern struct smp_operations cns3xxx_smp_ops;
 extern void cns3xxx_timer_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
--- /dev/null
+++ b/arch/arm/mach-cns3xxx/headsmp.S
@@ -0,0 +1,39 @@
+/*
+ *  Cloned from linux/arch/arm/mach-exynos/headsmp.S
+ *
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
+/*
+ * CNS3XXX specific entry point for secondary CPUs.  This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(cns3xxx_secondary_startup)
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #15
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+pen:	ldr	r7, [r6]
+	cmp	r7, r0
+	bne	pen
+
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+ENDPROC(cns3xxx_secondary_startup)
+
+	.align 2
+1:	.long	.
+	.long	pen_release
--- /dev/null
+++ b/arch/arm/mach-cns3xxx/platsmp.c
@@ -0,0 +1,151 @@
+/*
+ *  linux/arch/arm/mach-cns3xxx/platsmp.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  Copyright 2012 Gateworks Corporation
+ *         Chris Lang <clang@gateworks.com>
+ *         Tim Harvey <tharvey@gateworks.com>
+ *
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/jiffies.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_scu.h>
+#include <asm/unified.h>
+#include "cns3xxx.h"
+
+extern void cns3xxx_secondary_startup(void);
+
+#define SCU_CPU_STATUS 0x08
+#define SCU_BASE ((void __iomem *)CNS3XXX_TC11MP_SCU_BASE_VIRT)
+
+/*
+ * Write pen_release in a way that is guaranteed to be visible to all
+ * observers, irrespective of whether they're taking part in coherency
+ * or not.  This is necessary for the hotplug code to work reliably.
+ */
+static void write_pen_release(int val)
+{
+	pen_release = val;
+	smp_wmb();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+}
+
+static DEFINE_SPINLOCK(boot_lock);
+
+static void cns3xxx_secondary_init(unsigned int cpu)
+{
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	write_pen_release(-1);
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+static int cns3xxx_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+
+	/*
+	 * Set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 *
+	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * "cpu" is Linux's internal ID.
+	 */
+	write_pen_release(cpu);
+
+	/*
+	 * Send the secondary CPU a soft interrupt, thereby causing
+	 * the boot monitor to read the system wide flags register,
+	 * and branch to the address found there.
+	 */
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
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
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+static void __init cns3xxx_smp_init_cpus(void)
+{
+	unsigned int i, ncores;
+	unsigned int status;
+
+	/* SCU_CPU_STATUS must be examined instead of SCU_CONFIGURATION
+	 * used in scu_get_core_count
+	 */
+	status = __raw_readl(SCU_BASE + SCU_CPU_STATUS);
+	for (i = 0; i < NR_CPUS + 1; i++) {
+		if (((status >> (i * 2)) & 0x3) == 0)
+			set_cpu_possible(i, true);
+		else
+			break;
+	}
+	ncores = i;
+}
+
+static void __init cns3xxx_smp_prepare_cpus(unsigned int max_cpus)
+{
+	/*
+	 * enable SCU
+	 */
+	scu_enable(SCU_BASE);
+
+	/*
+	 * Write the address of secondary startup into the
+	 * system-wide flags register. The boot monitor waits
+	 * until it receives a soft interrupt, and then the
+	 * secondary CPU branches to this address.
+	 */
+	__raw_writel(virt_to_phys(cns3xxx_secondary_startup),
+			(void __iomem *)(CNS3XXX_MISC_BASE_VIRT + 0x0600));
+}
+
+struct smp_operations cns3xxx_smp_ops __initdata = {
+	.smp_init_cpus      = cns3xxx_smp_init_cpus,
+	.smp_prepare_cpus   = cns3xxx_smp_prepare_cpus,
+	.smp_secondary_init = cns3xxx_secondary_init,
+	.smp_boot_secondary = cns3xxx_boot_secondary,
+};

-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
