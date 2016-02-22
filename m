From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:03 +0530
Subject: [PATCH 14/61] gpio: cs5535: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-15-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-cs5535.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-cs5535.c b/drivers/gpio/gpio-cs5535.c
index eccb712..90278b1 100644
--- a/drivers/gpio/gpio-cs5535.c
+++ b/drivers/gpio/gpio-cs5535.c
@@ -320,13 +320,13 @@ static int cs5535_gpio_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "can't fetch device resource info\n");
-		goto done;
+		return err;
 	}
 
 	if (!devm_request_region(&pdev->dev, res->start, resource_size(res),
 				 pdev->name)) {
 		dev_err(&pdev->dev, "can't request region\n");
-		goto done;
+		return err;
 	}
 
 	/* set up the driver-specific struct */
@@ -348,19 +348,10 @@ static int cs5535_gpio_probe(struct platform_device *pdev)
 				mask_orig, mask);
 
 	/* finally, register with the generic GPIO API */
-	err = gpiochip_add_data(&cs5535_gpio_chip.chip, &cs5535_gpio_chip);
+	err = devm_gpiochip_add_data(&pdev->dev, &cs5535_gpio_chip.chip,
+				     &cs5535_gpio_chip);
 	if (err)
-		goto done;
-
-	return 0;
-
-done:
-	return err;
-}
-
-static int cs5535_gpio_remove(struct platform_device *pdev)
-{
-	gpiochip_remove(&cs5535_gpio_chip.chip);
+		return err;
 
 	return 0;
 }
@@ -370,7 +361,6 @@ static struct platform_driver cs5535_gpio_driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cs5535_gpio_probe,
-	.remove = cs5535_gpio_remove,
 };
 
 module_platform_driver(cs5535_gpio_driver);
-- 
2.1.4
