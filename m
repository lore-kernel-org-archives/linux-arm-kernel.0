From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 10 Jul 2018 13:31:48 -0300
Subject: [PATCH v4 6/6] ARM: mx5: Set the DBGEN bit in ARM_GPC register
In-Reply-To: <1531240308-24798-1-git-send-email-fabio.estevam@nxp.com>
References: <1531240308-24798-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1531240308-24798-6-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX51/i.MX53 it is necessary to set the DBGEN bit in 
ARM_GPC register in order to turn on the debug clocks.

The DBGEN bit of ARM_GPC register has the following description
in the i.MX53 Reference Manual:

"This allows the user to manually activate clocks within the debug
system. This register bit directly controls the platform's dbgen_out
output signal which connects to the DAP_SYS to enable all debug clocks.
Once enabled, the clocks cannot be disabled except by asserting the
disable_trace input of the DAP_SYS."

Based on a previous patch from Sebastian Reichel.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v3:
- Add missing of_node_put()

 arch/arm/mach-imx/common.h     |  1 +
 arch/arm/mach-imx/cpu-imx5.c   | 45 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mach-imx51.c |  2 +-
 arch/arm/mach-imx/mach-imx53.c |  2 +-
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 93225db7..423dd76 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -62,6 +62,7 @@ void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw);
 void imx_gpc_set_arm_power_down_timing(u32 sw2iso, u32 sw);
 void imx25_pm_init(void);
 void imx27_pm_init(void);
+void imx5_pmu_init(void);
 
 enum mxc_cpu_pwr_mode {
 	WAIT_CLOCKED,		/* wfi only */
diff --git a/arch/arm/mach-imx/cpu-imx5.c b/arch/arm/mach-imx/cpu-imx5.c
index 4f2d1c7..e210bac 100644
--- a/arch/arm/mach-imx/cpu-imx5.c
+++ b/arch/arm/mach-imx/cpu-imx5.c
@@ -117,3 +117,48 @@ int mx53_revision(void)
 	return mx5_cpu_rev;
 }
 EXPORT_SYMBOL(mx53_revision);
+
+#define ARM_GPC		0x4
+#define DBGEN		BIT(16)
+
+/*
+ * This enables the DBGEN bit in ARM_GPC register, which is
+ * required for accessing some performance counter features.
+ * Technically it is only required while perf is used, but to
+ * keep the source code simple we just enable it all the time
+ * when the kernel configuration allows using the feature.
+ */
+void __init imx5_pmu_init(void)
+{
+	void __iomem *tigerp_base;
+	struct device_node *np;
+	u32 gpc;
+
+	if (!IS_ENABLED(CONFIG_ARM_PMU))
+		return;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a8-pmu");
+	if (!np)
+		return;
+
+	if (!of_property_read_bool(np, "secure-reg-access"))
+		goto exit;
+
+	of_node_put(np);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx51-tigerp");
+	if (!np)
+		return;
+
+	tigerp_base = of_iomap(np, 0);
+	if (!tigerp_base)
+		goto exit;
+
+	gpc = readl_relaxed(tigerp_base + ARM_GPC);
+	gpc |= DBGEN;
+	writel_relaxed(gpc, tigerp_base + ARM_GPC);
+	iounmap(tigerp_base);
+exit:
+	of_node_put(np);
+
+}
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index 3835b6a..8838fba 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -52,7 +52,7 @@ static void __init imx51_dt_init(void)
 {
 	imx51_ipu_mipi_setup();
 	imx_src_init();
-
+	imx5_pmu_init();
 	imx_aips_allow_unprivileged_access("fsl,imx51-aipstz");
 }
 
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 07c2e8d..5ec7100 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -31,7 +31,7 @@ static void __init imx53_init_early(void)
 static void __init imx53_dt_init(void)
 {
 	imx_src_init();
-
+	imx5_pmu_init();
 	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
 }
 
-- 
2.7.4
