From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 21 Sep 2010 14:17:50 +0200
Subject: [PATCH v2 1/3] [ARM] tegra: add PCI Express clocks
In-Reply-To: <cover.1285070872.git.mike@compulab.co.il>
References: <cover.1285070872.git.mike@compulab.co.il>
Message-ID: <d60716bcaa7991bb4d43d7d694391326a166969d.1285070872.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
CC: Colin Cross <ccross@google.com>
CC: Gary King <GKing@nvidia.com>
---
 arch/arm/mach-tegra/tegra2_clocks.c |   46 +++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index 4261632..5ce4783 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -92,6 +92,8 @@
 #define PLLD_MISC_DIV_RST		(1<<23)
 #define PLLD_MISC_DCCON_SHIFT		12
 
+#define PLLE_MISC_READY			(1 << 15)
+
 #define PERIPH_CLK_TO_ENB_REG(c)	((c->clk_num / 32) * 4)
 #define PERIPH_CLK_TO_ENB_SET_REG(c)	((c->clk_num / 32) * 8)
 #define PERIPH_CLK_TO_ENB_BIT(c)	(1 << (c->clk_num % 32))
@@ -482,6 +484,31 @@ static struct clk_ops tegra_pll_ops = {
 	.recalculate_rate	= tegra2_pll_clk_recalculate_rate,
 };
 
+static int tegra2_plle_clk_enable(struct clk *c)
+{
+	u32 val;
+
+	pr_debug("%s on clock %s\n", __func__, c->name);
+
+	mdelay(1);
+
+	val = clk_readl(c->reg + PLL_BASE);
+	if (!(val & PLLE_MISC_READY))
+		return -EBUSY;
+
+	val = clk_readl(c->reg + PLL_BASE);
+	val |= PLL_BASE_ENABLE | PLL_BASE_BYPASS;
+	clk_writel(val, c->reg + PLL_BASE);
+
+	return 0;
+}
+
+static struct clk_ops tegra_plle_ops = {
+	.init       = tegra2_pll_clk_init,
+	.enable     = tegra2_plle_clk_enable,
+	.set_rate   = tegra2_pll_clk_set_rate,
+};
+
 /* Clock divider ops */
 static void tegra2_pll_div_clk_init(struct clk *c)
 {
@@ -1030,6 +1057,21 @@ static struct clk tegra_pll_x = {
 	.pll_table = tegra_pll_x_table,
 };
 
+static struct clk_pll_table tegra_pll_e_table[] = {
+	{ 12000000, 100000000,  200,  24, 1, 0 },
+};
+
+static struct clk tegra_pll_e = {
+	.name      = "pll_e",
+	.flags	   = PLL_ALT_MISC_REG,
+	.ops       = &tegra_plle_ops,
+	.input_min = 12000000,
+	.input_max = 12000000,
+	.parent    = &tegra_clk_m,
+	.reg       = 0xe8,
+	.pll_table = tegra_pll_e_table,
+};
+
 static struct clk tegra_clk_d = {
 	.name      = "clk_d",
 	.flags     = PERIPH_NO_RESET,
@@ -1265,6 +1307,9 @@ struct clk tegra_periph_clks[] = {
 	PERIPH_CLK("usb3",	"usb.2",		NULL,	59,	0,	mux_clk_m,			0),
 	PERIPH_CLK("emc",	"emc",			NULL,	57,	0x19c,	mux_pllm_pllc_pllp_clkm,	MUX | DIV_U71 | PERIPH_EMC_ENB),
 	PERIPH_CLK("dsi",	"dsi",			NULL,	48,	0,	mux_plld,			0),
+	PERIPH_CLK("pex",       NULL,			"pex",  70,     0,	mux_clk_m,			PERIPH_MANUAL_RESET),
+	PERIPH_CLK("afi",       NULL,			"afi",  72,     0,	mux_clk_m,			PERIPH_MANUAL_RESET),
+	PERIPH_CLK("pcie_xclk", NULL,		  "pcie_xclk",  74,     0,	mux_clk_m,			PERIPH_MANUAL_RESET),
 };
 
 #define CLK_DUPLICATE(_name, _dev, _con)		\
@@ -1315,6 +1360,7 @@ struct clk_lookup tegra_clk_lookups[] = {
 	CLK(NULL,	"pll_d_out0",	&tegra_pll_d_out0),
 	CLK(NULL,	"pll_u",	&tegra_pll_u),
 	CLK(NULL,	"pll_x",	&tegra_pll_x),
+	CLK(NULL,	"pll_e",	&tegra_pll_e),
 	CLK(NULL,	"cpu",		&tegra_clk_cpu),
 	CLK(NULL,	"sys",		&tegra_clk_sys),
 	CLK(NULL,	"hclk",		&tegra_clk_hclk),
-- 
1.6.6.2
