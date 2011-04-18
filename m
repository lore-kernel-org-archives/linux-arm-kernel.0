From: jochen@scram.de (Jochen Friedrich)
Date: Mon, 18 Apr 2011 15:00:36 +0200
Subject: [PATCHv2 2.6.40 3/3] ARM:simpad: add GPIO based device definitions.
In-Reply-To: <1303131636-19442-1-git-send-email-jochen@scram.de>
References: <1303131636-19442-1-git-send-email-jochen@scram.de>
Message-ID: <1303131636-19442-4-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register LED, keyboard, polled keyboard and I2C platform
devices based on GPIOs.

V2: Remove the legacy ARM LED code for simpad devices.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/arm/mach-sa1100/Makefile      |    1 -
 arch/arm/mach-sa1100/leds-simpad.c |   97 ------------------------------------
 arch/arm/mach-sa1100/simpad.c      |   95 ++++++++++++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 99 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/leds-simpad.c

diff --git a/arch/arm/mach-sa1100/Makefile b/arch/arm/mach-sa1100/Makefile
index 41252d2..0063178 100644
--- a/arch/arm/mach-sa1100/Makefile
+++ b/arch/arm/mach-sa1100/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_SA1100_PLEB)		+= pleb.o
 obj-$(CONFIG_SA1100_SHANNON)		+= shannon.o
 
 obj-$(CONFIG_SA1100_SIMPAD)		+= simpad.o
-led-$(CONFIG_SA1100_SIMPAD)		+= leds-simpad.o
 
 # LEDs support
 obj-$(CONFIG_LEDS) += $(led-y)
diff --git a/arch/arm/mach-sa1100/leds-simpad.c b/arch/arm/mach-sa1100/leds-simpad.c
deleted file mode 100644
index d25784c..0000000
--- a/arch/arm/mach-sa1100/leds-simpad.c
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- * linux/arch/arm/mach-sa1100/leds-simpad.c
- *
- * Author: Juergen Messerer <juergen.messerer@siemens.ch>
- */
-#include <linux/init.h>
-
-#include <mach/hardware.h>
-#include <asm/leds.h>
-#include <asm/system.h>
-#include <mach/simpad.h>
-
-#include "leds.h"
-
-
-#define LED_STATE_ENABLED	1
-#define LED_STATE_CLAIMED	2
-
-static unsigned int led_state;
-static unsigned int hw_led_state;
-
-#define	LED_GREEN	(1)
-#define	LED_MASK	(1)
-
-void simpad_leds_event(led_event_t evt)
-{
-	switch (evt)
-	{
-	case led_start:
-	        hw_led_state = LED_GREEN;
-		led_state = LED_STATE_ENABLED;
-		break;
-
-	case led_stop:
-		led_state &= ~LED_STATE_ENABLED;
-		break;
-
-	case led_claim:
-		led_state |= LED_STATE_CLAIMED;
-		hw_led_state = LED_GREEN;
-		break;
-
-	case led_release:
-		led_state &= ~LED_STATE_CLAIMED;
-		hw_led_state = LED_GREEN;
-		break;
-
-#ifdef CONFIG_LEDS_TIMER
-	case led_timer:
-		if (!(led_state & LED_STATE_CLAIMED))
-			hw_led_state ^= LED_GREEN;
-		break;
-#endif
-
-#ifdef CONFIG_LEDS_CPU
-	case led_idle_start:
-		break;
-
-	case led_idle_end:
-		break;
-#endif
-
-	case led_halted:
-		break;
-
-	case led_green_on:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state |= LED_GREEN;
-		break;
-
-	case led_green_off:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state &= ~LED_GREEN;
-		break;
-
-	case led_amber_on:
-		break;
-
-	case led_amber_off:
-		break;
-
-	case led_red_on:
-		break;
-
-	case led_red_off:
-		break;
-
-	default:
-		break;
-	}
-
-	if  (led_state & LED_STATE_ENABLED)
-		simpad_set_cs3_bit(LED2_ON);
-	else 
-		simpad_clear_cs3_bit(LED2_ON);
-}
-
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index ec6e381..cf3a68a 100644
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
 
@@ -249,6 +253,91 @@ static void simpad_power_off(void)
 
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
@@ -259,7 +348,11 @@ static struct platform_device simpad_mq200fb = {
 };
 
 static struct platform_device *devices[] __initdata = {
-	&simpad_mq200fb
+	&simpad_keys,
+	&simpad_polled_keys,
+	&simpad_mq200fb,
+	&simpad_gpio_leds,
+	&simpad_i2c,
 };
 
 
-- 
1.7.4.1
