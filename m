From: robherring2@gmail.com (Rob Herring)
Date: Fri, 29 Apr 2011 21:08:08 -0500
Subject: [PATCH 01/10] ARM: move Versatile SMP pen code to common location
In-Reply-To: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
Message-ID: <1304129297-6614-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The same secondary boot pen code is used by several platforms besides ARM Ltd
boards, so move it to a shared location.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig                          |    7 ++
 arch/arm/include/asm/smp.h                |    4 +
 arch/arm/kernel/Makefile                  |    3 +-
 arch/arm/kernel/headsmp.S                 |   40 +++++++++++
 arch/arm/kernel/smp_pen.c                 |  104 +++++++++++++++++++++++++++++
 arch/arm/mach-realview/include/mach/smp.h |    3 +
 arch/arm/mach-realview/platsmp.c          |    4 +-
 arch/arm/mach-vexpress/include/mach/smp.h |    3 +
 arch/arm/mach-vexpress/platsmp.c          |    4 +-
 arch/arm/plat-versatile/Makefile          |    1 -
 arch/arm/plat-versatile/headsmp.S         |   40 -----------
 arch/arm/plat-versatile/platsmp.c         |  104 -----------------------------
 12 files changed, 165 insertions(+), 152 deletions(-)
 create mode 100644 arch/arm/kernel/headsmp.S
 create mode 100644 arch/arm/kernel/smp_pen.c
 delete mode 100644 arch/arm/plat-versatile/headsmp.S
 delete mode 100644 arch/arm/plat-versatile/platsmp.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d46185a..84e2127 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1057,6 +1057,7 @@ config PLAT_PXA
 
 config PLAT_VERSATILE
 	bool
+	select SMP_COMMON_PEN if SMP
 
 config ARM_TIMER_SP804
 	bool
@@ -1381,6 +1382,12 @@ config HAVE_ARM_SCU
 	help
 	  This option enables support for the ARM system coherency unit
 
+config SMP_COMMON_PEN
+	bool
+	depends on SMP
+	help
+	  This option enables common secondary boot pen code.
+
 config HAVE_ARM_TWD
 	bool
 	depends on SMP
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 96ed521..6766cd3 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -73,6 +73,10 @@ extern void platform_secondary_init(unsigned int cpu);
  */
 extern void platform_smp_prepare_cpus(unsigned int);
 
+extern void pen_secondary_init(unsigned int cpu);
+extern int pen_boot_secondary(unsigned int cpu, struct task_struct *);
+extern void pen_secondary_startup(void);
+
 /*
  * Initial data for bringing up a secondary CPU.
  */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 908c78c..62061fa 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_LEDS)		+= leds.o
 obj-$(CONFIG_OC_ETM)		+= etm.o
 
 obj-$(CONFIG_ISA_DMA_API)	+= dma.o
-obj-$(CONFIG_ARCH_ACORN)	+= ecard.o 
+obj-$(CONFIG_ARCH_ACORN)	+= ecard.o
 obj-$(CONFIG_FIQ)		+= fiq.o
 obj-$(CONFIG_MODULES)		+= armksyms.o module.o
 obj-$(CONFIG_ARTHUR)		+= arthur.o
@@ -32,6 +32,7 @@ obj-$(CONFIG_PCI)		+= bios32.o isa.o
 obj-$(CONFIG_PM_SLEEP)		+= sleep.o
 obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
 obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
+obj-$(CONFIG_SMP_COMMON_PEN)	+= headsmp.o smp_pen.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
diff --git a/arch/arm/kernel/headsmp.S b/arch/arm/kernel/headsmp.S
new file mode 100644
index 0000000..712b401
--- /dev/null
+++ b/arch/arm/kernel/headsmp.S
@@ -0,0 +1,40 @@
+/*
+ *  linux/arch/arm/kernel/headsmp.S
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
+ * Entry point for secondary CPUs.
+ * This provides a "holding pen" into which all secondary cores are held
+ * until we're ready for them to initialise.
+ */
+ENTRY(pen_secondary_startup)
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
diff --git a/arch/arm/kernel/smp_pen.c b/arch/arm/kernel/smp_pen.c
new file mode 100644
index 0000000..8a81eeb
--- /dev/null
+++ b/arch/arm/kernel/smp_pen.c
@@ -0,0 +1,104 @@
+/*
+ *  linux/arch/arm/kernel/smp_pen.c
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
+void __cpuinit pen_secondary_init(unsigned int cpu)
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
+int __cpuinit pen_boot_secondary(unsigned int cpu, struct task_struct *idle)
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
diff --git a/arch/arm/mach-realview/include/mach/smp.h b/arch/arm/mach-realview/include/mach/smp.h
index c8221b3..e688f64 100644
--- a/arch/arm/mach-realview/include/mach/smp.h
+++ b/arch/arm/mach-realview/include/mach/smp.h
@@ -3,6 +3,9 @@
 
 #include <asm/hardware/gic.h>
 
+#define boot_secondary pen_boot_secondary
+#define platform_secondary_init pen_secondary_init
+
 /*
  * We use IRQ1 as the IPI
  */
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 2391922..f443ef3 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -24,8 +24,6 @@
 
 #include "core.h"
 
-extern void versatile_secondary_startup(void);
-
 static void __iomem *scu_base_addr(void)
 {
 	if (machine_is_realview_eb_mp())
@@ -82,6 +80,6 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	__raw_writel(BSYM(virt_to_phys(versatile_secondary_startup)),
+	__raw_writel(BSYM(virt_to_phys(pen_secondary_startup)),
 		     __io_address(REALVIEW_SYS_FLAGSSET));
 }
diff --git a/arch/arm/mach-vexpress/include/mach/smp.h b/arch/arm/mach-vexpress/include/mach/smp.h
index 4c05e4a..306ff05 100644
--- a/arch/arm/mach-vexpress/include/mach/smp.h
+++ b/arch/arm/mach-vexpress/include/mach/smp.h
@@ -3,6 +3,9 @@
 
 #include <asm/hardware/gic.h>
 
+#define boot_secondary pen_boot_secondary
+#define platform_secondary_init pen_secondary_init
+
 /*
  * We use IRQ1 as the IPI
  */
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 2b5f7ac..7fa0b68 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -20,8 +20,6 @@
 
 #include "core.h"
 
-extern void versatile_secondary_startup(void);
-
 /*
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
@@ -46,6 +44,6 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * secondary CPU branches to this address.
 	 */
 	writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
-	writel(BSYM(virt_to_phys(versatile_secondary_startup)),
+	writel(BSYM(virt_to_phys(pen_secondary_startup)),
 		MMIO_P2V(V2M_SYS_FLAGSSET));
 }
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 86fe64d..ef7b749 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -3,4 +3,3 @@ obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
 obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
 obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
-obj-$(CONFIG_SMP) += headsmp.o platsmp.o
diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
deleted file mode 100644
index d397a1f..0000000
--- a/arch/arm/plat-versatile/headsmp.S
+++ /dev/null
@@ -1,40 +0,0 @@
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
-
-	__INIT
-
-/*
- * Realview/Versatile Express specific entry point for secondary CPUs.
- * This provides a "holding pen" into which all secondary cores are held
- * until we're ready for them to initialise.
- */
-ENTRY(versatile_secondary_startup)
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
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
deleted file mode 100644
index ba3d471..0000000
--- a/arch/arm/plat-versatile/platsmp.c
+++ /dev/null
@@ -1,104 +0,0 @@
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
-
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
-- 
1.7.1
