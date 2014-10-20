From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Oct 2014 22:10:28 +0800
Subject: [PATCH v2 3/5] clk: sunxi: Add support for bus clock gates on
 Allwinner A80 SoC
In-Reply-To: <1413814230-13735-1-git-send-email-wens@csie.org>
References: <1413814230-13735-1-git-send-email-wens@csie.org>
Message-ID: <1413814230-13735-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the gate clocks for AHB/APB busses on the A80 SoC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  5 ++++
 drivers/clk/sunxi/clk-sunxi.c                     | 31 +++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 7f1c486..0455cb9 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -29,6 +29,9 @@ Required properties:
 	"allwinner,sun6i-a31-ahb1-mux-clk" - for the AHB1 multiplexer on A31
 	"allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
 	"allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
+	"allwinner,sun9i-a80-ahb0-gates-clk" - for the AHB0 gates on A80
+	"allwinner,sun9i-a80-ahb1-gates-clk" - for the AHB1 gates on A80
+	"allwinner,sun9i-a80-ahb2-gates-clk" - for the AHB2 gates on A80
 	"allwinner,sun4i-a10-apb0-clk" - for the APB0 clock
 	"allwinner,sun6i-a31-apb0-clk" - for the APB0 clock on A31
 	"allwinner,sun8i-a23-apb0-clk" - for the APB0 clock on A23
@@ -39,6 +42,7 @@ Required properties:
 	"allwinner,sun6i-a31-apb0-gates-clk" - for the APB0 gates on A31
 	"allwinner,sun7i-a20-apb0-gates-clk" - for the APB0 gates on A20
 	"allwinner,sun8i-a23-apb0-gates-clk" - for the APB0 gates on A23
+	"allwinner,sun9i-a80-apb0-gates-clk" - for the APB0 gates on A80
 	"allwinner,sun4i-a10-apb1-clk" - for the APB1 clock
 	"allwinner,sun9i-a80-apb1-clk" - for the APB1 bus clock on A80
 	"allwinner,sun4i-a10-apb1-mux-clk" - for the APB1 clock muxing
@@ -48,6 +52,7 @@ Required properties:
 	"allwinner,sun6i-a31-apb1-gates-clk" - for the APB1 gates on A31
 	"allwinner,sun7i-a20-apb1-gates-clk" - for the APB1 gates on A20
 	"allwinner,sun8i-a23-apb1-gates-clk" - for the APB1 gates on A23
+	"allwinner,sun9i-a80-apb1-gates-clk" - for the APB1 gates on A80
 	"allwinner,sun6i-a31-apb2-div-clk" - for the APB2 gates on A31
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 636b8d7..20f47c6 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -758,6 +758,18 @@ static const struct gates_data sun8i_a23_ahb1_gates_data __initconst = {
 	.mask = {0x25386742, 0x2505111},
 };
 
+static const struct gates_data sun9i_a80_ahb0_gates_data __initconst = {
+	.mask = {0xF5F12B},
+};
+
+static const struct gates_data sun9i_a80_ahb1_gates_data __initconst = {
+	.mask = {0x1E20003},
+};
+
+static const struct gates_data sun9i_a80_ahb2_gates_data __initconst = {
+	.mask = {0x9B7},
+};
+
 static const struct gates_data sun4i_apb0_gates_data __initconst = {
 	.mask = {0x4EF},
 };
@@ -774,6 +786,10 @@ static const struct gates_data sun7i_a20_apb0_gates_data __initconst = {
 	.mask = { 0x4ff },
 };
 
+static const struct gates_data sun9i_a80_apb0_gates_data __initconst = {
+	.mask = {0xEB822},
+};
+
 static const struct gates_data sun4i_apb1_gates_data __initconst = {
 	.mask = {0xFF00F7},
 };
@@ -802,6 +818,10 @@ static const struct gates_data sun7i_a20_apb1_gates_data __initconst = {
 	.mask = { 0xff80ff },
 };
 
+static const struct gates_data sun9i_a80_apb1_gates_data __initconst = {
+	.mask = {0x3F001F},
+};
+
 static const struct gates_data sun8i_a23_apb2_gates_data __initconst = {
 	.mask = {0x1F0007},
 };
@@ -1103,16 +1123,21 @@ static const struct of_device_id clk_gates_match[] __initconst = {
 	{.compatible = "allwinner,sun6i-a31-ahb1-gates-clk", .data = &sun6i_a31_ahb1_gates_data,},
 	{.compatible = "allwinner,sun7i-a20-ahb-gates-clk", .data = &sun7i_a20_ahb_gates_data,},
 	{.compatible = "allwinner,sun8i-a23-ahb1-gates-clk", .data = &sun8i_a23_ahb1_gates_data,},
+	{.compatible = "allwinner,sun9i-a80-ahb0-gates-clk", .data = &sun9i_a80_ahb0_gates_data,},
+	{.compatible = "allwinner,sun9i-a80-ahb1-gates-clk", .data = &sun9i_a80_ahb1_gates_data,},
+	{.compatible = "allwinner,sun9i-a80-ahb2-gates-clk", .data = &sun9i_a80_ahb2_gates_data,},
 	{.compatible = "allwinner,sun4i-a10-apb0-gates-clk", .data = &sun4i_apb0_gates_data,},
 	{.compatible = "allwinner,sun5i-a10s-apb0-gates-clk", .data = &sun5i_a10s_apb0_gates_data,},
 	{.compatible = "allwinner,sun5i-a13-apb0-gates-clk", .data = &sun5i_a13_apb0_gates_data,},
 	{.compatible = "allwinner,sun7i-a20-apb0-gates-clk", .data = &sun7i_a20_apb0_gates_data,},
+	{.compatible = "allwinner,sun9i-a80-apb0-gates-clk", .data = &sun9i_a80_apb0_gates_data,},
 	{.compatible = "allwinner,sun4i-a10-apb1-gates-clk", .data = &sun4i_apb1_gates_data,},
 	{.compatible = "allwinner,sun5i-a10s-apb1-gates-clk", .data = &sun5i_a10s_apb1_gates_data,},
 	{.compatible = "allwinner,sun5i-a13-apb1-gates-clk", .data = &sun5i_a13_apb1_gates_data,},
 	{.compatible = "allwinner,sun6i-a31-apb1-gates-clk", .data = &sun6i_a31_apb1_gates_data,},
 	{.compatible = "allwinner,sun7i-a20-apb1-gates-clk", .data = &sun7i_a20_apb1_gates_data,},
 	{.compatible = "allwinner,sun8i-a23-apb1-gates-clk", .data = &sun8i_a23_apb1_gates_data,},
+	{.compatible = "allwinner,sun9i-a80-apb1-gates-clk", .data = &sun9i_a80_apb1_gates_data,},
 	{.compatible = "allwinner,sun6i-a31-apb2-gates-clk", .data = &sun6i_a31_apb2_gates_data,},
 	{.compatible = "allwinner,sun8i-a23-apb2-gates-clk", .data = &sun8i_a23_apb2_gates_data,},
 	{.compatible = "allwinner,sun4i-a10-usb-clk", .data = &sun4i_a10_usb_gates_data,},
@@ -1201,3 +1226,9 @@ static void __init sun6i_init_clocks(struct device_node *node)
 }
 CLK_OF_DECLARE(sun6i_a31_clk_init, "allwinner,sun6i-a31", sun6i_init_clocks);
 CLK_OF_DECLARE(sun8i_a23_clk_init, "allwinner,sun8i-a23", sun6i_init_clocks);
+
+static void __init sun9i_init_clocks(struct device_node *node)
+{
+	sunxi_init_clocks(NULL, 0);
+}
+CLK_OF_DECLARE(sun9i_a80_clk_init, "allwinner,sun9i-a80", sun9i_init_clocks);
-- 
2.1.1
