From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 17:07:50 +0200
Subject: [PATCH 4/6] clk: oxnas: Refactor to make use of devm_clk_hw_register()
In-Reply-To: <20161005150752.22618-1-narmstrong@baylibre.com>
References: <20161005150752.22618-1-narmstrong@baylibre.com>
Message-ID: <20161005150752.22618-5-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make usage of static tables identified by the OF match table to
feed devm_clk_hw_register() and use of_clk_add_hw_provider().

This structure is cleaner and simplifies adding new SoC support while
having common probe and gate ops code.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/clk-oxnas.c | 148 +++++++++++++++++++++++++++---------------------
 1 file changed, 84 insertions(+), 64 deletions(-)

diff --git a/drivers/clk/clk-oxnas.c b/drivers/clk/clk-oxnas.c
index a76c7fb..b1ef3ea9 100644
--- a/drivers/clk/clk-oxnas.c
+++ b/drivers/clk/clk-oxnas.c
@@ -20,18 +20,29 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/stringify.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 
+#include <dt-bindings/clock/oxsemi,ox810se.h>
+
 /* Standard regmap gate clocks */
 struct clk_oxnas_gate {
 	struct clk_hw hw;
-	signed char bit;
+	unsigned int bit;
 	struct regmap *regmap;
 };
 
+struct oxnas_stdclk_data {
+	struct clk_hw_onecell_data *onecell_data;
+	struct clk_oxnas_gate **gates;
+	unsigned int ngates;
+	struct clk_oxnas_pll **plls;
+	unsigned int nplls;
+};
+
 /* Regmap offsets */
 #define CLK_STAT_REGOFFSET	0x24
 #define CLK_SET_REGOFFSET	0x2c
@@ -77,7 +88,7 @@ static const struct clk_ops oxnas_clk_gate_ops = {
 	.is_enabled = oxnas_clk_gate_is_enabled,
 };
 
-static const char *const oxnas_clk_parents[] = {
+static const char *const osc_parents[] = {
 	"oscillator",
 };
 
@@ -85,63 +96,81 @@ static const char *const eth_parents[] = {
 	"gmacclk",
 };
 
-#define DECLARE_STD_CLKP(__clk, __parent)			\
-static const struct clk_init_data clk_##__clk##_init = {	\
-	.name = __stringify(__clk),				\
-	.ops = &oxnas_clk_gate_ops,					\
-	.parent_names = __parent,				\
-	.num_parents = ARRAY_SIZE(__parent),			\
+#define OXNAS_GATE(_name, _bit, _parents)				\
+struct clk_oxnas_gate _name = {						\
+	.bit = (_bit),							\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = #_name,						\
+		.ops = &oxnas_clk_gate_ops,				\
+		.parent_names = _parents,				\
+		.num_parents = ARRAY_SIZE(_parents),			\
+		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
+	},								\
 }
 
-#define DECLARE_STD_CLK(__clk) DECLARE_STD_CLKP(__clk, oxnas_clk_parents)
+static OXNAS_GATE(ox810se_leon, 0, osc_parents);
+static OXNAS_GATE(ox810se_dma_sgdma, 1, osc_parents);
+static OXNAS_GATE(ox810se_cipher, 2, osc_parents);
+static OXNAS_GATE(ox810se_sata, 4, osc_parents);
+static OXNAS_GATE(ox810se_audio, 5, osc_parents);
+static OXNAS_GATE(ox810se_usbmph, 6, osc_parents);
+static OXNAS_GATE(ox810se_etha, 7, eth_parents);
+static OXNAS_GATE(ox810se_pciea, 8, osc_parents);
+static OXNAS_GATE(ox810se_nand, 9, osc_parents);
+
+static struct clk_oxnas_gate *ox810se_gates[] = {
+	&ox810se_leon,
+	&ox810se_dma_sgdma,
+	&ox810se_cipher,
+	&ox810se_sata,
+	&ox810se_audio,
+	&ox810se_usbmph,
+	&ox810se_etha,
+	&ox810se_pciea,
+	&ox810se_nand,
+};
 
-/* Hardware Bit - Clock association */
-struct clk_oxnas_init_data {
-	unsigned long bit;
-	const struct clk_init_data *clk_init;
+static struct clk_hw_onecell_data ox810se_hw_onecell_data = {
+	.hws = {
+		[CLK_810_LEON]	= &ox810se_leon.hw,
+		[CLK_810_DMA_SGDMA]	= &ox810se_dma_sgdma.hw,
+		[CLK_810_CIPHER]	= &ox810se_cipher.hw,
+		[CLK_810_SATA]	= &ox810se_sata.hw,
+		[CLK_810_AUDIO]	= &ox810se_audio.hw,
+		[CLK_810_USBMPH]	= &ox810se_usbmph.hw,
+		[CLK_810_ETHA]	= &ox810se_etha.hw,
+		[CLK_810_PCIEA]	= &ox810se_pciea.hw,
+		[CLK_810_NAND]	= &ox810se_nand.hw,
+	},
+	.num = ARRAY_SIZE(ox810se_gates),
 };
 
-/* Clk init data declaration */
-DECLARE_STD_CLK(leon);
-DECLARE_STD_CLK(dma_sgdma);
-DECLARE_STD_CLK(cipher);
-DECLARE_STD_CLK(sata);
-DECLARE_STD_CLK(audio);
-DECLARE_STD_CLK(usbmph);
-DECLARE_STD_CLKP(etha, eth_parents);
-DECLARE_STD_CLK(pciea);
-DECLARE_STD_CLK(nand);
-
-/* Table index is clock indice */
-static const struct clk_oxnas_init_data clk_oxnas_init[] = {
-	[0] = {0, &clk_leon_init},
-	[1] = {1, &clk_dma_sgdma_init},
-	[2] = {2, &clk_cipher_init},
-	/* Skip & Do not touch to DDR clock */
-	[3] = {4, &clk_sata_init},
-	[4] = {5, &clk_audio_init},
-	[5] = {6, &clk_usbmph_init},
-	[6] = {7, &clk_etha_init},
-	[7] = {8, &clk_pciea_init},
-	[8] = {9, &clk_nand_init},
+
+static struct oxnas_stdclk_data ox810se_stdclk_data = {
+	.onecell_data = &ox810se_hw_onecell_data,
+	.gates = ox810se_gates,
+	.ngates = ARRAY_SIZE(ox810se_gates),
 };
 
-struct clk_oxnas_data {
-	struct clk_oxnas_gate clk_oxnas[ARRAY_SIZE(clk_oxnas_init)];
-	struct clk_onecell_data onecell_data[ARRAY_SIZE(clk_oxnas_init)];
-	struct clk *clks[ARRAY_SIZE(clk_oxnas_init)];
+
+static const struct of_device_id oxnas_stdclk_dt_ids[] = {
+	{ .compatible = "oxsemi,ox810se-stdclk", &ox810se_stdclk_data },
+	{ }
 };
 
 static int oxnas_stdclk_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct clk_oxnas_data *clk_oxnas;
+	const struct oxnas_stdclk_data *data;
+	const struct of_device_id *id;
 	struct regmap *regmap;
+	int ret;
 	int i;
 
-	clk_oxnas = devm_kzalloc(&pdev->dev, sizeof(*clk_oxnas), GFP_KERNEL);
-	if (!clk_oxnas)
-		return -ENOMEM;
+	id = of_match_device(oxnas_stdclk_dt_ids, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+	data = id->data;
 
 	regmap = syscon_node_to_regmap(of_get_parent(np));
 	if (IS_ERR(regmap)) {
@@ -149,32 +178,23 @@ static int oxnas_stdclk_probe(struct platform_device *pdev)
 		return PTR_ERR(regmap);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(clk_oxnas_init); i++) {
-		struct clk_oxnas_gate *_clk;
+	for (i = 0 ; i < data->ngates ; ++i)
+		data->gates[i]->regmap = regmap;
 
-		_clk = &clk_oxnas->clk_oxnas[i];
-		_clk->bit = clk_oxnas_init[i].bit;
-		_clk->hw.init = clk_oxnas_init[i].clk_init;
-		_clk->regmap = regmap;
+	for (i = 0; i < data->onecell_data->num; i++) {
+		if (!data->onecell_data->hws[i])
+			continue;
 
-		clk_oxnas->clks[i] =
-			devm_clk_register(&pdev->dev, &_clk->hw);
-		if (WARN_ON(IS_ERR(clk_oxnas->clks[i])))
-			return PTR_ERR(clk_oxnas->clks[i]);
+		ret = devm_clk_hw_register(&pdev->dev,
+					   data->onecell_data->hws[i]);
+		if (ret)
+			return ret;
 	}
 
-	clk_oxnas->onecell_data->clks = clk_oxnas->clks;
-	clk_oxnas->onecell_data->clk_num = ARRAY_SIZE(clk_oxnas_init);
-
-	return of_clk_add_provider(np, of_clk_src_onecell_get,
-				   clk_oxnas->onecell_data);
+	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
+				      data->onecell_data);
 }
 
-static const struct of_device_id oxnas_stdclk_dt_ids[] = {
-	{ .compatible = "oxsemi,ox810se-stdclk" },
-	{ }
-};
-
 static struct platform_driver oxnas_stdclk_driver = {
 	.probe = oxnas_stdclk_probe,
 	.driver	= {
-- 
2.7.0
