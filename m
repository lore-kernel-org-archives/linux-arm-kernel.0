From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 May 2015 14:10:09 +0800
Subject: [RFC 5/7] ARM: sunxi: mcpm: Support CPU/cluster power down and
 hotplugging for cpu1~7
In-Reply-To: <1431583811-25780-1-git-send-email-wens@csie.org>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
Message-ID: <1431583811-25780-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The primary core (cpu0) requires setting flags to have the BROM bounce
execution to the SMP software entry code.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/mcpm.c | 103 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sunxi/mcpm.c b/arch/arm/mach-sunxi/mcpm.c
index cf9cbf268d29..5ea4b488890c 100644
--- a/arch/arm/mach-sunxi/mcpm.c
+++ b/arch/arm/mach-sunxi/mcpm.c
@@ -15,7 +15,9 @@
 #include <linux/arm-cci.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/of_address.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/cputype.h>
 #include <asm/cp15.h>
@@ -33,6 +35,9 @@
 #define CPUCFG_CX_CTRL_REG0_L2_RST_DISABLE_A15	BIT(0)
 #define CPUCFG_CX_CTRL_REG1(c)		(0x10 * (c) + 0x4)
 #define CPUCFG_CX_CTRL_REG1_ACINACTM	BIT(0)
+#define CPUCFG_CX_STATUS(c)		(0x30 * (c) + 0x4)
+#define CPUCFG_CX_STATUS_STANDBYWFI(n)	BIT(16 + (n))
+#define CPUCFG_CX_STATUS_STANDBYWFIL2	BIT(0)
 #define CPUCFG_CX_RST_CTRL(c)		(0x80 + 0x4 * (c))
 #define CPUCFG_CX_RST_CTRL_DBG_SOC_RST	BIT(24)
 #define CPUCFG_CX_RST_CTRL_ETM_RST(n)	BIT(20 + (n))
@@ -221,6 +226,15 @@ static int sunxi_cluster_powerup(unsigned int cluster)
 	return 0;
 }
 
+static void sunxi_cpu_powerdown_prepare(unsigned int cpu, unsigned int cluster)
+{
+	gic_cpu_if_down();
+}
+
+static void sunxi_cluster_powerdown_prepare(unsigned int cluster)
+{
+}
+
 static void sunxi_cpu_cache_disable(void)
 {
 	/* Disable and flush the local CPU cache. */
@@ -253,11 +267,92 @@ static void sunxi_cluster_cache_disable(void)
 	cci_disable_port_by_cpu(read_cpuid_mpidr());
 }
 
+static int sunxi_cpu_powerdown(unsigned int cpu, unsigned int cluster)
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
+static int sunxi_cluster_powerdown(unsigned int cluster)
+{
+	u32 reg;
+
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+	if (cluster >= SUNXI_NR_CLUSTERS)
+		return -EINVAL;
+
+	/* clear cluster power gate */
+	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
+	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER;
+	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
+	udelay(20);
+
+	return 0;
+}
+
+static int sunxi_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
+{
+	int ret;
+	u32 reg;
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+
+	/* wait for CPU core to enter WFI */
+	ret = readl_poll_timeout(cpucfg_base + CPUCFG_CX_STATUS(cluster), reg,
+				 reg & CPUCFG_CX_STATUS_STANDBYWFI(cpu),
+				 1000, 100000);
+
+	if (ret)
+		return ret;
+
+	/* power down CPU core */
+	sunxi_cpu_powerdown(cpu, cluster);
+
+	if (__mcpm_cluster_state(cluster) != CLUSTER_DOWN)
+		return 0;
+
+	/* last man standing, assert ACINACTM */
+	reg = readl(cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
+	reg |= CPUCFG_CX_CTRL_REG1_ACINACTM;
+	writel(reg, cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
+
+	/* wait for cluster L2 WFI */
+	ret = readl_poll_timeout(cpucfg_base + CPUCFG_CX_STATUS(cluster), reg,
+				 reg & CPUCFG_CX_STATUS_STANDBYWFIL2,
+				 1000, 100000);
+	if (ret) {
+		pr_warn("%s: cluster %u time out waiting for STANDBYWFIL2\n",
+				__func__, cluster);
+		return ret;
+	}
+
+	sunxi_cluster_powerdown(cluster);
+
+	return 0;
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
-- 
2.1.4
