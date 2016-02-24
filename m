From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:47 +0530
Subject: [PATCH 22/50] pinctrl: pxa: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-23-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and clean
the error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index 216f227..deb6aa1 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -416,7 +416,7 @@ int pxa2xx_pinctrl_init(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	pctl->pctl_dev = pinctrl_register(&pctl->desc, &pdev->dev, pctl);
+	pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, &pctl->desc, pctl);
 	if (IS_ERR(pctl->pctl_dev)) {
 		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
 		return PTR_ERR(pctl->pctl_dev);
@@ -427,11 +427,3 @@ int pxa2xx_pinctrl_init(struct platform_device *pdev,
 	return 0;
 }
 EXPORT_SYMBOL(pxa2xx_pinctrl_init);
-
-int pxa2xx_pinctrl_exit(struct platform_device *pdev)
-{
-	struct pxa_pinctrl *pctl = platform_get_drvdata(pdev);
-
-	pinctrl_unregister(pctl->pctl_dev);
-	return 0;
-}
-- 
2.1.4
