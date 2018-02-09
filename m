From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Fri,  9 Feb 2018 18:03:57 +0100
Subject: [PATCHv3 1/2] ARM: imx53: add secure-reg-access support for PMU
In-Reply-To: <20180209170358.7227-1-sebastian.reichel@collabora.co.uk>
References: <20180209170358.7227-1-sebastian.reichel@collabora.co.uk>
Message-ID: <20180209170358.7227-2-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX53 it is necessary to set the DBG_EN bit in the
platform GPC register to enable access to PMU counters
other than the cycle counter.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/mach-imx/mach-imx53.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 07c2e8dca494..661777ee1cc4 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -28,10 +28,49 @@ static void __init imx53_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX53);
 }
 
+#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004
+#define GPC_DBG_EN BIT(16)
+
+/*
+ * This enables the DBGEN bit in ARM_GPC register, which is
+ * required for accessing some performance counter features.
+ * Technically it is only required while perf is used, but to
+ * keep the source code simple we just enable it all the time
+ * when the kernel configuration allows using the feature.
+ */
+static void imx53_pmu_init(void)
+{
+	void __iomem *gpc_reg;
+	struct device_node *node;
+	u32 gpc;
+
+	if (!IS_ENABLED(CONFIG_ARM_PMU))
+		return;
+
+	node = of_find_compatible_node(NULL, NULL, "arm,cortex-a8-pmu");
+	if (!node)
+		return;
+
+	if (!of_property_read_bool(node, "secure-reg-access"))
+		return;
+
+	gpc_reg = ioremap(MXC_CORTEXA8_PLAT_GPC, 4);
+	if (!gpc_reg) {
+		pr_warning("unable to map GPC to enable perf\n");
+		return;
+	}
+
+	gpc = __raw_readl(gpc_reg);
+	gpc |= GPC_DBG_EN;
+	__raw_writel(gpc, gpc_reg);
+
+	return;
+}
+
 static void __init imx53_dt_init(void)
 {
 	imx_src_init();
-
+	imx53_pmu_init();
 	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
 }
 
-- 
2.15.1
