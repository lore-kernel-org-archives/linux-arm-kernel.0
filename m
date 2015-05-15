From: jenskuske@gmail.com (Jens Kuske)
Date: Fri, 15 May 2015 18:38:56 +0200
Subject: [PATCH v2 06/10] clk: sunxi: Add H3 clocks support
In-Reply-To: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
References: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
Message-ID: <1431707940-19372-7-git-send-email-jenskuske@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H3 clock control unit is similar to the those of other sun8i family
members like the A23.

It makes use of the new multiple parents option for the bus gates.
Some of the gates use the new AHB2 clock as parent, whose clock source
is muxable between AHB1 and PLL6/2. The documentation isn't totally clear
about which devices belong to AHB2 now, especially USB EHIC/OHIC, so it
is mostly based on Allwinner kernel source code.

Signed-off-by: Jens Kuske <jenskuske@gmail.com>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  6 +++
 drivers/clk/sunxi/clk-sunxi.c                     | 50 ++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 4fa11af..e367963 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -14,6 +14,7 @@ Required properties:
 	"allwinner,sun4i-a10-pll5-clk" - for the PLL5 clock
 	"allwinner,sun4i-a10-pll6-clk" - for the PLL6 clock
 	"allwinner,sun6i-a31-pll6-clk" - for the PLL6 clock on A31
+	"allwinner,sun8i-h3-pll6-clk" - for the PLL6 clock on H3
 	"allwinner,sun9i-a80-gt-clk" - for the GT bus clock on A80
 	"allwinner,sun4i-a10-cpu-clk" - for the CPU multiplexer clock
 	"allwinner,sun4i-a10-axi-clk" - for the AXI clock
@@ -28,6 +29,7 @@ Required properties:
 	"allwinner,sun7i-a20-ahb-gates-clk" - for the AHB gates on A20
 	"allwinner,sun6i-a31-ar100-clk" - for the AR100 on A31
 	"allwinner,sun6i-a31-ahb1-clk" - for the AHB1 clock on A31
+	"allwinner,sun8i-h3-ahb2-clk" - for the AHB2 clock on H3
 	"allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
 	"allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
 	"allwinner,sun9i-a80-ahb0-gates-clk" - for the AHB0 gates on A80
@@ -55,6 +57,7 @@ Required properties:
 	"allwinner,sun9i-a80-apb1-gates-clk" - for the APB1 gates on A80
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
+	"allwinner,sun8i-h3-bus-gates-clk" - for the bus gates on H3
 	"allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
 	"allwinner,sun4i-a10-mmc-clk" - for the MMC clock
 	"allwinner,sun9i-a80-mmc-clk" - for mmc module clocks on A80
@@ -95,6 +98,9 @@ The "allwinner,sun9i-a80-mmc-config-clk" clock also requires:
 For "allwinner,sun7i-a20-gmac-clk", the parent clocks shall be fixed rate
 dummy clocks at 25 MHz and 125 MHz, respectively. See example.
 
+For "allwinner,sun8i-h3-bus-gates-clk", the parent clocks shall be
+AHB1, AHB2, APB1 and APB2, in that order.
+
 Clock consumers should specify the desired clocks they use with a
 "clocks" phandle cell. Consumers that are using a gated clock should
 provide an additional ID in their clock property. This ID is the
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index afe560c..79364be 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -771,6 +771,10 @@ static const struct mux_data sun6i_a31_ahb1_mux_data __initconst = {
 	.shift = 12,
 };
 
+static const struct mux_data sun8i_h3_ahb2_mux_data __initconst = {
+	.shift = 0,
+};
+
 static void __init sunxi_mux_clk_setup(struct device_node *node,
 				       struct mux_data *data)
 {
@@ -886,7 +890,7 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
  * sunxi_gates_clk_setup() - Setup function for leaf gates on clocks
  */
 
-#define SUNXI_GATES_MAX_SIZE	64
+#define SUNXI_GATES_MAX_SIZE	160
 
 struct gates_data {
 	DECLARE_BITMAP(mask, SUNXI_GATES_MAX_SIZE);
@@ -990,6 +994,36 @@ static const struct gates_data sun8i_a23_apb2_gates_data __initconst = {
 	.mask = {0x1F0007},
 };
 
+#define BUS_GATE_PARENT_AHB1	0
+#define BUS_GATE_PARENT_AHB2	1
+#define BUS_GATE_PARENT_APB1	2
+#define BUS_GATE_PARENT_APB2	3
+
+static const u8 sun8i_h3_bus_gates_parents[] __initconst = {
+	BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1,
+	BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1,
+	BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB2, BUS_GATE_PARENT_AHB1,
+	BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1,
+	BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1,
+	BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1,
+	BUS_GATE_PARENT_AHB2, BUS_GATE_PARENT_AHB2, BUS_GATE_PARENT_AHB2,
+	BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1,
+	BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1,
+	BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1,
+	BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_AHB1, BUS_GATE_PARENT_APB1,
+	BUS_GATE_PARENT_APB1, BUS_GATE_PARENT_APB1, BUS_GATE_PARENT_APB1,
+	BUS_GATE_PARENT_APB1, BUS_GATE_PARENT_APB1, BUS_GATE_PARENT_APB1,
+	BUS_GATE_PARENT_APB2, BUS_GATE_PARENT_APB2, BUS_GATE_PARENT_APB2,
+	BUS_GATE_PARENT_APB2, BUS_GATE_PARENT_APB2, BUS_GATE_PARENT_APB2,
+	BUS_GATE_PARENT_APB2, BUS_GATE_PARENT_APB2, BUS_GATE_PARENT_AHB1,
+	BUS_GATE_PARENT_AHB1
+};
+
+static const struct gates_data sun8i_h3_bus_gates_data __initconst = {
+	.mask = {0xffbe6760, 0x00701b39, 0x00007123, 0x001f0007, 0x00000081},
+	.parents = sun8i_h3_bus_gates_parents,
+};
+
 static void __init sunxi_gates_clk_setup(struct device_node *node,
 					 struct gates_data *data)
 {
@@ -1110,6 +1144,16 @@ static const struct divs_data sun6i_a31_pll6_divs_data __initconst = {
 	}
 };
 
+static const struct divs_data sun8i_h3_pll6_divs_data __initconst = {
+	.factors = &sun6i_a31_pll6_data,
+	.ndivs = 3,
+	.div = {
+		{ .fixed = 2 }, /* normal output, pll6 */
+		{ .self = 1 }, /* base factor clock, pll6 x2 */
+		{ .fixed = 4 }, /* divided output, pll6 /2 */
+	}
+};
+
 /**
  * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
  *
@@ -1283,6 +1327,7 @@ static const struct of_device_id clk_divs_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-a10-pll5-clk", .data = &pll5_divs_data,},
 	{.compatible = "allwinner,sun4i-a10-pll6-clk", .data = &pll6_divs_data,},
 	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_divs_data,},
+	{.compatible = "allwinner,sun8i-h3-pll6-clk", .data = &sun8i_h3_pll6_divs_data,},
 	{}
 };
 
@@ -1290,6 +1335,7 @@ static const struct of_device_id clk_divs_match[] __initconst = {
 static const struct of_device_id clk_mux_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-a10-cpu-clk", .data = &sun4i_cpu_mux_data,},
 	{.compatible = "allwinner,sun6i-a31-ahb1-mux-clk", .data = &sun6i_a31_ahb1_mux_data,},
+	{.compatible = "allwinner,sun8i-h3-ahb2-clk", .data = &sun8i_h3_ahb2_mux_data,},
 	{}
 };
 
@@ -1319,6 +1365,7 @@ static const struct of_device_id clk_gates_match[] __initconst = {
 	{.compatible = "allwinner,sun9i-a80-apb1-gates-clk", .data = &sun9i_a80_apb1_gates_data,},
 	{.compatible = "allwinner,sun6i-a31-apb2-gates-clk", .data = &sun6i_a31_apb2_gates_data,},
 	{.compatible = "allwinner,sun8i-a23-apb2-gates-clk", .data = &sun8i_a23_apb2_gates_data,},
+	{.compatible = "allwinner,sun8i-h3-bus-gates-clk", .data = &sun8i_h3_bus_gates_data,},
 	{}
 };
 
@@ -1403,6 +1450,7 @@ static void __init sun6i_init_clocks(struct device_node *node)
 CLK_OF_DECLARE(sun6i_a31_clk_init, "allwinner,sun6i-a31", sun6i_init_clocks);
 CLK_OF_DECLARE(sun6i_a31s_clk_init, "allwinner,sun6i-a31s", sun6i_init_clocks);
 CLK_OF_DECLARE(sun8i_a23_clk_init, "allwinner,sun8i-a23", sun6i_init_clocks);
+CLK_OF_DECLARE(sun8i_h3_clk_init, "allwinner,sun8i-h3", sun6i_init_clocks);
 
 static void __init sun9i_init_clocks(struct device_node *node)
 {
-- 
2.4.0
