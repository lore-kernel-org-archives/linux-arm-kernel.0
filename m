From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 Dec 2014 14:35:56 +0800
Subject: [PATCH 01/10] clk: sunxi: Add module 0 (storage) style clock support
 for A80
In-Reply-To: <1417588565-26215-1-git-send-email-wens@csie.org>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
Message-ID: <1417588565-26215-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The module 0 style clocks, or storage module clocks as named in the
official SDK, are almost the same as the module 0 clocks on earlier
Allwinner SoCs. The only difference is wider mux register bits.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 drivers/clk/sunxi/clk-mod0.c                      | 24 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 9dc4f55..d0fb9c5 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -58,6 +58,7 @@ Required properties:
 	"allwinner,sun4i-a10-mmc-output-clk" - for the MMC output clock on A10
 	"allwinner,sun4i-a10-mmc-sample-clk" - for the MMC sample clock on A10
 	"allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
+	"allwinner,sun9i-a80-mod0-clk" - for module 0 (storage) clocks on A80
 	"allwinner,sun8i-a23-mbus-clk" - for the MBUS clock on A23
 	"allwinner,sun7i-a20-out-clk" - for the external output clocks
 	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index 658d74f..d72063f 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -93,6 +93,30 @@ static void __init sun4i_a10_mod0_setup(struct device_node *node)
 }
 CLK_OF_DECLARE(sun4i_a10_mod0, "allwinner,sun4i-a10-mod0-clk", sun4i_a10_mod0_setup);
 
+static const struct factors_data sun9i_a80_mod0_data __initconst = {
+	.enable = 31,
+	.mux = 24,
+	.muxmask = BIT(3) | BIT(2) | BIT(1) | BIT(0),
+	.table = &sun4i_a10_mod0_config,
+	.getter = sun4i_a10_get_mod0_factors,
+};
+
+static void __init sun9i_a80_mod0_setup(struct device_node *node)
+{
+	void __iomem *reg;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (!reg) {
+		pr_err("Could not get registers for mod0-clk: %s\n",
+		       node->name);
+		return;
+	}
+
+	sunxi_factors_register(node, &sun9i_a80_mod0_data,
+			       &sun4i_a10_mod0_lock, reg);
+}
+CLK_OF_DECLARE(sun9i_a80_mod0, "allwinner,sun9i-a80-mod0-clk", sun9i_a80_mod0_setup);
+
 static DEFINE_SPINLOCK(sun5i_a13_mbus_lock);
 
 static void __init sun5i_a13_mbus_setup(struct device_node *node)
-- 
2.1.3
