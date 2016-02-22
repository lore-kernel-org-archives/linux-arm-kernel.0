From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:37:58 +0530
Subject: [PATCH 09/61] gpio: arizona: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-10-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: patches at opensource.wolfsonmicro.com
---
 drivers/gpio/gpio-arizona.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index e910c1f..9913704 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -132,7 +132,8 @@ static int arizona_gpio_probe(struct platform_device *pdev)
 	else
 		arizona_gpio->gpio_chip.base = -1;
 
-	ret = gpiochip_add_data(&arizona_gpio->gpio_chip, arizona_gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &arizona_gpio->gpio_chip,
+				     arizona_gpio);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not register gpiochip, %d\n",
 			ret);
@@ -147,18 +148,9 @@ err:
 	return ret;
 }
 
-static int arizona_gpio_remove(struct platform_device *pdev)
-{
-	struct arizona_gpio *arizona_gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&arizona_gpio->gpio_chip);
-	return 0;
-}
-
 static struct platform_driver arizona_gpio_driver = {
 	.driver.name	= "arizona-gpio",
 	.probe		= arizona_gpio_probe,
-	.remove		= arizona_gpio_remove,
 };
 
 module_platform_driver(arizona_gpio_driver);
-- 
2.1.4
