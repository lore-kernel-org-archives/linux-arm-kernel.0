From: jtzhou@marvell.com (Jett.Zhou)
Date: Fri, 17 Feb 2012 17:03:56 +0800
Subject: [V1 3/3] led: modified power control of pm860x led
Message-ID: <1329469436-8247-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since several sub modules such as backlight, leds and vibrator depend
on the refernce group and internal oscillator in pm8606, so modified
the power control of led in pm8606 by unified interface.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/leds/leds-88pm860x.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/leds/leds-88pm860x.c b/drivers/leds/leds-88pm860x.c
index 4ca0062..5b61aaf 100644
--- a/drivers/leds/leds-88pm860x.c
+++ b/drivers/leds/leds-88pm860x.c
@@ -114,6 +114,27 @@ static inline int __blink_ctl_mask(int port)
 	return ret;
 }
 
+static int led_power_set(struct pm860x_chip *chip, int port, int on)
+{
+	int ret = -EINVAL;
+
+	switch (port) {
+	case PM8606_LED1_RED:
+	case PM8606_LED1_GREEN:
+	case PM8606_LED1_BLUE:
+		ret = on ? pm8606_osc_enable(chip, RGB1_ENABLE) :
+			pm8606_osc_disable(chip, RGB1_ENABLE);
+		break;
+	case PM8606_LED2_RED:
+	case PM8606_LED2_GREEN:
+	case PM8606_LED2_BLUE:
+		ret = on ? pm8606_osc_enable(chip, RGB2_ENABLE) :
+			pm8606_osc_disable(chip, RGB2_ENABLE);
+		break;
+	}
+	return ret;
+}
+
 static void pm860x_led_work(struct work_struct *work)
 {
 
@@ -126,6 +147,7 @@ static void pm860x_led_work(struct work_struct *work)
 	chip = led->chip;
 	mutex_lock(&led->lock);
 	if ((led->current_brightness == 0) && led->brightness) {
+		led_power_set(chip, led->port, 1);
 		if (led->iset) {
 			pm860x_set_bits(led->i2c, __led_off(led->port),
 					LED_CURRENT_MASK, led->iset);
@@ -149,6 +171,7 @@ static void pm860x_led_work(struct work_struct *work)
 					LED_CURRENT_MASK, 0);
 			mask = __blink_ctl_mask(led->port);
 			pm860x_set_bits(led->i2c, PM8606_WLED3B, mask, 0);
+			led_power_set(chip, led->port, 0);
 		}
 	}
 	led->current_brightness = led->brightness;
-- 
1.7.0.4
