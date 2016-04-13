From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Wed, 13 Apr 2016 15:08:19 -0300
Subject: [PATCH v2 3/3] leds: gpio: Support the "panic-indicator" firmware
 property
In-Reply-To: <1460570899-24642-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1460570899-24642-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <1460570899-24642-4-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling a GPIO LEDs is quite likely to work even if the kernel
has paniced, so they are ideal to blink in this situation.
This commit adds support for the new "panic-indicator"
firmware property, allowing to mark a given LED to blink on
a kernel panic.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/leds/leds-gpio.c | 4 ++++
 include/linux/leds.h     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 61143f55597e..8229f063b483 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -127,6 +127,8 @@ static int create_gpio_led(const struct gpio_led *template,
 	led_dat->cdev.brightness = state ? LED_FULL : LED_OFF;
 	if (!template->retain_state_suspended)
 		led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
+	if (template->panic_indicator)
+		led_dat->cdev.flags |= LED_PANIC_INDICATOR;
 
 	ret = gpiod_direction_output(led_dat->gpiod, state);
 	if (ret < 0)
@@ -200,6 +202,8 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 
 		if (fwnode_property_present(child, "retain-state-suspended"))
 			led.retain_state_suspended = 1;
+		if (fwnode_property_present(child, "panic-indicator"))
+			led.panic_indicator = 1;
 
 		ret = create_gpio_led(&led, &priv->leds[priv->num_leds],
 				      dev, NULL);
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 49adf9c6e326..1067fb5f9296 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -359,6 +359,7 @@ struct gpio_led {
 	unsigned 	gpio;
 	unsigned	active_low : 1;
 	unsigned	retain_state_suspended : 1;
+	unsigned	panic_indicator : 1;
 	unsigned	default_state : 2;
 	/* default_state should be one of LEDS_GPIO_DEFSTATE_(ON|OFF|KEEP) */
 	struct gpio_desc *gpiod;
-- 
2.7.0
