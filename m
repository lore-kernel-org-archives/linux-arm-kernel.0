From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 13 Jan 2015 09:37:24 +0800
Subject: [PATCH v3 02/13] clk: sunxi: Add mod0 and mmc module clock support
 for A80
In-Reply-To: <1421113055-17867-1-git-send-email-wens@csie.org>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
Message-ID: <1421113055-17867-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The module 0 style clocks, or storage module clocks as named in the
official SDK, are almost the same as the module 0 clocks on earlier
Allwinner SoCs. The only difference is wider mux register bits.

As with earlier Allwinner SoCs, mmc module clocks are a special case
of mod0 clocks, with phase controls for 2 child clocks, output and
sample.

This patch adds support for both.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  7 +++--
 drivers/clk/sunxi/clk-mod0.c                      | 32 +++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index e4c42276c577..0dfd018ba47b 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -56,7 +56,9 @@ Required properties:
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
 	"allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
 	"allwinner,sun4i-a10-mmc-clk" - for the MMC clock
+	"allwinner,sun9i-a80-mmc-clk" - for mmc module clocks on A80
 	"allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
+	"allwinner,sun9i-a80-mod0-clk" - for module 0 (storage) clocks on A80
 	"allwinner,sun8i-a23-mbus-clk" - for the MBUS clock on A23
 	"allwinner,sun7i-a20-out-clk" - for the external output clocks
 	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
@@ -72,7 +74,8 @@ Required properties for all clocks:
 - #clock-cells : from common clock binding; shall be set to 0 except for
 	the following compatibles where it shall be set to 1:
 	"allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk",
-	"allwinner,sun4i-pll6-clk", "allwinner,sun6i-a31-pll6-clk"
+	"allwinner,sun4i-pll6-clk", "allwinner,sun6i-a31-pll6-clk",
+	"allwinner,*-usb-clk", "allwinner,*-mmc-clk"
 - clock-output-names : shall be the corresponding names of the outputs.
 	If the clock module only has one output, the name shall be the
 	module name.
@@ -94,7 +97,7 @@ For "allwinner,sun6i-a31-pll6-clk", there are 2 outputs. The first output
 is the normal PLL6 output, or "pll6". The second output is rate doubled
 PLL6, or "pll6x2".
 
-The "allwinner,sun4i-a10-mmc-clk" has three different outputs: the
+The "allwinner,*-mmc-clk" clocks have three different outputs: the
 main clock, with the ID 0, and the output and sample clocks, with the
 IDs 1 and 2, respectively.
 
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index 4430d1398ce6..99ff2c7cccf7 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -130,6 +130,30 @@ static struct platform_driver sun4i_a10_mod0_clk_driver = {
 };
 module_platform_driver(sun4i_a10_mod0_clk_driver);
 
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
@@ -358,3 +382,11 @@ static void __init sun4i_a10_mmc_setup(struct device_node *node)
 	sunxi_mmc_setup(node, &sun4i_a10_mod0_data, &sun4i_a10_mmc_lock);
 }
 CLK_OF_DECLARE(sun4i_a10_mmc, "allwinner,sun4i-a10-mmc-clk", sun4i_a10_mmc_setup);
+
+static DEFINE_SPINLOCK(sun9i_a80_mmc_lock);
+
+static void __init sun9i_a80_mmc_setup(struct device_node *node)
+{
+	sunxi_mmc_setup(node, &sun9i_a80_mod0_data, &sun9i_a80_mmc_lock);
+}
+CLK_OF_DECLARE(sun9i_a80_mmc, "allwinner,sun9i-a80-mmc-clk", sun9i_a80_mmc_setup);
-- 
2.1.4
