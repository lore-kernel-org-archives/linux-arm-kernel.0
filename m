From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  1 Mar 2017 11:46:03 +0100
Subject: [PATCH v2 2/3] clk: meson-gxbb: Add MALI clocks
In-Reply-To: <1488365164-22861-1-git-send-email-narmstrong@baylibre.com>
References: <1488365164-22861-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1488365164-22861-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Mali is clocked by two identical clock paths behind a glitch free mux
to safely change frequency while running.

The two "mali_0" and "mali_1" clocks are composed of a mux, divider and gate.
Expose these two clocks trees using generic clocks.
Finally the glitch free mux is added as "mali" clock.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index a52063f..31f6090 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -634,6 +634,131 @@
 	},
 };
 
+/*
+ * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
+ * muxed by a glitch-free switch.
+ */
+
+static u32 mux_table_mali_0_1[] = {0, 1, 2, 3, 4, 5, 6, 7};
+const char *gxbb_mali_0_1_parent_names[] = {
+	"xtal", "gp0_pll", "mpll2", "mpll1", "fclk_div7",
+	"fclk_div4", "fclk_div3", "fclk_div5"
+};
+
+static struct clk_mux gxbb_mali_0_sel = {
+	.reg = (void *)HHI_MALI_CLK_CNTL,
+	.mask = 0x7,
+	.shift = 9,
+	.table = mux_table_mali_0_1,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_0_sel",
+		.ops = &clk_mux_ops,
+		/*
+		 * bits 10:9 selects from 8 possible parents:
+		 * xtal, gp0_pll, mpll2, mpll1, fclk_div7,
+		 * fclk_div4, fclk_div3, fclk_div5
+		 */
+		.parent_names = gxbb_mali_0_1_parent_names,
+		.num_parents = 8,
+		.flags = (CLK_SET_RATE_NO_REPARENT | CLK_IGNORE_UNUSED),
+	},
+};
+
+static struct clk_divider gxbb_mali_0_div = {
+	.reg = (void *)HHI_MALI_CLK_CNTL,
+	.shift = 0,
+	.width = 7,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_0_div",
+		.ops = &clk_divider_ops,
+		.parent_names = (const char *[]){ "mali_0_sel" },
+		.num_parents = 1,
+		.flags = (CLK_SET_RATE_NO_REPARENT | CLK_IGNORE_UNUSED),
+	},
+};
+
+static struct clk_gate gxbb_mali_0 = {
+	.reg = (void *)HHI_MALI_CLK_CNTL,
+	.bit_idx = 8,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_0",
+		.ops = &clk_gate_ops,
+		.parent_names = (const char *[]){ "mali_0_div" },
+		.num_parents = 1,
+		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),
+	},
+};
+
+static struct clk_mux gxbb_mali_1_sel = {
+	.reg = (void *)HHI_MALI_CLK_CNTL,
+	.mask = 0x7,
+	.shift = 25,
+	.table = mux_table_mali_0_1,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_1_sel",
+		.ops = &clk_mux_ops,
+		/*
+		 * bits 10:9 selects from 8 possible parents:
+		 * xtal, gp0_pll, mpll2, mpll1, fclk_div7,
+		 * fclk_div4, fclk_div3, fclk_div5
+		 */
+		.parent_names = gxbb_mali_0_1_parent_names,
+		.num_parents = 8,
+		.flags = (CLK_SET_RATE_NO_REPARENT | CLK_IGNORE_UNUSED),
+	},
+};
+
+static struct clk_divider gxbb_mali_1_div = {
+	.reg = (void *)HHI_MALI_CLK_CNTL,
+	.shift = 16,
+	.width = 7,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_1_div",
+		.ops = &clk_divider_ops,
+		.parent_names = (const char *[]){ "mali_1_sel" },
+		.num_parents = 1,
+		.flags = (CLK_SET_RATE_NO_REPARENT | CLK_IGNORE_UNUSED),
+	},
+};
+
+static struct clk_gate gxbb_mali_1 = {
+	.reg = (void *)HHI_MALI_CLK_CNTL,
+	.bit_idx = 24,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_1",
+		.ops = &clk_gate_ops,
+		.parent_names = (const char *[]){ "mali_1_div" },
+		.num_parents = 1,
+		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),
+	},
+};
+
+static u32 mux_table_mali[] = {0, 1};
+const char *gxbb_mali_parent_names[] = {
+	"mali_0", "mali_1"
+};
+
+static struct clk_mux gxbb_mali = {
+	.reg = (void *)HHI_MALI_CLK_CNTL,
+	.mask = 1,
+	.shift = 31,
+	.table = mux_table_mali,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mali",
+		.ops = &clk_mux_ops,
+		.parent_names = gxbb_mali_parent_names,
+		.num_parents = 2,
+		.flags = (CLK_SET_RATE_NO_REPARENT | CLK_IGNORE_UNUSED),
+	},
+};
+
 /* Everything Else (EE) domain gates */
 static MESON_GATE(gxbb_ddr, HHI_GCLK_MPEG0, 0);
 static MESON_GATE(gxbb_dos, HHI_GCLK_MPEG0, 1);
@@ -827,6 +952,13 @@
 		[CLKID_SAR_ADC_CLK]	    = &gxbb_sar_adc_clk.hw,
 		[CLKID_SAR_ADC_SEL]	    = &gxbb_sar_adc_clk_sel.hw,
 		[CLKID_SAR_ADC_DIV]	    = &gxbb_sar_adc_clk_div.hw,
+		[CLKID_MALI_0_SEL]	    = &gxbb_mali_0_sel.hw,
+		[CLKID_MALI_0_DIV]	    = &gxbb_mali_0_div.hw,
+		[CLKID_MALI_0]		    = &gxbb_mali_0.hw,
+		[CLKID_MALI_1_SEL]	    = &gxbb_mali_1_sel.hw,
+		[CLKID_MALI_1_DIV]	    = &gxbb_mali_1_div.hw,
+		[CLKID_MALI_1]		    = &gxbb_mali_1.hw,
+		[CLKID_MALI]		    = &gxbb_mali.hw,
 	},
 	.num = NR_CLKS,
 };
@@ -930,16 +1062,23 @@
 	&gxbb_emmc_b,
 	&gxbb_emmc_c,
 	&gxbb_sar_adc_clk,
+	&gxbb_mali_0,
+	&gxbb_mali_1,
 };
 
 static struct clk_mux *gxbb_clk_muxes[] = {
 	&gxbb_mpeg_clk_sel,
 	&gxbb_sar_adc_clk_sel,
+	&gxbb_mali_0_sel,
+	&gxbb_mali_1_sel,
+	&gxbb_mali,
 };
 
 static struct clk_divider *gxbb_clk_dividers[] = {
 	&gxbb_mpeg_clk_div,
 	&gxbb_sar_adc_clk_div,
+	&gxbb_mali_0_div,
+	&gxbb_mali_1_div,
 };
 
 static int gxbb_clkc_probe(struct platform_device *pdev)
-- 
1.9.1
