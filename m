From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Fri, 4 Aug 2017 09:32:25 +0800
Subject: [PATCH v3 1/4] memory: mtk-smi: Use of_device_get_match_data helper
In-Reply-To: <1501810348-20997-1-git-send-email-honghui.zhang@mediatek.com>
References: <1501810348-20997-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1501810348-20997-2-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Replace custom code with generic helper to retrieve driver data.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/memory/mtk-smi.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 4afbc41..2b798bb4 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -240,20 +240,15 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *smi_node;
 	struct platform_device *smi_pdev;
-	const struct of_device_id *of_id;
 
 	if (!dev->pm_domain)
 		return -EPROBE_DEFER;
 
-	of_id = of_match_node(mtk_smi_larb_of_ids, pdev->dev.of_node);
-	if (!of_id)
-		return -EINVAL;
-
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
 	if (!larb)
 		return -ENOMEM;
 
-	larb->larb_gen = of_id->data;
+	larb->larb_gen = of_device_get_match_data(dev);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	larb->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(larb->base))
@@ -319,7 +314,6 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mtk_smi *common;
 	struct resource *res;
-	const struct of_device_id *of_id;
 	enum mtk_smi_gen smi_gen;
 
 	if (!dev->pm_domain)
@@ -338,17 +332,13 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	if (IS_ERR(common->clk_smi))
 		return PTR_ERR(common->clk_smi);
 
-	of_id = of_match_node(mtk_smi_common_of_ids, pdev->dev.of_node);
-	if (!of_id)
-		return -EINVAL;
-
 	/*
 	 * for mtk smi gen 1, we need to get the ao(always on) base to config
 	 * m4u port, and we need to enable the aync clock for transform the smi
 	 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
 	 * base.
 	 */
-	smi_gen = (enum mtk_smi_gen)of_id->data;
+	smi_gen = (enum mtk_smi_gen)of_device_get_match_data(dev);
 	if (smi_gen == MTK_SMI_GEN1) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		common->smi_ao_base = devm_ioremap_resource(dev, res);
-- 
2.6.4
