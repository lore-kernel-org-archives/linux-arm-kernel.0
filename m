From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Thu, 20 Sep 2018 17:57:27 +0800
Subject: [PATCH v1 3/3] clk: mediatek: mt2712: add pll reference support
In-Reply-To: <20180920095727.11868-1-weiyi.lu@mediatek.com>
References: <20180920095727.11868-1-weiyi.lu@mediatek.com>
Message-ID: <20180920095727.11868-5-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some MT2712 projects, audpll could select another reference
clock source if there exists an extra Crystal Oscillators than
the default clk26m XTAL.
Declare with the property "mediatek,refclk-aud" to switch
the audpll reference clock.
And also support to modify the reference clock of all PLL with
property "mediatek,refclk" instead of the default source "clk26m".

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2712.c | 87 ++++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index e36f4aab634d..2a4db1718089 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1174,7 +1174,7 @@ static const struct mtk_gate peri_clks[] = {
 #define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
 			_pd_reg, _pd_shift, _tuner_reg, _tuner_en_reg,	\
 			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
-			_div_table) {					\
+			_div_table, _parent_name) {			\
 		.id = _id,						\
 		.name = _name,						\
 		.reg = _reg,						\
@@ -1192,15 +1192,17 @@ static const struct mtk_gate peri_clks[] = {
 		.pcw_reg = _pcw_reg,					\
 		.pcw_shift = _pcw_shift,				\
 		.div_table = _div_table,				\
+		.parent_name = _parent_name,				\
 	}
 
 #define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
 			_pd_reg, _pd_shift, _tuner_reg, _tuner_en_reg,	\
-			_tuner_en_bit, _pcw_reg, _pcw_shift)		\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
+			_parent_name)					\
 		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,	\
 			_pcwbits, _pd_reg, _pd_shift, _tuner_reg,	\
 			_tuner_en_reg, _tuner_en_bit, _pcw_reg,		\
-			_pcw_shift, NULL)
+			_pcw_shift, NULL, _parent_name)
 
 static const struct mtk_pll_div_table armca35pll_div_table[] = {
 	{ .div = 0, .freq = MT2712_PLL_FMAX },
@@ -1229,48 +1231,95 @@ static const struct mtk_pll_div_table mmpll_div_table[] = {
 	{ } /* sentinel */
 };
 
-static const struct mtk_pll_data plls[] = {
+static struct mtk_pll_data plls[] = {
 	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0230, 0x023C, 0xf0000101,
-		HAVE_RST_BAR, 31, 0x0230, 4, 0, 0, 0, 0x0234, 0),
+		HAVE_RST_BAR, 31, 0x0230, 4, 0, 0, 0, 0x0234, 0, "clk26m"),
 	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0240, 0x024C, 0xfe000101,
-		HAVE_RST_BAR, 31, 0x0240, 4, 0, 0, 0, 0x0244, 0),
+		HAVE_RST_BAR, 31, 0x0240, 4, 0, 0, 0, 0x0244, 0, "clk26m"),
 	PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x0320, 0x032C, 0xc0000101,
-		0, 31, 0x0320, 4, 0, 0, 0, 0x0324, 0),
+		0, 31, 0x0320, 4, 0, 0, 0, 0x0324, 0, "clk26m"),
 	PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x0280, 0x028C, 0x00000101,
-		0, 31, 0x0280, 4, 0, 0, 0, 0x0284, 0),
+		0, 31, 0x0280, 4, 0, 0, 0, 0x0284, 0, "clk26m"),
 	PLL(CLK_APMIXED_APLL1, "apll1", 0x0330, 0x0340, 0x00000101,
-		0, 31, 0x0330, 4, 0x0338, 0x0014, 0, 0x0334, 0),
+		0, 31, 0x0330, 4, 0x0338, 0x0014, 0, 0x0334, 0, "clk26m"),
 	PLL(CLK_APMIXED_APLL2, "apll2", 0x0350, 0x0360, 0x00000101,
-		0, 31, 0x0350, 4, 0x0358, 0x0014, 1, 0x0354, 0),
+		0, 31, 0x0350, 4, 0x0358, 0x0014, 1, 0x0354, 0, "clk26m"),
 	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x0370, 0x037c, 0x00000101,
-		0, 31, 0x0370, 4, 0, 0, 0, 0x0374, 0),
+		0, 31, 0x0370, 4, 0, 0, 0, 0x0374, 0, "clk26m"),
 	PLL(CLK_APMIXED_LVDSPLL2, "lvdspll2", 0x0390, 0x039C, 0x00000101,
-		0, 31, 0x0390, 4, 0, 0, 0, 0x0394, 0),
+		0, 31, 0x0390, 4, 0, 0, 0, 0x0394, 0, "clk26m"),
 	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0270, 0x027C, 0x00000101,
-		0, 31, 0x0270, 4, 0, 0, 0, 0x0274, 0),
+		0, 31, 0x0270, 4, 0, 0, 0, 0x0274, 0, "clk26m"),
 	PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x0410, 0x041C, 0x00000101,
-		0, 31, 0x0410, 4, 0, 0, 0, 0x0414, 0),
+		0, 31, 0x0410, 4, 0, 0, 0, 0x0414, 0, "clk26m"),
 	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0290, 0x029C, 0xc0000101,
-		0, 31, 0x0290, 4, 0, 0, 0, 0x0294, 0),
+		0, 31, 0x0290, 4, 0, 0, 0, 0x0294, 0, "clk26m"),
 	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0250, 0x0260, 0x00000101,
 		0, 31, 0x0250, 4, 0, 0, 0, 0x0254, 0,
-		mmpll_div_table),
+		mmpll_div_table, "clk26m"),
 	PLL_B(CLK_APMIXED_ARMCA35PLL, "armca35pll", 0x0100, 0x0110, 0xf0000101,
 		HAVE_RST_BAR, 31, 0x0100, 4, 0, 0, 0, 0x0104, 0,
-		armca35pll_div_table),
+		armca35pll_div_table, "clk26m"),
 	PLL_B(CLK_APMIXED_ARMCA72PLL, "armca72pll", 0x0210, 0x0220, 0x00000101,
 		0, 31, 0x0210, 4, 0, 0, 0, 0x0214, 0,
-		armca72pll_div_table),
+		armca72pll_div_table, "clk26m"),
 	PLL(CLK_APMIXED_ETHERPLL, "etherpll", 0x0300, 0x030C, 0xc0000101,
-		0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
+		0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0, "clk26m"),
 };
 
+static void clk_mt2712_set_pll_reference(struct device_node *node,
+		struct mtk_pll_data *plls, size_t num_plls)
+{
+	void __iomem *base, *sel_addr;
+	struct of_phandle_args refclk, refclk_aud;
+	const char *refclk_name = "clk26m";
+	const char *refclk_aud_name;
+	int rc;
+	size_t i;
+	u32 r;
+
+	base = of_iomap(node, 0);
+	if (base) {
+		sel_addr = base + 0x40;
+	} else {
+		pr_err("%s(): ioremap failed\n", __func__);
+		return;
+	}
+
+	rc = of_parse_phandle_with_args(node, "mediatek,refclk",
+			"#clock-cells", 0, &refclk);
+	if (!rc) {
+		of_property_read_string(refclk.np, "clock-output-names",
+				&refclk_name);
+		for (i = 0; i < num_plls; i++)
+			plls[i].parent_name = refclk_name;
+	}
+
+	rc = of_parse_phandle_with_args(node, "mediatek,refclk-aud",
+			"#clock-cells", 0, &refclk_aud);
+	if (!rc) {
+		of_property_read_string(refclk_aud.np, "clock-output-names",
+				&refclk_aud_name);
+		if (strcmp(refclk_name, refclk_aud_name)) {
+			plls[CLK_APMIXED_APLL1].parent_name = refclk_aud_name;
+			plls[CLK_APMIXED_APLL2].parent_name = refclk_aud_name;
+			r = readl(sel_addr) | 0x60000;
+		} else {
+			r = readl(sel_addr) & ~0x60000;
+		}
+
+		writel(r, sel_addr);
+	}
+}
+
 static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
+	clk_mt2712_set_pll_reference(node, plls, ARRAY_SIZE(plls));
+
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-- 
2.12.5.2.gbdf23ab
