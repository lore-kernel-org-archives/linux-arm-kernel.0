From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 15 Jan 2018 15:14:47 +0800
Subject: [PATCH v3 5/8] ARM: sun9i: mcpm: Support CPU/cluster power down and
 hotplugging for cpu1~7
In-Reply-To: <20180115071450.18355-1-wens@csie.org>
References: <20180115071450.18355-1-wens@csie.org>
Message-ID: <20180115071450.18355-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds common code used to power down all cores and clusters.
The code was previously based on the MCPM framework. It has now been
adapted to hook into struct smp_operations directly, but the code
structure still shows signs of prior work.

The primary core (cpu0) requires setting flags to have the BROM bounce
execution to the SMP software entry code. This is done in a subsequent
patch to keep the changes cleanly separated. By default the ARM SMP code
blocks cpu0 from being turned off, so splitting this out is safe.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/mcpm.c | 190 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 189 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/mcpm.c b/arch/arm/mach-sunxi/mcpm.c
index 7c77bb3b367a..740343a2156e 100644
--- a/arch/arm/mach-sunxi/mcpm.c
+++ b/arch/arm/mach-sunxi/mcpm.c
@@ -14,6 +14,8 @@
 #include <linux/cpu_pm.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -29,6 +31,9 @@
 #define SUNXI_CPUS_PER_CLUSTER		4
 #define SUNXI_NR_CLUSTERS		2
 
+#define POLL_USEC	100
+#define TIMEOUT_USEC	100000
+
 #define CPUCFG_CX_CTRL_REG0(c)		(0x10 * (c))
 #define CPUCFG_CX_CTRL_REG0_L1_RST_DISABLE(n)	BIT(n)
 #define CPUCFG_CX_CTRL_REG0_L1_RST_DISABLE_ALL	0xf
@@ -36,6 +41,9 @@
 #define CPUCFG_CX_CTRL_REG0_L2_RST_DISABLE_A15	BIT(0)
 #define CPUCFG_CX_CTRL_REG1(c)		(0x10 * (c) + 0x4)
 #define CPUCFG_CX_CTRL_REG1_ACINACTM	BIT(0)
+#define CPUCFG_CX_STATUS(c)		(0x30 + 0x4 * (c))
+#define CPUCFG_CX_STATUS_STANDBYWFI(n)	BIT(16 + (n))
+#define CPUCFG_CX_STATUS_STANDBYWFIL2	BIT(0)
 #define CPUCFG_CX_RST_CTRL(c)		(0x80 + 0x4 * (c))
 #define CPUCFG_CX_RST_CTRL_DBG_SOC_RST	BIT(24)
 #define CPUCFG_CX_RST_CTRL_ETM_RST(n)	BIT(20 + (n))
@@ -120,7 +128,7 @@ static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
 {
 	u32 reg;
 
-	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	pr_debug("%s: cluster %u cpu %u\n", __func__, cluster, cpu);
 	if (cpu >= SUNXI_CPUS_PER_CLUSTER || cluster >= SUNXI_NR_CLUSTERS)
 		return -EINVAL;
 
@@ -388,8 +396,188 @@ static int sunxi_mcpm_boot_secondary(unsigned int l_cpu, struct task_struct *idl
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
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
+static void sunxi_mcpm_cpu_die(unsigned int l_cpu)
+{
+	unsigned int mpidr, cpu, cluster;
+	bool last_man;
+
+	mpidr = cpu_logical_map(l_cpu);
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	pr_debug("%s: cluster %u cpu %u\n", __func__, cluster, cpu);
+
+	spin_lock(&boot_lock);
+	sunxi_mcpm_cpu_table[cluster][cpu]--;
+	if (sunxi_mcpm_cpu_table[cluster][cpu] == 1) {
+		/* A power_up request went ahead of us. */
+		pr_debug("%s: aborting due to a power up request\n",
+			 __func__);
+		spin_unlock(&boot_lock);
+		return;
+	} else if (sunxi_mcpm_cpu_table[cluster][cpu] > 1) {
+		pr_err("Cluster %d CPU%d boots multiple times\n",
+		       cluster, cpu);
+		BUG();
+	}
+
+	last_man = sunxi_mcpm_cluster_is_down(cluster);
+	spin_unlock(&boot_lock);
+
+	gic_cpu_if_down(0);
+	if (last_man)
+		sunxi_cluster_cache_disable();
+	else
+		v7_exit_coherency_flush(louis);
+
+	for (;;)
+		wfi();
+}
+
+static int sunxi_cpu_powerdown(unsigned int cpu, unsigned int cluster)
+{
+	u32 reg;
+
+	pr_debug("%s: cluster %u cpu %u\n", __func__, cluster, cpu);
+	if (cpu >= SUNXI_CPUS_PER_CLUSTER || cluster >= SUNXI_NR_CLUSTERS)
+		return -EINVAL;
+
+	/* gate processor power */
+	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
+	reg |= PRCM_PWROFF_GATING_REG_CORE(cpu);
+	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
+	udelay(20);
+
+	/* close power switch */
+	sunxi_cpu_power_switch_set(cpu, cluster, false);
+
+	return 0;
+}
+
+static int sunxi_cluster_powerdown(unsigned int cluster)
+{
+	u32 reg;
+
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+	if (cluster >= SUNXI_NR_CLUSTERS)
+		return -EINVAL;
+
+	/* assert cluster resets or system will hang */
+	pr_debug("%s: assert cluster reset\n", __func__);
+	reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+	reg &= ~CPUCFG_CX_RST_CTRL_DBG_SOC_RST;
+	reg &= ~CPUCFG_CX_RST_CTRL_H_RST;
+	reg &= ~CPUCFG_CX_RST_CTRL_L2_RST;
+	writel(reg, cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+
+	/* gate cluster power */
+	pr_debug("%s: gate cluster power\n", __func__);
+	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
+	reg |= PRCM_PWROFF_GATING_REG_CLUSTER;
+	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
+	udelay(20);
+
+	return 0;
+}
+
+static int sunxi_mcpm_cpu_kill(unsigned int l_cpu)
+{
+	unsigned int mpidr, cpu, cluster;
+	unsigned int tries, count;
+	int ret = 0;
+	u32 reg;
+
+	mpidr = cpu_logical_map(l_cpu);
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	/* This should never happen */
+	if (WARN_ON(cluster >= SUNXI_NR_CLUSTERS ||
+		    cpu >= SUNXI_CPUS_PER_CLUSTER))
+		return 0;
+
+	/* wait for CPU core to die and enter WFI */
+	count = TIMEOUT_USEC / POLL_USEC;
+	spin_lock_irq(&boot_lock);
+	for (tries = 0; tries < count; tries++) {
+		spin_unlock_irq(&boot_lock);
+		usleep_range(POLL_USEC / 2, POLL_USEC);
+		spin_lock_irq(&boot_lock);
+
+		/*
+		 * If the user turns off a bunch of cores@the same
+		 * time, the kernel might call cpu_kill before some of
+		 * them are ready. This is because boot_lock serializes
+		 * both cpu_die and cpu_kill callbacks. Either one could
+		 * run first. We should wait for cpu_die to complete.
+		 */
+		if (sunxi_mcpm_cpu_table[cluster][cpu])
+			continue;
+
+		reg = readl(cpucfg_base + CPUCFG_CX_STATUS(cluster));
+		if (reg & CPUCFG_CX_STATUS_STANDBYWFI(cpu))
+			break;
+	}
+
+	if (tries >= count) {
+		ret = ETIMEDOUT;
+		goto out;
+	}
+
+	/* power down CPU core */
+	sunxi_cpu_powerdown(cpu, cluster);
+
+	if (!sunxi_mcpm_cluster_is_down(cluster))
+		goto out;
+
+	/* wait for cluster L2 WFI */
+	ret = readl_poll_timeout(cpucfg_base + CPUCFG_CX_STATUS(cluster), reg,
+				 reg & CPUCFG_CX_STATUS_STANDBYWFIL2,
+				 POLL_USEC, TIMEOUT_USEC);
+	if (ret) {
+		/*
+		 * Ignore timeout on the cluster. Leaving the cluster on
+		 * will not affect system execution, just use a bit more
+		 * power. But returning an error here will only confuse
+		 * the user as the CPU has already been shutdown.
+		 */
+		ret = 0;
+		goto out;
+	}
+
+	/* Power down cluster */
+	sunxi_cluster_powerdown(cluster);
+
+out:
+	spin_unlock_irq(&boot_lock);
+	pr_debug("%s: cluster %u cpu %u powerdown: %d\n",
+		 __func__, cluster, cpu, ret);
+	return !ret;
+}
+
+#endif
+
 static const struct smp_operations sunxi_mcpm_smp_ops __initconst = {
 	.smp_boot_secondary	= sunxi_mcpm_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= sunxi_mcpm_cpu_die,
+	.cpu_kill		= sunxi_mcpm_cpu_kill,
+#endif
 };
 
 static bool __init sunxi_mcpm_cpu_table_init(void)
-- 
2.15.1
