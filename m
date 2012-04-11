From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 11 Apr 2012 14:29:19 -0700
Subject: [PATCH v2] arm: ep93xx: use gpio_led_register_device
Message-ID: <201204111429.20038.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_led_register_device to register the two leds
connected to the ep93xx.

Since this is a common feature for all ep93xx based boards,
create a new Kconfig option, ARCH_EP93XX_TYPICAL, to select
the LEDS_GPIO_REGISTER feature.

The struct gpio_led and struct gpio_led_platform_data variables
have been changed to const struct because of:

commit 9517f925f2eb9ffca78b3f0f9389fc675bcb572c
    leds: make *struct gpio_led_platform_data.leds const

They have also been marked as __initconst because the helper
function gpio_led_register_device makes a deep copy of the
platform data to allow it to live in init memory:

commit 4440673a95e63ad888a41db596edaa0c55d3a332
    leds: provide helper to register "leds-gpio" devices

Signed-off-by: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>

---

diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 97a2493..19d8148 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -2,6 +2,11 @@ if ARCH_EP93XX
 
 menu "Cirrus EP93xx Implementation Options"
 
+config ARCH_EP93XX_TYPICAL
+	bool
+	default y
+	select LEDS_GPIO_REGISTER
+
 config CRUNCH
 	bool "Support for MaverickCrunch"
 	help
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 8d25895..257a124 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -513,7 +513,7 @@ void __init ep93xx_register_spi(struct ep93xx_spi_info *info,
 /*************************************************************************
  * EP93xx LEDs
  *************************************************************************/
-static struct gpio_led ep93xx_led_pins[] = {
+static const struct gpio_led ep93xx_led_pins[] __initconst = {
 	{
 		.name	= "platform:grled",
 		.gpio	= EP93XX_GPIO_LINE_GRLED,
@@ -523,20 +523,11 @@ static struct gpio_led ep93xx_led_pins[] = {
 	},
 };
 
-static struct gpio_led_platform_data ep93xx_led_data = {
+static const struct gpio_led_platform_data ep93xx_led_data __initconst = {
 	.num_leds	= ARRAY_SIZE(ep93xx_led_pins),
 	.leds		= ep93xx_led_pins,
 };
 
-static struct platform_device ep93xx_leds = {
-	.name		= "leds-gpio",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &ep93xx_led_data,
-	},
-};
-
-
 /*************************************************************************
  * EP93xx pwm peripheral handling
  *************************************************************************/
@@ -889,8 +880,9 @@ void __init ep93xx_init_devices(void)
 
 	platform_device_register(&ep93xx_rtc_device);
 	platform_device_register(&ep93xx_ohci_device);
-	platform_device_register(&ep93xx_leds);
 	platform_device_register(&ep93xx_wdt_device);
+
+	gpio_led_register_device(-1, &ep93xx_led_data);
 }
 
 void ep93xx_restart(char mode, const char *cmd)
