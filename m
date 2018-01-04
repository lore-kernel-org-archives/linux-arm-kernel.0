From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  4 Jan 2018 22:37:51 +0800
Subject: [PATCH v2 5/8] ARM: sun9i: mcpm: Support CPU/cluster power down and
 hotplugging for cpu1~7
In-Reply-To: <20180104143754.2425-1-wens@csie.org>
References: <20180104143754.2425-1-wens@csie.org>
Message-ID: <20180104143754.2425-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds common code used to power down all cores and clusters.
The code is quite long. The common MCPM library does not provide a
callback for doing the actual power down sequence. Instead it assumes
some other part (maybe a power management coprocessor) will handle it.
Since our platform does not have this, we resort to using a single thread
workqueue, based on how our work should be done in the order they were
queued, so the cluster power down code does not execute before the core
power down code. Though the scenario is not catastrophic, it will leave
the cluster on and using power.

This might be a bit racy, as nothing prevents the system from bringing a
core or cluster back before the asynchronous work shuts it down. This would
likely happen under a heavily loaded system with a scheduler that brings
cores in and out of the system frequently. It would either result in a
stall on a single core, or worse, hang the system if a cluster is abruptly
turned off. In simple use-cases it performs OK.

The primary core (cpu0) requires setting flags to have the BROM bounce
execution to the SMP software entry code. This is done in a subsequent
patch to keep the changes cleanly separated.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/mcpm.c | 170 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-sunxi/mcpm.c b/arch/arm/mach-sunxi/mcpm.c
index 30719998f3f0..ddc26b5fec48 100644
--- a/arch/arm/mach-sunxi/mcpm.c
+++ b/arch/arm/mach-sunxi/mcpm.c
@@ -12,9 +12,12 @@
 #include <linux/arm-cci.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/workqueue.h>
 
 #include <asm/cputype.h>
 #include <asm/cp15.h>
@@ -30,6 +33,9 @@
 #define CPUCFG_CX_CTRL_REG0_L2_RST_DISABLE_A15	BIT(0)
 #define CPUCFG_CX_CTRL_REG1(c)		(0x10 * (c) + 0x4)
 #define CPUCFG_CX_CTRL_REG1_ACINACTM	BIT(0)
+#define CPUCFG_CX_STATUS(c)		(0x30 + 0x4 * (c))
+#define CPUCFG_CX_STATUS_STANDBYWFI(n)	BIT(16 + (n))
+#define CPUCFG_CX_STATUS_STANDBYWFIL2	BIT(0)
 #define CPUCFG_CX_RST_CTRL(c)		(0x80 + 0x4 * (c))
 #define CPUCFG_CX_RST_CTRL_DBG_SOC_RST	BIT(24)
 #define CPUCFG_CX_RST_CTRL_ETM_RST(n)	BIT(20 + (n))
@@ -237,6 +243,30 @@ static int sunxi_cluster_powerup(unsigned int cluster)
 	return 0;
 }
 
+struct sunxi_mcpm_work {
+	struct work_struct work;
+	unsigned int cpu;
+	unsigned int cluster;
+};
+
+static struct workqueue_struct *sunxi_mcpm_wq;
+static struct sunxi_mcpm_work sunxi_mcpm_cpu_down_work[2][4];
+static struct sunxi_mcpm_work sunxi_mcpm_cluster_down_work[2];
+
+static void sunxi_cpu_powerdown_prepare(unsigned int cpu, unsigned int cluster)
+{
+	gic_cpu_if_down(0);
+
+	queue_work(sunxi_mcpm_wq,
+		   &sunxi_mcpm_cpu_down_work[cluster][cpu].work);
+}
+
+static void sunxi_cluster_powerdown_prepare(unsigned int cluster)
+{
+	queue_work(sunxi_mcpm_wq,
+		   &sunxi_mcpm_cluster_down_work[cluster].work);
+}
+
 static void sunxi_cpu_cache_disable(void)
 {
 	/* Disable and flush the local CPU cache. */
@@ -286,11 +316,116 @@ static void sunxi_cluster_cache_disable(void)
 	writel(reg, cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
 }
 
+static int sunxi_do_cpu_powerdown(unsigned int cpu, unsigned int cluster)
+{
+	u32 reg;
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
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
+static int sunxi_do_cluster_powerdown(unsigned int cluster)
+{
+	u32 reg;
+
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+	if (cluster >= SUNXI_NR_CLUSTERS)
+		return -EINVAL;
+
+	/* assert cluster resets */
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
+static struct sunxi_mcpm_work *to_sunxi_mcpm_work(struct work_struct *work)
+{
+	return container_of(work, struct sunxi_mcpm_work, work);
+}
+
+/* async. work functions to bring down cpus and clusters */
+static void sunxi_cpu_powerdown(struct work_struct *_work)
+{
+	struct sunxi_mcpm_work *work = to_sunxi_mcpm_work(_work);
+	unsigned int cluster = work->cluster, cpu = work->cpu;
+	int ret;
+	u32 reg;
+
+	/* wait for CPU core to enter WFI */
+	ret = readl_poll_timeout(cpucfg_base + CPUCFG_CX_STATUS(cluster), reg,
+				 reg & CPUCFG_CX_STATUS_STANDBYWFI(cpu),
+				 1000, 100000);
+
+	if (ret)
+		return;
+
+	/* power down CPU core */
+	sunxi_do_cpu_powerdown(cpu, cluster);
+}
+
+static void sunxi_cluster_powerdown(struct work_struct *_work)
+{
+	struct sunxi_mcpm_work *work = to_sunxi_mcpm_work(_work);
+	unsigned int cluster = work->cluster;
+	int ret;
+	u32 reg;
+
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+
+	/* wait for cluster L2 WFI */
+	ret = readl_poll_timeout(cpucfg_base + CPUCFG_CX_STATUS(cluster), reg,
+				 reg & CPUCFG_CX_STATUS_STANDBYWFIL2,
+				 1000, 100000);
+	if (ret)
+		return;
+
+	sunxi_do_cluster_powerdown(cluster);
+}
+
+static int sunxi_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
+{
+	int ret;
+	u32 reg;
+
+	ret = readl_poll_timeout(prcm_base + PRCM_PWR_SWITCH_REG(cluster, cpu),
+				 reg, reg == 0xff, 1000, 100000);
+	pr_debug("%s: cpu %u cluster %u powerdown: %s\n", __func__,
+		 cpu, cluster, ret ? "timed out" : "done");
+	return ret;
+}
+
 static const struct mcpm_platform_ops sunxi_power_ops = {
-	.cpu_powerup		= sunxi_cpu_powerup,
-	.cluster_powerup	= sunxi_cluster_powerup,
-	.cpu_cache_disable	= sunxi_cpu_cache_disable,
-	.cluster_cache_disable	= sunxi_cluster_cache_disable,
+	.cpu_powerup		   = sunxi_cpu_powerup,
+	.cpu_powerdown_prepare	   = sunxi_cpu_powerdown_prepare,
+	.cluster_powerup	   = sunxi_cluster_powerup,
+	.cluster_powerdown_prepare = sunxi_cluster_powerdown_prepare,
+	.cpu_cache_disable	   = sunxi_cpu_cache_disable,
+	.cluster_cache_disable	   = sunxi_cluster_cache_disable,
+	.wait_for_powerdown	   = sunxi_wait_for_powerdown,
 };
 
 /*
@@ -352,6 +487,7 @@ static int __init sunxi_mcpm_init(void)
 	struct device_node *cpucfg_node, *node;
 	struct resource res;
 	int ret;
+	int i, j;
 
 	if (!of_machine_is_compatible("allwinner,sun9i-a80"))
 		return -ENODEV;
@@ -389,6 +525,28 @@ static int __init sunxi_mcpm_init(void)
 		goto err_put_cpucfg_node;
 	}
 
+	/* Initialize our strictly ordered workqueue */
+	sunxi_mcpm_wq = alloc_ordered_workqueue("%s", 0, "sunxi-mcpm");
+	if (!sunxi_mcpm_wq) {
+		ret = -ENOMEM;
+		pr_err("%s: failed to create our workqueue\n", __func__);
+		goto err_unmap_release_cpucfg;
+	}
+
+	/* Initialize power down work */
+	for (i = 0; i < SUNXI_NR_CLUSTERS; i++) {
+		for (j = 0; j < SUNXI_CPUS_PER_CLUSTER; j++) {
+			sunxi_mcpm_cpu_down_work[i][j].cluster = i;
+			sunxi_mcpm_cpu_down_work[i][j].cpu = j;
+			INIT_WORK(&sunxi_mcpm_cpu_down_work[i][j].work,
+				  sunxi_cpu_powerdown);
+		}
+
+		sunxi_mcpm_cluster_down_work[i].cluster = i;
+		INIT_WORK(&sunxi_mcpm_cluster_down_work[i].work,
+			  sunxi_cluster_powerdown);
+	}
+
 	ret = mcpm_platform_register(&sunxi_power_ops);
 	if (!ret)
 		ret = mcpm_sync_init(sunxi_power_up_setup);
@@ -396,7 +554,7 @@ static int __init sunxi_mcpm_init(void)
 		/* do not disable AXI master as no one will re-enable it */
 		ret = mcpm_loopback(sunxi_cluster_cache_disable_without_axi);
 	if (ret)
-		goto err_unmap_release_cpucfg;
+		goto err_destroy_workqueue;
 
 	/* We don't need the CPUCFG device node anymore */
 	of_node_put(cpucfg_node);
@@ -411,6 +569,8 @@ static int __init sunxi_mcpm_init(void)
 
 	return ret;
 
+err_destroy_workqueue:
+	destroy_workqueue(sunxi_mcpm_wq);
 err_unmap_release_cpucfg:
 	iounmap(cpucfg_base);
 	of_address_to_resource(cpucfg_node, 0, &res);
-- 
2.15.1
