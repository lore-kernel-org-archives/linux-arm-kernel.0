From: mikedunn@newsguy.com (Mike Dunn)
Date: Sat, 22 Dec 2012 11:31:58 -0800
Subject: [PATCH 2/3] ARM: pxa: palmtreo: fix #ifdefs for leds-gpio device
In-Reply-To: <1356204719-3317-1-git-send-email-mikedunn@newsguy.com>
References: <1356204719-3317-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <1356204719-3317-3-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The #ifdefs around the leds-gpio device platform data are erroneous.  Currently
the device is not instantiated on the centro unless CONFIG_MACH_TREO680 is
defined.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---

The #ifdefs within palmtreo_leds_init() are a little ugly, but I think the only
alternative would be to instantiate the leds-gpio device platform data for both
treo680 and centro, which would require some of the #defines in palmtreo.h to be
moved outside their containing #ifdef CONFIG_MACH_{TREO680,CENTRO}.

 arch/arm/mach-pxa/palmtreo.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index dcc38a1..cb9cc7b 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -357,7 +357,9 @@ static struct gpio_led_platform_data treo680_gpio_led_info = {
 	.leds		= treo680_gpio_leds,
 	.num_leds	= ARRAY_SIZE(treo680_gpio_leds),
 };
+#endif
 
+#ifdef CONFIG_MACH_CENTRO
 static struct gpio_led centro_gpio_leds[] = {
 	{
 		.name			= "centro:vibra:vibra",
@@ -381,25 +383,25 @@ static struct gpio_led_platform_data centro_gpio_led_info = {
 	.leds		= centro_gpio_leds,
 	.num_leds	= ARRAY_SIZE(centro_gpio_leds),
 };
+#endif
 
 static struct platform_device palmtreo_leds = {
 	.name   = "leds-gpio",
 	.id     = -1,
-	.dev    = {
-		.platform_data  = &treo680_gpio_led_info,
-	}
 };
 
 static void __init palmtreo_leds_init(void)
 {
+#ifdef CONFIG_MACH_CENTRO
 	if (machine_is_centro())
 		palmtreo_leds.dev.platform_data = &centro_gpio_led_info;
-
+#endif
+#ifdef CONFIG_MACH_TREO680
+	if (machine_is_treo680())
+		palmtreo_leds.dev.platform_data = &treo680_gpio_led_info;
+#endif
 	platform_device_register(&palmtreo_leds);
 }
-#else
-static inline void palmtreo_leds_init(void) {}
-#endif
 
 /******************************************************************************
  * Machine init
-- 
1.7.8.6
