From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 22 Apr 2014 11:47:15 +0530
Subject: [PATCH v2 2/3] arm: exynos: Add MCPM call-back functions
In-Reply-To: <1397239311-27717-6-git-send-email-a.kesavan@samsung.com>
References: <1397239311-27717-6-git-send-email-a.kesavan@samsung.com>
Message-ID: <1398147435-3122-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add machine-dependent MCPM call-backs for Exynos5420. These are used
to power up/down the secondary CPUs during boot, shutdown, s2r and
switching.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/Kconfig       |    8 +
 arch/arm/mach-exynos/Makefile      |    2 +
 arch/arm/mach-exynos/mcpm-exynos.c |  345 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/regs-pmu.h    |    2 +
 4 files changed, 357 insertions(+)
 create mode 100644 arch/arm/mach-exynos/mcpm-exynos.c

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index fc8bf18..1602abc 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -110,4 +110,12 @@ config SOC_EXYNOS5440
 
 endmenu
 
+config EXYNOS5420_MCPM
+	bool "Exynos5420 Multi-Cluster PM support"
+	depends on MCPM && SOC_EXYNOS5420
+	select ARM_CCI
+	help
+	  This is needed to provide CPU and cluster power management
+	  on Exynos5420 implementing big.LITTLE.
+
 endif
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index a656dbe..01bc9b9 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -29,3 +29,5 @@ obj-$(CONFIG_ARCH_EXYNOS)	+= firmware.o
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
+
+obj-$(CONFIG_EXYNOS5420_MCPM)	+= mcpm-exynos.o
diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
new file mode 100644
index 0000000..49b9031
--- /dev/null
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -0,0 +1,345 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * arch/arm/mach-exynos/mcpm-exynos.c
+ *
+ * Based on arch/arm/mach-vexpress/dcscb.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/delay.h>
+#include <linux/arm-cci.h>
+
+#include <asm/mcpm.h>
+#include <asm/cputype.h>
+#include <asm/cp15.h>
+
+#include <plat/cpu.h>
+#include "regs-pmu.h"
+
+#define EXYNOS5420_CPUS_PER_CLUSTER	4
+#define EXYNOS5420_NR_CLUSTERS		2
+
+/* Secondary CPU entry point */
+#define REG_ENTRY_ADDR		(S5P_VA_SYSRAM_NS + 0x1C)
+
+#define EXYNOS_CORE_LOCAL_PWR_EN		0x3
+#define EXYNOS_CORE_LOCAL_PWR_DIS		0x0
+
+#define EXYNOS_ARM_COMMON_CONFIGURATION		S5P_PMUREG(0x2500)
+#define EXYNOS_ARM_L2_CONFIGURATION		S5P_PMUREG(0x2600)
+
+#define EXYNOS_ARM_CORE_CONFIGURATION(_nr)	\
+			(S5P_ARM_CORE0_CONFIGURATION + ((_nr) * 0x80))
+#define EXYNOS_ARM_CORE_STATUS(_nr)		\
+			(S5P_ARM_CORE0_STATUS + ((_nr) * 0x80))
+
+#define EXYNOS_COMMON_CONFIGURATION(_nr)	\
+			(EXYNOS_ARM_COMMON_CONFIGURATION + ((_nr) * 0x80))
+#define EXYNOS_COMMON_STATUS(_nr)		\
+			(EXYNOS_COMMON_CONFIGURATION(_nr) + 0x4)
+
+#define EXYNOS_L2_CONFIGURATION(_nr)		\
+			(EXYNOS_ARM_L2_CONFIGURATION + ((_nr) * 0x80))
+#define EXYNOS_L2_STATUS(_nr)			\
+			(EXYNOS_L2_CONFIGURATION(_nr) + 0x4)
+
+/*
+ * The common v7_exit_coherency_flush API could not be used because of the
+ * Erratum 799270 workaround. This macro is the same as the common one (in
+ * arch/arm/include/asm/cacheflush.h) except for the erratum handling.
+ */
+#define exynos_v7_exit_coherency_flush(level) \
+	asm volatile( \
+	"stmfd	sp!, {fp, ip}\n\t"\
+	"mrc	p15, 0, r0, c1, c0, 0	@ get SCTLR\n\t" \
+	"bic	r0, r0, #"__stringify(CR_C)"\n\t" \
+	"mcr	p15, 0, r0, c1, c0, 0	@ set SCTLR\n\t" \
+	"isb\n\t"\
+	"bl	v7_flush_dcache_"__stringify(level)"\n\t" \
+	"clrex\n\t"\
+	"mrc	p15, 0, r0, c1, c0, 1	@ get ACTLR\n\t" \
+	"bic	r0, r0, #(1 << 6)	@ disable local coherency\n\t" \
+	/* Dummy Load of a device register to avoid Erratum 799270 */ \
+	"ldr	r4, [%0]\n\t" \
+	"and	r4, r4, #0\n\t" \
+	"orr	r0, r0, r4\n\t" \
+	"mcr	p15, 0, r0, c1, c0, 1	@ set ACTLR\n\t" \
+	"isb\n\t" \
+	"dsb\n\t" \
+	"ldmfd	sp!, {fp, ip}" \
+	: \
+	: "Ir" (S5P_INFORM0) \
+	: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", \
+	  "r9", "r10", "lr", "memory")
+
+/*
+ * We can't use regular spinlocks. In the switcher case, it is possible
+ * for an outbound CPU to call power_down() after its inbound counterpart
+ * is already live using the same logical CPU number which trips lockdep
+ * debugging.
+ */
+static arch_spinlock_t exynos_mcpm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
+static int
+cpu_use_count[EXYNOS5420_CPUS_PER_CLUSTER][EXYNOS5420_NR_CLUSTERS];
+
+static bool exynos_core_power_state(unsigned int cpu, unsigned int cluster)
+{
+	unsigned int val;
+	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
+
+	val = __raw_readl(EXYNOS_ARM_CORE_STATUS(cpunr)) &
+				EXYNOS_CORE_LOCAL_PWR_EN;
+	return !!val;
+}
+
+static void exynos_core_power_control(unsigned int cpu, unsigned int cluster,
+						int enable)
+{
+	unsigned int val = EXYNOS_CORE_LOCAL_PWR_DIS;
+	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
+
+	if (exynos_core_power_state(cpu, cluster) == enable)
+		return;
+
+	if (enable)
+		val = EXYNOS_CORE_LOCAL_PWR_EN;
+	__raw_writel(val, EXYNOS_ARM_CORE_CONFIGURATION(cpunr));
+}
+
+static void exynos_cluster_power_control(unsigned int cluster, int enable)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(20);
+	unsigned int status, val = EXYNOS_CORE_LOCAL_PWR_DIS;
+
+	if (enable)
+		val = EXYNOS_CORE_LOCAL_PWR_EN;
+
+	status = __raw_readl(EXYNOS_COMMON_STATUS(cluster));
+	if ((status & EXYNOS_CORE_LOCAL_PWR_EN) == val)
+		return;
+
+	__raw_writel(val, EXYNOS_COMMON_CONFIGURATION(cluster));
+	/* Wait until cluster power control is applied */
+	while (time_before(jiffies, timeout)) {
+		status = __raw_readl(EXYNOS_COMMON_STATUS(cluster));
+
+		if ((status & EXYNOS_CORE_LOCAL_PWR_EN) == val)
+			return;
+
+		cpu_relax();
+	}
+	pr_warn("timed out waiting for cluster %u to power %s\n", cluster,
+		enable ? "on" : "off");
+}
+
+static int exynos_power_up(unsigned int cpu, unsigned int cluster)
+{
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	if (cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
+		cluster >= EXYNOS5420_NR_CLUSTERS)
+		return -EINVAL;
+
+	/*
+	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
+	 * variant exists, we need to disable IRQs manually here.
+	 */
+	local_irq_disable();
+	arch_spin_lock(&exynos_mcpm_lock);
+
+	cpu_use_count[cpu][cluster]++;
+	if (cpu_use_count[cpu][cluster] == 1) {
+		bool was_cluster_down =
+			__mcpm_cluster_state(cluster) == CLUSTER_DOWN;
+
+		/*
+		 * Turn on the cluster (L2/COMMON) and then power on the cores.
+		 * TODO: Turn off the clusters when all cores in the cluster
+		 * are down to achieve significant power savings.
+		 */
+		if (was_cluster_down)
+			exynos_cluster_power_control(cluster, 1);
+		exynos_core_power_control(cpu, cluster, 1);
+
+		/* CPU should be powered up there */
+		/* Also setup Cluster Power Sequence here */
+	} else if (cpu_use_count[cpu][cluster] != 2) {
+		/*
+		 * The only possible values are:
+		 * 0 = CPU down
+		 * 1 = CPU (still) up
+		 * 2 = CPU requested to be up before it had a chance
+		 *     to actually make itself down.
+		 * Any other value is a bug.
+		 */
+		BUG();
+	}
+
+	arch_spin_unlock(&exynos_mcpm_lock);
+	local_irq_enable();
+
+	return 0;
+}
+
+static void exynos_power_down(void)
+{
+	unsigned int mpidr, cpu, cluster, cpumask;
+	bool last_man = false, skip_wfi = false;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	cpumask = (1 << cpu);
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
+			cluster >= EXYNOS5420_NR_CLUSTERS);
+
+	__mcpm_cpu_going_down(cpu, cluster);
+
+	arch_spin_lock(&exynos_mcpm_lock);
+	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
+	cpu_use_count[cpu][cluster]--;
+	if (cpu_use_count[cpu][cluster] == 0) {
+		int cnt = 0, i;
+
+		exynos_core_power_control(cpu, cluster, 0);
+		for (i = 0; i < EXYNOS5420_CPUS_PER_CLUSTER; i++)
+			cnt += cpu_use_count[i][cluster];
+		if (cnt == 0)
+			last_man = true;
+	} else if (cpu_use_count[cpu][cluster] == 1) {
+		/*
+		 * A power_up request went ahead of us.
+		 * Even if we do not want to shut this CPU down,
+		 * the caller expects a certain state as if the WFI
+		 * was aborted.  So let's continue with cache cleaning.
+		 */
+		skip_wfi = true;
+	} else {
+		BUG();
+	}
+
+	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
+		arch_spin_unlock(&exynos_mcpm_lock);
+
+		/* Flush all cache levels for this cluster. */
+		exynos_v7_exit_coherency_flush(all);
+
+		/*
+		 * Disable cluster-level coherency by masking
+		 * incoming snoops and DVM messages:
+		 */
+		cci_disable_port_by_cpu(mpidr);
+
+		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
+	} else {
+		arch_spin_unlock(&exynos_mcpm_lock);
+
+		/* Disable and flush the local CPU cache. */
+		exynos_v7_exit_coherency_flush(louis);
+	}
+
+	__mcpm_cpu_down(cpu, cluster);
+
+	/* Now we are prepared for power-down, do it: */
+	if (!skip_wfi)
+		wfi();
+
+	/* Not dead@this point?  Let our caller cope. */
+}
+
+static int exynos_power_down_finish(unsigned int cpu, unsigned int cluster)
+{
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
+			cluster >= EXYNOS5420_NR_CLUSTERS);
+
+	/* Wait for the core state to be OFF */
+	while (exynos_core_power_state(cpu, cluster) != 0x0)
+		;
+
+	return 0; /* success: the CPU is halted */
+}
+
+static const struct mcpm_platform_ops exynos_power_ops = {
+	.power_up		= exynos_power_up,
+	.power_down		= exynos_power_down,
+	.power_down_finish	= exynos_power_down_finish,
+};
+
+static void __init exynos_mcpm_usage_count_init(void)
+{
+	unsigned int mpidr, cpu, cluster;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER  ||
+			cluster >= EXYNOS5420_NR_CLUSTERS);
+
+	cpu_use_count[cpu][cluster] = 1;
+}
+
+/*
+ * Enable cluster-level coherency, in preparation for turning on the MMU.
+ */
+static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
+{
+	asm volatile ("\n"
+	"cmp	r0, #1\n"
+	"bxne	lr\n"
+	"b	cci_enable_port_for_self");
+}
+
+static int __init exynos_mcpm_init(void)
+{
+	int ret = 0;
+
+	if (!soc_is_exynos5420())
+		return -ENODEV;
+
+	if (!cci_probed())
+		return -ENODEV;
+
+	/*
+	 * To increase the stability of KFC reset we need to program
+	 * the PMU SPARE3 register
+	 */
+	__raw_writel(EXYNOS5420_SWRESET_KFC_SEL, S5P_PMU_SPARE3);
+
+	exynos_mcpm_usage_count_init();
+
+	ret = mcpm_platform_register(&exynos_power_ops);
+	if (!ret)
+		ret = mcpm_sync_init(exynos_pm_power_up_setup);
+	if (ret)
+		return ret;
+
+	mcpm_smp_set_ops();
+
+	pr_info("Exynos MCPM support installed\n");
+
+	/*
+	 * Future entries into the kernel can now go
+	 * through the cluster entry vectors.
+	 */
+	__raw_writel(virt_to_phys(mcpm_entry_point),
+		REG_ENTRY_ADDR);
+
+	return ret;
+}
+
+early_initcall(exynos_mcpm_init);
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index cfbfc575..43fe7a0 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -38,6 +38,7 @@
 #define S5P_INFORM5				S5P_PMUREG(0x0814)
 #define S5P_INFORM6				S5P_PMUREG(0x0818)
 #define S5P_INFORM7				S5P_PMUREG(0x081C)
+#define S5P_PMU_SPARE3				S5P_PMUREG(0x090C)
 
 #define EXYNOS_IROM_DATA2			S5P_PMUREG(0x0988)
 
@@ -540,5 +541,6 @@
 #define EXYNOS5420_KFC_USE_STANDBY_WFE3				(1 << 23)
 
 #define DUR_WAIT_RESET				0xF
+#define EXYNOS5420_SWRESET_KFC_SEL		0x3
 
 #endif /* __ASM_ARCH_REGS_PMU_H */
-- 
1.7.9.5
