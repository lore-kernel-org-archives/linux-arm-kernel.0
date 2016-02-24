From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:38 +0530
Subject: [PATCH 13/50] pinctrl: mtk-common: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-14-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and clean
the error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Hongzhou Yang <hongzhou.yang@mediatek.com>
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index ddc9217..194413d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1390,17 +1390,16 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	pctl->pctl_desc.pmxops = &mtk_pmx_ops;
 	pctl->dev = &pdev->dev;
 
-	pctl->pctl_dev = pinctrl_register(&pctl->pctl_desc, &pdev->dev, pctl);
+	pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, &pctl->pctl_desc,
+					       pctl);
 	if (IS_ERR(pctl->pctl_dev)) {
 		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
 		return PTR_ERR(pctl->pctl_dev);
 	}
 
 	pctl->chip = devm_kzalloc(&pdev->dev, sizeof(*pctl->chip), GFP_KERNEL);
-	if (!pctl->chip) {
-		ret = -ENOMEM;
-		goto pctrl_error;
-	}
+	if (!pctl->chip)
+		return -ENOMEM;
 
 	*pctl->chip = mtk_gpio_chip;
 	pctl->chip->ngpio = pctl->devdata->npins;
@@ -1409,10 +1408,8 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	pctl->chip->base = -1;
 
 	ret = gpiochip_add_data(pctl->chip, pctl);
-	if (ret) {
-		ret = -EINVAL;
-		goto pctrl_error;
-	}
+	if (ret)
+		return -EINVAL;
 
 	/* Register the GPIO to pin mappings. */
 	ret = gpiochip_add_pin_range(pctl->chip, dev_name(&pdev->dev),
@@ -1490,8 +1487,6 @@ int mtk_pctrl_init(struct platform_device *pdev,
 
 chip_error:
 	gpiochip_remove(pctl->chip);
-pctrl_error:
-	pinctrl_unregister(pctl->pctl_dev);
 	return ret;
 }
 
-- 
2.1.4
