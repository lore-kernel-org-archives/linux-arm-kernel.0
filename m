From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Jan 2013 23:55:49 +0100
Subject: [PATCH 01/11] ARM: nomadik: move last custom calls to pinctrl
Message-ID: <1357599349-7353-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C pins were still set up using custom nmk_* calls, move
these to use the pinctrl mapping table instead. There was also
a remaining call to turn the Ethernet pin to GPIO, and this is
now done implicitly by the GPIO-to-pinctrl range translation
calls.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/board-nhk8815.c | 10 +++++++++-
 arch/arm/mach-nomadik/i2c-8815nhk.c   | 11 -----------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 9f19069..75075ab 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -239,7 +239,6 @@ static int __init nhk8815_eth_init(void)
 	int err;
 
 	err = gpio_request(gpio_nr, "eth_irq");
-	if (!err) err = nmk_gpio_set_mode(gpio_nr, NMK_GPIO_ALT_GPIO);
 	if (!err) err = gpio_direction_input(gpio_nr);
 	if (err)
 		pr_err("Error %i in %s\n", err, __func__);
@@ -326,6 +325,15 @@ static struct pinctrl_map __initdata nhk8815_pinmap[] = {
 	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO111_H21", in_nopull),
 	/* CD bias drive */
 	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO112_J21", out_low),
+	/* I2C0 */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO62_D3", in_pullup),
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO63_D2", in_pullup),
+	/* I2C1 */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO53_L4", in_pullup),
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO54_L3", in_pullup),
+	/* I2C2 */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO73_C21", in_pullup),
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO74_C20", in_pullup),
 };
 
 static void __init nhk8815_platform_init(void)
diff --git a/arch/arm/mach-nomadik/i2c-8815nhk.c b/arch/arm/mach-nomadik/i2c-8815nhk.c
index 0c2f662..f0e9e64 100644
--- a/arch/arm/mach-nomadik/i2c-8815nhk.c
+++ b/arch/arm/mach-nomadik/i2c-8815nhk.c
@@ -4,7 +4,6 @@
 #include <linux/i2c-algo-bit.h>
 #include <linux/i2c-gpio.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/pinctrl-nomadik.h>
 
 /*
  * There are two busses in the 8815NHK.
@@ -57,18 +56,8 @@ static struct platform_device nhk8815_i2c_dev2 = {
 	},
 };
 
-static pin_cfg_t cpu8815_pins_i2c[] = {
-	PIN_CFG_INPUT(62, GPIO, PULLUP),
-	PIN_CFG_INPUT(63, GPIO, PULLUP),
-	PIN_CFG_INPUT(53, GPIO, PULLUP),
-	PIN_CFG_INPUT(54, GPIO, PULLUP),
-	PIN_CFG_INPUT(73, GPIO, PULLUP),
-	PIN_CFG_INPUT(74, GPIO, PULLUP),
-};
-
 static int __init nhk8815_i2c_init(void)
 {
-	nmk_config_pins(cpu8815_pins_i2c, ARRAY_SIZE(cpu8815_pins_i2c));
 	platform_device_register(&nhk8815_i2c_dev0);
 	platform_device_register(&nhk8815_i2c_dev1);
 	platform_device_register(&nhk8815_i2c_dev2);
-- 
1.7.11.7
