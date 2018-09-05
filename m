From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Wed, 5 Sep 2018 16:31:35 +0800
Subject: [PATCH v2 02/13] drm/mediatek: move hardware register to node data
In-Reply-To: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
Message-ID: <20180905083146.14727-3-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: chunhui dai <chunhui.dai@mediatek.com>

The address of register DPI_H_FRE_CON is different in different IC.
Using of_node data to find this address.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c      | 29 +++++++++++++++++++++++------
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  1 -
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index d9373e67d328..3db959fed493 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -72,6 +72,7 @@ struct mtk_dpi {
 	struct clk *tvd_clk;
 	int irq;
 	struct drm_display_mode mode;
+	const struct mtk_dpi_conf *conf;
 	enum mtk_dpi_out_color_format color_format;
 	enum mtk_dpi_out_yc_map yc_map;
 	enum mtk_dpi_out_bit_num bit_num;
@@ -117,6 +118,10 @@ struct mtk_dpi_yc_limit {
 	u16 c_bottom;
 };
 
+struct mtk_dpi_conf {
+	const u32 reg_h_fre_con;
+};
+
 static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
 {
 	u32 tmp = readl(dpi->regs + offset) & ~mask;
@@ -342,7 +347,7 @@ static void mtk_dpi_config_swap_input(struct mtk_dpi *dpi, bool enable)
 
 static void mtk_dpi_config_2n_h_fre(struct mtk_dpi *dpi)
 {
-	mtk_dpi_mask(dpi, DPI_H_FRE_CON, H_FRE_2N, H_FRE_2N);
+	mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
 }
 
 static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
@@ -668,6 +673,18 @@ static const struct component_ops mtk_dpi_component_ops = {
 	.unbind = mtk_dpi_unbind,
 };
 
+static const struct mtk_dpi_conf mt8173_conf = {
+	.reg_h_fre_con = 0xe0,
+};
+
+static const struct of_device_id mtk_dpi_of_ids[] = {
+	{ .compatible = "mediatek,mt8173-dpi",
+	  .data = &mt8173_conf,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
+
 static int mtk_dpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -675,13 +692,18 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct device_node *bridge_node;
 	int comp_id;
+	const struct of_device_id *match;
 	int ret;
 
+	match = of_match_node(mtk_dpi_of_ids, dev->of_node);
+	if (!match)
+		return -ENODEV;
 	dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
 	if (!dpi)
 		return -ENOMEM;
 
 	dpi->dev = dev;
+	dpi->conf = (struct mtk_dpi_conf *)match->data;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dpi->regs = devm_ioremap_resource(dev, mem);
@@ -760,11 +782,6 @@ static int mtk_dpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mtk_dpi_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-dpi", },
-	{}
-};
-
 struct platform_driver mtk_dpi_driver = {
 	.probe = mtk_dpi_probe,
 	.remove = mtk_dpi_remove,
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
index 4b6ad4751a31..040444d7718d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
+++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
@@ -223,6 +223,5 @@
 #define ESAV_CODE2			(0xFFF << 0)
 #define ESAV_CODE3_MSB			BIT(16)
 
-#define DPI_H_FRE_CON		0xE0
 #define H_FRE_2N			BIT(25)
 #endif /* __MTK_DPI_REGS_H */
-- 
2.12.5.2.gbdf23ab
