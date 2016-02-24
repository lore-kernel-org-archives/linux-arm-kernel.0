From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:35 +0530
Subject: [PATCH 10/50] pinctrl: imxl: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-11-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and remove
need of .remove callback.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Hongzhou Yang <hongzhou.yang@mediatek.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/freescale/pinctrl-imx1-core.c | 11 +----------
 drivers/pinctrl/freescale/pinctrl-imx1.c      |  1 -
 drivers/pinctrl/freescale/pinctrl-imx1.h      |  1 -
 drivers/pinctrl/freescale/pinctrl-imx21.c     |  1 -
 drivers/pinctrl/freescale/pinctrl-imx27.c     |  1 -
 5 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx1-core.c b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
index acaf84c..b4400cb 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
@@ -635,7 +635,7 @@ int imx1_pinctrl_core_probe(struct platform_device *pdev,
 	ipctl->info = info;
 	ipctl->dev = info->dev;
 	platform_set_drvdata(pdev, ipctl);
-	ipctl->pctl = pinctrl_register(pctl_desc, &pdev->dev, ipctl);
+	ipctl->pctl = devm_pinctrl_register(&pdev->dev, pctl_desc, ipctl);
 	if (IS_ERR(ipctl->pctl)) {
 		dev_err(&pdev->dev, "could not register IMX pinctrl driver\n");
 		return PTR_ERR(ipctl->pctl);
@@ -652,12 +652,3 @@ int imx1_pinctrl_core_probe(struct platform_device *pdev,
 
 	return 0;
 }
-
-int imx1_pinctrl_core_remove(struct platform_device *pdev)
-{
-	struct imx1_pinctrl *ipctl = platform_get_drvdata(pdev);
-
-	pinctrl_unregister(ipctl->pctl);
-
-	return 0;
-}
diff --git a/drivers/pinctrl/freescale/pinctrl-imx1.c b/drivers/pinctrl/freescale/pinctrl-imx1.c
index d3bacb7..0472345 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx1.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx1.c
@@ -269,7 +269,6 @@ static struct platform_driver imx1_pinctrl_driver = {
 		.name		= "imx1-pinctrl",
 		.of_match_table	= imx1_pinctrl_of_match,
 	},
-	.remove	= imx1_pinctrl_core_remove,
 };
 module_platform_driver_probe(imx1_pinctrl_driver, imx1_pinctrl_probe);
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx1.h b/drivers/pinctrl/freescale/pinctrl-imx1.h
index 692a54c..1740743 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx1.h
+++ b/drivers/pinctrl/freescale/pinctrl-imx1.h
@@ -69,5 +69,4 @@ struct imx1_pinctrl_soc_info {
 
 int imx1_pinctrl_core_probe(struct platform_device *pdev,
 			struct imx1_pinctrl_soc_info *info);
-int imx1_pinctrl_core_remove(struct platform_device *pdev);
 #endif /* __DRIVERS_PINCTRL_IMX1_H */
diff --git a/drivers/pinctrl/freescale/pinctrl-imx21.c b/drivers/pinctrl/freescale/pinctrl-imx21.c
index 9d9aca3..aa1221f 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx21.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx21.c
@@ -332,7 +332,6 @@ static struct platform_driver imx21_pinctrl_driver = {
 		.name		= "imx21-pinctrl",
 		.of_match_table	= imx21_pinctrl_of_match,
 	},
-	.remove	= imx1_pinctrl_core_remove,
 };
 module_platform_driver_probe(imx21_pinctrl_driver, imx21_pinctrl_probe);
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx27.c b/drivers/pinctrl/freescale/pinctrl-imx27.c
index a461d58..f828fbb 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx27.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx27.c
@@ -405,7 +405,6 @@ static struct platform_driver imx27_pinctrl_driver = {
 		.of_match_table = of_match_ptr(imx27_pinctrl_of_match),
 	},
 	.probe = imx27_pinctrl_probe,
-	.remove = imx1_pinctrl_core_remove,
 };
 
 static int __init imx27_pinctrl_init(void)
-- 
2.1.4
