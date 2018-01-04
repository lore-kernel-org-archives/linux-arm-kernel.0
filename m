From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  4 Jan 2018 22:37:47 +0800
Subject: [PATCH v2 1/8] ARM: sun9i: Support SMP on A80 with Multi-Cluster
 Power Management (MCPM)
In-Reply-To: <20180104143754.2425-1-wens@csie.org>
References: <20180104143754.2425-1-wens@csie.org>
Message-ID: <20180104143754.2425-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 is a big.LITTLE SoC with 1 cluster of 4 Cortex-A7s and
1 cluster of 4 Cortex-A15s.

This patch adds support to bring up the second cluster and thus all
cores using the common MCPM code. Core/cluster power down has not
been implemented, thus CPU hotplugging and big.LITTLE switcher is
not supported.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/Kconfig  |   2 +
 arch/arm/mach-sunxi/Makefile |   1 +
 arch/arm/mach-sunxi/mcpm.c   | 425 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 428 insertions(+)
 create mode 100644 arch/arm/mach-sunxi/mcpm.c

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 58153cdf025b..53c4e7420cfb 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -47,5 +47,7 @@ config MACH_SUN9I
 	bool "Allwinner (sun9i) SoCs support"
 	default ARCH_SUNXI
 	select ARM_GIC
+	select MCPM if SMP
+	select ARM_CCI400_PORT_CTRL if SMP
 
 endif
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 27b168f121a1..cd25d9d81257 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
+obj-$(CONFIG_MCPM) += mcpm.o
 obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-sunxi/mcpm.c b/arch/arm/mach-sunxi/mcpm.c
new file mode 100644
index 000000000000..30719998f3f0
--- /dev/null
+++ b/arch/arm/mach-sunxi/mcpm.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2015 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * arch/arm/mach-sunxi/mcpm.c
+ *
+ * Based on arch/arm/mach-exynos/mcpm-exynos.c and Allwinner code
+ */
+
+#include <linux/arm-cci.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+
+#include <asm/cputype.h>
+#include <asm/cp15.h>
+#include <asm/mcpm.h>
+
+#define SUNXI_CPUS_PER_CLUSTER		4
+#define SUNXI_NR_CLUSTERS		2
+
+#define CPUCFG_CX_CTRL_REG0(c)		(0x10 * (c))
+#define CPUCFG_CX_CTRL_REG0_L1_RST_DISABLE(n)	BIT(n)
+#define CPUCFG_CX_CTRL_REG0_L1_RST_DISABLE_ALL	0xf
+#define CPUCFG_CX_CTRL_REG0_L2_RST_DISABLE_A7	BIT(4)
+#define CPUCFG_CX_CTRL_REG0_L2_RST_DISABLE_A15	BIT(0)
+#define CPUCFG_CX_CTRL_REG1(c)		(0x10 * (c) + 0x4)
+#define CPUCFG_CX_CTRL_REG1_ACINACTM	BIT(0)
+#define CPUCFG_CX_RST_CTRL(c)		(0x80 + 0x4 * (c))
+#define CPUCFG_CX_RST_CTRL_DBG_SOC_RST	BIT(24)
+#define CPUCFG_CX_RST_CTRL_ETM_RST(n)	BIT(20 + (n))
+#define CPUCFG_CX_RST_CTRL_ETM_RST_ALL	(0xf << 20)
+#define CPUCFG_CX_RST_CTRL_DBG_RST(n)	BIT(16 + (n))
+#define CPUCFG_CX_RST_CTRL_DBG_RST_ALL	(0xf << 16)
+#define CPUCFG_CX_RST_CTRL_H_RST	BIT(12)
+#define CPUCFG_CX_RST_CTRL_L2_RST	BIT(8)
+#define CPUCFG_CX_RST_CTRL_CX_RST(n)	BIT(4 + (n))
+#define CPUCFG_CX_RST_CTRL_CORE_RST(n)	BIT(n)
+
+#define PRCM_CPU_PO_RST_CTRL(c)		(0x4 + 0x4 * (c))
+#define PRCM_CPU_PO_RST_CTRL_CORE(n)	BIT(n)
+#define PRCM_CPU_PO_RST_CTRL_CORE_ALL	0xf
+#define PRCM_PWROFF_GATING_REG(c)	(0x100 + 0x4 * (c))
+#define PRCM_PWROFF_GATING_REG_CLUSTER	BIT(4)
+#define PRCM_PWROFF_GATING_REG_CORE(n)	BIT(n)
+#define PRCM_PWR_SWITCH_REG(c, cpu)	(0x140 + 0x10 * (c) + 0x4 * (cpu))
+#define PRCM_CPU_SOFT_ENTRY_REG		0x164
+
+static void __iomem *cpucfg_base;
+static void __iomem *prcm_base;
+
+static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
+{
+	struct device_node *node;
+	int cpu = cluster * SUNXI_CPUS_PER_CLUSTER + core;
+
+	node = of_cpu_device_node_get(cpu);
+
+	/* In case of_cpu_device_node_get fails */
+	if (!node)
+		node = of_get_cpu_node(cpu, NULL);
+
+	if (!node) {
+		/*
+		 * There's no point in returning an error, since we
+		 * would be mid way in a core or cluster power sequence.
+		 */
+		pr_err("%s: Couldn't get CPU cluster %u core %u device node\n",
+		       __func__, cluster, core);
+
+		return false;
+	}
+
+	return of_device_is_compatible(node, "arm,cortex-a15");
+}
+
+static int sunxi_cpu_power_switch_set(unsigned int cpu, unsigned int cluster,
+				      bool enable)
+{
+	u32 reg;
+
+	/* control sequence from Allwinner A80 user manual v1.2 PRCM section */
+	reg = readl(prcm_base + PRCM_PWR_SWITCH_REG(cluster, cpu));
+	if (enable) {
+		if (reg == 0x00) {
+			pr_debug("power clamp for cluster %u cpu %u already open\n",
+				 cluster, cpu);
+			return 0;
+		}
+
+		writel(0xff, prcm_base + PRCM_PWR_SWITCH_REG(cluster, cpu));
+		udelay(10);
+		writel(0xfe, prcm_base + PRCM_PWR_SWITCH_REG(cluster, cpu));
+		udelay(10);
+		writel(0xf8, prcm_base + PRCM_PWR_SWITCH_REG(cluster, cpu));
+		udelay(10);
+		writel(0xf0, prcm_base + PRCM_PWR_SWITCH_REG(cluster, cpu));
+		udelay(10);
+		writel(0x00, prcm_base + PRCM_PWR_SWITCH_REG(cluster, cpu));
+		udelay(10);
+	} else {
+		writel(0xff, prcm_base + PRCM_PWR_SWITCH_REG(cluster, cpu));
+		udelay(10);
+	}
+
+	return 0;
+}
+
+static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
+{
+	u32 reg;
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	if (cpu >= SUNXI_CPUS_PER_CLUSTER || cluster >= SUNXI_NR_CLUSTERS)
+		return -EINVAL;
+
+	/* assert processor power-on reset */
+	reg = readl(prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
+	reg &= ~PRCM_CPU_PO_RST_CTRL_CORE(cpu);
+	writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
+
+	/* Cortex-A7: hold L1 reset disable signal low */
+	if (!sunxi_core_is_cortex_a15(cpu, cluster)) {
+		reg = readl(cpucfg_base + CPUCFG_CX_CTRL_REG0(cluster));
+		reg &= ~CPUCFG_CX_CTRL_REG0_L1_RST_DISABLE(cpu);
+		writel(reg, cpucfg_base + CPUCFG_CX_CTRL_REG0(cluster));
+	}
+
+	/* assert processor related resets */
+	reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+	reg &= ~CPUCFG_CX_RST_CTRL_DBG_RST(cpu);
+
+	/*
+	 * Allwinner code also asserts resets for NEON on A15. According
+	 * to ARM manuals, asserting power-on reset is sufficient.
+	 */
+	if (!sunxi_core_is_cortex_a15(cpu, cluster))
+		reg &= ~CPUCFG_CX_RST_CTRL_ETM_RST(cpu);
+
+	writel(reg, cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+
+	/* open power switch */
+	sunxi_cpu_power_switch_set(cpu, cluster, true);
+
+	/* clear processor power gate */
+	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
+	reg &= ~PRCM_PWROFF_GATING_REG_CORE(cpu);
+	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
+	udelay(20);
+
+	/* de-assert processor power-on reset */
+	reg = readl(prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
+	reg |= PRCM_CPU_PO_RST_CTRL_CORE(cpu);
+	writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
+
+	/* de-assert all processor resets */
+	reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+	reg |= CPUCFG_CX_RST_CTRL_DBG_RST(cpu);
+	reg |= CPUCFG_CX_RST_CTRL_CORE_RST(cpu);
+	if (!sunxi_core_is_cortex_a15(cpu, cluster))
+		reg |= CPUCFG_CX_RST_CTRL_ETM_RST(cpu);
+	else
+		reg |= CPUCFG_CX_RST_CTRL_CX_RST(cpu); /* NEON */
+	writel(reg, cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+
+	return 0;
+}
+
+static int sunxi_cluster_powerup(unsigned int cluster)
+{
+	u32 reg;
+
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+	if (cluster >= SUNXI_NR_CLUSTERS)
+		return -EINVAL;
+
+	/* assert ACINACTM */
+	reg = readl(cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
+	reg |= CPUCFG_CX_CTRL_REG1_ACINACTM;
+	writel(reg, cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
+
+	/* assert cluster processor power-on resets */
+	reg = readl(prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
+	reg &= ~PRCM_CPU_PO_RST_CTRL_CORE_ALL;
+	writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
+
+	/* assert cluster resets */
+	reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+	reg &= ~CPUCFG_CX_RST_CTRL_DBG_SOC_RST;
+	reg &= ~CPUCFG_CX_RST_CTRL_DBG_RST_ALL;
+	reg &= ~CPUCFG_CX_RST_CTRL_H_RST;
+	reg &= ~CPUCFG_CX_RST_CTRL_L2_RST;
+
+	/*
+	 * Allwinner code also asserts resets for NEON on A15. According
+	 * to ARM manuals, asserting power-on reset is sufficient.
+	 */
+	if (!sunxi_core_is_cortex_a15(0, cluster))
+		reg &= ~CPUCFG_CX_RST_CTRL_ETM_RST_ALL;
+
+	writel(reg, cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+
+	/* hold L1/L2 reset disable signals low */
+	reg = readl(cpucfg_base + CPUCFG_CX_CTRL_REG0(cluster));
+	if (sunxi_core_is_cortex_a15(0, cluster)) {
+		/* Cortex-A15: hold L2RSTDISABLE low */
+		reg &= ~CPUCFG_CX_CTRL_REG0_L2_RST_DISABLE_A15;
+	} else {
+		/* Cortex-A7: hold L1RSTDISABLE and L2RSTDISABLE low */
+		reg &= ~CPUCFG_CX_CTRL_REG0_L1_RST_DISABLE_ALL;
+		reg &= ~CPUCFG_CX_CTRL_REG0_L2_RST_DISABLE_A7;
+	}
+	writel(reg, cpucfg_base + CPUCFG_CX_CTRL_REG0(cluster));
+
+	/* clear cluster power gate */
+	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
+	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER;
+	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
+	udelay(20);
+
+	/* de-assert cluster resets */
+	reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+	reg |= CPUCFG_CX_RST_CTRL_DBG_SOC_RST;
+	reg |= CPUCFG_CX_RST_CTRL_H_RST;
+	reg |= CPUCFG_CX_RST_CTRL_L2_RST;
+	writel(reg, cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+
+	/* de-assert ACINACTM */
+	reg = readl(cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
+	reg &= ~CPUCFG_CX_CTRL_REG1_ACINACTM;
+	writel(reg, cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
+
+	return 0;
+}
+
+static void sunxi_cpu_cache_disable(void)
+{
+	/* Disable and flush the local CPU cache. */
+	v7_exit_coherency_flush(louis);
+}
+
+/*
+ * This bit is shared between the initial mcpm_sync_init call to enable
+ * CCI-400 and proper cluster cache disable before power down.
+ */
+static void sunxi_cluster_cache_disable_without_axi(void)
+{
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A15) {
+		/*
+		 * On the Cortex-A15 we need to disable
+		 * L2 prefetching before flushing the cache.
+		 */
+		asm volatile(
+		"mcr	p15, 1, %0, c15, c0, 3\n"
+		"isb\n"
+		"dsb"
+		: : "r" (0x400));
+	}
+
+	/* Flush all cache levels for this cluster. */
+	v7_exit_coherency_flush(all);
+
+	/*
+	 * Disable cluster-level coherency by masking
+	 * incoming snoops and DVM messages:
+	 */
+	cci_disable_port_by_cpu(read_cpuid_mpidr());
+}
+
+static void sunxi_cluster_cache_disable(void)
+{
+	unsigned int cluster = MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 1);
+	u32 reg;
+
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+
+	sunxi_cluster_cache_disable_without_axi();
+
+	/* last man standing, assert ACINACTM */
+	reg = readl(cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
+	reg |= CPUCFG_CX_CTRL_REG1_ACINACTM;
+	writel(reg, cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
+}
+
+static const struct mcpm_platform_ops sunxi_power_ops = {
+	.cpu_powerup		= sunxi_cpu_powerup,
+	.cluster_powerup	= sunxi_cluster_powerup,
+	.cpu_cache_disable	= sunxi_cpu_cache_disable,
+	.cluster_cache_disable	= sunxi_cluster_cache_disable,
+};
+
+/*
+ * Enable cluster-level coherency, in preparation for turning on the MMU.
+ *
+ * Also enable regional clock gating and L2 data latency settings for
+ * Cortex-A15. These settings are from the vendor kernel.
+ */
+static void __naked sunxi_power_up_setup(unsigned int affinity_level)
+{
+	asm volatile (
+		"mrc	p15, 0, r1, c0, c0, 0\n"
+		"movw	r2, #" __stringify(ARM_CPU_PART_MASK & 0xffff) "\n"
+		"movt	r2, #" __stringify(ARM_CPU_PART_MASK >> 16) "\n"
+		"and	r1, r1, r2\n"
+		"movw	r2, #" __stringify(ARM_CPU_PART_CORTEX_A15 & 0xffff) "\n"
+		"movt	r2, #" __stringify(ARM_CPU_PART_CORTEX_A15 >> 16) "\n"
+		"cmp	r1, r2\n"
+		"bne	not_a15\n"
+
+		/* The following is Cortex-A15 specific */
+
+		/* ACTLR2: Enable CPU regional clock gates */
+		"mrc p15, 1, r1, c15, c0, 4\n"
+		"orr r1, r1, #(0x1<<31)\n"
+		"mcr p15, 1, r1, c15, c0, 4\n"
+
+		/* L2ACTLR */
+		"mrc p15, 1, r1, c15, c0, 0\n"
+		/* Enable L2, GIC, and Timer regional clock gates */
+		"orr r1, r1, #(0x1<<26)\n"
+		/* Disable clean/evict from being pushed to external */
+		"orr r1, r1, #(0x1<<3)\n"
+		"mcr p15, 1, r1, c15, c0, 0\n"
+
+		/* L2CTRL: L2 data RAM latency */
+		"mrc p15, 1, r1, c9, c0, 2\n"
+		"bic r1, r1, #(0x7<<0)\n"
+		"orr r1, r1, #(0x3<<0)\n"
+		"mcr p15, 1, r1, c9, c0, 2\n"
+
+		/* End of Cortex-A15 specific setup */
+		"not_a15:\n"
+
+		"cmp	r0, #1\n"
+		"bxne	lr\n"
+		"b	cci_enable_port_for_self"
+	);
+}
+
+static void sunxi_mcpm_setup_entry_point(void)
+{
+	__raw_writel(virt_to_phys(mcpm_entry_point),
+		     prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
+}
+
+static int __init sunxi_mcpm_init(void)
+{
+	struct device_node *cpucfg_node, *node;
+	struct resource res;
+	int ret;
+
+	if (!of_machine_is_compatible("allwinner,sun9i-a80"))
+		return -ENODEV;
+
+	if (!cci_probed())
+		return -ENODEV;
+
+	node = of_find_compatible_node(NULL, NULL, "allwinner,sun9i-a80-prcm");
+	if (!node)
+		return -ENODEV;
+
+	/*
+	 * Unfortunately we can not request the I/O region for the PRCM.
+	 * It is shared with the PRCM clock.
+	 */
+	prcm_base = of_iomap(node, 0);
+	of_node_put(node);
+	if (!prcm_base) {
+		pr_err("%s: failed to map PRCM registers\n", __func__);
+		return -ENOMEM;
+	}
+
+	cpucfg_node = of_find_compatible_node(NULL, NULL,
+					      "allwinner,sun9i-a80-cpucfg");
+	if (!cpucfg_node) {
+		ret = -ENODEV;
+		goto err_unmap_prcm;
+	}
+
+	cpucfg_base = of_io_request_and_map(cpucfg_node, 0, "sunxi-mcpm");
+	if (IS_ERR(cpucfg_base)) {
+		ret = PTR_ERR(cpucfg_base);
+		pr_err("%s: failed to map CPUCFG registers: %d\n",
+		       __func__, ret);
+		goto err_put_cpucfg_node;
+	}
+
+	ret = mcpm_platform_register(&sunxi_power_ops);
+	if (!ret)
+		ret = mcpm_sync_init(sunxi_power_up_setup);
+	if (!ret)
+		/* do not disable AXI master as no one will re-enable it */
+		ret = mcpm_loopback(sunxi_cluster_cache_disable_without_axi);
+	if (ret)
+		goto err_unmap_release_cpucfg;
+
+	/* We don't need the CPUCFG device node anymore */
+	of_node_put(cpucfg_node);
+
+	/* Set the hardware entry point address */
+	sunxi_mcpm_setup_entry_point();
+
+	/* Actually enable MCPM */
+	mcpm_smp_set_ops();
+
+	pr_info("sunxi MCPM support installed\n");
+
+	return ret;
+
+err_unmap_release_cpucfg:
+	iounmap(cpucfg_base);
+	of_address_to_resource(cpucfg_node, 0, &res);
+	release_mem_region(res.start, resource_size(&res));
+err_put_cpucfg_node:
+	of_node_put(cpucfg_node);
+err_unmap_prcm:
+	iounmap(prcm_base);
+	return ret;
+}
+
+early_initcall(sunxi_mcpm_init);
-- 
2.15.1
