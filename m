From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:48 +0530
Subject: [PATCH 59/61] gpio: wm8994: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-60-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: patches at opensource.wolfsonmicro.com
---
 drivers/gpio/gpio-wm8994.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-wm8994.c b/drivers/gpio/gpio-wm8994.c
index 3ae4c15..b089df9 100644
--- a/drivers/gpio/gpio-wm8994.c
+++ b/drivers/gpio/gpio-wm8994.c
@@ -261,34 +261,23 @@ static int wm8994_gpio_probe(struct platform_device *pdev)
 	else
 		wm8994_gpio->gpio_chip.base = -1;
 
-	ret = gpiochip_add_data(&wm8994_gpio->gpio_chip, wm8994_gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &wm8994_gpio->gpio_chip,
+				     wm8994_gpio);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not register gpiochip, %d\n",
 			ret);
-		goto err;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, wm8994_gpio);
 
 	return ret;
-
-err:
-	return ret;
-}
-
-static int wm8994_gpio_remove(struct platform_device *pdev)
-{
-	struct wm8994_gpio *wm8994_gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&wm8994_gpio->gpio_chip);
-	return 0;
 }
 
 static struct platform_driver wm8994_gpio_driver = {
 	.driver.name	= "wm8994-gpio",
 	.driver.owner	= THIS_MODULE,
 	.probe		= wm8994_gpio_probe,
-	.remove		= wm8994_gpio_remove,
 };
 
 static int __init wm8994_gpio_init(void)
-- 
2.1.4
