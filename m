From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 17 Oct 2016 10:43:02 +0200
Subject: [PATCH 1/2] ARM: oxnas: Add OX820 SMP support
In-Reply-To: <20161017084303.20078-1-narmstrong@baylibre.com>
References: <20161017084303.20078-1-narmstrong@baylibre.com>
Message-ID: <20161017084303.20078-2-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Oxford Semiconductor OX820 is a ARM11MPcore based SoC sharing some
features with the OX810 earlier SoC.
This patch adds the core to wake up the second core.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-oxnas/Makefile  |   2 +
 arch/arm/mach-oxnas/headsmp.S |  28 ++++++++
 arch/arm/mach-oxnas/hotplug.c | 111 +++++++++++++++++++++++++++++
 arch/arm/mach-oxnas/platsmp.c | 161 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 302 insertions(+)
 create mode 100644 arch/arm/mach-oxnas/Makefile
 create mode 100644 arch/arm/mach-oxnas/headsmp.S
 create mode 100644 arch/arm/mach-oxnas/hotplug.c
 create mode 100644 arch/arm/mach-oxnas/platsmp.c

diff --git a/arch/arm/mach-oxnas/Makefile b/arch/arm/mach-oxnas/Makefile
new file mode 100644
index 0000000..b625906
--- /dev/null
+++ b/arch/arm/mach-oxnas/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+obj-$(CONFIG_HOTPLUG_CPU) 	+= hotplug.o
diff --git a/arch/arm/mach-oxnas/headsmp.S b/arch/arm/mach-oxnas/headsmp.S
new file mode 100644
index 0000000..2a94dcb
--- /dev/null
+++ b/arch/arm/mach-oxnas/headsmp.S
@@ -0,0 +1,28 @@
+/*
+ * linux/arch/arm/mach-oxnas/headsmp.S
+ *
+ * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
+ * Copyright (c) 2003 ARM Limited
+ * All Rights Reserved
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
+ * OX820 specific entry point for secondary CPUs.
+ */
+ENTRY(ox820_secondary_startup)
+	mov r4, #0
+	/* invalidate both caches and branch target cache */
+	mcr p15, 0, r4, c7, c7, 0
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
diff --git a/arch/arm/mach-oxnas/hotplug.c b/arch/arm/mach-oxnas/hotplug.c
new file mode 100644
index 0000000..18fa814
--- /dev/null
+++ b/arch/arm/mach-oxnas/hotplug.c
@@ -0,0 +1,111 @@
+/*
+ *  linux/arch/arm/mach-oxnas/hotplug.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+
+#include <asm/cp15.h>
+#include <asm/smp_plat.h>
+
+static inline void cpu_enter_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile(
+	"	mcr	p15, 0, %1, c7, c5, 0\n"
+	"	mcr	p15, 0, %1, c7, c10, 4\n"
+	/*
+	 * Turn off coherency
+	 */
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	bic	%0, %0, #0x20\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	bic	%0, %0, %2\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	  : "=&r" (v)
+	  : "r" (0), "Ir" (CR_C)
+	  : "cc");
+}
+
+static inline void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile(	"mrc	p15, 0, %0, c1, c0, 0\n"
+	"	orr	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	orr	%0, %0, #0x20\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	  : "=&r" (v)
+	  : "Ir" (CR_C)
+	  : "cc");
+}
+
+static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
+{
+	/*
+	 * there is no power-control hardware on this platform, so all
+	 * we can do is put the core into WFI; this is safe as the calling
+	 * code will have already disabled interrupts
+	 */
+	for (;;) {
+		/*
+		 * here's the WFI
+		 */
+		asm(".word	0xe320f003\n"
+		    :
+		    :
+		    : "memory", "cc");
+
+		if (pen_release == cpu_logical_map(cpu)) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
+
+		/*
+		 * Getting here, means that we have come out of WFI without
+		 * having been woken up - this shouldn't happen
+		 *
+		 * Just note it happening - when we're woken, we can report
+		 * its occurrence.
+		 */
+		(*spurious)++;
+	}
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void ox820_cpu_die(unsigned int cpu)
+{
+	int spurious = 0;
+
+	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	cpu_enter_lowpower();
+	platform_do_lowpower(cpu, &spurious);
+
+	/*
+	 * bring this CPU back into the world of cache
+	 * coherency, and then restore interrupts
+	 */
+	cpu_leave_lowpower();
+
+	if (spurious)
+		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
+}
diff --git a/arch/arm/mach-oxnas/platsmp.c b/arch/arm/mach-oxnas/platsmp.c
new file mode 100644
index 0000000..d2ff2c4
--- /dev/null
+++ b/arch/arm/mach-oxnas/platsmp.c
@@ -0,0 +1,161 @@
+/*
+ * arch/arm/mach-oxnas/platsmp.c
+ *
+ * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
+ * Copyright (C) 2002 ARM Ltd.
+ * All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cp15.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+
+extern void ox820_secondary_startup(void);
+extern void ox820_cpu_die(unsigned int cpu);
+
+static DEFINE_SPINLOCK(boot_lock);
+
+static void __iomem *cpu_ctrl;
+static void __iomem *gic_cpu_ctrl;
+
+#define HOLDINGPEN_CPU_OFFSET		0xc8
+#define HOLDINGPEN_LOCATION_OFFSET	0xc4
+
+#define GIC_NCPU_OFFSET(cpu)		(0x100 + (cpu)*0x100)
+#define GIC_CPU_CTRL			0x00
+#define GIC_CPU_CTRL_ENABLE		1
+
+static inline void write_pen_release(int val)
+{
+	writel(val, cpu_ctrl + HOLDINGPEN_CPU_OFFSET);
+}
+
+static inline int read_pen_release(void)
+{
+	return readl(cpu_ctrl + HOLDINGPEN_CPU_OFFSET);
+}
+
+void ox820_secondary_init(unsigned int cpu)
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
+int ox820_boot_secondary(unsigned int cpu, struct task_struct *idle)
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
+	 * Enable GIC cpu interface in CPU Interface Control Register
+	 */
+	writel(GIC_CPU_CTRL_ENABLE,
+		gic_cpu_ctrl + GIC_NCPU_OFFSET(cpu) + GIC_CPU_CTRL);
+
+	/*
+	 * Send the secondary CPU a soft interrupt, thereby causing
+	 * the boot monitor to read the system wide flags register,
+	 * and branch to the address found there.
+	 */
+
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (read_pen_release() == -1)
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
+	return read_pen_release() != -1 ? -ENOSYS : 0;
+}
+
+static void __init ox820_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *np;
+	void __iomem *scu_base;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,arm11mp-scu");
+	scu_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!scu_base)
+		return;
+
+	/* Remap CPU Interrupt Interface Registers */
+	np = of_find_compatible_node(NULL, NULL, "arm,arm11mp-gic");
+	gic_cpu_ctrl = of_iomap(np, 1);
+	of_node_put(np);
+	if (!gic_cpu_ctrl)
+		goto unmap_scu;
+
+	np = of_find_compatible_node(NULL, NULL, "oxsemi,ox820-sys-ctrl");
+	cpu_ctrl = of_iomap(np, 0);
+	of_node_put(np);
+	if (!cpu_ctrl)
+		goto unmap_scu;
+
+	scu_enable(scu_base);
+	flush_cache_all();
+
+	/*
+	 * Write the address of secondary startup into the
+	 * system-wide flags register. The BootMonitor waits
+	 * until it receives a soft interrupt, and then the
+	 * secondary CPU branches to this address.
+	 */
+	writel(virt_to_phys(ox820_secondary_startup),
+			cpu_ctrl + HOLDINGPEN_LOCATION_OFFSET);
+
+unmap_scu:
+	iounmap(scu_base);
+}
+
+static const struct smp_operations ox820_smp_ops __initconst = {
+	.smp_prepare_cpus	= ox820_smp_prepare_cpus,
+	.smp_secondary_init	= ox820_secondary_init,
+	.smp_boot_secondary	= ox820_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= ox820_cpu_die,
+#endif
+};
+
+CPU_METHOD_OF_DECLARE(ox820_smp, "oxsemi,ox820-smp", &ox820_smp_ops);
-- 
2.7.0
