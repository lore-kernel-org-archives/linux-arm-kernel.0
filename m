From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:13 +0530
Subject: [PATCH 24/61] gpio: kempld: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-25-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-kempld.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-kempld.c b/drivers/gpio/gpio-kempld.c
index 0111774..701f151 100644
--- a/drivers/gpio/gpio-kempld.c
+++ b/drivers/gpio/gpio-kempld.c
@@ -178,7 +178,7 @@ static int kempld_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ret = gpiochip_add_data(chip, gpio);
+	ret = devm_gpiochip_add_data(dev, chip, gpio);
 	if (ret) {
 		dev_err(dev, "Could not register GPIO chip\n");
 		return ret;
@@ -190,20 +190,11 @@ static int kempld_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int kempld_gpio_remove(struct platform_device *pdev)
-{
-	struct kempld_gpio_data *gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&gpio->chip);
-	return 0;
-}
-
 static struct platform_driver kempld_gpio_driver = {
 	.driver = {
 		.name = "kempld-gpio",
 	},
 	.probe		= kempld_gpio_probe,
-	.remove		= kempld_gpio_remove,
 };
 
 module_platform_driver(kempld_gpio_driver);
-- 
2.1.4
