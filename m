From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:37 +0530
Subject: [PATCH 48/61] gpio: tps6586x: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-49-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-tps6586x.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-tps6586x.c b/drivers/gpio/gpio-tps6586x.c
index 87de548..c88bdc8 100644
--- a/drivers/gpio/gpio-tps6586x.c
+++ b/drivers/gpio/gpio-tps6586x.c
@@ -117,7 +117,8 @@ static int tps6586x_gpio_probe(struct platform_device *pdev)
 	else
 		tps6586x_gpio->gpio_chip.base = -1;
 
-	ret = gpiochip_add_data(&tps6586x_gpio->gpio_chip, tps6586x_gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &tps6586x_gpio->gpio_chip,
+				     tps6586x_gpio);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
 		return ret;
@@ -128,19 +129,10 @@ static int tps6586x_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tps6586x_gpio_remove(struct platform_device *pdev)
-{
-	struct tps6586x_gpio *tps6586x_gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&tps6586x_gpio->gpio_chip);
-	return 0;
-}
-
 static struct platform_driver tps6586x_gpio_driver = {
 	.driver.name	= "tps6586x-gpio",
 	.driver.owner	= THIS_MODULE,
 	.probe		= tps6586x_gpio_probe,
-	.remove		= tps6586x_gpio_remove,
 };
 
 static int __init tps6586x_gpio_init(void)
-- 
2.1.4
