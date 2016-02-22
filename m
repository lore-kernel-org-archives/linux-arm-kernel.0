From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:38 +0530
Subject: [PATCH 49/61] gpio: tps65910: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-50-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-tps65910.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-tps65910.c b/drivers/gpio/gpio-tps65910.c
index e81eee7..cdbd7c7 100644
--- a/drivers/gpio/gpio-tps65910.c
+++ b/drivers/gpio/gpio-tps65910.c
@@ -170,7 +170,8 @@ static int tps65910_gpio_probe(struct platform_device *pdev)
 	}
 
 skip_init:
-	ret = gpiochip_add_data(&tps65910_gpio->gpio_chip, tps65910_gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &tps65910_gpio->gpio_chip,
+				     tps65910_gpio);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
 		return ret;
@@ -181,19 +182,10 @@ skip_init:
 	return ret;
 }
 
-static int tps65910_gpio_remove(struct platform_device *pdev)
-{
-	struct tps65910_gpio *tps65910_gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&tps65910_gpio->gpio_chip);
-	return 0;
-}
-
 static struct platform_driver tps65910_gpio_driver = {
 	.driver.name    = "tps65910-gpio",
 	.driver.owner   = THIS_MODULE,
 	.probe		= tps65910_gpio_probe,
-	.remove		= tps65910_gpio_remove,
 };
 
 static int __init tps65910_gpio_init(void)
-- 
2.1.4
