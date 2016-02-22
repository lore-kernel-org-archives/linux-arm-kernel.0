From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:21 +0530
Subject: [PATCH 32/61] gpio: octeon: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-33-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-octeon.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-octeon.c b/drivers/gpio/gpio-octeon.c
index 7665ebc..47aead1 100644
--- a/drivers/gpio/gpio-octeon.c
+++ b/drivers/gpio/gpio-octeon.c
@@ -117,7 +117,7 @@ static int octeon_gpio_probe(struct platform_device *pdev)
 	chip->get = octeon_gpio_get;
 	chip->direction_output = octeon_gpio_dir_out;
 	chip->set = octeon_gpio_set;
-	err = gpiochip_add_data(chip, gpio);
+	err = devm_gpiochip_add_data(&pdev->dev, chip, gpio);
 	if (err)
 		goto out;
 
@@ -126,13 +126,6 @@ out:
 	return err;
 }
 
-static int octeon_gpio_remove(struct platform_device *pdev)
-{
-	struct gpio_chip *chip = dev_get_platdata(&pdev->dev);
-	gpiochip_remove(chip);
-	return 0;
-}
-
 static struct of_device_id octeon_gpio_match[] = {
 	{
 		.compatible = "cavium,octeon-3860-gpio",
@@ -147,7 +140,6 @@ static struct platform_driver octeon_gpio_driver = {
 		.of_match_table = octeon_gpio_match,
 	},
 	.probe		= octeon_gpio_probe,
-	.remove		= octeon_gpio_remove,
 };
 
 module_platform_driver(octeon_gpio_driver);
-- 
2.1.4
