From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 27 Nov 2014 17:29:30 +0800
Subject: [PATCH] clk: sunxi: Fix factor clocks usage for sun9i core clocks
Message-ID: <1417080570-5099-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi factor clocks usage was changed in

    clk: sunxi: Give sunxi_factors_register a registers parameter

However the sun9i core clocks were not fixed up in that patch,
resulting in breakage. This patch fixes that.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>
---

This patch is for 3.20.

A bit of boiler plate code for each clock provider.
Maybe we should add a local helper or something?

---
 drivers/clk/sunxi/clk-sun9i-core.c | 62 ++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
index 3cb9036..9b5e7a1 100644
--- a/drivers/clk/sunxi/clk-sun9i-core.c
+++ b/drivers/clk/sunxi/clk-sun9i-core.c
@@ -89,7 +89,17 @@ static DEFINE_SPINLOCK(sun9i_a80_pll4_lock);
 
 static void __init sun9i_a80_pll4_setup(struct device_node *node)
 {
-	sunxi_factors_register(node, &sun9i_a80_pll4_data, &sun9i_a80_pll4_lock);
+	void __iomem *reg;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (!reg) {
+		pr_err("Could not get registers for a80-pll4-clk: %s\n",
+		       node->name);
+		return;
+	}
+
+	sunxi_factors_register(node, &sun9i_a80_pll4_data,
+			       &sun9i_a80_pll4_lock, reg);
 }
 CLK_OF_DECLARE(sun9i_a80_pll4, "allwinner,sun9i-a80-pll4-clk", sun9i_a80_pll4_setup);
 
@@ -139,8 +149,18 @@ static DEFINE_SPINLOCK(sun9i_a80_gt_lock);
 
 static void __init sun9i_a80_gt_setup(struct device_node *node)
 {
-	struct clk *gt = sunxi_factors_register(node, &sun9i_a80_gt_data,
-						&sun9i_a80_gt_lock);
+	void __iomem *reg;
+	struct clk *gt;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (!reg) {
+		pr_err("Could not get registers for a80-gt-clk: %s\n",
+		       node->name);
+		return;
+	}
+
+	gt = sunxi_factors_register(node, &sun9i_a80_gt_data,
+				    &sun9i_a80_gt_lock, reg);
 
 	/* The GT bus clock needs to be always enabled */
 	__clk_get(gt);
@@ -194,7 +214,17 @@ static DEFINE_SPINLOCK(sun9i_a80_ahb_lock);
 
 static void __init sun9i_a80_ahb_setup(struct device_node *node)
 {
-	sunxi_factors_register(node, &sun9i_a80_ahb_data, &sun9i_a80_ahb_lock);
+	void __iomem *reg;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (!reg) {
+		pr_err("Could not get registers for a80-ahb-clk: %s\n",
+		       node->name);
+		return;
+	}
+
+	sunxi_factors_register(node, &sun9i_a80_ahb_data,
+			       &sun9i_a80_ahb_lock, reg);
 }
 CLK_OF_DECLARE(sun9i_a80_ahb, "allwinner,sun9i-a80-ahb-clk", sun9i_a80_ahb_setup);
 
@@ -210,7 +240,17 @@ static DEFINE_SPINLOCK(sun9i_a80_apb0_lock);
 
 static void __init sun9i_a80_apb0_setup(struct device_node *node)
 {
-	sunxi_factors_register(node, &sun9i_a80_apb0_data, &sun9i_a80_apb0_lock);
+	void __iomem *reg;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (!reg) {
+		pr_err("Could not get registers for a80-apb0-clk: %s\n",
+		       node->name);
+		return;
+	}
+
+	sunxi_factors_register(node, &sun9i_a80_apb0_data,
+			       &sun9i_a80_apb0_lock, reg);
 }
 CLK_OF_DECLARE(sun9i_a80_apb0, "allwinner,sun9i-a80-apb0-clk", sun9i_a80_apb0_setup);
 
@@ -266,6 +306,16 @@ static DEFINE_SPINLOCK(sun9i_a80_apb1_lock);
 
 static void __init sun9i_a80_apb1_setup(struct device_node *node)
 {
-	sunxi_factors_register(node, &sun9i_a80_apb1_data, &sun9i_a80_apb1_lock);
+	void __iomem *reg;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (!reg) {
+		pr_err("Could not get registers for a80-apb1-clk: %s\n",
+		       node->name);
+		return;
+	}
+
+	sunxi_factors_register(node, &sun9i_a80_apb1_data,
+			       &sun9i_a80_apb1_lock, reg);
 }
 CLK_OF_DECLARE(sun9i_a80_apb1, "allwinner,sun9i-a80-apb1-clk", sun9i_a80_apb1_setup);
-- 
2.1.3
