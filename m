From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 12 Feb 2016 17:31:14 +0800
Subject: [PATCH v2 1/2] clk: sunxi: Add support for A80 APBS clock
In-Reply-To: <1455269475-8180-1-git-send-email-wens@csie.org>
References: <1455269475-8180-1-git-send-email-wens@csie.org>
Message-ID: <1455269475-8180-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A80's APBS clock is not the same as the APB0 clock on A23. The A80's
is a zero-based divider, while the A23's is a power-of-two divider.

Replace the CLK_OF_DECLARE version of sun8i-a23-apb0. This also extends
the common setup function to take div clk flags.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 drivers/clk/sunxi/clk-sun8i-apb0.c                | 23 ++++++++---------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 966dcaffcb9c..5206e48694d6 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -60,6 +60,7 @@ Required properties:
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
 	"allwinner,sun8i-a83t-bus-gates-clk" - for the bus gates on A83T
 	"allwinner,sun8i-h3-bus-gates-clk" - for the bus gates on H3
+	"allwinner,sun9i-a80-apbs-clk" - for the APBS clock on A80
 	"allwinner,sun9i-a80-apbs-gates-clk" - for the APBS gates on A80
 	"allwinner,sun4i-a10-dram-gates-clk" - for the DRAM gates on A10
 	"allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
diff --git a/drivers/clk/sunxi/clk-sun8i-apb0.c b/drivers/clk/sunxi/clk-sun8i-apb0.c
index 7ba61103a6f5..cfe9c19a831b 100644
--- a/drivers/clk/sunxi/clk-sun8i-apb0.c
+++ b/drivers/clk/sunxi/clk-sun8i-apb0.c
@@ -21,7 +21,7 @@
 #include <linux/platform_device.h>
 
 static struct clk *sun8i_a23_apb0_register(struct device_node *node,
-					   void __iomem *reg)
+					   void __iomem *reg, u8 div_flags)
 {
 	const char *clk_name = node->name;
 	const char *clk_parent;
@@ -36,7 +36,7 @@ static struct clk *sun8i_a23_apb0_register(struct device_node *node,
 
 	/* The A23 APB0 clock is a standard 2 bit wide divider clock */
 	clk = clk_register_divider(NULL, clk_name, clk_parent, 0, reg,
-				   0, 2, CLK_DIVIDER_POWER_OF_TWO, NULL);
+				   0, 2, div_flags, NULL);
 	if (IS_ERR(clk))
 		return clk;
 
@@ -52,7 +52,7 @@ err_unregister:
 	return ERR_PTR(ret);
 }
 
-static void sun8i_a23_apb0_setup(struct device_node *node)
+static void sun9i_a80_apbs_setup(struct device_node *node)
 {
 	void __iomem *reg;
 	struct resource res;
@@ -60,18 +60,11 @@ static void sun8i_a23_apb0_setup(struct device_node *node)
 
 	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(reg)) {
-		/*
-		 * This happens with clk nodes instantiated through mfd,
-		 * as those do not have their resources assigned in the
-		 * device tree. Do not print an error in this case.
-		 */
-		if (PTR_ERR(reg) != -EINVAL)
-			pr_err("Could not get registers for a23-apb0-clk\n");
-
+		pr_err("Could not get registers for a80-apbs-clk\n");
 		return;
 	}
 
-	clk = sun8i_a23_apb0_register(node, reg);
+	clk = sun8i_a23_apb0_register(node, reg, 0);
 	if (IS_ERR(clk))
 		goto err_unmap;
 
@@ -82,8 +75,8 @@ err_unmap:
 	of_address_to_resource(node, 0, &res);
 	release_mem_region(res.start, resource_size(&res));
 }
-CLK_OF_DECLARE(sun8i_a23_apb0, "allwinner,sun8i-a23-apb0-clk",
-	       sun8i_a23_apb0_setup);
+CLK_OF_DECLARE(sun9i_a80_apbs, "allwinner,sun9i-a80-apbs-clk",
+	       sun9i_a80_apbs_setup);
 
 static int sun8i_a23_apb0_clk_probe(struct platform_device *pdev)
 {
@@ -97,7 +90,7 @@ static int sun8i_a23_apb0_clk_probe(struct platform_device *pdev)
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-	clk = sun8i_a23_apb0_register(np, reg);
+	clk = sun8i_a23_apb0_register(np, reg, CLK_DIVIDER_POWER_OF_TWO);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-- 
2.7.0
