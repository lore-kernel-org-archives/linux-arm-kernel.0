From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 11 Mar 2011 16:08:09 -0700
Subject: [PATCH 07/10] ux500: added snowball-digio.c
In-Reply-To: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1299884892-6766-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@gnudd.com>

This file includes definitions for the output led and 5 input buttons,
4 on the strip on the side and one soldered near the mmc slot.

This work is originally by Gregory Hermant, split by me to a
separate file.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
---
 arch/arm/mach-ux500/board-snowball-digio.c |  122 ++++++++++++++++++++++++++++
 1 files changed, 122 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-snowball-digio.c

diff --git a/arch/arm/mach-ux500/board-snowball-digio.c b/arch/arm/mach-ux500/board-snowball-digio.c
new file mode 100644
index 0000000..57f9e3f
--- /dev/null
+++ b/arch/arm/mach-ux500/board-snowball-digio.c
@@ -0,0 +1,122 @@
+/*
+ * Copyright (C) 2010-2011 ST-Ericsson
+ *
+ * This defines the user led (output) and 4-keys gpio keyboard (input)
+ * Original code by Gregory Hermant <gregory.hermant@calao-systems.com>
+ * Split to a standalone file by Alessandro Rubini <rubini@gnudd.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/leds.h>
+#include <plat/pincfg.h>
+#include <plat/gpio.h>
+#include "pins-db5500.h"
+
+static pin_cfg_t snowball_pins[] = {
+	PIN_CFG(32, GPIO)     | PIN_INPUT_PULLUP, /* led */
+	PIN_CFG(151, GPIO)	| PIN_INPUT_PULLUP, /* button */
+	PIN_CFG(152, GPIO)	| PIN_INPUT_PULLUP, /* button */
+	PIN_CFG(161, GPIO)	| PIN_INPUT_PULLUP, /* button */
+	PIN_CFG(162, GPIO)	| PIN_INPUT_PULLUP, /* button */
+};
+
+static struct gpio_led snowball_led_array[] = {
+	{
+		.name = "user_led",
+		.default_trigger = "none",
+		.gpio = 142,
+	},
+};
+
+static struct gpio_led_platform_data snowball_led_data = {
+	.leds = snowball_led_array,
+	.num_leds = ARRAY_SIZE(snowball_led_array),
+};
+
+static struct platform_device snowball_led_dev = {
+	.name = "leds-gpio",
+	.dev = {
+		.platform_data = &snowball_led_data,
+	},
+};
+
+static struct gpio_keys_button snowball_key_array[] = {
+	{
+		.gpio		= 32,
+		.type		= EV_KEY,
+		.code		= KEY_1,
+		.desc		= "userpb",
+		.active_low	= 1,
+		.debounce_interval = 50,
+		.wakeup		= 1,
+	},
+	{
+		.gpio		= 151,
+		.type		= EV_KEY,
+		.code		= KEY_2,
+		.desc		= "extkb1",
+		.active_low	= 1,
+		.debounce_interval = 50,
+		.wakeup		= 1,
+	},
+	{
+		.gpio		= 152,
+		.type		= EV_KEY,
+		.code		= KEY_3,
+		.desc		= "extkb2",
+		.active_low	= 1,
+		.debounce_interval = 50,
+		.wakeup		= 1,
+	},
+	{
+		.gpio		= 161,
+		.type		= EV_KEY,
+		.code		= KEY_4,
+		.desc		= "extkb3",
+		.active_low	= 1,
+		.debounce_interval = 50,
+		.wakeup		= 1,
+	},
+	{
+		.gpio		= 162,
+		.type		= EV_KEY,
+		.code		= KEY_5,
+		.desc		= "extkb4",
+		.active_low	= 1,
+		.debounce_interval = 50,
+		.wakeup		= 1,
+	},
+};
+
+static struct gpio_keys_platform_data snowball_key_data = {
+	.buttons	= snowball_key_array,
+	.nbuttons	= ARRAY_SIZE(snowball_key_array),
+};
+
+static struct platform_device snowball_key_dev = {
+	.name		= "gpio-keys",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &snowball_key_data,
+	}
+};
+
+static int snowball_digio_init(void)
+{
+        nmk_config_pins(snowball_pins, ARRAY_SIZE(snowball_pins));
+	platform_device_register(&snowball_led_dev);
+	platform_device_register(&snowball_key_dev);
+	return 0;
+}
+
+module_init(snowball_digio_init);
+
+/* no release function: I'm lazy at this point */
-- 
1.7.1
