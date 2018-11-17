From: yong.wu@mediatek.com (Yong Wu)
Date: Sat, 17 Nov 2018 10:35:36 +0800
Subject: [PATCH v3 09/15] memory: mtk-smi: Use a struct for the platform data
 for smi-common
In-Reply-To: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1542422142-30688-10-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a struct as the platform special data instead of the enumeration.

Also there is a minor change that moving the position of
"enum mtk_smi_gen" definition, this is because we expect define
"struct mtk_smi_common_plat" before it is referred.

This is a prepare patch for adding bus_sel for mt8183.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 7cf4573..3e6e0a8 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -49,6 +49,15 @@
 #define SMI_LARB_NONSEC_CON(id)	(0x380 + ((id) * 4))
 #define F_MMU_EN		BIT(0)
 
+enum mtk_smi_gen {
+	MTK_SMI_GEN1,
+	MTK_SMI_GEN2
+};
+
+struct mtk_smi_common_plat {
+	enum mtk_smi_gen gen;
+};
+
 struct mtk_smi_larb_gen {
 	bool need_larbid;
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
@@ -62,6 +71,8 @@ struct mtk_smi {
 	struct clk			*clk_gals0, *clk_gals1;
 	struct clk			*clk_async; /*only needed by mt2701*/
 	void __iomem			*smi_ao_base;
+
+	const struct mtk_smi_common_plat *plat;
 };
 
 struct mtk_smi_larb { /* larb: local arbiter */
@@ -73,11 +84,6 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	u32				*mmu;
 };
 
-enum mtk_smi_gen {
-	MTK_SMI_GEN1,
-	MTK_SMI_GEN2
-};
-
 static int mtk_smi_clk_enable(const struct mtk_smi *smi)
 {
 	int ret;
@@ -387,22 +393,30 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 	}
 };
 
+static const struct mtk_smi_common_plat mtk_smi_common_gen1 = {
+	.gen = MTK_SMI_GEN1,
+};
+
+static const struct mtk_smi_common_plat mtk_smi_common_gen2 = {
+	.gen = MTK_SMI_GEN2,
+};
+
 static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{
 		.compatible = "mediatek,mt8173-smi-common",
-		.data = (void *)MTK_SMI_GEN2
+		.data = &mtk_smi_common_gen2,
 	},
 	{
 		.compatible = "mediatek,mt2701-smi-common",
-		.data = (void *)MTK_SMI_GEN1
+		.data = &mtk_smi_common_gen1,
 	},
 	{
 		.compatible = "mediatek,mt2712-smi-common",
-		.data = (void *)MTK_SMI_GEN2
+		.data = &mtk_smi_common_gen2,
 	},
 	{
 		.compatible = "mediatek,mt8183-smi-common",
-		.data = (void *)MTK_SMI_GEN2
+		.data = &mtk_smi_common_gen2,
 	},
 	{}
 };
@@ -412,13 +426,13 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mtk_smi *common;
 	struct resource *res;
-	enum mtk_smi_gen smi_gen;
 	int ret;
 
 	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
 	if (!common)
 		return -ENOMEM;
 	common->dev = dev;
+	common->plat = of_device_get_match_data(dev);
 
 	common->clk_apb = devm_clk_get(dev, "apb");
 	if (IS_ERR(common->clk_apb))
@@ -446,8 +460,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
 	 * base.
 	 */
-	smi_gen = (enum mtk_smi_gen)of_device_get_match_data(dev);
-	if (smi_gen == MTK_SMI_GEN1) {
+	if (common->plat->gen == MTK_SMI_GEN1) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		common->smi_ao_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(common->smi_ao_base))
-- 
1.9.1
