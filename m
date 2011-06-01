From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 1 Jun 2011 14:54:46 -0700
Subject: [PATCH] ep93xx: use gpio_led_register_device
Message-ID: <201106011454.48049.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_led_register_device() to register the leds.

This allows the platform data to live in init memory.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>
Cc: Richard Purdie <rpurdie@rpsys.net>

---

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9e76a75..386673c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -358,6 +358,7 @@ config ARCH_EP93XX
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_USES_GETTIMEOFFSET
+	select LEDS_GPIO_REGISTER
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 8207954..e294941 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -524,7 +524,7 @@ void __init ep93xx_register_spi(struct ep93xx_spi_info *info,
 /*************************************************************************
  * EP93xx LEDs
  *************************************************************************/
-static struct gpio_led ep93xx_led_pins[] = {
+static const struct gpio_led ep93xx_led_pins[] __initconst = {
 	{
 		.name	= "platform:grled",
 		.gpio	= EP93XX_GPIO_LINE_GRLED,
@@ -534,20 +534,11 @@ static struct gpio_led ep93xx_led_pins[] = {
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
@@ -881,5 +872,6 @@ void __init ep93xx_init_devices(void)
 
 	platform_device_register(&ep93xx_rtc_device);
 	platform_device_register(&ep93xx_ohci_device);
-	platform_device_register(&ep93xx_leds);
+
+	gpio_led_register_device(-1, &ep93xx_led_data);
 }
