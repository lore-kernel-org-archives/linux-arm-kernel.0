From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  3 Apr 2018 08:18:33 +0200
Subject: [PATCH v5 10/13] ARM: sun9i: smp: Move structures
In-Reply-To: <20180403061836.3926-1-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
Message-ID: <20180403061836.3926-11-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare the support for sun8i-a83t, move some structures
at the beginning of the file.

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/mc_smp.c | 48 +++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 03f021d0c73e..0a7252df207f 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -72,9 +72,34 @@ static void __iomem *cpucfg_base;
 static void __iomem *prcm_base;
 static void __iomem *sram_b_smp_base;
 
+/*
+ * This holds any device nodes that we requested resources for,
+ * so that we may easily release resources in the error path.
+ */
+struct sunxi_mc_smp_nodes {
+	struct device_node *prcm_node;
+	struct device_node *cpucfg_node;
+	struct device_node *sram_node;
+};
+
+/* This structure holds SoC-specific bits tied to an enable-method string. */
+struct sunxi_mc_smp_data {
+	const char *enable_method;
+	int (*get_smp_nodes)(struct sunxi_mc_smp_nodes *nodes);
+};
+
 extern void sunxi_mc_smp_secondary_startup(void);
 extern void sunxi_mc_smp_resume(void);
 
+static int __init sun9i_a80_get_smp_nodes(struct sunxi_mc_smp_nodes *nodes);
+
+static const struct sunxi_mc_smp_data sunxi_mc_smp_data[] __initconst = {
+	{
+		.enable_method	= "allwinner,sun9i-a80-smp",
+		.get_smp_nodes	= sun9i_a80_get_smp_nodes,
+	},
+};
+
 static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
 {
 	struct device_node *node;
@@ -610,22 +635,6 @@ static int __init sunxi_mc_smp_loopback(void)
 	return ret;
 }
 
-/*
- * This holds any device nodes that we requested resources for,
- * so that we may easily release resources in the error path.
- */
-struct sunxi_mc_smp_nodes {
-	struct device_node *prcm_node;
-	struct device_node *cpucfg_node;
-	struct device_node *sram_node;
-};
-
-/* This structure holds SoC-specific bits tied to an enable-method string. */
-struct sunxi_mc_smp_data {
-	const char *enable_method;
-	int (*get_smp_nodes)(struct sunxi_mc_smp_nodes *nodes);
-};
-
 static void __init sunxi_mc_smp_put_nodes(struct sunxi_mc_smp_nodes *nodes)
 {
 	of_node_put(nodes->prcm_node);
@@ -660,13 +669,6 @@ static int __init sun9i_a80_get_smp_nodes(struct sunxi_mc_smp_nodes *nodes)
 	return 0;
 }
 
-static const struct sunxi_mc_smp_data sunxi_mc_smp_data[] __initconst = {
-	{
-		.enable_method	= "allwinner,sun9i-a80-smp",
-		.get_smp_nodes	= sun9i_a80_get_smp_nodes,
-	},
-};
-
 static int __init sunxi_mc_smp_init(void)
 {
 	struct sunxi_mc_smp_nodes nodes = { 0 };
-- 
2.11.0
