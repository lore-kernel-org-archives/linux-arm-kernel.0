From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2018 10:52:19 -0300
Subject: [PATCH 3/3] ARM: mx5: Set the DBGEN bit in ARM_GPC register
In-Reply-To: <1529329939-14117-1-git-send-email-festevam@gmail.com>
References: <1529329939-14117-1-git-send-email-festevam@gmail.com>
Message-ID: <1529329939-14117-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

On i.MX51/i.MX53 it is necessery to set the DBGEN bit in 
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
 arch/arm/mach-imx/common.h     |  1 +
 arch/arm/mach-imx/cpu-imx5.c   | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mach-imx53.c |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index c8d68e9..db78329 100644
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
index 4f2d1c7..6c5a055 100644
--- a/arch/arm/mach-imx/cpu-imx5.c
+++ b/arch/arm/mach-imx/cpu-imx5.c
@@ -117,3 +117,41 @@ int mx53_revision(void)
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
+void imx5_pmu_init(void)
+{
+	void __iomem *arm_plat_base;
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
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx51-arm-plat");
+	if (!np)
+		return;
+
+	arm_plat_base = of_iomap(np, 0);
+	if (!arm_plat_base) {
+		pr_warn("Unable to map ARM platform registers\n");
+		return;
+	}
+
+	gpc = readl_relaxed(arm_plat_base + ARM_GPC);
+	gpc |= DBGEN;
+	writel_relaxed(gpc, arm_plat_base + ARM_GPC);
+}
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 07c2e8d..15fba89 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -32,6 +32,8 @@ static void __init imx53_dt_init(void)
 {
 	imx_src_init();
 
+	imx5_pmu_init();
+
 	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
 }
 
-- 
2.7.4
