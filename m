From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:37:57 +0530
Subject: [PATCH 08/61] gpio: amdpt: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-9-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-amdpt.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index c248404..857eec5 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -212,7 +212,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
 #if defined(CONFIG_OF_GPIO)
 	pt_gpio->gc.of_node          = pdev->dev.of_node;
 #endif
-	ret = gpiochip_add_data(&pt_gpio->gc, pt_gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &pt_gpio->gc, pt_gpio);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register GPIO lib\n");
 		return ret;
@@ -228,15 +228,6 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pt_gpio_remove(struct platform_device *pdev)
-{
-	struct pt_gpio_chip *pt_gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&pt_gpio->gc);
-
-	return 0;
-}
-
 static const struct acpi_device_id pt_gpio_acpi_match[] = {
 	{ "AMDF030", 0 },
 	{ },
@@ -249,7 +240,6 @@ static struct platform_driver pt_gpio_driver = {
 		.acpi_match_table = ACPI_PTR(pt_gpio_acpi_match),
 	},
 	.probe = pt_gpio_probe,
-	.remove = pt_gpio_remove,
 };
 
 module_platform_driver(pt_gpio_driver);
-- 
2.1.4
