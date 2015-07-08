From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 8 Jul 2015 16:37:46 +0800
Subject: [PATCH v2 2/2] clk: mediatek: Add MT8173 MMPLL change rate support
In-Reply-To: <1436344666-25645-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436344666-25645-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1436344666-25645-3-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT8173 MMPLL frequency settings are different from common PLLs.
It needs different post divider settings for some ranges of frequency.
This patch add support for MT8173 MMPLL frequency setting, includes:

1. Add div-rate table for PLLs.
2. Increase the max ost divider setting from 3 (/8) to 4 (/16).

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8173.c | 24 +++++++++++++++++++++---
 drivers/clk/mediatek/clk-mtk.h    |  6 ++++++
 drivers/clk/mediatek/clk-pll.c    | 18 +++++++++++++++---
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 357b080..e3101e6 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -779,8 +779,9 @@ CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
 
 #define CON0_MT8173_RST_BAR	BIT(24)
 
-#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg, _pd_shift, \
-			_tuner_reg, _pcw_reg, _pcw_shift) { \
+#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
+			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg,	\
+			_pcw_shift, _div_table) {			\
 		.id = _id,						\
 		.name = _name,						\
 		.reg = _reg,						\
@@ -795,14 +796,31 @@ CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
 		.tuner_reg = _tuner_reg,				\
 		.pcw_reg = _pcw_reg,					\
 		.pcw_shift = _pcw_shift,				\
+		.div_table = _div_table,				\
 	}
 
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
+			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg,	\
+			_pcw_shift)					\
+		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, \
+			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift, \
+			NULL)
+
+static const struct mtk_pll_div_table mmpll_div_table[] = {
+	{ .div = 0, .freq = MT8173_PLL_FMAX },
+	{ .div = 1, .freq = 1000000000 },
+	{ .div = 2, .freq = 702000000 },
+	{ .div = 3, .freq = 253500000 },
+	{ .div = 4, .freq = 126750000 },
+	{ } /* sentinel */
+};
+
 static const struct mtk_pll_data plls[] = {
 	PLL(CLK_APMIXED_ARMCA15PLL, "armca15pll", 0x200, 0x20c, 0x00000001, 0, 21, 0x204, 24, 0x0, 0x204, 0),
 	PLL(CLK_APMIXED_ARMCA7PLL, "armca7pll", 0x210, 0x21c, 0x00000001, 0, 21, 0x214, 24, 0x0, 0x214, 0),
 	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x220, 0x22c, 0xf0000101, HAVE_RST_BAR, 21, 0x220, 4, 0x0, 0x224, 0),
 	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x230, 0x23c, 0xfe000001, HAVE_RST_BAR, 7, 0x230, 4, 0x0, 0x234, 14),
-	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0x00000001, 0, 21, 0x244, 24, 0x0, 0x244, 0),
+	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0x00000001, 0, 21, 0x244, 24, 0x0, 0x244, 0, mmpll_div_table),
 	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x250, 0x25c, 0x00000001, 0, 21, 0x250, 4, 0x0, 0x254, 0),
 	PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x260, 0x26c, 0x00000001, 0, 21, 0x260, 4, 0x0, 0x264, 0),
 	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x270, 0x27c, 0x00000001, 0, 21, 0x270, 4, 0x0, 0x274, 0),
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 61035b9..fa0c1fe 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -134,6 +134,11 @@ struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
 
 #define HAVE_RST_BAR	BIT(0)
 
+struct mtk_pll_div_table {
+	u32 div;
+	unsigned long freq;
+};
+
 struct mtk_pll_data {
 	int id;
 	const char *name;
@@ -150,6 +155,7 @@ struct mtk_pll_data {
 	int pcwbits;
 	uint32_t pcw_reg;
 	int pcw_shift;
+	const struct mtk_pll_div_table *div_table;
 };
 
 void __init mtk_clk_register_plls(struct device_node *node,
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 68af518..622e7b6 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -138,16 +138,28 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
 		u32 freq, u32 fin)
 {
 	unsigned long fmin = 1000 * MHZ;
+	const struct mtk_pll_div_table *div_table = pll->data->div_table;
 	u64 _pcw;
 	u32 val;
 
 	if (freq > pll->data->fmax)
 		freq = pll->data->fmax;
 
-	for (val = 0; val < 4; val++) {
+	if (div_table) {
+		if (freq > div_table[0].freq)
+			freq = div_table[0].freq;
+
+		for (val = 0; div_table[val + 1].freq != 0; val++) {
+			if (freq > div_table[val + 1].freq)
+				break;
+		}
 		*postdiv = 1 << val;
-		if (freq * *postdiv >= fmin)
-			break;
+	} else {
+		for (val = 0; val < 5; val++) {
+			*postdiv = 1 << val;
+			if ((u64)freq * *postdiv >= fmin)
+				break;
+		}
 	}
 
 	/* _pcw = freq * postdiv / fin * 2^pcwfbits */
-- 
1.8.1.1.dirty
