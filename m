From: jun.nie@linaro.org (Jun Nie)
Date: Sat, 14 Mar 2015 19:49:40 +0800
Subject: [PATCH 05/10] ARM: zx: bring up the secondary core
In-Reply-To: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1426333785-3952-6-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use release_pen mechanism to bring up the secondary core.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 arch/arm/mach-zx/Makefile   |   1 +
 arch/arm/mach-zx/core.h     |  17 +++++
 arch/arm/mach-zx/headsmp.S  |  38 ++++++++++++
 arch/arm/mach-zx/platsmp.c  | 147 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-zx/zx296702.c |   1 +
 5 files changed, 204 insertions(+)
 create mode 100644 arch/arm/mach-zx/core.h
 create mode 100644 arch/arm/mach-zx/headsmp.S
 create mode 100644 arch/arm/mach-zx/platsmp.c

diff --git a/arch/arm/mach-zx/Makefile b/arch/arm/mach-zx/Makefile
index 7a541c7..7c2edf6 100644
--- a/arch/arm/mach-zx/Makefile
+++ b/arch/arm/mach-zx/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_SOC_ZX296702) += zx296702.o
+obj-$(CONFIG_SMP) += headsmp.o platsmp.o
diff --git a/arch/arm/mach-zx/core.h b/arch/arm/mach-zx/core.h
new file mode 100644
index 0000000..400c7b4
--- /dev/null
+++ b/arch/arm/mach-zx/core.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright 2014 Linaro Ltd.
+ * Copyright (C) 2014 ZTE Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MACH_ZX_CORE_H
+#define __MACH_ZX_CORE_H
+
+extern struct smp_operations zx_smp_ops;
+
+void zx_secondary_startup(void);
+
+#endif /* __MACH_ZX_CORE_H */
diff --git a/arch/arm/mach-zx/headsmp.S b/arch/arm/mach-zx/headsmp.S
new file mode 100644
index 0000000..8f70ff7
--- /dev/null
+++ b/arch/arm/mach-zx/headsmp.S
@@ -0,0 +1,38 @@
+/*
+ * Copyright 2014 Linaro Ltd.
+ * Copyright (C) 2014 ZTE Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+/*
+ * zx2967 specific entry point for secondary CPUs.  This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(zx_secondary_startup)
+	bl	v7_invalidate_l1
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
+ENDPROC(zx_secondary_startup)
+
+	.align	2
+1:	.long	.
+	.long	pen_release
diff --git a/arch/arm/mach-zx/platsmp.c b/arch/arm/mach-zx/platsmp.c
new file mode 100644
index 0000000..e508a9c
--- /dev/null
+++ b/arch/arm/mach-zx/platsmp.c
@@ -0,0 +1,147 @@
+/*
+ * Copyright 2014 Linaro Ltd.
+ * Copyright (C) 2014 ZTE Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/smp.h>
+
+#include <asm/cacheflush.h>
+#include <asm/smp_scu.h>
+
+#include "core.h"
+
+#define AON_SYS_CTRL_RESERVED1		0xa8
+
+static DEFINE_SPINLOCK(boot_lock);
+
+void __init zx_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *np;
+	unsigned long base = 0;
+	void __iomem *scu_base;
+	void __iomem *aonsysctrl_base;
+
+	base = scu_a9_get_base();
+	scu_base = ioremap(base, SZ_256);
+	if (!scu_base) {
+		pr_err("%s: failed to map scu\n", __func__);
+		return;
+	}
+
+	scu_enable(scu_base);
+	iounmap(scu_base);
+
+	np = of_find_compatible_node(NULL, NULL, "zte,aon-sysctrl");
+	if (!np) {
+		pr_err("%s: failed to find sysctrl node\n", __func__);
+		return;
+	}
+
+	aonsysctrl_base = of_iomap(np, 0);
+	if (!aonsysctrl_base) {
+		pr_err("%s: failed to map aonsysctrl\n", __func__);
+		of_node_put(np);
+		return;
+	}
+
+	/*
+	 * Write the address of secondary startup into the
+	 * system-wide flags register. The BootMonitor waits
+	 * until it receives a soft interrupt, and then the
+	 * secondary CPU branches to this address.
+	 */
+	__raw_writel(virt_to_phys(zx_secondary_startup),
+		     aonsysctrl_base + AON_SYS_CTRL_RESERVED1);
+
+	iounmap(aonsysctrl_base);
+	of_node_put(np);
+}
+
+/*
+ * Write pen_release in a way that is guaranteed to be visible to all
+ * observers, irrespective of whether they're taking part in coherency
+ * or not.  This is necessary for the hotplug code to work reliably.
+ */
+static void write_pen_release(int val)
+{
+	pen_release = val;
+	/* make sure pen_release is visible */
+	smp_wmb();
+	sync_cache_w(&pen_release);
+}
+
+static void zx_secondary_init(unsigned int cpu)
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
+static int zx_boot_secondary(unsigned int cpu, struct task_struct *idle)
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
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		/* sync pen_release value */
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
+struct smp_operations zx_smp_ops __initdata = {
+	.smp_prepare_cpus	= zx_smp_prepare_cpus,
+	.smp_secondary_init	= zx_secondary_init,
+	.smp_boot_secondary	= zx_boot_secondary,
+};
diff --git a/arch/arm/mach-zx/zx296702.c b/arch/arm/mach-zx/zx296702.c
index 9c055ea..d5d8be6 100644
--- a/arch/arm/mach-zx/zx296702.c
+++ b/arch/arm/mach-zx/zx296702.c
@@ -59,6 +59,7 @@ static const char *zx296702_dt_compat[] __initconst = {
 };
 
 DT_MACHINE_START(ZX, "ZTE ZX296702 (Device Tree)")
+	.smp		= smp_ops(zx_smp_ops),
 	.dt_compat	= zx296702_dt_compat,
 	.init_machine	= zx296702_init_machine,
 MACHINE_END
-- 
1.9.1
