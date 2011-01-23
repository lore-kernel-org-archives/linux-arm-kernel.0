From: jochen@scram.de (Jochen Friedrich)
Date: Sun, 23 Jan 2011 18:35:03 +0100
Subject: [PATCH 3/3] ARM:simpad: add GPIO based device definitions.
In-Reply-To: <1295804103-5398-1-git-send-email-jochen@scram.de>
References: <1295804103-5398-1-git-send-email-jochen@scram.de>
Message-ID: <1295804103-5398-3-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register LED, keyboard, polled keyboard and I2C platform
devices based on GPIOs.

Make LED resources conditional to CONFIG_LEDS to avoid
using the legacy ARM LED code and generic GPIO LED code
concurrently on the same GPIO pin.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/arm/mach-sa1100/simpad.c |   99 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 98 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index ec6e381..058a3ee 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -29,6 +29,10 @@
 
 #include <linux/serial_core.h>
 #include <linux/ioport.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/leds.h>
+#include <linux/i2c-gpio.h>
 
 #include "generic.h"
 
@@ -249,6 +253,93 @@ static void simpad_power_off(void)
 
 }
 
+/*
+ * gpio_keys
+*/
+
+static struct gpio_keys_button simpad_button_table[] = {
+	{ KEY_POWER, IRQ_GPIO_POWER_BUTTON, 1, "power button" },
+};
+
+static struct gpio_keys_platform_data simpad_keys_data = {
+	.buttons = simpad_button_table,
+	.nbuttons = ARRAY_SIZE(simpad_button_table),
+};
+
+static struct platform_device simpad_keys = {
+	.name = "gpio-keys",
+	.dev = {
+		.platform_data = &simpad_keys_data,
+	},
+};
+
+static struct gpio_keys_button simpad_polled_button_table[] = {
+	{ KEY_PROG1, SIMPAD_UCB1X00_GPIO_PROG1, 1, "prog1 button" },
+	{ KEY_PROG2, SIMPAD_UCB1X00_GPIO_PROG2, 1, "prog2 button" },
+	{ KEY_UP,    SIMPAD_UCB1X00_GPIO_UP,    1, "up button" },
+	{ KEY_DOWN,  SIMPAD_UCB1X00_GPIO_DOWN,  1, "down button" },
+	{ KEY_LEFT,  SIMPAD_UCB1X00_GPIO_LEFT,  1, "left button" },
+	{ KEY_RIGHT, SIMPAD_UCB1X00_GPIO_RIGHT, 1, "right button" },
+};
+
+static struct gpio_keys_platform_data simpad_polled_keys_data = {
+	.buttons = simpad_polled_button_table,
+	.nbuttons = ARRAY_SIZE(simpad_polled_button_table),
+	.poll_interval = 50,
+};
+
+static struct platform_device simpad_polled_keys = {
+	.name = "gpio-keys-polled",
+	.dev = {
+		.platform_data = &simpad_polled_keys_data,
+	},
+};
+
+/*
+ * GPIO LEDs
+ */
+
+#ifndef CONFIG_LEDS
+static struct gpio_led simpad_leds[] = {
+	{
+		.name = "power",
+		.gpio = SIMPAD_CS3_LED2_ON,
+		.active_low = 0,
+		.default_trigger = "default-on",
+	},
+};
+
+static struct gpio_led_platform_data simpad_led_data = {
+	.num_leds = 1,
+	.leds = simpad_leds,
+};
+
+static struct platform_device simpad_gpio_leds = {
+	.name = "leds-gpio",
+	.id = 0,
+	.dev = {
+		.platform_data = &simpad_led_data,
+	},
+};
+#endif
+
+/*
+ * i2c
+ */
+static struct i2c_gpio_platform_data simpad_i2c_data = {
+	.sda_pin = GPIO_GPIO21,
+	.scl_pin = GPIO_GPIO25,
+	.udelay = 10,
+	.timeout = HZ,
+};
+
+static struct platform_device simpad_i2c = {
+	.name = "i2c-gpio",
+	.id = 0,
+	.dev = {
+		.platform_data = &simpad_i2c_data,
+	},
+};
 
 /*
  * MediaQ Video Device
@@ -259,7 +350,13 @@ static struct platform_device simpad_mq200fb = {
 };
 
 static struct platform_device *devices[] __initdata = {
-	&simpad_mq200fb
+	&simpad_keys,
+	&simpad_polled_keys,
+	&simpad_mq200fb,
+#ifndef CONFIG_LEDS
+	&simpad_gpio_leds,
+#endif
+	&simpad_i2c,
 };
 
 
-- 
1.7.2.3
