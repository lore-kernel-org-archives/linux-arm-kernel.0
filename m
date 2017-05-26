From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 26 May 2017 16:00:24 +0800
Subject: [PATCH 2/3] clk: sunxi-ng: a83t: Add support for A83T's PRCM
In-Reply-To: <20170526080025.28532-1-wens@csie.org>
References: <20170526080025.28532-1-wens@csie.org>
Message-ID: <20170526080025.28532-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T's PRCM has the same set of clocks and resets as the A64.
However, a few dividers are different. And due to the lack of a low
speed 32.768 kHz oscillator, a few of the clock parents are different.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r.c | 107 +++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index de02be75785c..e54816ec1dbe 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -27,6 +27,8 @@
 
 static const char * const ar100_parents[] = { "osc32k", "osc24M",
 					     "pll-periph0", "iosc" };
+static const char * const a83t_ar100_parents[] = { "osc16M-d512", "osc24M",
+						   "pll-periph0", "iosc" };
 static const struct ccu_mux_var_prediv ar100_predivs[] = {
 	{ .index = 2, .shift = 8, .width = 5 },
 };
@@ -52,6 +54,27 @@ static struct ccu_div ar100_clk = {
 	},
 };
 
+static struct ccu_div a83t_ar100_clk = {
+	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
+
+	.mux		= {
+		.shift	= 16,
+		.width	= 2,
+
+		.var_predivs	= ar100_predivs,
+		.n_var_predivs	= ARRAY_SIZE(ar100_predivs),
+	},
+
+	.common		= {
+		.reg		= 0x00,
+		.features	= CCU_FEATURE_VARIABLE_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS("ar100",
+						      a83t_ar100_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
 static CLK_FIXED_FACTOR(ahb0_clk, "ahb0", "ar100", 1, 1, 0);
 
 static struct ccu_div apb0_clk = {
@@ -66,6 +89,8 @@ static struct ccu_div apb0_clk = {
 	},
 };
 
+static SUNXI_CCU_M(a83t_apb0_clk, "apb0", "ahb0", 0x0c, 0, 2, 0);
+
 static SUNXI_CCU_GATE(apb0_pio_clk,	"apb0-pio",	"apb0",
 		      0x28, BIT(0), 0);
 static SUNXI_CCU_GATE(apb0_ir_clk,	"apb0-ir",	"apb0",
@@ -90,6 +115,46 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(ir_clk, "ir",
 				  BIT(31),	/* gate */
 				  0);
 
+static const char *const a83t_r_mod0_parents[] = { "osc16M", "osc24M" };
+static const struct ccu_mux_fixed_prediv a83t_ir_predivs[] = {
+	{ .index = 0, .div = 16 },
+};
+static struct ccu_mp a83t_ir_clk = {
+	.enable	= BIT(31),
+
+	.m	= _SUNXI_CCU_DIV(0, 4),
+	.p	= _SUNXI_CCU_DIV(16, 2),
+
+	.mux	= {
+		.shift	= 24,
+		.width	= 2,
+		.fixed_predivs	= a83t_ir_predivs,
+		.n_predivs	= ARRAY_SIZE(a83t_ir_predivs),
+	},
+
+	.common		= {
+		.reg		= 0x54,
+		.features	= CCU_FEATURE_VARIABLE_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS("ir",
+						      a83t_r_mod0_parents,
+						      &ccu_mp_ops,
+						      0),
+	},
+};
+
+static struct ccu_common *sun8i_a83t_r_ccu_clks[] = {
+	&a83t_ar100_clk.common,
+	&a83t_apb0_clk.common,
+	&apb0_pio_clk.common,
+	&apb0_ir_clk.common,
+	&apb0_timer_clk.common,
+	&apb0_rsb_clk.common,
+	&apb0_uart_clk.common,
+	&apb0_i2c_clk.common,
+	&apb0_twd_clk.common,
+	&a83t_ir_clk.common,
+};
+
 static struct ccu_common *sun8i_h3_r_ccu_clks[] = {
 	&ar100_clk.common,
 	&apb0_clk.common,
@@ -115,6 +180,23 @@ static struct ccu_common *sun50i_a64_r_ccu_clks[] = {
 	&ir_clk.common,
 };
 
+static struct clk_hw_onecell_data sun8i_a83t_r_hw_clks = {
+	.hws	= {
+		[CLK_AR100]		= &a83t_ar100_clk.common.hw,
+		[CLK_AHB0]		= &ahb0_clk.hw,
+		[CLK_APB0]		= &a83t_apb0_clk.common.hw,
+		[CLK_APB0_PIO]		= &apb0_pio_clk.common.hw,
+		[CLK_APB0_IR]		= &apb0_ir_clk.common.hw,
+		[CLK_APB0_TIMER]	= &apb0_timer_clk.common.hw,
+		[CLK_APB0_RSB]		= &apb0_rsb_clk.common.hw,
+		[CLK_APB0_UART]		= &apb0_uart_clk.common.hw,
+		[CLK_APB0_I2C]		= &apb0_i2c_clk.common.hw,
+		[CLK_APB0_TWD]		= &apb0_twd_clk.common.hw,
+		[CLK_IR]		= &a83t_ir_clk.common.hw,
+	},
+	.num	= CLK_NUMBER,
+};
+
 static struct clk_hw_onecell_data sun8i_h3_r_hw_clks = {
 	.hws	= {
 		[CLK_AR100]		= &ar100_clk.common.hw,
@@ -148,6 +230,14 @@ static struct clk_hw_onecell_data sun50i_a64_r_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
+static struct ccu_reset_map sun8i_a83t_r_ccu_resets[] = {
+	[RST_APB0_IR]		=  { 0xb0, BIT(1) },
+	[RST_APB0_TIMER]	=  { 0xb0, BIT(2) },
+	[RST_APB0_RSB]		=  { 0xb0, BIT(3) },
+	[RST_APB0_UART]		=  { 0xb0, BIT(4) },
+	[RST_APB0_I2C]		=  { 0xb0, BIT(6) },
+};
+
 static struct ccu_reset_map sun8i_h3_r_ccu_resets[] = {
 	[RST_APB0_IR]		=  { 0xb0, BIT(1) },
 	[RST_APB0_TIMER]	=  { 0xb0, BIT(2) },
@@ -163,6 +253,16 @@ static struct ccu_reset_map sun50i_a64_r_ccu_resets[] = {
 	[RST_APB0_I2C]		=  { 0xb0, BIT(6) },
 };
 
+static const struct sunxi_ccu_desc sun8i_a83t_r_ccu_desc = {
+	.ccu_clks	= sun8i_a83t_r_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_a83t_r_ccu_clks),
+
+	.hw_clks	= &sun8i_a83t_r_hw_clks,
+
+	.resets		= sun8i_a83t_r_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun8i_a83t_r_ccu_resets),
+};
+
 static const struct sunxi_ccu_desc sun8i_h3_r_ccu_desc = {
 	.ccu_clks	= sun8i_h3_r_ccu_clks,
 	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_r_ccu_clks),
@@ -198,6 +298,13 @@ static void __init sunxi_r_ccu_init(struct device_node *node,
 	sunxi_ccu_probe(node, reg, desc);
 }
 
+static void __init sun8i_a83t_r_ccu_setup(struct device_node *node)
+{
+	sunxi_r_ccu_init(node, &sun8i_a83t_r_ccu_desc);
+}
+CLK_OF_DECLARE(sun8i_a83t_r_ccu, "allwinner,sun8i-a83t-r-ccu",
+	       sun8i_a83t_r_ccu_setup);
+
 static void __init sun8i_h3_r_ccu_setup(struct device_node *node)
 {
 	sunxi_r_ccu_init(node, &sun8i_h3_r_ccu_desc);
-- 
2.11.0
