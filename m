From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:45 +0530
Subject: [PATCH 56/61] gpio: vx855: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-57-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-vx855.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-vx855.c b/drivers/gpio/gpio-vx855.c
index 764999c..8cdb9f7 100644
--- a/drivers/gpio/gpio-vx855.c
+++ b/drivers/gpio/gpio-vx855.c
@@ -259,16 +259,7 @@ static int vx855gpio_probe(struct platform_device *pdev)
 
 	vx855gpio_gpio_setup(vg);
 
-	return gpiochip_add_data(&vg->gpio, vg);
-}
-
-static int vx855gpio_remove(struct platform_device *pdev)
-{
-	struct vx855_gpio *vg = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&vg->gpio);
-
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &vg->gpio, vg);
 }
 
 static struct platform_driver vx855gpio_driver = {
@@ -276,7 +267,6 @@ static struct platform_driver vx855gpio_driver = {
 		.name	= MODULE_NAME,
 	},
 	.probe		= vx855gpio_probe,
-	.remove		= vx855gpio_remove,
 };
 
 module_platform_driver(vx855gpio_driver);
-- 
2.1.4
