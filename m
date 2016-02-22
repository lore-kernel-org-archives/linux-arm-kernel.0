From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:50 +0530
Subject: [PATCH 61/61] gpio: xgene: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-62-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-xgene.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-xgene.c b/drivers/gpio/gpio-xgene.c
index 592e9cd..c0aa387 100644
--- a/drivers/gpio/gpio-xgene.c
+++ b/drivers/gpio/gpio-xgene.c
@@ -193,7 +193,7 @@ static int xgene_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpio);
 
-	err = gpiochip_add_data(&gpio->chip, gpio);
+	err = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
 	if (err) {
 		dev_err(&pdev->dev,
 			"failed to register gpiochip.\n");
@@ -207,14 +207,6 @@ err:
 	return err;
 }
 
-static int xgene_gpio_remove(struct platform_device *pdev)
-{
-	struct xgene_gpio *gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&gpio->chip);
-	return 0;
-}
-
 static const struct of_device_id xgene_gpio_of_match[] = {
 	{ .compatible = "apm,xgene-gpio", },
 	{},
@@ -228,7 +220,6 @@ static struct platform_driver xgene_gpio_driver = {
 		.pm     = XGENE_GPIO_PM_OPS,
 	},
 	.probe = xgene_gpio_probe,
-	.remove = xgene_gpio_remove,
 };
 
 module_platform_driver(xgene_gpio_driver);
-- 
2.1.4
