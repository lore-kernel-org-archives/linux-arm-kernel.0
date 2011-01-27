From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:49:09 +0000
Subject: [PATCH 10/11] ARM: realview/vexpress: consolidate SMP bringup code
In-Reply-To: <20110127134532.GE25968@n2100.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiSDl-0003pT-It@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Realview and Versatile Express share the same SMP bringup code, so
consolidate the two implementations.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/Makefile   |    2 +-
 arch/arm/mach-realview/headsmp.S  |   40 --------------
 arch/arm/mach-realview/platsmp.c  |   98 +---------------------------------
 arch/arm/mach-vexpress/Makefile   |    2 +-
 arch/arm/mach-vexpress/headsmp.S  |   40 --------------
 arch/arm/mach-vexpress/platsmp.c  |   94 +--------------------------------
 arch/arm/plat-versatile/Makefile  |    2 +-
 arch/arm/plat-versatile/headsmp.S |   40 ++++++++++++++
 arch/arm/plat-versatile/platsmp.c |  104 +++++++++++++++++++++++++++++++++++++
 9 files changed, 152 insertions(+), 270 deletions(-)
 delete mode 100644 arch/arm/mach-realview/headsmp.S
 delete mode 100644 arch/arm/mach-vexpress/headsmp.S
 create mode 100644 arch/arm/plat-versatile/headsmp.S
 create mode 100644 arch/arm/plat-versatile/platsmp.c

diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index ba85e52..541fa4c 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -8,5 +8,5 @@ obj-$(CONFIG_MACH_REALVIEW_PB11MP)	+= realview_pb11mp.o
 obj-$(CONFIG_MACH_REALVIEW_PB1176)	+= realview_pb1176.o
 obj-$(CONFIG_MACH_REALVIEW_PBA8)	+= realview_pba8.o
 obj-$(CONFIG_MACH_REALVIEW_PBX)		+= realview_pbx.o
-obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
+obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-realview/headsmp.S b/arch/arm/mach-realview/headsmp.S
deleted file mode 100644
index b34be45..0000000
--- a/arch/arm/mach-realview/headsmp.S
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- *  linux/arch/arm/mach-realview/headsmp.S
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
-
-	__INIT
-
-/*
- * Realview specific entry point for secondary CPUs.  This provides
- * a "holding pen" into which all secondary cores are held until we're
- * ready for them to initialise.
- */
-ENTRY(realview_secondary_startup)
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
-	.align
-1:	.long	.
-	.long	pen_release
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 6959d13..2391922 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -10,44 +10,21 @@
  */
 #include <linux/init.h>
 #include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/jiffies.h>
 #include <linux/smp.h>
 #include <linux/io.h>
 
-#include <asm/cacheflush.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
+#include <asm/smp_scu.h>
 #include <asm/unified.h>
 
 #include <mach/board-eb.h>
 #include <mach/board-pb11mp.h>
 #include <mach/board-pbx.h>
-#include <asm/smp_scu.h>
 
 #include "core.h"
 
-extern void realview_secondary_startup(void);
-
-/*
- * control for which core is the next to come out of the secondary
- * boot "holding pen"
- */
-volatile int __cpuinitdata pen_release = -1;
-
-/*
- * Write pen_release in a way that is guaranteed to be visible to all
- * observers, irrespective of whether they're taking part in coherency
- * or not.  This is necessary for the hotplug code to work reliably.
- */
-static void __cpuinit write_pen_release(int val)
-{
-	pen_release = val;
-	smp_wmb();
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
-}
+extern void versatile_secondary_startup(void);
 
 static void __iomem *scu_base_addr(void)
 {
@@ -62,75 +39,6 @@ static void __iomem *scu_base_addr(void)
 		return (void __iomem *)0;
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
-	 *
-	 * Note that "pen_release" is the hardware CPU ID, whereas
-	 * "cpu" is Linux's internal ID.
-	 */
-	write_pen_release(cpu);
-
-	/*
-	 * Send the secondary CPU a soft interrupt, thereby causing
-	 * the boot monitor to read the system wide flags register,
-	 * and branch to the address found there.
-	 */
-	smp_cross_call(cpumask_of(cpu), 1);
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
-
 /*
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
@@ -174,6 +82,6 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	__raw_writel(BSYM(virt_to_phys(realview_secondary_startup)),
+	__raw_writel(BSYM(virt_to_phys(versatile_secondary_startup)),
 		     __io_address(REALVIEW_SYS_FLAGSSET));
 }
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index cfe344e..90551b9 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -4,5 +4,5 @@
 
 obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
-obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
+obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-vexpress/headsmp.S b/arch/arm/mach-vexpress/headsmp.S
deleted file mode 100644
index 7a3f063..0000000
--- a/arch/arm/mach-vexpress/headsmp.S
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- *  linux/arch/arm/mach-vexpress/headsmp.S
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
-
-	__INIT
-
-/*
- * Versatile Express specific entry point for secondary CPUs.  This
- * provides a "holding pen" into which all secondary cores are held
- * until we're ready for them to initialise.
- */
-ENTRY(vexpress_secondary_startup)
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
-	.align
-1:	.long	.
-	.long	pen_release
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 634bf1d..1892702 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -10,13 +10,9 @@
  */
 #include <linux/init.h>
 #include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/jiffies.h>
 #include <linux/smp.h>
 #include <linux/io.h>
 
-#include <asm/cacheflush.h>
 #include <asm/smp_scu.h>
 #include <asm/unified.h>
 
@@ -26,99 +22,13 @@
 
 #include "core.h"
 
-extern void vexpress_secondary_startup(void);
-
-/*
- * control for which core is the next to come out of the secondary
- * boot "holding pen"
- */
-volatile int __cpuinitdata pen_release = -1;
-
-/*
- * Write pen_release in a way that is guaranteed to be visible to all
- * observers, irrespective of whether they're taking part in coherency
- * or not.  This is necessary for the hotplug code to work reliably.
- */
-static void __cpuinit write_pen_release(int val)
-{
-	pen_release = val;
-	smp_wmb();
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
-}
+extern void versatile_secondary_startup(void);
 
 static void __iomem *scu_base_addr(void)
 {
 	return MMIO_P2V(A9_MPCORE_SCU);
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
-	write_pen_release(cpu);
-
-	/*
-	 * Send the secondary CPU a soft interrupt, thereby causing
-	 * the boot monitor to read the system wide flags register,
-	 * and branch to the address found there.
-	 */
-	smp_cross_call(cpumask_of(cpu), 1);
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
-
 /*
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
@@ -163,6 +73,6 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * secondary CPU branches to this address.
 	 */
 	writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
-	writel(BSYM(virt_to_phys(vexpress_secondary_startup)),
+	writel(BSYM(virt_to_phys(versatile_secondary_startup)),
 		MMIO_P2V(V2M_SYS_FLAGSSET));
 }
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index b511abb..69714db 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
 obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
 obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
 obj-$(CONFIG_PLAT_VERSATILE_SCHED_CLOCK) += sched-clock.o
-
+obj-$(CONFIG_SMP) += headsmp.o platsmp.o
diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
new file mode 100644
index 0000000..d397a1f
--- /dev/null
+++ b/arch/arm/plat-versatile/headsmp.S
@@ -0,0 +1,40 @@
+/*
+ *  linux/arch/arm/plat-versatile/headsmp.S
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
+	__INIT
+
+/*
+ * Realview/Versatile Express specific entry point for secondary CPUs.
+ * This provides a "holding pen" into which all secondary cores are held
+ * until we're ready for them to initialise.
+ */
+ENTRY(versatile_secondary_startup)
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
+
+	.align
+1:	.long	.
+	.long	pen_release
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
new file mode 100644
index 0000000..ba3d471
--- /dev/null
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -0,0 +1,104 @@
+/*
+ *  linux/arch/arm/plat-versatile/platsmp.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
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
+
+#include <asm/cacheflush.h>
+
+/*
+ * control for which core is the next to come out of the secondary
+ * boot "holding pen"
+ */
+volatile int __cpuinitdata pen_release = -1;
+
+/*
+ * Write pen_release in a way that is guaranteed to be visible to all
+ * observers, irrespective of whether they're taking part in coherency
+ * or not.  This is necessary for the hotplug code to work reliably.
+ */
+static void __cpuinit write_pen_release(int val)
+{
+	pen_release = val;
+	smp_wmb();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+}
+
+static DEFINE_SPINLOCK(boot_lock);
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_secondary_init(0);
+
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
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
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
+	 * This is really belt and braces; we hold unintended secondary
+	 * CPUs in the holding pen until we're ready for them.  However,
+	 * since we haven't sent them a soft interrupt, they shouldn't
+	 * be there.
+	 */
+	write_pen_release(cpu);
+
+	/*
+	 * Send the secondary CPU a soft interrupt, thereby causing
+	 * the boot monitor to read the system wide flags register,
+	 * and branch to the address found there.
+	 */
+	smp_cross_call(cpumask_of(cpu), 1);
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
-- 
1.6.2.5
