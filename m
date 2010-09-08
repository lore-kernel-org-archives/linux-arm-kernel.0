From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed,  8 Sep 2010 09:44:33 -0400
Subject: [PATCH 2/5] leds: remove auto blink in 88pm860x
In-Reply-To: <1283953476-2395-1-git-send-email-haojian.zhuang@marvell.com>
References: <1283953476-2395-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1283953476-2395-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88pm860x supports auto-blink LED in hardware. It messed with
timer trigger. Now disable the auto-blink function.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Samuel Ortiz <sameo@openedhand.com>
---
 drivers/leds/leds-88pm860x.c |  119 +++++++++--------------------------------
 1 files changed, 26 insertions(+), 93 deletions(-)

diff --git a/drivers/leds/leds-88pm860x.c b/drivers/leds/leds-88pm860x.c
index b767710..e672b44 100644
--- a/drivers/leds/leds-88pm860x.c
+++ b/drivers/leds/leds-88pm860x.c
@@ -24,26 +24,17 @@
 #define LED_CURRENT_MASK	(0x07 << 5)
 
 #define LED_BLINK_ON_MASK	(0x07)
-#define LED_BLINK_PERIOD_MASK	(0x0F << 3)
 #define LED_BLINK_MASK		(0x7F)
 
 #define LED_BLINK_ON(x)		((x & 0x7) * 66 + 66)
-#define LED_BLINK_PERIOD(x)	((x & 0xF) * 530 + 930)
 #define LED_BLINK_ON_MIN	LED_BLINK_ON(0)
 #define LED_BLINK_ON_MAX	LED_BLINK_ON(0x7)
-#define LED_BLINK_PERIOD_MIN	LED_BLINK_PERIOD(0)
-#define LED_BLINK_PERIOD_MAX	LED_BLINK_PERIOD(0xE)
+#define LED_ON_CONTINUOUS	(0x0F << 3)
 #define LED_TO_ON(x)		((x - 66) / 66)
-#define LED_TO_PERIOD(x)	((x - 930) / 530)
 
 #define LED1_BLINK_EN		(1 << 1)
 #define LED2_BLINK_EN		(1 << 2)
 
-enum {
-	SET_BRIGHTNESS,
-	SET_BLINK,
-};
-
 struct pm860x_led {
 	struct led_classdev cdev;
 	struct i2c_client *i2c;
@@ -54,8 +45,6 @@ struct pm860x_led {
 
 	int port;
 	int iset;
-	int command;
-	int offset;
 	unsigned char brightness;
 	unsigned char current_brightness;
 
@@ -95,10 +84,12 @@ static inline int __blink_off(int port)
 	case PM8606_LED1_GREEN:
 	case PM8606_LED1_BLUE:
 		ret = PM8606_RGB1A;
+		break;
 	case PM8606_LED2_RED:
 	case PM8606_LED2_GREEN:
 	case PM8606_LED2_BLUE:
 		ret = PM8606_RGB2A;
+		break;
 	}
 	return ret;
 }
@@ -122,60 +113,35 @@ static inline int __blink_ctl_mask(int port)
 	return ret;
 }
 
-static int __led_set(struct pm860x_led *led, int command)
+static void pm860x_led_work(struct work_struct *work)
 {
-	struct pm860x_chip *chip = led->chip;
-	int mask, ret;
 
+	struct pm860x_led *led;
+	struct pm860x_chip *chip;
+	int mask;
+
+	led = container_of(work, struct pm860x_led, work);
+	chip = led->chip;
 	mutex_lock(&led->lock);
-	switch (command) {
-	case SET_BRIGHTNESS:
-		if ((led->current_brightness == 0) && led->brightness) {
-			if (led->iset) {
-				ret = pm860x_set_bits(led->i2c, led->offset,
-						LED_CURRENT_MASK, led->iset);
-				if (ret < 0)
-					goto out;
-			}
-		} else if (led->brightness == 0) {
-			ret = pm860x_set_bits(led->i2c, led->offset,
-						LED_CURRENT_MASK, 0);
-			if (ret < 0)
-				goto out;
+	if ((led->current_brightness == 0) && led->brightness) {
+		if (led->iset) {
+			pm860x_set_bits(led->i2c, __led_off(led->port),
+					LED_CURRENT_MASK, led->iset);
 		}
-		ret = pm860x_set_bits(led->i2c, led->offset, LED_PWM_MASK,
-					led->brightness);
-		if (ret < 0)
-			goto out;
-		led->current_brightness = led->brightness;
-		dev_dbg(chip->dev, "Update LED. (reg:%d, brightness:%d)\n",
-			led->offset, led->brightness);
-		break;
-	case SET_BLINK:
-		ret = pm860x_set_bits(led->i2c, led->offset,
-				LED_BLINK_MASK, led->blink_data);
-		if (ret < 0)
-			goto out;
-
 		mask = __blink_ctl_mask(led->port);
-		ret = pm860x_set_bits(led->i2c, PM8606_WLED3B, mask, mask);
-		if (ret < 0)
-			goto out;
-		dev_dbg(chip->dev, "LED blink delay on:%dms, delay off:%dms\n",
-			led->blink_on, led->blink_off);
-		break;
+		pm860x_set_bits(led->i2c, PM8606_WLED3B, mask, mask);
+	} else if (led->brightness == 0) {
+		pm860x_set_bits(led->i2c, __led_off(led->port),
+				LED_CURRENT_MASK, 0);
+		mask = __blink_ctl_mask(led->port);
+		pm860x_set_bits(led->i2c, PM8606_WLED3B, mask, 0);
 	}
-out:
+	pm860x_set_bits(led->i2c, __led_off(led->port), LED_PWM_MASK,
+			led->brightness);
+	led->current_brightness = led->brightness;
+	dev_dbg(chip->dev, "Update LED. (reg:%d, brightness:%d)\n",
+		__led_off(led->port), led->brightness);
 	mutex_unlock(&led->lock);
-	return 0;
-}
-
-static void pm860x_led_work(struct work_struct *work)
-{
-	struct pm860x_led *led;
-
-	led = container_of(work, struct pm860x_led, work);
-	__led_set(led, led->command);
 }
 
 static void pm860x_led_set(struct led_classdev *cdev,
@@ -183,42 +149,10 @@ static void pm860x_led_set(struct led_classdev *cdev,
 {
 	struct pm860x_led *data = container_of(cdev, struct pm860x_led, cdev);
 
-	data->offset = __led_off(data->port);
 	data->brightness = value >> 3;
-	data->command = SET_BRIGHTNESS;
 	schedule_work(&data->work);
 }
 
-static int pm860x_led_blink(struct led_classdev *cdev,
-			    unsigned long *delay_on,
-			    unsigned long *delay_off)
-{
-	struct pm860x_led *data = container_of(cdev, struct pm860x_led, cdev);
-	int period, on;
-
-	on = *delay_on;
-	if ((on < LED_BLINK_ON_MIN) || (on > LED_BLINK_ON_MAX))
-		return -EINVAL;
-
-	on = LED_TO_ON(on);
-	on = LED_BLINK_ON(on);
-
-	period = on + *delay_off;
-	if ((period < LED_BLINK_PERIOD_MIN) || (period > LED_BLINK_PERIOD_MAX))
-		return -EINVAL;
-	period = LED_TO_PERIOD(period);
-	period = LED_BLINK_PERIOD(period);
-
-	data->offset = __blink_off(data->port);
-	data->blink_on = on;
-	data->blink_off = period - data->blink_on;
-	data->blink_data = (period << 3) | data->blink_on;
-	data->command = SET_BLINK;
-	schedule_work(&data->work);
-
-	return 0;
-}
-
 static int __check_device(struct pm860x_led_pdata *pdata, char *name)
 {
 	struct pm860x_led_pdata *p = pdata;
@@ -257,7 +191,7 @@ static int pm860x_led_probe(struct platform_device *pdev)
 		pm860x_pdata = pdev->dev.parent->platform_data;
 		pdata = pm860x_pdata->led;
 	} else {
-		dev_err(&pdev->dev, "missing platform data\n");
+		dev_err(&pdev->dev, "No platform data!\n");
 		return -EINVAL;
 	}
 
@@ -279,7 +213,6 @@ static int pm860x_led_probe(struct platform_device *pdev)
 	data->current_brightness = 0;
 	data->cdev.name = data->name;
 	data->cdev.brightness_set = pm860x_led_set;
-	data->cdev.blink_set = pm860x_led_blink;
 	mutex_init(&data->lock);
 	INIT_WORK(&data->work, pm860x_led_work);
 
-- 
1.5.6.5
