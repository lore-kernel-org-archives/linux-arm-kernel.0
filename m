From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:44 +0530
Subject: [PATCH 55/61] gpio: viperboard: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-56-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-viperboard.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-viperboard.c b/drivers/gpio/gpio-viperboard.c
index 1170b03..dec47aa 100644
--- a/drivers/gpio/gpio-viperboard.c
+++ b/drivers/gpio/gpio-viperboard.c
@@ -410,10 +410,10 @@ static int vprbrd_gpio_probe(struct platform_device *pdev)
 	vb_gpio->gpioa.get = vprbrd_gpioa_get;
 	vb_gpio->gpioa.direction_input = vprbrd_gpioa_direction_input;
 	vb_gpio->gpioa.direction_output = vprbrd_gpioa_direction_output;
-	ret = gpiochip_add_data(&vb_gpio->gpioa, vb_gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &vb_gpio->gpioa, vb_gpio);
 	if (ret < 0) {
 		dev_err(vb_gpio->gpioa.parent, "could not add gpio a");
-		goto err_gpioa;
+		return ret;
 	}
 
 	/* registering gpio b */
@@ -427,37 +427,21 @@ static int vprbrd_gpio_probe(struct platform_device *pdev)
 	vb_gpio->gpiob.get = vprbrd_gpiob_get;
 	vb_gpio->gpiob.direction_input = vprbrd_gpiob_direction_input;
 	vb_gpio->gpiob.direction_output = vprbrd_gpiob_direction_output;
-	ret = gpiochip_add_data(&vb_gpio->gpiob, vb_gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &vb_gpio->gpiob, vb_gpio);
 	if (ret < 0) {
 		dev_err(vb_gpio->gpiob.parent, "could not add gpio b");
-		goto err_gpiob;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, vb_gpio);
 
 	return ret;
-
-err_gpiob:
-	gpiochip_remove(&vb_gpio->gpioa);
-
-err_gpioa:
-	return ret;
-}
-
-static int vprbrd_gpio_remove(struct platform_device *pdev)
-{
-	struct vprbrd_gpio *vb_gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&vb_gpio->gpiob);
-
-	return 0;
 }
 
 static struct platform_driver vprbrd_gpio_driver = {
 	.driver.name	= "viperboard-gpio",
 	.driver.owner	= THIS_MODULE,
 	.probe		= vprbrd_gpio_probe,
-	.remove		= vprbrd_gpio_remove,
 };
 
 static int __init vprbrd_gpio_init(void)
-- 
2.1.4
