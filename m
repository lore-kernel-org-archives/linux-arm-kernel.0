From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:58 +0530
Subject: [PATCH 33/50] pinctrl: adi2: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-34-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and remove
the need of .remove callback.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pinctrl/pinctrl-adi2.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-adi2.c b/drivers/pinctrl/pinctrl-adi2.c
index ecb57635..54569a7 100644
--- a/drivers/pinctrl/pinctrl-adi2.c
+++ b/drivers/pinctrl/pinctrl-adi2.c
@@ -1058,7 +1058,8 @@ static int adi_pinctrl_probe(struct platform_device *pdev)
 	adi_pinmux_desc.npins = pinctrl->soc->npins;
 
 	/* Now register the pin controller and all pins it handles */
-	pinctrl->pctl = pinctrl_register(&adi_pinmux_desc, &pdev->dev, pinctrl);
+	pinctrl->pctl = devm_pinctrl_register(&pdev->dev, &adi_pinmux_desc,
+					      pinctrl);
 	if (IS_ERR(pinctrl->pctl)) {
 		dev_err(&pdev->dev, "could not register pinctrl ADI2 driver\n");
 		return PTR_ERR(pinctrl->pctl);
@@ -1069,18 +1070,8 @@ static int adi_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int adi_pinctrl_remove(struct platform_device *pdev)
-{
-	struct adi_pinctrl *pinctrl = platform_get_drvdata(pdev);
-
-	pinctrl_unregister(pinctrl->pctl);
-
-	return 0;
-}
-
 static struct platform_driver adi_pinctrl_driver = {
 	.probe		= adi_pinctrl_probe,
-	.remove		= adi_pinctrl_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 	},
-- 
2.1.4
