From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon,  4 Apr 2016 17:22:06 -0300
Subject: [PATCH 5/5] leds: gpio: Support the panic-blink firmware property
In-Reply-To: <1459801326-5541-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1459801326-5541-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <1459801326-5541-6-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO LEDs are relatively cheap, and so are ideal to blink on
a kernel panic. This commit adds support for the new "panic-blink"
firmware property, allowing to mark a given LED to blink on
a kernel panic.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/leds/leds-gpio.c | 4 ++++
 include/linux/leds.h     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 61143f55597e..74e35dcaf874 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -127,6 +127,8 @@ static int create_gpio_led(const struct gpio_led *template,
 	led_dat->cdev.brightness = state ? LED_FULL : LED_OFF;
 	if (!template->retain_state_suspended)
 		led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
+	if (template->panic_blink)
+		led_dat->cdev.flags |= LED_BLINK_AT_PANIC;
 
 	ret = gpiod_direction_output(led_dat->gpiod, state);
 	if (ret < 0)
@@ -200,6 +202,8 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 
 		if (fwnode_property_present(child, "retain-state-suspended"))
 			led.retain_state_suspended = 1;
+		if (fwnode_property_present(child, "panic-blink"))
+			led.panic_blink = 1;
 
 		ret = create_gpio_led(&led, &priv->leds[priv->num_leds],
 				      dev, NULL);
diff --git a/include/linux/leds.h b/include/linux/leds.h
index d33b230ce66d..e8e99cc5f99e 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -363,6 +363,7 @@ struct gpio_led {
 	unsigned 	gpio;
 	unsigned	active_low : 1;
 	unsigned	retain_state_suspended : 1;
+	unsigned	panic_blink : 1;
 	unsigned	default_state : 2;
 	/* default_state should be one of LEDS_GPIO_DEFSTATE_(ON|OFF|KEEP) */
 	struct gpio_desc *gpiod;
-- 
2.7.0
