From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:46:12 +0530
Subject: [PATCH 47/50] pinctrl: tz1090-pdc: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-48-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and
remove the need of .remove callback.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pinctrl/pinctrl-tz1090-pdc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tz1090-pdc.c b/drivers/pinctrl/pinctrl-tz1090-pdc.c
index b89ad3c..e70e362 100644
--- a/drivers/pinctrl/pinctrl-tz1090-pdc.c
+++ b/drivers/pinctrl/pinctrl-tz1090-pdc.c
@@ -947,7 +947,8 @@ static int tz1090_pdc_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(pmx->regs))
 		return PTR_ERR(pmx->regs);
 
-	pmx->pctl = pinctrl_register(&tz1090_pdc_pinctrl_desc, &pdev->dev, pmx);
+	pmx->pctl = devm_pinctrl_register(&pdev->dev, &tz1090_pdc_pinctrl_desc,
+					  pmx);
 	if (IS_ERR(pmx->pctl)) {
 		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
 		return PTR_ERR(pmx->pctl);
@@ -960,15 +961,6 @@ static int tz1090_pdc_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tz1090_pdc_pinctrl_remove(struct platform_device *pdev)
-{
-	struct tz1090_pdc_pmx *pmx = platform_get_drvdata(pdev);
-
-	pinctrl_unregister(pmx->pctl);
-
-	return 0;
-}
-
 static const struct of_device_id tz1090_pdc_pinctrl_of_match[] = {
 	{ .compatible = "img,tz1090-pdc-pinctrl", },
 	{ },
@@ -980,7 +972,6 @@ static struct platform_driver tz1090_pdc_pinctrl_driver = {
 		.of_match_table	= tz1090_pdc_pinctrl_of_match,
 	},
 	.probe	= tz1090_pdc_pinctrl_probe,
-	.remove	= tz1090_pdc_pinctrl_remove,
 };
 
 static int __init tz1090_pdc_pinctrl_init(void)
-- 
2.1.4
