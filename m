From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Jan 2013 02:51:04 -0500
Subject: [PATCH v3 09/15] ARM: vexpress: introduce DCSCB support
In-Reply-To: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1359445870-18925-10-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds basic CPU and cluster reset controls on RTSM for the
A15x4-A7x4 model configuration using the Dual Cluster System
Configuration Block (DCSCB).

The cache coherency interconnect (CCI) is not handled yet.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-vexpress/Kconfig  |   8 ++
 arch/arm/mach-vexpress/Makefile |   1 +
 arch/arm/mach-vexpress/dcscb.c  | 159 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 arch/arm/mach-vexpress/dcscb.c

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 52d315b792..f3f92b120a 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -52,4 +52,12 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
 config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
 
+config ARCH_VEXPRESS_DCSCB
+	bool "Dual Cluster System Control Block (DCSCB) support"
+	depends on CLUSTER_PM
+	help
+	  Support for the Dual Cluster System Configuration Block (DCSCB).
+	  This is needed to provide CPU and cluster power management
+	  on RTSM.
+
 endmenu
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 80b64971fb..2253644054 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -6,5 +6,6 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 
 obj-y					:= v2m.o reset.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
+obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
new file mode 100644
index 0000000000..677ced9efc
--- /dev/null
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -0,0 +1,159 @@
+/*
+ * arch/arm/mach-vexpress/dcscb.c - Dual Cluster System Control Block
+ *
+ * Created by:	Nicolas Pitre, May 2012
+ * Copyright:	(C) 2012-2013  Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/vexpress.h>
+
+#include <asm/mcpm_entry.h>
+#include <asm/proc-fns.h>
+#include <asm/cacheflush.h>
+#include <asm/cputype.h>
+#include <asm/cp15.h>
+
+
+#define DCSCB_PHYS_BASE	0x60000000
+
+#define RST_HOLD0	0x0
+#define RST_HOLD1	0x4
+#define SYS_SWRESET	0x8
+#define RST_STAT0	0xc
+#define RST_STAT1	0x10
+#define EAG_CFG_R	0x20
+#define EAG_CFG_W	0x24
+#define KFC_CFG_R	0x28
+#define KFC_CFG_W	0x2c
+#define DCS_CFG_R	0x30
+
+/*
+ * We can't use regular spinlocks. In the switcher case, it is possible
+ * for an outbound CPU to call power_down() after its inbound counterpart
+ * is already live using the same logical CPU number which trips lockdep
+ * debugging.
+ */
+static arch_spinlock_t dcscb_lock = __ARCH_SPIN_LOCK_UNLOCKED;
+
+static void __iomem *dcscb_base;
+
+static int dcscb_power_up(unsigned int cpu, unsigned int cluster)
+{
+	unsigned int rst_hold, cpumask = (1 << cpu);
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	if (cpu >= 4 || cluster >= 2)
+		return -EINVAL;
+
+	/*
+	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
+	 * variant exists, we need to disable IRQs manually here.
+	 */
+	local_irq_disable();
+	arch_spin_lock(&dcscb_lock);
+
+	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
+	if (rst_hold & (1 << 8)) {
+		/* remove cluster reset and add individual CPU's reset */
+		rst_hold &= ~(1 << 8);
+		rst_hold |= 0xf;
+	}
+	rst_hold &= ~(cpumask | (cpumask << 4));
+	writel(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
+
+	arch_spin_unlock(&dcscb_lock);
+	local_irq_enable();
+
+	return 0;
+}
+
+static void dcscb_power_down(void)
+{
+	unsigned int mpidr, cpu, cluster, rst_hold, cpumask, last_man;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	cpumask = (1 << cpu);
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	BUG_ON(cpu >= 4 || cluster >= 2);
+
+	arch_spin_lock(&dcscb_lock);
+	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
+	rst_hold |= cpumask;
+	if (((rst_hold | (rst_hold >> 4)) & 0xf) == 0xf)
+		rst_hold |= (1 << 8);
+	writel(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
+	arch_spin_unlock(&dcscb_lock);
+	last_man = (rst_hold & (1 << 8));
+
+	/*
+	 * Now let's clean our L1 cache and shut ourself down.
+	 * If we're the last CPU in this cluster then clean L2 too.
+	 */
+
+	/*
+	 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
+	 * a preliminary flush here for those CPUs.  At least, that's
+	 * the theory -- without the extra flush, Linux explodes on
+	 * RTSM (maybe not needed anymore, to be investigated)..
+	 */
+	flush_cache_louis();
+	cpu_proc_fin();
+
+	if (!last_man) {
+		flush_cache_louis();
+	} else {
+		flush_cache_all();
+		outer_flush_all();
+	}
+
+	/* Disable local coherency by clearing the ACTLR "SMP" bit: */
+	set_auxcr(get_auxcr() & ~(1 << 6));
+
+	/* Now we are prepared for power-down, do it: */
+	dsb();
+	wfi();
+
+	/* Not dead@this point?  Let our caller cope. */
+}
+
+static const struct mcpm_platform_ops dcscb_power_ops = {
+	.power_up	= dcscb_power_up,
+	.power_down	= dcscb_power_down,
+};
+
+static int __init dcscb_init(void)
+{
+	int ret;
+
+	dcscb_base = ioremap(DCSCB_PHYS_BASE, 0x1000);
+	if (!dcscb_base)
+		return -EADDRNOTAVAIL;
+
+	ret = mcpm_platform_register(&dcscb_power_ops);
+	if (ret) {
+		iounmap(dcscb_base);
+		return ret;
+	}
+
+	/*
+	 * Future entries into the kernel can now go
+	 * through the cluster entry vectors.
+	 */
+	vexpress_flags_set(virt_to_phys(mcpm_entry_point));
+
+	return 0;
+}
+
+early_initcall(dcscb_init);
-- 
1.8.1.2
