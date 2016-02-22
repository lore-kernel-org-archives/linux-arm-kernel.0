From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:26 +0530
Subject: [PATCH 37/61] gpio: rdc321x: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-38-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-rdc321x.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-rdc321x.c b/drivers/gpio/gpio-rdc321x.c
index 96ddee3..ec945b9 100644
--- a/drivers/gpio/gpio-rdc321x.c
+++ b/drivers/gpio/gpio-rdc321x.c
@@ -194,23 +194,14 @@ static int rdc321x_gpio_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "registering %d GPIOs\n",
 					rdc321x_gpio_dev->chip.ngpio);
-	return gpiochip_add_data(&rdc321x_gpio_dev->chip, rdc321x_gpio_dev);
-}
-
-static int rdc321x_gpio_remove(struct platform_device *pdev)
-{
-	struct rdc321x_gpio *rdc321x_gpio_dev = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&rdc321x_gpio_dev->chip);
-
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &rdc321x_gpio_dev->chip,
+				      rdc321x_gpio_dev);
 }
 
 static struct platform_driver rdc321x_gpio_driver = {
 	.driver.name	= "rdc321x-gpio",
 	.driver.owner	= THIS_MODULE,
 	.probe		= rdc321x_gpio_probe,
-	.remove		= rdc321x_gpio_remove,
 };
 
 module_platform_driver(rdc321x_gpio_driver);
-- 
2.1.4
