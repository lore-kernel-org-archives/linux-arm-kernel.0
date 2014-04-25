From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:42:21 +0100
Subject: [PATCH 128/222] leds: leds-pwm: convert OF parsing code to use
 led_pwm_add()
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeWL-0007Lm-Aa@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the OF parsing code to use the common PWM LED registration code,
which means we have a consistent method, and single point where the
registration happens for both paths.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/leds/leds-pwm.c | 62 ++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 203e332967b2..35c1c5f144dc 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -93,7 +93,7 @@ static void led_pwm_cleanup(struct led_pwm_priv *priv)
 }
 
 static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
-		       struct led_pwm *led)
+		       struct led_pwm *led, struct device_node *child)
 {
 	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
 	int ret;
@@ -107,7 +107,10 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 	led_data->cdev.max_brightness = led->max_brightness;
 	led_data->cdev.flags = LED_CORE_SUSPENDRESUME;
 
-	led_data->pwm = devm_pwm_get(dev, led->name);
+	if (child)
+		led_data->pwm = devm_of_pwm_get(dev, child, NULL);
+	else
+		led_data->pwm = devm_pwm_get(dev, led->name);
 	if (IS_ERR(led_data->pwm)) {
 		ret = PTR_ERR(led_data->pwm);
 		dev_err(dev, "unable to request PWM for %s: %d\n",
@@ -115,6 +118,9 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		return ret;
 	}
 
+	if (child)
+		led_data->period = pwm_get_period(led_data->pwm);
+
 	led_data->can_sleep = pwm_can_sleep(led_data->pwm);
 	if (led_data->can_sleep)
 		INIT_WORK(&led_data->work, led_pwm_work);
@@ -130,53 +136,30 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 	return ret;
 }
 
-static int led_pwm_create_of(struct platform_device *pdev,
-			     struct led_pwm_priv *priv)
+static int led_pwm_create_of(struct device *dev, struct led_pwm_priv *priv)
 {
 	struct device_node *child;
-	int ret;
-
-	for_each_child_of_node(pdev->dev.of_node, child) {
-		struct led_pwm_data *led_dat = &priv->leds[priv->num_leds];
+	struct led_pwm led;
+	int ret = 0;
 
-		led_dat->cdev.name = of_get_property(child, "label",
-						     NULL) ? : child->name;
+	memset(&led, 0, sizeof(led));
 
-		led_dat->pwm = devm_of_pwm_get(&pdev->dev, child, NULL);
-		if (IS_ERR(led_dat->pwm)) {
-			dev_err(&pdev->dev, "unable to request PWM for %s\n",
-				led_dat->cdev.name);
-			ret = PTR_ERR(led_dat->pwm);
-			goto err;
-		}
-		/* Get the period from PWM core when n*/
-		led_dat->period = pwm_get_period(led_dat->pwm);
+	for_each_child_of_node(dev->of_node, child) {
+		led.name = of_get_property(child, "label", NULL) ? :
+			   child->name;
 
-		led_dat->cdev.default_trigger = of_get_property(child,
+		led.default_trigger = of_get_property(child,
 						"linux,default-trigger", NULL);
 		of_property_read_u32(child, "max-brightness",
-				     &led_dat->cdev.max_brightness);
-
-		led_dat->cdev.brightness_set = led_pwm_set;
-		led_dat->cdev.brightness = LED_OFF;
-		led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
-
-		led_dat->can_sleep = pwm_can_sleep(led_dat->pwm);
-		if (led_dat->can_sleep)
-			INIT_WORK(&led_dat->work, led_pwm_work);
+				     &led.max_brightness);
 
-		ret = led_classdev_register(&pdev->dev, &led_dat->cdev);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to register for %s\n",
-				led_dat->cdev.name);
+		ret = led_pwm_add(dev, priv, &led, child);
+		if (ret) {
 			of_node_put(child);
-			goto err;
+			break;
 		}
-		priv->num_leds++;
 	}
 
-	return 0;
-err:
 	return ret;
 }
 
@@ -202,12 +185,13 @@ static int led_pwm_probe(struct platform_device *pdev)
 
 	if (pdata) {
 		for (i = 0; i < count; i++) {
-			ret = led_pwm_add(&pdev->dev, priv, &pdata->leds[i]);
+			ret = led_pwm_add(&pdev->dev, priv, &pdata->leds[i],
+					  NULL);
 			if (ret)
 				break;
 		}
 	} else {
-		ret = led_pwm_create_of(pdev, priv);
+		ret = led_pwm_create_of(&pdev->dev, priv);
 	}
 
 	if (ret) {
-- 
1.8.3.1
