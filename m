From: jochen@scram.de (Jochen Friedrich)
Date: Fri, 29 Apr 2011 17:16:54 +0200
Subject: [PATCHv4 2.6.40 3/4] ARM:simpad: add GPIO based device definitions.
In-Reply-To: <1304090215-7457-1-git-send-email-jochen@scram.de>
References: <1304090215-7457-1-git-send-email-jochen@scram.de>
Message-ID: <1304090215-7457-4-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register keyboard, polled keyboard and I2C platform
devices based on GPIOs.

V3: Split LED changes into seperate patch.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/arm/mach-sa1100/simpad.c |   67 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 4d60c28..d1a13bb 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -29,6 +29,9 @@
 
 #include <linux/serial_core.h>
 #include <linux/ioport.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/i2c-gpio.h>
 
 #include "generic.h"
 
@@ -249,6 +252,65 @@ static void simpad_power_off(void)
 
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
@@ -259,7 +321,10 @@ static struct platform_device simpad_mq200fb = {
 };
 
 static struct platform_device *devices[] __initdata = {
-	&simpad_mq200fb
+	&simpad_keys,
+	&simpad_polled_keys,
+	&simpad_mq200fb,
+	&simpad_i2c,
 };
 
 
-- 
1.7.4.1
