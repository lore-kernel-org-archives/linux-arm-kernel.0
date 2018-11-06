From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  6 Nov 2018 15:57:35 +0100
Subject: [PATCH v2 2/4] clk: meson-gxbb: Fix HDMI PLL for GXL SoCs
In-Reply-To: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1541516257-16157-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In an attempt to better describe the HDMI PLL, a single DCO clock was
left for GXBB and GXL, but the GXL DCO does not have a pre-multiplier.

This patch adds back a GXL specific HDMI PLL DCO with xtal as parent.

Fixes: 87173557d2f6 ("clk: meson: clk-pll: remove od parameters")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 9309cfa..0fd354b 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -199,6 +199,52 @@ static struct clk_regmap gxbb_hdmi_pll_dco = {
 	},
 };
 
+static struct clk_regmap gxl_hdmi_pll_dco = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = HHI_HDMI_PLL_CNTL2,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.l = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 28,
+			.width   = 1,
+		},
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_pll_dco",
+		.ops = &meson_clk_pll_ro_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+		/*
+		 * Display directly handle hdmi pll registers ATM, we need
+		 * NOCACHE to keep our view of the clock as accurate as possible
+		 */
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
 static struct clk_regmap gxbb_hdmi_pll_od = {
 	.data = &(struct clk_regmap_div_data){
 		.offset = HHI_HDMI_PLL_CNTL2,
@@ -2089,7 +2135,7 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 		[CLKID_GEN_CLK_DIV]	    = &gxbb_gen_clk_div.hw,
 		[CLKID_GEN_CLK]		    = &gxbb_gen_clk.hw,
 		[CLKID_FIXED_PLL_DCO]	    = &gxbb_fixed_pll_dco.hw,
-		[CLKID_HDMI_PLL_DCO]	    = &gxbb_hdmi_pll_dco.hw,
+		[CLKID_HDMI_PLL_DCO]	    = &gxl_hdmi_pll_dco.hw,
 		[CLKID_HDMI_PLL_OD]	    = &gxl_hdmi_pll_od.hw,
 		[CLKID_HDMI_PLL_OD2]	    = &gxl_hdmi_pll_od2.hw,
 		[CLKID_SYS_PLL_DCO]	    = &gxbb_sys_pll_dco.hw,
@@ -2104,6 +2150,7 @@ static struct clk_regmap *const gxbb_clk_regmaps[] = {
 	&gxbb_hdmi_pll,
 	&gxbb_hdmi_pll_od,
 	&gxbb_hdmi_pll_od2,
+	&gxbb_hdmi_pll_dco,
 };
 
 static struct clk_regmap *const gxl_clk_regmaps[] = {
@@ -2111,6 +2158,7 @@ static struct clk_regmap *const gxl_clk_regmaps[] = {
 	&gxl_hdmi_pll,
 	&gxl_hdmi_pll_od,
 	&gxl_hdmi_pll_od2,
+	&gxl_hdmi_pll_dco,
 };
 
 static struct clk_regmap *const gx_clk_regmaps[] = {
@@ -2266,7 +2314,6 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_gen_clk_div,
 	&gxbb_gen_clk,
 	&gxbb_fixed_pll_dco,
-	&gxbb_hdmi_pll_dco,
 	&gxbb_sys_pll_dco,
 	&gxbb_gp0_pll,
 };
-- 
2.7.4
