From: mikedunn@newsguy.com (Mike Dunn)
Date: Thu, 27 Dec 2012 10:02:18 -0800
Subject: [PATCH v2 2/4] ARM: palmtreo: fix #ifdefs for leds-gpio device
In-Reply-To: <1356631340-30328-1-git-send-email-mikedunn@newsguy.com>
References: <1356631340-30328-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <1356631340-30328-3-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The #ifdefs around the leds-gpio device platform data are erroneous.  Currently
the device is not instantiated on the centro unless CONFIG_MACH_TREO680 is
defined.  This patch eliminates the #ifdefs, and uses the machine_is_* macros to
initialize the data based on which machine the code is running on and the
build-time configuration.  Unused data is optimized out by the build tools if
build configuration does not enable support for both machines.

Tested on my palm treo 680, and compile-tested for all three combinations of
treo680/centro build configurations.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 arch/arm/mach-pxa/include/mach/palmtreo.h |    2 --
 arch/arm/mach-pxa/palmtreo.c              |    9 ++-------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/palmtreo.h b/arch/arm/mach-pxa/include/mach/palmtreo.h
index 3266194..714b657 100644
--- a/arch/arm/mach-pxa/include/mach/palmtreo.h
+++ b/arch/arm/mach-pxa/include/mach/palmtreo.h
@@ -38,7 +38,6 @@
 #define GPIO_NR_TREO_LCD_POWER	25
 
 /* Treo680 specific GPIOs */
-#ifdef CONFIG_MACH_TREO680
 #define GPIO_NR_TREO680_SD_READONLY	33
 #define GPIO_NR_TREO680_SD_POWER	42
 #define GPIO_NR_TREO680_VIBRATE_EN	44
@@ -47,7 +46,6 @@
 #define GPIO_NR_TREO680_LCD_POWER	77
 #define GPIO_NR_TREO680_LCD_EN		86
 #define GPIO_NR_TREO680_LCD_EN_N	25
-#endif /* CONFIG_MACH_TREO680 */
 
 /* Centro685 specific GPIOs */
 #define GPIO_NR_CENTRO_SD_POWER		21
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 4441216..5775128 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -334,7 +334,6 @@ static inline void palmtreo_uhc_init(void) {}
 /******************************************************************************
  * Vibra and LEDs
  ******************************************************************************/
-#ifdef CONFIG_MACH_TREO680
 static struct gpio_led treo680_gpio_leds[] = {
 	{
 		.name			= "treo680:vibra:vibra",
@@ -385,21 +384,17 @@ static struct gpio_led_platform_data centro_gpio_led_info = {
 static struct platform_device palmtreo_leds = {
 	.name   = "leds-gpio",
 	.id     = -1,
-	.dev    = {
-		.platform_data  = &treo680_gpio_led_info,
-	}
 };
 
 static void __init palmtreo_leds_init(void)
 {
 	if (machine_is_centro())
 		palmtreo_leds.dev.platform_data = &centro_gpio_led_info;
+	else if (machine_is_treo680())
+		palmtreo_leds.dev.platform_data = &treo680_gpio_led_info;
 
 	platform_device_register(&palmtreo_leds);
 }
-#else
-static inline void palmtreo_leds_init(void) {}
-#endif
 
 /******************************************************************************
  * Machine init
-- 
1.7.8.6
