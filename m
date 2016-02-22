From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:40 +0530
Subject: [PATCH 51/61] gpio: ts4800: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-52-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-ts4800.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index c4908a4..b8762d9 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -61,16 +61,7 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chip);
 
-	return gpiochip_add_data(chip, NULL);
-}
-
-static int ts4800_gpio_remove(struct platform_device *pdev)
-{
-	struct gpio_chip *chip = platform_get_drvdata(pdev);
-
-	gpiochip_remove(chip);
-
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, chip, NULL);
 }
 
 static const struct of_device_id ts4800_gpio_of_match[] = {
@@ -84,7 +75,6 @@ static struct platform_driver ts4800_gpio_driver = {
 		   .of_match_table = ts4800_gpio_of_match,
 		   },
 	.probe = ts4800_gpio_probe,
-	.remove = ts4800_gpio_remove,
 };
 
 module_platform_driver_probe(ts4800_gpio_driver, ts4800_gpio_probe);
-- 
2.1.4
