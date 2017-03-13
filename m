From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 13 Mar 2017 14:26:42 +0100
Subject: [PATCH 3/5] clk: meson-gxbb: Add GXL/GXM GP0 Variant
In-Reply-To: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
References: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1489411604-18700-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock tree in the Amlogic GXBB and GXL/GXM SoCs is shared, but the GXL/GXM
SoCs embeds a different GP0 PLL, and needs different parameters with a vendor
provided reduced rate table.

This patch adds the GXL GP0 variant, and adds a GXL DT compatible in order
to use the GXL GP0 PLL instead of the GXBB specific one.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/clk/meson/gxbb.h |  2 ++
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 5e1a7dc4..1838f22 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -120,7 +120,7 @@
 	{ /* sentinel */ },
 };
 
-static const struct pll_rate_table gp0_pll_rate_table[] = {
+static const struct pll_rate_table gxbb_gp0_pll_rate_table[] = {
 	PLL_RATE(96000000, 32, 1, 3),
 	PLL_RATE(99000000, 33, 1, 3),
 	PLL_RATE(102000000, 34, 1, 3),
@@ -248,6 +248,35 @@
 	{ /* sentinel */ },
 };
 
+static const struct pll_rate_table gxl_gp0_pll_rate_table[] = {
+	PLL_RATE(504000000, 42, 1, 1),
+	PLL_RATE(516000000, 43, 1, 1),
+	PLL_RATE(528000000, 44, 1, 1),
+	PLL_RATE(540000000, 45, 1, 1),
+	PLL_RATE(552000000, 46, 1, 1),
+	PLL_RATE(564000000, 47, 1, 1),
+	PLL_RATE(576000000, 48, 1, 1),
+	PLL_RATE(588000000, 49, 1, 1),
+	PLL_RATE(600000000, 50, 1, 1),
+	PLL_RATE(612000000, 51, 1, 1),
+	PLL_RATE(624000000, 52, 1, 1),
+	PLL_RATE(636000000, 53, 1, 1),
+	PLL_RATE(648000000, 54, 1, 1),
+	PLL_RATE(660000000, 55, 1, 1),
+	PLL_RATE(672000000, 56, 1, 1),
+	PLL_RATE(684000000, 57, 1, 1),
+	PLL_RATE(696000000, 58, 1, 1),
+	PLL_RATE(708000000, 59, 1, 1),
+	PLL_RATE(720000000, 60, 1, 1),
+	PLL_RATE(732000000, 61, 1, 1),
+	PLL_RATE(744000000, 62, 1, 1),
+	PLL_RATE(756000000, 63, 1, 1),
+	PLL_RATE(768000000, 64, 1, 1),
+	PLL_RATE(780000000, 65, 1, 1),
+	PLL_RATE(792000000, 66, 1, 1),
+	{ /* sentinel */ },
+};
+
 static const struct clk_div_table cpu_div_table[] = {
 	{ .val = 1, .div = 1 },
 	{ .val = 2, .div = 2 },
@@ -381,8 +410,51 @@ struct pll_params_table gxbb_gp0_params_table[] = {
 		.no_init_reset = true,
 		.unreset_for_lock = true,
 	},
-	.rate_table = gp0_pll_rate_table,
-	.rate_count = ARRAY_SIZE(gp0_pll_rate_table),
+	.rate_table = gxbb_gp0_pll_rate_table,
+	.rate_count = ARRAY_SIZE(gxbb_gp0_pll_rate_table),
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "gp0_pll",
+		.ops = &meson_clk_pll_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+struct pll_params_table gxl_gp0_params_table[] = {
+	PLL_PARAM(HHI_GP0_PLL_CNTL, 0x40010250),
+	PLL_PARAM(HHI_GP0_PLL_CNTL1, 0xc084a000),
+	PLL_PARAM(HHI_GP0_PLL_CNTL2, 0xb75020be),
+	PLL_PARAM(HHI_GP0_PLL_CNTL3, 0x0a59a288),
+	PLL_PARAM(HHI_GP0_PLL_CNTL4, 0xc000004d),
+	PLL_PARAM(HHI_GP0_PLL_CNTL5, 0x00078000),
+};
+
+static struct meson_clk_pll gxl_gp0_pll = {
+	.m = {
+		.reg_off = HHI_GP0_PLL_CNTL,
+		.shift   = 0,
+		.width   = 9,
+	},
+	.n = {
+		.reg_off = HHI_GP0_PLL_CNTL,
+		.shift   = 9,
+		.width   = 5,
+	},
+	.od = {
+		.reg_off = HHI_GP0_PLL_CNTL,
+		.shift   = 16,
+		.width   = 2,
+	},
+	.params = {
+		.params_table = gxl_gp0_params_table,
+		.params_count =	ARRAY_SIZE(gxl_gp0_params_table),
+		.no_init_reset = true,
+		.reset_lock_loop = true,
+	},
+	.rate_table = gxl_gp0_pll_rate_table,
+	.rate_count = ARRAY_SIZE(gxl_gp0_pll_rate_table),
 	.lock = &clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll",
@@ -821,6 +893,7 @@ struct pll_params_table gxbb_gp0_params_table[] = {
 	&gxbb_hdmi_pll,
 	&gxbb_sys_pll,
 	&gxbb_gp0_pll,
+	&gxl_gp0_pll,
 };
 
 static struct meson_clk_mpll *const gxbb_clk_mplls[] = {
@@ -923,6 +996,10 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	struct clk *parent_clk;
 	struct device *dev = &pdev->dev;
 
+	/* Override GP0 clock for GXL/GXM */
+	if (of_device_is_compatible(dev->of_node, "amlogic,gxl-clkc"))
+		gxbb_hw_onecell_data.hws[CLKID_GP0_PLL] = &gxl_gp0_pll.hw;
+
 	/*  Generic clocks and PLLs */
 	clk_base = of_iomap(dev->of_node, 0);
 	if (!clk_base) {
@@ -996,6 +1073,7 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 
 static const struct of_device_id gxbb_clkc_match_table[] = {
 	{ .compatible = "amlogic,gxbb-clkc" },
+	{ .compatible = "amlogic,gxl-clkc" },
 	{ }
 };
 
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 8ee2022..7f99bf6 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -71,6 +71,8 @@
 #define HHI_GP0_PLL_CNTL2		0x44 /* 0x11 offset in data sheet */
 #define HHI_GP0_PLL_CNTL3		0x48 /* 0x12 offset in data sheet */
 #define HHI_GP0_PLL_CNTL4		0x4c /* 0x13 offset in data sheet */
+#define	HHI_GP0_PLL_CNTL5		0x50 /* 0x14 offset in data sheet */
+#define	HHI_GP0_PLL_CNTL1		0x58 /* 0x16 offset in data sheet */
 
 #define HHI_XTAL_DIVN_CNTL		0xbc /* 0x2f offset in data sheet */
 #define HHI_TIMER90K			0xec /* 0x3b offset in data sheet */
-- 
1.9.1
