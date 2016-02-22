From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:34 +0530
Subject: [PATCH 45/61] gpio: tc3589x: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-46-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-tc3589x.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-tc3589x.c b/drivers/gpio/gpio-tc3589x.c
index 05a27ec..4f566e6 100644
--- a/drivers/gpio/gpio-tc3589x.c
+++ b/drivers/gpio/gpio-tc3589x.c
@@ -272,7 +272,8 @@ static int tc3589x_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = gpiochip_add_data(&tc3589x_gpio->chip, tc3589x_gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &tc3589x_gpio->chip,
+				     tc3589x_gpio);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to add gpiochip: %d\n", ret);
 		return ret;
@@ -299,20 +300,10 @@ static int tc3589x_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tc3589x_gpio_remove(struct platform_device *pdev)
-{
-	struct tc3589x_gpio *tc3589x_gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&tc3589x_gpio->chip);
-
-	return 0;
-}
-
 static struct platform_driver tc3589x_gpio_driver = {
 	.driver.name	= "tc3589x-gpio",
 	.driver.owner	= THIS_MODULE,
 	.probe		= tc3589x_gpio_probe,
-	.remove		= tc3589x_gpio_remove,
 };
 
 static int __init tc3589x_gpio_init(void)
-- 
2.1.4
