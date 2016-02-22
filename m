From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:05 +0530
Subject: [PATCH 16/61] gpio: da9055: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-17-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Support Opensource <support.opensource@diasemi.com>
---
 drivers/gpio/gpio-da9055.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-da9055.c b/drivers/gpio/gpio-da9055.c
index 18210fb..2c2c18d 100644
--- a/drivers/gpio/gpio-da9055.c
+++ b/drivers/gpio/gpio-da9055.c
@@ -151,31 +151,19 @@ static int da9055_gpio_probe(struct platform_device *pdev)
 	if (pdata && pdata->gpio_base)
 		gpio->gp.base = pdata->gpio_base;
 
-	ret = gpiochip_add_data(&gpio->gp, gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &gpio->gp, gpio);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
-		goto err_mem;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, gpio);
 
 	return 0;
-
-err_mem:
-	return ret;
-}
-
-static int da9055_gpio_remove(struct platform_device *pdev)
-{
-	struct da9055_gpio *gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&gpio->gp);
-	return 0;
 }
 
 static struct platform_driver da9055_gpio_driver = {
 	.probe = da9055_gpio_probe,
-	.remove = da9055_gpio_remove,
 	.driver = {
 		.name	= "da9055-gpio",
 	},
-- 
2.1.4
