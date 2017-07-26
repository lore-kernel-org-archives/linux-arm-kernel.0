From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 26 Jul 2017 22:31:38 +0200
Subject: [PATCH] clk: meson: gxbb: add sd_emmc clk0 clocks
Message-ID: <20170726203138.11367-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Input source 0 of the mmc controllers are not the xtal, as currently
described in DT, but  composite clocks (the usual mux, divider and gate).
The muxes can take the crytal (default) and any of the fclk_div clocks
which should provide any rate an mmc/nand could request.

The mux should also be able to take mpll2, mpll3 and gp0_pll but these
are precious clock for other usage. It is better if the mmc does not use
these them. For this reason, mpll2, mpll3 and gp0_pll is not listed among
the possible parent.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.h |  11 +++-
 2 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index a897ea45327c..d466901e88a2 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -974,6 +974,146 @@ static struct clk_mux gxbb_32k_clk_sel = {
 	},
 };
 
+static const char * const gxbb_sd_emmc_clk0_parent_names[] = {
+	"xtal", "fclk_div2", "fclk_div3", "fclk_div5", "fclk_div7",
+
+	/*
+	 * Following these clocks, we should also have had mpll2, mpll3
+	 * and gp0_pll but these clocks are too precious to be used here.
+	 * All the necessary rates for MMC and NAND operation can acheived
+	 * using the xtal and the fclk_div clocks
+	 */
+};
+
+/* SDIO clock */
+static struct clk_mux gxbb_sd_emmc_a_clk0_sel = {
+	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
+	.mask = 0x7,
+	.shift = 9,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_a_clk0_sel",
+		.ops = &clk_mux_ops,
+		.parent_names = gxbb_sd_emmc_clk0_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_sd_emmc_clk0_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_divider gxbb_sd_emmc_a_clk0_div = {
+	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
+	.shift = 0,
+	.width = 7,
+	.lock = &clk_lock,
+	.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_a_clk0_div",
+		.ops = &clk_divider_ops,
+		.parent_names = (const char *[]){ "sd_emmc_a_clk0_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_gate gxbb_sd_emmc_a_clk0 = {
+	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
+	.bit_idx = 7,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "sd_emmc_a_clk0",
+		.ops = &clk_gate_ops,
+		.parent_names = (const char *[]){ "sd_emmc_a_clk0_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* SDcard clock */
+static struct clk_mux gxbb_sd_emmc_b_clk0_sel = {
+	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
+	.mask = 0x7,
+	.shift = 25,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_b_clk0_sel",
+		.ops = &clk_mux_ops,
+		.parent_names = gxbb_sd_emmc_clk0_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_sd_emmc_clk0_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_divider gxbb_sd_emmc_b_clk0_div = {
+	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
+	.shift = 16,
+	.width = 7,
+	.lock = &clk_lock,
+	.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_b_clk0_div",
+		.ops = &clk_divider_ops,
+		.parent_names = (const char *[]){ "sd_emmc_b_clk0_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_gate gxbb_sd_emmc_b_clk0 = {
+	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
+	.bit_idx = 23,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "sd_emmc_b_clk0",
+		.ops = &clk_gate_ops,
+		.parent_names = (const char *[]){ "sd_emmc_b_clk0_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* EMMC/NAND clock */
+static struct clk_mux gxbb_sd_emmc_c_clk0_sel = {
+	.reg = (void *)HHI_NAND_CLK_CNTL,
+	.mask = 0x7,
+	.shift = 9,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_c_clk0_sel",
+		.ops = &clk_mux_ops,
+		.parent_names = gxbb_sd_emmc_clk0_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_sd_emmc_clk0_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_divider gxbb_sd_emmc_c_clk0_div = {
+	.reg = (void *)HHI_NAND_CLK_CNTL,
+	.shift = 0,
+	.width = 7,
+	.lock = &clk_lock,
+	.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_c_clk0_div",
+		.ops = &clk_divider_ops,
+		.parent_names = (const char *[]){ "sd_emmc_c_clk0_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_gate gxbb_sd_emmc_c_clk0 = {
+	.reg = (void *)HHI_NAND_CLK_CNTL,
+	.bit_idx = 7,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "sd_emmc_c_clk0",
+		.ops = &clk_gate_ops,
+		.parent_names = (const char *[]){ "sd_emmc_c_clk0_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 static MESON_GATE(gxbb_ddr, HHI_GCLK_MPEG0, 0);
 static MESON_GATE(gxbb_dos, HHI_GCLK_MPEG0, 1);
@@ -1183,6 +1323,15 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
 		[CLKID_32K_CLK]		    = &gxbb_32k_clk.hw,
 		[CLKID_32K_CLK_SEL]	    = &gxbb_32k_clk_sel.hw,
 		[CLKID_32K_CLK_DIV]	    = &gxbb_32k_clk_div.hw,
+		[CLKID_SD_EMMC_A_CLK0_SEL]  = &gxbb_sd_emmc_a_clk0_sel.hw,
+		[CLKID_SD_EMMC_A_CLK0_DIV]  = &gxbb_sd_emmc_a_clk0_div.hw,
+		[CLKID_SD_EMMC_A_CLK0]	    = &gxbb_sd_emmc_a_clk0.hw,
+		[CLKID_SD_EMMC_B_CLK0_SEL]  = &gxbb_sd_emmc_b_clk0_sel.hw,
+		[CLKID_SD_EMMC_B_CLK0_DIV]  = &gxbb_sd_emmc_b_clk0_div.hw,
+		[CLKID_SD_EMMC_B_CLK0]	    = &gxbb_sd_emmc_b_clk0.hw,
+		[CLKID_SD_EMMC_C_CLK0_SEL]  = &gxbb_sd_emmc_c_clk0_sel.hw,
+		[CLKID_SD_EMMC_C_CLK0_DIV]  = &gxbb_sd_emmc_c_clk0_div.hw,
+		[CLKID_SD_EMMC_C_CLK0]	    = &gxbb_sd_emmc_c_clk0.hw,
 	},
 	.num = NR_CLKS,
 };
@@ -1305,6 +1454,15 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 		[CLKID_32K_CLK]		    = &gxbb_32k_clk.hw,
 		[CLKID_32K_CLK_SEL]	    = &gxbb_32k_clk_sel.hw,
 		[CLKID_32K_CLK_DIV]	    = &gxbb_32k_clk_div.hw,
+		[CLKID_SD_EMMC_A_CLK0_SEL]  = &gxbb_sd_emmc_a_clk0_sel.hw,
+		[CLKID_SD_EMMC_A_CLK0_DIV]  = &gxbb_sd_emmc_a_clk0_div.hw,
+		[CLKID_SD_EMMC_A_CLK0]	    = &gxbb_sd_emmc_a_clk0.hw,
+		[CLKID_SD_EMMC_B_CLK0_SEL]  = &gxbb_sd_emmc_b_clk0_sel.hw,
+		[CLKID_SD_EMMC_B_CLK0_DIV]  = &gxbb_sd_emmc_b_clk0_div.hw,
+		[CLKID_SD_EMMC_B_CLK0]	    = &gxbb_sd_emmc_b_clk0.hw,
+		[CLKID_SD_EMMC_C_CLK0_SEL]  = &gxbb_sd_emmc_c_clk0_sel.hw,
+		[CLKID_SD_EMMC_C_CLK0_DIV]  = &gxbb_sd_emmc_c_clk0_div.hw,
+		[CLKID_SD_EMMC_C_CLK0]	    = &gxbb_sd_emmc_c_clk0.hw,
 	},
 	.num = NR_CLKS,
 };
@@ -1420,6 +1578,9 @@ static struct clk_gate *const gxbb_clk_gates[] = {
 	&gxbb_cts_amclk,
 	&gxbb_cts_mclk_i958,
 	&gxbb_32k_clk,
+	&gxbb_sd_emmc_a_clk0,
+	&gxbb_sd_emmc_b_clk0,
+	&gxbb_sd_emmc_c_clk0,
 };
 
 static struct clk_mux *const gxbb_clk_muxes[] = {
@@ -1432,6 +1593,9 @@ static struct clk_mux *const gxbb_clk_muxes[] = {
 	&gxbb_cts_mclk_i958_sel,
 	&gxbb_cts_i958,
 	&gxbb_32k_clk_sel,
+	&gxbb_sd_emmc_a_clk0_sel,
+	&gxbb_sd_emmc_b_clk0_sel,
+	&gxbb_sd_emmc_c_clk0_sel,
 };
 
 static struct clk_divider *const gxbb_clk_dividers[] = {
@@ -1441,6 +1605,9 @@ static struct clk_divider *const gxbb_clk_dividers[] = {
 	&gxbb_mali_1_div,
 	&gxbb_cts_mclk_i958_div,
 	&gxbb_32k_clk_div,
+	&gxbb_sd_emmc_a_clk0_div,
+	&gxbb_sd_emmc_b_clk0_div,
+	&gxbb_sd_emmc_c_clk0_div,
 };
 
 static struct meson_clk_audio_divider *const gxbb_audio_dividers[] = {
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index d63e77e8433d..17e5629777dc 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -287,8 +287,17 @@
 #define CLKID_32K_CLK		  114
 #define CLKID_32K_CLK_SEL	  115
 #define CLKID_32K_CLK_DIV	  116
+#define CLKID_SD_EMMC_A_CLK0_SEL  117
+#define CLKID_SD_EMMC_A_CLK0_DIV  118
+#define CLKID_SD_EMMC_A_CLK0	  119
+#define CLKID_SD_EMMC_B_CLK0_SEL  120
+#define CLKID_SD_EMMC_B_CLK0_DIV  121
+#define CLKID_SD_EMMC_B_CLK0	  122
+#define CLKID_SD_EMMC_C_CLK0_SEL  123
+#define CLKID_SD_EMMC_C_CLK0_DIV  124
+#define CLKID_SD_EMMC_C_CLK0	  125
 
-#define NR_CLKS			  117
+#define NR_CLKS			  126
 
 /* include the CLKIDs that have been made part of the stable DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
-- 
2.9.4
