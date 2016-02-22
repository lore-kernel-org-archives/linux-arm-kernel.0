From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:37:53 +0530
Subject: [PATCH 04/61] gpio: 74xx-mmio: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-5-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
call for gpiochip_remove() from error path.

Also remove the need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/gpio/gpio-74xx-mmio.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
index 372b0e0..0475e8e 100644
--- a/drivers/gpio/gpio-74xx-mmio.c
+++ b/drivers/gpio/gpio-74xx-mmio.c
@@ -140,15 +140,7 @@ static int mmio_74xx_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	return gpiochip_add_data(&priv->gc, priv);
-}
-
-static int mmio_74xx_gpio_remove(struct platform_device *pdev)
-{
-	struct mmio_74xx_gpio_priv *priv = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&priv->gc);
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
 }
 
 static struct platform_driver mmio_74xx_gpio_driver = {
@@ -157,7 +149,6 @@ static struct platform_driver mmio_74xx_gpio_driver = {
 		.of_match_table	= mmio_74xx_gpio_ids,
 	},
 	.probe	= mmio_74xx_gpio_probe,
-	.remove	= mmio_74xx_gpio_remove,
 };
 module_platform_driver(mmio_74xx_gpio_driver);
 
-- 
2.1.4
