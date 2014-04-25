From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:42:16 +0100
Subject: [PATCH 127/222] leds: leds-pwm: provide a common function to setup a
 single led-pwm device
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeWG-0007Lh-74@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a common function to setup a single led-pwm device, replacing
the platform data initialisation path with this function.  This allows
us to have a common method of creating these devices in a consistent
manner, which then allows us to place the probe failure cleanup in one
place.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/leds/leds-pwm.c | 85 ++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 7d0aaed1e23a..203e332967b2 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -92,6 +92,44 @@ static void led_pwm_cleanup(struct led_pwm_priv *priv)
 	}
 }
 
+static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
+		       struct led_pwm *led)
+{
+	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
+	int ret;
+
+	led_data->active_low = led->active_low;
+	led_data->period = led->pwm_period_ns;
+	led_data->cdev.name = led->name;
+	led_data->cdev.default_trigger = led->default_trigger;
+	led_data->cdev.brightness_set = led_pwm_set;
+	led_data->cdev.brightness = LED_OFF;
+	led_data->cdev.max_brightness = led->max_brightness;
+	led_data->cdev.flags = LED_CORE_SUSPENDRESUME;
+
+	led_data->pwm = devm_pwm_get(dev, led->name);
+	if (IS_ERR(led_data->pwm)) {
+		ret = PTR_ERR(led_data->pwm);
+		dev_err(dev, "unable to request PWM for %s: %d\n",
+			led->name, ret);
+		return ret;
+	}
+
+	led_data->can_sleep = pwm_can_sleep(led_data->pwm);
+	if (led_data->can_sleep)
+		INIT_WORK(&led_data->work, led_pwm_work);
+
+	ret = led_classdev_register(dev, &led_data->cdev);
+	if (ret == 0) {
+		priv->num_leds++;
+	} else {
+		dev_err(dev, "failed to register PWM led for %s: %d\n",
+			led->name, ret);
+	}
+
+	return ret;
+}
+
 static int led_pwm_create_of(struct platform_device *pdev,
 			     struct led_pwm_priv *priv)
 {
@@ -139,8 +177,6 @@ static int led_pwm_create_of(struct platform_device *pdev,
 
 	return 0;
 err:
-	led_pwm_cleanup(priv);
-
 	return ret;
 }
 
@@ -166,51 +202,22 @@ static int led_pwm_probe(struct platform_device *pdev)
 
 	if (pdata) {
 		for (i = 0; i < count; i++) {
-			struct led_pwm *cur_led = &pdata->leds[i];
-			struct led_pwm_data *led_dat = &priv->leds[i];
-
-			led_dat->pwm = devm_pwm_get(&pdev->dev, cur_led->name);
-			if (IS_ERR(led_dat->pwm)) {
-				ret = PTR_ERR(led_dat->pwm);
-				dev_err(&pdev->dev,
-					"unable to request PWM for %s\n",
-					cur_led->name);
-				goto err;
-			}
-
-			led_dat->cdev.name = cur_led->name;
-			led_dat->cdev.default_trigger = cur_led->default_trigger;
-			led_dat->active_low = cur_led->active_low;
-			led_dat->period = cur_led->pwm_period_ns;
-			led_dat->cdev.brightness_set = led_pwm_set;
-			led_dat->cdev.brightness = LED_OFF;
-			led_dat->cdev.max_brightness = cur_led->max_brightness;
-			led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
-
-			led_dat->can_sleep = pwm_can_sleep(led_dat->pwm);
-			if (led_dat->can_sleep)
-				INIT_WORK(&led_dat->work, led_pwm_work);
-
-			ret = led_classdev_register(&pdev->dev, &led_dat->cdev);
-			if (ret < 0)
-				goto err;
+			ret = led_pwm_add(&pdev->dev, priv, &pdata->leds[i]);
+			if (ret)
+				break;
 		}
-		priv->num_leds = count;
 	} else {
 		ret = led_pwm_create_of(pdev, priv);
-		if (ret)
-			return ret;
+	}
+
+	if (ret) {
+		led_pwm_cleanup(priv);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, priv);
 
 	return 0;
-
-err:
-	priv->num_leds = i;
-	led_pwm_cleanup(priv);
-
-	return ret;
 }
 
 static int led_pwm_remove(struct platform_device *pdev)
-- 
1.8.3.1
