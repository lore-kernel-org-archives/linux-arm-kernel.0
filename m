From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Apr 2014 14:53:46 +0800
Subject: [PATCH v4 08/14] ARM: hisi: add hip04 SoC support
In-Reply-To: <1398668032-8335-1-git-send-email-haojian.zhuang@linaro.org>
References: <1398668032-8335-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1398668032-8335-9-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hisilicon Hi3xxx is based on Cortex A9 Core. Now HiP04 SoC is based on
Cortex A15 Core. Since multiple clusters is used in HiP04 SoC, it could
be based on MCPM.

And HiP04 supports LPAE to support large memory.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig               |   2 +-
 arch/arm/mach-hisi/Kconfig     |  10 +-
 arch/arm/mach-hisi/Makefile    |   1 +
 arch/arm/mach-hisi/core.h      |   2 +
 arch/arm/mach-hisi/hisilicon.c |  12 ++
 arch/arm/mach-hisi/platmcpm.c  | 318 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 343 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-hisi/platmcpm.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 58e995d..d225585 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1114,7 +1114,7 @@ source arch/arm/mm/Kconfig
 
 config ARM_NR_BANKS
 	int
-	default 16 if ARCH_EP93XX
+	default 16 if ARCH_EP93XX || ARCH_HIP04
 	default 8
 
 config IWMMXT
diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index da16efd..17af1d2 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -17,7 +17,15 @@ config ARCH_HI3xxx
 	select PINCTRL
 	select PINCTRL_SINGLE
 	help
-	  Support for Hisilicon Hi36xx/Hi37xx processor family
+	  Support for Hisilicon Hi36xx/Hi37xx SoC family
+
+config ARCH_HIP04
+	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7_LPAE
+	select HAVE_ARM_ARCH_TIMER
+	select MCPM if SMP
+	select MCPM_QUAD_CLUSTER if SMP
+	help
+	  Support for Hisilicon HiP04 SoC family
 
 endmenu
 
diff --git a/arch/arm/mach-hisi/Makefile b/arch/arm/mach-hisi/Makefile
index 2ae1b59..e7a8640 100644
--- a/arch/arm/mach-hisi/Makefile
+++ b/arch/arm/mach-hisi/Makefile
@@ -3,4 +3,5 @@
 #
 
 obj-y	+= hisilicon.o
+obj-$(CONFIG_MCPM)		+= platmcpm.o
 obj-$(CONFIG_SMP)		+= platsmp.o hotplug.o
diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
index af23ec2..1e60795 100644
--- a/arch/arm/mach-hisi/core.h
+++ b/arch/arm/mach-hisi/core.h
@@ -12,4 +12,6 @@ extern void hi3xxx_cpu_die(unsigned int cpu);
 extern int hi3xxx_cpu_kill(unsigned int cpu);
 extern void hi3xxx_set_cpu(int cpu, bool enable);
 
+extern bool __init hip04_smp_init_ops(void);
+
 #endif
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 741faf3..6489e57 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -88,3 +88,15 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.smp		= smp_ops(hi3xxx_smp_ops),
 	.restart	= hi3xxx_restart,
 MACHINE_END
+
+#ifdef CONFIG_ARCH_HIP04
+static const char *hip04_compat[] __initconst = {
+	"hisilicon,hip04-d01",
+	NULL,
+};
+
+DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
+	.dt_compat	= hip04_compat,
+	.smp_init	= smp_init_ops(hip04_smp_init_ops),
+MACHINE_END
+#endif
diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
new file mode 100644
index 0000000..ac25d7b
--- /dev/null
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -0,0 +1,318 @@
+/*
+ * Copyright (c) 2013-2014 Linaro Ltd.
+ * Copyright (c) 2013-2014 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/memblock.h>
+#include <linux/of_address.h>
+
+#include <asm/cputype.h>
+#include <asm/cp15.h>
+#include <asm/mcpm.h>
+
+#include "core.h"
+
+/* bits definition in SC_CPU_RESET_REQ[x]/SC_CPU_RESET_DREQ[x]
+ * 1 -- unreset; 0 -- reset
+ */
+#define CORE_RESET_BIT(x)		(1 << x)
+#define NEON_RESET_BIT(x)		(1 << (x + 4))
+#define CORE_DEBUG_RESET_BIT(x)		(1 << (x + 9))
+#define CLUSTER_L2_RESET_BIT		(1 << 8)
+#define CLUSTER_DEBUG_RESET_BIT		(1 << 13)
+
+/*
+ * bits definition in SC_CPU_RESET_STATUS[x]
+ * 1 -- reset status; 0 -- unreset status
+ */
+#define CORE_RESET_STATUS(x)		(1 << x)
+#define NEON_RESET_STATUS(x)		(1 << (x + 4))
+#define CORE_DEBUG_RESET_STATUS(x)	(1 << (x + 9))
+#define CLUSTER_L2_RESET_STATUS		(1 << 8)
+#define CLUSTER_DEBUG_RESET_STATUS	(1 << 13)
+#define CORE_WFI_STATUS(x)		(1 << (x + 16))
+#define CORE_WFE_STATUS(x)		(1 << (x + 20))
+#define CORE_DEBUG_ACK(x)		(1 << (x + 24))
+
+#define SC_CPU_RESET_REQ(x)		(0x520 + (x << 3))	/* reset */
+#define SC_CPU_RESET_DREQ(x)		(0x524 + (x << 3))	/* unreset */
+#define SC_CPU_RESET_STATUS(x)		(0x1520 + (x << 3))
+
+#define FAB_SF_MODE			0x0c
+#define FAB_SF_INVLD			0x10
+
+/* bits definition in FB_SF_INVLD */
+#define FB_SF_INVLD_START		(1 << 8)
+
+#define HIP04_MAX_CLUSTERS		4
+#define HIP04_MAX_CPUS_PER_CLUSTER	4
+
+#define POLL_MSEC	10
+#define TIMEOUT_MSEC	1000
+
+struct hip04_secondary_cpu_data {
+	u32	bootwrapper_phys;
+	u32	bootwrapper_size;
+	u32	bootwrapper_magic;
+	u32	relocation_entry;
+	u32	relocation_size;
+};
+
+static void __iomem *relocation, *sysctrl, *fabric;
+static int hip04_cpu_table[HIP04_MAX_CLUSTERS][HIP04_MAX_CPUS_PER_CLUSTER];
+static DEFINE_SPINLOCK(boot_lock);
+static struct hip04_secondary_cpu_data hip04_boot;
+
+static bool hip04_cluster_down(unsigned int cluster)
+{
+	int i;
+
+	for (i = 0; i < HIP04_MAX_CPUS_PER_CLUSTER; i++)
+		if (hip04_cpu_table[cluster][i])
+			return false;
+	return true;
+}
+
+static void hip04_set_snoop_filter(unsigned int cluster, unsigned int on)
+{
+	unsigned long data;
+
+	if (!fabric)
+		return;
+	data = readl_relaxed(fabric + FAB_SF_MODE);
+	if (on)
+		data |= 1 << cluster;
+	else
+		data &= ~(1 << cluster);
+	writel_relaxed(data, fabric + FAB_SF_MODE);
+	while (1) {
+		if (data == readl_relaxed(fabric + FAB_SF_MODE))
+			break;
+	}
+}
+
+static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
+{
+	unsigned long data, mask;
+
+	if (!relocation || !sysctrl)
+		return -ENODEV;
+	if (cluster >= HIP04_MAX_CLUSTERS || cpu >= HIP04_MAX_CPUS_PER_CLUSTER)
+		return -EINVAL;
+
+	spin_lock_irq(&boot_lock);
+	writel_relaxed(hip04_boot.bootwrapper_phys, relocation);
+	writel_relaxed(hip04_boot.bootwrapper_magic, relocation + 4);
+	writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
+	writel_relaxed(0, relocation + 12);
+
+	if (hip04_cluster_down(cluster)) {
+		data = CLUSTER_L2_RESET_BIT | CLUSTER_DEBUG_RESET_BIT;
+		writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
+		do {
+			mask = CLUSTER_L2_RESET_STATUS | \
+			       CLUSTER_DEBUG_RESET_STATUS;
+			data = readl_relaxed(sysctrl + \
+					     SC_CPU_RESET_STATUS(cluster));
+		} while (data & mask);
+		hip04_set_snoop_filter(cluster, 1);
+	}
+
+	hip04_cpu_table[cluster][cpu]++;
+
+	data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
+	       CORE_DEBUG_RESET_BIT(cpu);
+	writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
+	spin_unlock_irq(&boot_lock);
+	msleep(POLL_MSEC);
+
+	return 0;
+}
+
+static void hip04_mcpm_power_down(void)
+{
+	unsigned int mpidr, cpu, cluster;
+	bool skip_wfi = false;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	__mcpm_cpu_going_down(cpu, cluster);
+
+	spin_lock(&boot_lock);
+	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
+	hip04_cpu_table[cluster][cpu]--;
+	if (hip04_cpu_table[cluster][cpu] == 1) {
+		/* A power_up request went ahead of us. */
+		skip_wfi = true;
+	} else if (hip04_cpu_table[cluster][cpu] > 1) {
+		pr_err("Cluster %d CPU%d is still running\n", cluster, cpu);
+		BUG();
+	}
+
+	spin_unlock(&boot_lock);
+
+	v7_exit_coherency_flush(louis);
+
+	__mcpm_cpu_down(cpu, cluster);
+
+	isb();
+	dsb();
+
+	if (!skip_wfi)
+		wfi();
+}
+
+static int hip04_mcpm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
+{
+	unsigned int data, tries;
+
+	BUG_ON(cluster >= HIP04_MAX_CLUSTERS ||
+	       cpu >= HIP04_MAX_CPUS_PER_CLUSTER);
+
+	for (tries = 0; tries < TIMEOUT_MSEC / POLL_MSEC; tries++) {
+		data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
+		if (!(data & CORE_WFI_STATUS(cpu))) {
+			msleep(POLL_MSEC);
+			continue;
+		}
+		data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
+		       CORE_DEBUG_RESET_BIT(cpu);
+		writel_relaxed(data, sysctrl + SC_CPU_RESET_REQ(cluster));
+		return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void hip04_mcpm_powered_up(void)
+{
+	if (!relocation)
+		return;
+	spin_lock(&boot_lock);
+	writel_relaxed(0, relocation);
+	writel_relaxed(0, relocation + 4);
+	writel_relaxed(0, relocation + 8);
+	writel_relaxed(0, relocation + 12);
+	spin_unlock(&boot_lock);
+}
+
+static const struct mcpm_platform_ops hip04_mcpm_ops = {
+	.power_up		= hip04_mcpm_power_up,
+	.power_down		= hip04_mcpm_power_down,
+	.wait_for_powerdown	= hip04_mcpm_wait_for_powerdown,
+	.powered_up		= hip04_mcpm_powered_up,
+};
+
+static bool __init hip04_cpu_table_init(void)
+{
+	unsigned int mpidr, cpu, cluster;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	if (cluster >= HIP04_MAX_CLUSTERS ||
+	    cpu >= HIP04_MAX_CPUS_PER_CLUSTER) {
+		pr_err("%s: boot CPU is out of bound!\n", __func__);
+		return false;
+	}
+	hip04_set_snoop_filter(cluster, 1);
+	hip04_cpu_table[cluster][cpu] = 1;
+	return true;
+}
+
+static int __init hip04_mcpm_init(void)
+{
+	struct device_node *np, *np_fab;
+	int ret = -ENODEV;
+
+	np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
+	if (!np)
+		goto err;
+	np_fab = of_find_compatible_node(NULL, NULL, "hisilicon,hip04-fabric");
+	if (!np_fab)
+		goto err;
+
+	if (of_property_read_u32(np, "bootwrapper-phys",
+				 &hip04_boot.bootwrapper_phys)) {
+		pr_err("failed to get bootwrapper-phys\n");
+		ret = -EINVAL;
+		goto err;
+	}
+	if (of_property_read_u32(np, "bootwrapper-size",
+				 &hip04_boot.bootwrapper_size)) {
+		pr_err("failed to get bootwrapper-size\n");
+		ret = -EINVAL;
+		goto err;
+	}
+	if (of_property_read_u32(np, "bootwrapper-magic",
+				 &hip04_boot.bootwrapper_magic)) {
+		pr_err("failed to get bootwrapper-magic\n");
+		ret = -EINVAL;
+		goto err;
+	}
+	if (of_property_read_u32(np, "relocation-entry",
+				 &hip04_boot.relocation_entry)) {
+		pr_err("failed to get relocation-entry\n");
+		ret = -EINVAL;
+		goto err;
+	}
+	if (of_property_read_u32(np, "relocation-size",
+				 &hip04_boot.relocation_size)) {
+		pr_err("failed to get relocation-size\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	relocation = ioremap(hip04_boot.relocation_entry,
+			     hip04_boot.relocation_size);
+	if (!relocation) {
+		pr_err("failed to map relocation space\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+	sysctrl = of_iomap(np, 0);
+	if (!sysctrl) {
+		pr_err("failed to get sysctrl base\n");
+		ret = -ENOMEM;
+		goto err_sysctrl;
+	}
+	fabric = of_iomap(np_fab, 0);
+	if (!fabric) {
+		pr_err("failed to get fabric base\n");
+		ret = -ENOMEM;
+		goto err_fabric;
+	}
+
+	memblock_reserve(hip04_boot.bootwrapper_phys,
+			 hip04_boot.bootwrapper_size);
+
+	if (!hip04_cpu_table_init())
+		return -EINVAL;
+	ret = mcpm_platform_register(&hip04_mcpm_ops);
+	if (!ret) {
+		mcpm_sync_init(NULL);
+		pr_info("HiP04 MCPM initialized\n");
+	}
+	return ret;
+err_fabric:
+	iounmap(sysctrl);
+err_sysctrl:
+	iounmap(relocation);
+err:
+	return ret;
+}
+early_initcall(hip04_mcpm_init);
+
+bool __init hip04_smp_init_ops(void)
+{
+	mcpm_smp_set_ops();
+	return true;
+}
-- 
1.9.1
