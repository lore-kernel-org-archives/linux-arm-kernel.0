From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:32 +0530
Subject: [PATCH 43/61] gpio: syscon: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-44-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-syscon.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index e5c5b62..24b6d64 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -238,15 +238,7 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	return gpiochip_add_data(&priv->chip, priv);
-}
-
-static int syscon_gpio_remove(struct platform_device *pdev)
-{
-	struct syscon_gpio_priv *priv = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&priv->chip);
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &priv->chip, priv);
 }
 
 static struct platform_driver syscon_gpio_driver = {
@@ -255,7 +247,6 @@ static struct platform_driver syscon_gpio_driver = {
 		.of_match_table	= syscon_gpio_ids,
 	},
 	.probe	= syscon_gpio_probe,
-	.remove	= syscon_gpio_remove,
 };
 module_platform_driver(syscon_gpio_driver);
 
-- 
2.1.4
