From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:42 +0530
Subject: [PATCH 53/61] gpio: twl6040: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-54-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-twl6040.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-twl6040.c b/drivers/gpio/gpio-twl6040.c
index 8e9e985..b780314 100644
--- a/drivers/gpio/gpio-twl6040.c
+++ b/drivers/gpio/gpio-twl6040.c
@@ -100,7 +100,7 @@ static int gpo_twl6040_probe(struct platform_device *pdev)
 	twl6040gpo_chip.of_node = twl6040_core_dev->of_node;
 #endif
 
-	ret = gpiochip_add_data(&twl6040gpo_chip, NULL);
+	ret = devm_gpiochip_add_data(&pdev->dev, &twl6040gpo_chip, NULL);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
 		twl6040gpo_chip.ngpio = 0;
@@ -109,12 +109,6 @@ static int gpo_twl6040_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int gpo_twl6040_remove(struct platform_device *pdev)
-{
-	gpiochip_remove(&twl6040gpo_chip);
-	return 0;
-}
-
 /* Note:  this hardware lives inside an I2C-based multi-function device. */
 MODULE_ALIAS("platform:twl6040-gpo");
 
@@ -123,7 +117,6 @@ static struct platform_driver gpo_twl6040_driver = {
 		.name	= "twl6040-gpo",
 	},
 	.probe		= gpo_twl6040_probe,
-	.remove		= gpo_twl6040_remove,
 };
 
 module_platform_driver(gpo_twl6040_driver);
-- 
2.1.4
