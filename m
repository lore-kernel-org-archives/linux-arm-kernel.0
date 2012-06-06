From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  6 Jun 2012 23:35:13 +0200
Subject: [PATCH 5/7] ARM: nomadik: register all three I2C busses
Message-ID: <1339018513-29158-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nomadik has two dedicated I2C bus blocks for I2C0 and I2C1,
and a bitbanged GPIO connection on two pins for the USB portions
of the STw4811 chip. Register all three as bit-banged GPIO for
the moment.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/i2c-8815nhk.c |   38 ++++++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-nomadik/i2c-8815nhk.c b/arch/arm/mach-nomadik/i2c-8815nhk.c
index 0fc2f6f..6d14454 100644
--- a/arch/arm/mach-nomadik/i2c-8815nhk.c
+++ b/arch/arm/mach-nomadik/i2c-8815nhk.c
@@ -5,6 +5,7 @@
 #include <linux/i2c-gpio.h>
 #include <linux/platform_device.h>
 #include <plat/gpio-nomadik.h>
+#include <plat/pincfg.h>
 
 /*
  * There are two busses in the 8815NHK.
@@ -12,19 +13,27 @@
  * use bit-bang through GPIO by now, to keep things simple
  */
 
+/* I2C0 connected to the STw4811 power management chip */
 static struct i2c_gpio_platform_data nhk8815_i2c_data0 = {
 	/* keep defaults for timeouts; pins are push-pull bidirectional */
 	.scl_pin = 62,
 	.sda_pin = 63,
 };
 
+/* I2C1 connected to various sensors */
 static struct i2c_gpio_platform_data nhk8815_i2c_data1 = {
 	/* keep defaults for timeouts; pins are push-pull bidirectional */
 	.scl_pin = 53,
 	.sda_pin = 54,
 };
 
-/* first bus: GPIO XX and YY */
+/* I2C2 connected to the USB portions of the STw4811 only */
+static struct i2c_gpio_platform_data nhk8815_i2c_data2 = {
+	/* keep defaults for timeouts; pins are push-pull bidirectional */
+	.scl_pin = 73,
+	.sda_pin = 74,
+};
+
 static struct platform_device nhk8815_i2c_dev0 = {
 	.name	= "i2c-gpio",
 	.id	= 0,
@@ -32,7 +41,7 @@ static struct platform_device nhk8815_i2c_dev0 = {
 		.platform_data = &nhk8815_i2c_data0,
 	},
 };
-/* second bus: GPIO XX and YY */
+
 static struct platform_device nhk8815_i2c_dev1 = {
 	.name	= "i2c-gpio",
 	.id	= 1,
@@ -41,15 +50,29 @@ static struct platform_device nhk8815_i2c_dev1 = {
 	},
 };
 
+static struct platform_device nhk8815_i2c_dev2 = {
+	.name	= "i2c-gpio",
+	.id	= 2,
+	.dev	= {
+		.platform_data = &nhk8815_i2c_data2,
+	},
+};
+
+static pin_cfg_t cpu8815_pins_i2c[] = {
+	PIN_CFG_INPUT(62, GPIO, PULLUP),
+	PIN_CFG_INPUT(63, GPIO, PULLUP),
+	PIN_CFG_INPUT(53, GPIO, PULLUP),
+	PIN_CFG_INPUT(54, GPIO, PULLUP),
+	PIN_CFG_INPUT(73, GPIO, PULLUP),
+	PIN_CFG_INPUT(74, GPIO, PULLUP),
+};
+
 static int __init nhk8815_i2c_init(void)
 {
-	nmk_gpio_set_mode(nhk8815_i2c_data0.scl_pin, NMK_GPIO_ALT_GPIO);
-	nmk_gpio_set_mode(nhk8815_i2c_data0.sda_pin, NMK_GPIO_ALT_GPIO);
+	nmk_config_pins(cpu8815_pins_i2c, ARRAY_SIZE(cpu8815_pins_i2c));
 	platform_device_register(&nhk8815_i2c_dev0);
-
-	nmk_gpio_set_mode(nhk8815_i2c_data1.scl_pin, NMK_GPIO_ALT_GPIO);
-	nmk_gpio_set_mode(nhk8815_i2c_data1.sda_pin, NMK_GPIO_ALT_GPIO);
 	platform_device_register(&nhk8815_i2c_dev1);
+	platform_device_register(&nhk8815_i2c_dev2);
 
 	return 0;
 }
@@ -58,6 +81,7 @@ static void __exit nhk8815_i2c_exit(void)
 {
 	platform_device_unregister(&nhk8815_i2c_dev0);
 	platform_device_unregister(&nhk8815_i2c_dev1);
+	platform_device_unregister(&nhk8815_i2c_dev2);
 	return;
 }
 
-- 
1.7.7.6
