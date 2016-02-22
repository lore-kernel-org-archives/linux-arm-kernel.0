From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:04 +0530
Subject: [PATCH 15/61] gpio: da9052: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-16-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-da9052.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-da9052.c b/drivers/gpio/gpio-da9052.c
index f9b3247..e29553b 100644
--- a/drivers/gpio/gpio-da9052.c
+++ b/drivers/gpio/gpio-da9052.c
@@ -214,7 +214,7 @@ static int da9052_gpio_probe(struct platform_device *pdev)
 	if (pdata && pdata->gpio_base)
 		gpio->gp.base = pdata->gpio_base;
 
-	ret = gpiochip_add_data(&gpio->gp, gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &gpio->gp, gpio);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
 		return ret;
@@ -225,17 +225,8 @@ static int da9052_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int da9052_gpio_remove(struct platform_device *pdev)
-{
-	struct da9052_gpio *gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&gpio->gp);
-	return 0;
-}
-
 static struct platform_driver da9052_gpio_driver = {
 	.probe = da9052_gpio_probe,
-	.remove = da9052_gpio_remove,
 	.driver = {
 		.name	= "da9052-gpio",
 	},
-- 
2.1.4
