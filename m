From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:24 +0530
Subject: [PATCH 35/61] gpio: palmas: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-36-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-palmas.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-palmas.c b/drivers/gpio/gpio-palmas.c
index fdfb3b1..6f27b3d 100644
--- a/drivers/gpio/gpio-palmas.c
+++ b/drivers/gpio/gpio-palmas.c
@@ -195,7 +195,8 @@ static int palmas_gpio_probe(struct platform_device *pdev)
 	else
 		palmas_gpio->gpio_chip.base = -1;
 
-	ret = gpiochip_add_data(&palmas_gpio->gpio_chip, palmas_gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &palmas_gpio->gpio_chip,
+				     palmas_gpio);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
 		return ret;
@@ -205,20 +206,11 @@ static int palmas_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int palmas_gpio_remove(struct platform_device *pdev)
-{
-	struct palmas_gpio *palmas_gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&palmas_gpio->gpio_chip);
-	return 0;
-}
-
 static struct platform_driver palmas_gpio_driver = {
 	.driver.name	= "palmas-gpio",
 	.driver.owner	= THIS_MODULE,
 	.driver.of_match_table = of_palmas_gpio_match,
 	.probe		= palmas_gpio_probe,
-	.remove		= palmas_gpio_remove,
 };
 
 static int __init palmas_gpio_init(void)
-- 
2.1.4
