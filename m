From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:47 +0530
Subject: [PATCH 58/61] gpio: wm8350: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-59-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: patches at opensource.wolfsonmicro.com
---
 drivers/gpio/gpio-wm8350.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-wm8350.c b/drivers/gpio/gpio-wm8350.c
index 0a306b4..07d45a3 100644
--- a/drivers/gpio/gpio-wm8350.c
+++ b/drivers/gpio/gpio-wm8350.c
@@ -125,7 +125,8 @@ static int wm8350_gpio_probe(struct platform_device *pdev)
 	else
 		wm8350_gpio->gpio_chip.base = -1;
 
-	ret = gpiochip_add_data(&wm8350_gpio->gpio_chip, wm8350_gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &wm8350_gpio->gpio_chip,
+				     wm8350_gpio);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
 		return ret;
@@ -136,19 +137,10 @@ static int wm8350_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int wm8350_gpio_remove(struct platform_device *pdev)
-{
-	struct wm8350_gpio_data *wm8350_gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&wm8350_gpio->gpio_chip);
-	return 0;
-}
-
 static struct platform_driver wm8350_gpio_driver = {
 	.driver.name	= "wm8350-gpio",
 	.driver.owner	= THIS_MODULE,
 	.probe		= wm8350_gpio_probe,
-	.remove		= wm8350_gpio_remove,
 };
 
 static int __init wm8350_gpio_init(void)
-- 
2.1.4
