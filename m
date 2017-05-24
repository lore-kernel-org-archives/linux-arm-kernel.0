From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 24 May 2017 11:43:45 +0200
Subject: [PATCH] clk: meson-gxbb: Add EE 32K Clock for CEC
Message-ID: <1495619025-1958-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Amlogic GX SoCs, there is two CEC controllers :
- An Amlogic CEC custom in the AO domain
- The Synopsys HDMI-TX Controller in the EE domain

Each of these controllers needs a 32.768KHz clock, but there is two paths :
- In the EE domain, the "32k_clk" this patchs is adding
- In the AO domain, with a more complex dual divider more precise setup

The AO 32K clock support will be pushed later in the corresponding
gxbb-aoclk driver when the AE CEC driver is ready.

The EE 32k_clk must be pushed earlier since mainline support for CEC in the
Synopsys HDMI-TX controller is nearby.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.h |  5 ++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index ad5f027..4b7d85a 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -951,6 +951,51 @@ struct pll_params_table gxl_gp0_params_table[] = {
 	},
 };
 
+static struct clk_divider gxbb_32k_clk_div = {
+	.reg = (void *)HHI_32K_CLK_CNTL,
+	.shift = 0,
+	.width = 14,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "32k_clk_div",
+		.ops = &clk_divider_ops,
+		.parent_names = (const char *[]){ "32k_clk_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_DIVIDER_ROUND_CLOSEST,
+	},
+};
+
+static struct clk_gate gxbb_32k_clk = {
+	.reg = (void *)HHI_32K_CLK_CNTL,
+	.bit_idx = 15,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "32k_clk",
+		.ops = &clk_gate_ops,
+		.parent_names = (const char *[]){ "32k_clk_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const char *gxbb_32k_clk_parent_names[] = {
+	"xtal", "cts_slow_oscin", "fclk_div3", "fclk_div5"
+};
+
+static struct clk_mux gxbb_32k_clk_sel = {
+	.reg = (void *)HHI_32K_CLK_CNTL,
+	.mask = 0x3,
+	.shift = 16,
+	.lock = &clk_lock,
+		.hw.init = &(struct clk_init_data){
+		.name = "32k_clk_sel",
+		.ops = &clk_mux_ops,
+		.parent_names = gxbb_32k_clk_parent_names,
+		.num_parents = 4,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 static MESON_GATE(gxbb_ddr, HHI_GCLK_MPEG0, 0);
 static MESON_GATE(gxbb_dos, HHI_GCLK_MPEG0, 1);
@@ -1158,6 +1203,9 @@ struct pll_params_table gxl_gp0_params_table[] = {
 		[CLKID_CTS_MCLK_I958_SEL]   = &gxbb_cts_mclk_i958_sel.hw,
 		[CLKID_CTS_MCLK_I958_DIV]   = &gxbb_cts_mclk_i958_div.hw,
 		[CLKID_CTS_I958]	    = &gxbb_cts_i958.hw,
+		[CLKID_32K_CLK]		    = &gxbb_32k_clk.hw,
+		[CLKID_32K_CLK_SEL]	    = &gxbb_32k_clk_sel.hw,
+		[CLKID_32K_CLK_DIV]	    = &gxbb_32k_clk_div.hw,
 	},
 	.num = NR_CLKS,
 };
@@ -1278,6 +1326,9 @@ struct pll_params_table gxl_gp0_params_table[] = {
 		[CLKID_CTS_MCLK_I958_SEL]   = &gxbb_cts_mclk_i958_sel.hw,
 		[CLKID_CTS_MCLK_I958_DIV]   = &gxbb_cts_mclk_i958_div.hw,
 		[CLKID_CTS_I958]	    = &gxbb_cts_i958.hw,
+		[CLKID_32K_CLK]		    = &gxbb_32k_clk.hw,
+		[CLKID_32K_CLK_SEL]	    = &gxbb_32k_clk_sel.hw,
+		[CLKID_32K_CLK_DIV]	    = &gxbb_32k_clk_div.hw,
 	},
 	.num = NR_CLKS,
 };
@@ -1392,6 +1443,7 @@ struct pll_params_table gxl_gp0_params_table[] = {
 	&gxbb_mali_1,
 	&gxbb_cts_amclk,
 	&gxbb_cts_mclk_i958,
+	&gxbb_32k_clk,
 };
 
 static struct clk_mux *const gxbb_clk_muxes[] = {
@@ -1403,6 +1455,7 @@ struct pll_params_table gxl_gp0_params_table[] = {
 	&gxbb_cts_amclk_sel,
 	&gxbb_cts_mclk_i958_sel,
 	&gxbb_cts_i958,
+	&gxbb_32k_clk_sel,
 };
 
 static struct clk_divider *const gxbb_clk_dividers[] = {
@@ -1411,6 +1464,7 @@ struct pll_params_table gxl_gp0_params_table[] = {
 	&gxbb_mali_0_div,
 	&gxbb_mali_1_div,
 	&gxbb_cts_mclk_i958_div,
+	&gxbb_32k_clk_div,
 };
 
 static struct meson_clk_audio_divider *const gxbb_audio_dividers[] = {
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 93b8f07..de5fad0 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -284,8 +284,11 @@
 #define CLKID_CTS_MCLK_I958_SEL	  111
 #define CLKID_CTS_MCLK_I958_DIV	  112
 #define CLKID_CTS_I958		  113
+#define CLKID_32K_CLK		  114
+#define CLKID_32K_CLK_SEL	  115
+#define CLKID_32K_CLK_DIV	  116
 
-#define NR_CLKS			  114
+#define NR_CLKS			  117
 
 /* include the CLKIDs that have been made part of the stable DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
-- 
1.9.1
