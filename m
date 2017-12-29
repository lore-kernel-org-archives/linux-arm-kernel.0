From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri, 29 Dec 2017 11:55:03 +0100
Subject: [PATCH v2 2/5] ARM: sunxi: mcpm: Add support for A83T
In-Reply-To: <20171229105506.24851-1-mylene.josserand@free-electrons.com>
References: <20171229105506.24851-1-mylene.josserand@free-electrons.com>
Message-ID: <20171229105506.24851-3-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the support for A83T.

A83T SoC has an additional register than A80 to handle CPU configurations:
R_CPUS_CFG. Information about the register comes from Allwinner's BSP
driver.
An important difference is the Power Off Gating register for clusters
which is BIT(4) in case of SUN9I-A80 and BIT(0) in case of SUN8I-A83T.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig |   1 +
 arch/arm/mach-sunxi/mcpm.c  | 142 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 133 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 177380548d99..ae7b57fbd7ac 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -42,6 +42,7 @@ config MACH_SUN8I
 	default ARCH_SUNXI
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
+	imply MCPM
 
 config MACH_SUN9I
 	bool "Allwinner (sun9i) SoCs support"
diff --git a/arch/arm/mach-sunxi/mcpm.c b/arch/arm/mach-sunxi/mcpm.c
index 4b6e1d6ae379..716a888df70e 100644
--- a/arch/arm/mach-sunxi/mcpm.c
+++ b/arch/arm/mach-sunxi/mcpm.c
@@ -43,17 +43,25 @@
 #define CPUCFG_CX_RST_CTRL_L2_RST	BIT(8)
 #define CPUCFG_CX_RST_CTRL_CX_RST(n)	BIT(4 + (n))
 #define CPUCFG_CX_RST_CTRL_CORE_RST(n)	BIT(n)
+#define CPUCFG_CX_RST_CTRL_CORE_RST_ALL	(0xf << 0)
 
 #define PRCM_CPU_PO_RST_CTRL(c)		(0x4 + 0x4 * (c))
 #define PRCM_CPU_PO_RST_CTRL_CORE(n)	BIT(n)
 #define PRCM_CPU_PO_RST_CTRL_CORE_ALL	0xf
 #define PRCM_PWROFF_GATING_REG(c)	(0x100 + 0x4 * (c))
-#define PRCM_PWROFF_GATING_REG_CLUSTER	BIT(4)
+/* The power off register for clusters are different from SUN9I and SUN8I */
+#define PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I	BIT(0)
+#define PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I	BIT(4)
 #define PRCM_PWROFF_GATING_REG_CORE(n)	BIT(n)
 #define PRCM_PWR_SWITCH_REG(c, cpu)	(0x140 + 0x10 * (c) + 0x4 * (cpu))
 #define PRCM_CPU_SOFT_ENTRY_REG		0x164
 
+#define R_CPUCFG_CLUSTER_PO_RST_CTRL(c)	(0x30 + (c) * 0x4)
+#define R_CPUCFG_CLUSTER_PO_RST_CTRL_CORE(n)	BIT(n)
+#define R_CPUCFG_CPU_SOFT_ENTRY_REG	0x01a4
+
 static void __iomem *cpucfg_base;
+static void __iomem *r_cpucfg_base;
 static void __iomem *prcm_base;
 
 static int sunxi_cpu_power_switch_set(unsigned int cpu, unsigned int cluster,
@@ -101,6 +109,16 @@ static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
 	reg &= ~PRCM_CPU_PO_RST_CTRL_CORE(cpu);
 	writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
 
+	if (r_cpucfg_base) {
+		/* assert cpu power-on reset */
+		reg  = readl(r_cpucfg_base +
+			     R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
+		reg &= ~(R_CPUCFG_CLUSTER_PO_RST_CTRL_CORE(cpu));
+		writel(reg, r_cpucfg_base +
+		       R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
+		udelay(10);
+	}
+
 	/* Cortex-A7: hold L1 reset disable signal low */
 	if (!(of_machine_is_compatible("allwinner,sun9i-a80") &&
 			cluster == SUN9I_A80_A15_CLUSTER)) {
@@ -126,17 +144,37 @@ static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
 	/* open power switch */
 	sunxi_cpu_power_switch_set(cpu, cluster, true);
 
+	/* Handle A83T bit swap */
+	if (of_machine_is_compatible("allwinner,sun8i-a83t")) {
+		if (cpu == 0)
+			cpu = 4;
+	}
+
 	/* clear processor power gate */
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	reg &= ~PRCM_PWROFF_GATING_REG_CORE(cpu);
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
+	if (of_machine_is_compatible("allwinner,sun8i-a83t")) {
+		if (cpu == 4)
+			cpu = 0;
+	}
+
 	/* de-assert processor power-on reset */
 	reg = readl(prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
 	reg |= PRCM_CPU_PO_RST_CTRL_CORE(cpu);
 	writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
 
+	if (r_cpucfg_base) {
+		reg  = readl(r_cpucfg_base +
+			     R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
+		reg |= R_CPUCFG_CLUSTER_PO_RST_CTRL_CORE(cpu);
+		writel(reg, r_cpucfg_base +
+		       R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
+		udelay(10);
+	}
+
 	/* de-assert all processor resets */
 	reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
 	reg |= CPUCFG_CX_RST_CTRL_DBG_RST(cpu);
@@ -160,6 +198,14 @@ static int sunxi_cluster_powerup(unsigned int cluster)
 	if (cluster >= SUNXI_NR_CLUSTERS)
 		return -EINVAL;
 
+	/* For A83T, assert cluster cores resets */
+	if (of_machine_is_compatible("allwinner,sun8i-a83t")) {
+		reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+		reg &= ~CPUCFG_CX_RST_CTRL_CORE_RST_ALL;   /* Core Reset    */
+		writel(reg, cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+		udelay(10);
+	}
+
 	/* assert ACINACTM */
 	reg = readl(cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
 	reg |= CPUCFG_CX_CTRL_REG1_ACINACTM;
@@ -170,6 +216,16 @@ static int sunxi_cluster_powerup(unsigned int cluster)
 	reg &= ~PRCM_CPU_PO_RST_CTRL_CORE_ALL;
 	writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
 
+	/* assert cluster cores resets */
+	if (r_cpucfg_base) {
+		reg  = readl(r_cpucfg_base +
+			     R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
+		reg &= ~CPUCFG_CX_RST_CTRL_CORE_RST_ALL;
+		writel(reg, r_cpucfg_base +
+		       R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
+		udelay(10);
+	}
+
 	/* assert cluster resets */
 	reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
 	reg &= ~CPUCFG_CX_RST_CTRL_DBG_SOC_RST;
@@ -202,7 +258,10 @@ static int sunxi_cluster_powerup(unsigned int cluster)
 
 	/* clear cluster power gate */
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
-	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER;
+	if (of_machine_is_compatible("allwinner,sun8i-a83t"))
+		reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I;
+	else
+		reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
@@ -327,23 +386,54 @@ static void __naked sunxi_power_up_setup(unsigned int affinity_level)
 
 static void sunxi_mcpm_setup_entry_point(void)
 {
-	__raw_writel(virt_to_phys(mcpm_entry_point),
-		     prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
+	if (of_machine_is_compatible("allwinner,sun9i-a80"))
+		__raw_writel(virt_to_phys(mcpm_entry_point),
+			     prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
+	else
+		__raw_writel(virt_to_phys(mcpm_entry_point), r_cpucfg_base +
+			     R_CPUCFG_CPU_SOFT_ENTRY_REG);
 }
 
-static int __init sunxi_mcpm_init(void)
+static int sun9i_dt_parsing(void)
 {
 	struct device_node *node;
-	int ret;
 
-	if (!of_machine_is_compatible("allwinner,sun9i-a80"))
+	node = of_find_compatible_node(NULL, NULL,
+				       "allwinner,sun9i-a80-cpucfg");
+	if (!node)
 		return -ENODEV;
 
-	if (!cci_probed())
+	cpucfg_base = of_iomap(node, 0);
+	of_node_put(node);
+	if (!cpucfg_base) {
+		pr_err("%s: failed to map CPUCFG registers\n", __func__);
+		return -ENOMEM;
+	}
+
+	node = of_find_compatible_node(NULL, NULL,
+				       "allwinner,sun9i-a80-prcm");
+	if (!node)
 		return -ENODEV;
 
+	prcm_base = of_iomap(node, 0);
+	of_node_put(node);
+	if (!prcm_base) {
+		pr_err("%s: failed to map PRCM registers\n", __func__);
+		iounmap(prcm_base);
+		return -ENOMEM;
+	}
+
+	r_cpucfg_base = NULL;
+
+	return 0;
+}
+
+static int sun8i_dt_parsing(void)
+{
+	struct device_node *node;
+
 	node = of_find_compatible_node(NULL, NULL,
-			"allwinner,sun9i-a80-cpucfg");
+				       "allwinner,sun8i-a83t-cpucfg");
 	if (!node)
 		return -ENODEV;
 
@@ -355,7 +445,7 @@ static int __init sunxi_mcpm_init(void)
 	}
 
 	node = of_find_compatible_node(NULL, NULL,
-			"allwinner,sun9i-a80-prcm");
+				       "allwinner,sun8i-a83t-prcm");
 	if (!node)
 		return -ENODEV;
 
@@ -367,6 +457,38 @@ static int __init sunxi_mcpm_init(void)
 		return -ENOMEM;
 	}
 
+	node = of_find_compatible_node(NULL, NULL,
+				       "allwinner,sun8i-a83t-r-cpucfg");
+	if (!node)
+		return -ENODEV;
+
+	r_cpucfg_base = of_iomap(node, 0);
+	of_node_put(node);
+	if (!r_cpucfg_base) {
+		pr_err("%s: failed to map R-CPUCFG registers\n",
+		       __func__);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int __init sunxi_mcpm_init(void)
+{
+	int ret;
+
+	if (!of_machine_is_compatible("allwinner,sun9i-a80") &&
+	    !of_machine_is_compatible("allwinner,sun8i-a83t"))
+		return -ENODEV;
+
+	if (!cci_probed())
+		return -ENODEV;
+
+	if (of_machine_is_compatible("allwinner,sun9i-a80"))
+		ret = sun9i_dt_parsing();
+	else
+		ret = sun8i_dt_parsing();
+
 	ret = mcpm_platform_register(&sunxi_power_ops);
 	if (!ret)
 		ret = mcpm_sync_init(sunxi_power_up_setup);
-- 
2.11.0
