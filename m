From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 24 May 2013 01:45:07 -0400
Subject: [PATCH 4/8] ARM: vexpress: introduce DCSCB support
In-Reply-To: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
References: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1369374311-21260-5-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds basic CPU and cluster reset controls on RTSM for the
A15x4-A7x4 model configuration using the Dual Cluster System
Configuration Block (DCSCB).

The cache coherency interconnect (CCI) is not handled yet.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Pawel Moll <pawel.moll@arm.com>
---
 .../devicetree/bindings/arm/rtsm-dcscb.txt         |  19 +++
 arch/arm/mach-vexpress/Kconfig                     |   8 +
 arch/arm/mach-vexpress/Makefile                    |   1 +
 arch/arm/mach-vexpress/dcscb.c                     | 162 +++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rtsm-dcscb.txt
 create mode 100644 arch/arm/mach-vexpress/dcscb.c

diff --git a/Documentation/devicetree/bindings/arm/rtsm-dcscb.txt b/Documentation/devicetree/bindings/arm/rtsm-dcscb.txt
new file mode 100644
index 0000000000..3b8fbf3c00
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rtsm-dcscb.txt
@@ -0,0 +1,19 @@
+ARM Dual Cluster System Configuration Block
+-------------------------------------------
+
+The Dual Cluster System Configuration Block (DCSCB) provides basic
+functionality for controlling clocks, resets and configuration pins in
+the Dual Cluster System implemented by the Real-Time System Model (RTSM).
+
+Required properties:
+
+- compatible : should be "arm,rtsm,dcscb"
+
+- reg : physical base address and the size of the registers window
+
+Example:
+
+	dcscb at 60000000 {
+		compatible = "arm,rtsm,dcscb";
+		reg = <0x60000000 0x1000>;
+	};
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 5907e10c37..2f46385c28 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -57,4 +57,12 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
 config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
 
+config ARCH_VEXPRESS_DCSCB
+	bool "Dual Cluster System Control Block (DCSCB) support"
+	depends on MCPM
+	help
+	  Support for the Dual Cluster System Configuration Block (DCSCB).
+	  This is needed to provide CPU and cluster power management
+	  on RTSM implementing big.LITTLE.
+
 endmenu
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 42703e8b4d..518519f57a 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -6,5 +6,6 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 
 obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
+obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
new file mode 100644
index 0000000000..38f042a6b2
--- /dev/null
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -0,0 +1,162 @@
+/*
+ * arch/arm/mach-vexpress/dcscb.c - Dual Cluster System Configuration Block
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
+#include <linux/of_address.h>
+#include <linux/vexpress.h>
+
+#include <asm/mcpm.h>
+#include <asm/proc-fns.h>
+#include <asm/cacheflush.h>
+#include <asm/cputype.h>
+#include <asm/cp15.h>
+
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
+ * for an outbound CPU to call power_down() while its inbound counterpart
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
+	writel_relaxed(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
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
+	writel_relaxed(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
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
+	 * RTSM (to be investigated)..
+	 */
+	flush_cache_louis();
+	set_cr(get_cr() & ~CR_C);
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
+	struct device_node *node;
+	int ret;
+
+	node = of_find_compatible_node(NULL, NULL, "arm,rtsm,dcscb");
+	if (!node)
+		return -ENODEV;
+	dcscb_base = of_iomap(node, 0);
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
