From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Tue, 25 Aug 2015 17:16:10 -0700
Subject: [PATCH v4] pinctrl: mediatek: Fix multiple registration issue.
Message-ID: <1440548170-10174-1-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since our common driver need support main chip and PMU
at the same time, that means it will register two
pinctrl device, and the pinctrl_desc structure should
be used two times.

But pinctrl_desc use global static definition, then
the latest registered pinctrl device will overwrite
the old one's, all members in pinctrl_desc will set to
the new one's, such as name, pins and pins numbers, etc.
This is a bug. Changing to use devm_kzalloc to fix it.

Cc: stable at vger.kernel.org # v4.1+
Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
---
 Adding pinctrl_desc into mtk_pinctrl, assign new value for each 
 pinctrl device.

 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   21 ++++++++++-----------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |    1 +
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index ad1ea16..4a52072 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1202,12 +1202,6 @@ static int mtk_pctrl_build_state(struct platform_device *pdev)
 	return 0;
 }
 
-static struct pinctrl_desc mtk_pctrl_desc = {
-	.confops	= &mtk_pconf_ops,
-	.pctlops	= &mtk_pctrl_ops,
-	.pmxops		= &mtk_pmx_ops,
-};
-
 int mtk_pctrl_init(struct platform_device *pdev,
 		const struct mtk_pinctrl_devdata *data,
 		struct regmap *regmap)
@@ -1265,12 +1259,17 @@ int mtk_pctrl_init(struct platform_device *pdev,
 
 	for (i = 0; i < pctl->devdata->npins; i++)
 		pins[i] = pctl->devdata->pins[i].pin;
-	mtk_pctrl_desc.name = dev_name(&pdev->dev);
-	mtk_pctrl_desc.owner = THIS_MODULE;
-	mtk_pctrl_desc.pins = pins;
-	mtk_pctrl_desc.npins = pctl->devdata->npins;
+
+	pctl->pctl_desc.name = dev_name(&pdev->dev);
+	pctl->pctl_desc.owner = THIS_MODULE;
+	pctl->pctl_desc.pins = pins;
+	pctl->pctl_desc.npins = pctl->devdata->npins;
+	pctl->pctl_desc.confops = &mtk_pconf_ops;
+	pctl->pctl_desc.pctlops = &mtk_pctrl_ops;
+	pctl->pctl_desc.pmxops = &mtk_pmx_ops;
 	pctl->dev = &pdev->dev;
-	pctl->pctl_dev = pinctrl_register(&mtk_pctrl_desc, &pdev->dev, pctl);
+
+	pctl->pctl_dev = pinctrl_register(&pctl->pctl_desc, &pdev->dev, pctl);
 	if (IS_ERR(pctl->pctl_dev)) {
 		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
 		return PTR_ERR(pctl->pctl_dev);
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 30213e5..c532c23 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -256,6 +256,7 @@ struct mtk_pinctrl_devdata {
 struct mtk_pinctrl {
 	struct regmap	*regmap1;
 	struct regmap	*regmap2;
+	struct pinctrl_desc pctl_desc;
 	struct device           *dev;
 	struct gpio_chip	*chip;
 	struct mtk_pinctrl_group	*groups;
-- 
1.7.9.5
