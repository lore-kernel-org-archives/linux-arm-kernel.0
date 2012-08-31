From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 31 Aug 2012 14:59:20 +0530
Subject: [PATCH 4/5] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
References: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
Message-ID: <1346405361-29711-5-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adopt pinctrl support to leds-gpio driver, based on the device
pointer (leds-gpio) pinctrl driver configure SoC pins to GPIO
mode.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/leds/leds-gpio.c |   31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index c032b21..d98dfb9 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 
 struct gpio_led_data {
 	struct led_classdev cdev;
@@ -236,14 +237,23 @@ static int __devinit gpio_led_probe(struct platform_device *pdev)
 {
 	struct gpio_led_platform_data *pdata = pdev->dev.platform_data;
 	struct gpio_leds_priv *priv;
-	int i, ret = 0;
+	struct pinctrl *pinctrl;
+	int i = 0;
+	int ret = 0;
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		return PTR_ERR(pinctrl);
+	}
 
 	if (pdata && pdata->num_leds) {
 		priv = devm_kzalloc(&pdev->dev,
 				sizeof_gpio_leds_priv(pdata->num_leds),
 					GFP_KERNEL);
-		if (!priv)
-			return -ENOMEM;
+		if (!priv) {
+			ret = -ENOMEM;
+			goto err_pctrl_put;
+		}
 
 		priv->num_leds = pdata->num_leds;
 		for (i = 0; i < priv->num_leds; i++) {
@@ -254,18 +264,25 @@ static int __devinit gpio_led_probe(struct platform_device *pdev)
 				/* On failure: unwind the led creations */
 				for (i = i - 1; i >= 0; i--)
 					delete_gpio_led(&priv->leds[i]);
-				return ret;
+				goto err_pctrl_put;
 			}
 		}
 	} else {
 		priv = gpio_leds_create_of(pdev);
-		if (!priv)
-			return -ENODEV;
+		if (!priv) {
+			ret = -ENODEV;
+			goto err_del_gpio_led;
+		}
 	}
 
 	platform_set_drvdata(pdev, priv);
 
-	return 0;
+err_pctrl_put:
+	pinctrl_put(pinctrl);
+err_del_gpio_led:
+	while (--i >= 0)
+		delete_gpio_led(&priv->leds[i]);
+	return ret;
 }
 
 static int __devexit gpio_led_remove(struct platform_device *pdev)
-- 
1.7.9.5
