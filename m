From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:25 +0530
Subject: [PATCH 36/61] gpio: rc5t583: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-37-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-rc5t583.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-rc5t583.c b/drivers/gpio/gpio-rc5t583.c
index 1e2d210..1d6100f 100644
--- a/drivers/gpio/gpio-rc5t583.c
+++ b/drivers/gpio/gpio-rc5t583.c
@@ -136,15 +136,8 @@ static int rc5t583_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rc5t583_gpio);
 
-	return gpiochip_add_data(&rc5t583_gpio->gpio_chip, rc5t583_gpio);
-}
-
-static int rc5t583_gpio_remove(struct platform_device *pdev)
-{
-	struct rc5t583_gpio *rc5t583_gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&rc5t583_gpio->gpio_chip);
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &rc5t583_gpio->gpio_chip,
+				      rc5t583_gpio);
 }
 
 static struct platform_driver rc5t583_gpio_driver = {
@@ -152,7 +145,6 @@ static struct platform_driver rc5t583_gpio_driver = {
 		.name    = "rc5t583-gpio",
 	},
 	.probe		= rc5t583_gpio_probe,
-	.remove		= rc5t583_gpio_remove,
 };
 
 static int __init rc5t583_gpio_init(void)
-- 
2.1.4
