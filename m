From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 12:03:07 +0100
Subject: [PATCH 2/3] ARM: sa1100/assabet: switch to using gpio leds
In-Reply-To: <20160829110157.GE1041@n2100.armlinux.org.uk>
References: <20160829110157.GE1041@n2100.armlinux.org.uk>
Message-ID: <E1beKLL-000170-HH@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch over to using gpio leds now that we have the gpio driver for
the assabet board register in place.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/Kconfig   |   1 +
 arch/arm/mach-sa1100/assabet.c | 109 +++++++++--------------------------------
 2 files changed, 25 insertions(+), 85 deletions(-)

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 07df3a59b13f..b34f229fbfb4 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -6,6 +6,7 @@ config SA1100_ASSABET
 	bool "Assabet"
 	select ARM_SA1110_CPUFREQ
 	select GPIO_REG
+	select LEDS_GPIO_REGISTER
 	help
 	  Say Y here if you are using the Intel(R) StrongARM(R) SA-1110
 	  Microprocessor Development Board (also known as the Assabet).
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 0d473aa23a6c..af5cea464a10 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -494,6 +494,25 @@ static int assabet_register_fixed_regulator(int n,
 	return 0;
 }
 
+static struct gpio_led assabet_leds[] __initdata = {
+	{
+		.name = "assabet:red",
+		.default_trigger = "cpu0",
+		.active_low = 1,
+		.default_state = LEDS_GPIO_DEFSTATE_KEEP,
+	}, {
+		.name = "assabet:green",
+		.default_trigger = "heartbeat",
+		.active_low = 1,
+		.default_state = LEDS_GPIO_DEFSTATE_KEEP,
+	},
+};
+
+static const struct gpio_led_platform_data assabet_leds_pdata __initconst = {
+	.num_leds = ARRAY_SIZE(assabet_leds),
+	.leds = assabet_leds,
+};
+
 static struct gpio_keys_button assabet_keys_buttons[] = {
 	{
 		.gpio = 0,
@@ -572,9 +591,10 @@ static void __init assabet_init(void)
 		assabet_register_fixed_regulator(0, &assabet_cf_vcc_pdata,
 					 assabet_cf_vcc_consumers,
 					 ARRAY_SIZE(assabet_cf_vcc_consumers));
-
 	}
 
+	gpio_led_register_device(-1, &assabet_leds_pdata);
+
 #ifndef ASSABET_PAL_VIDEO
 	sa11x0_register_lcd(&lq039q2ds54_info);
 #else
@@ -768,90 +788,6 @@ static void __init assabet_map_io(void)
 	sa1100_register_uart(2, 3);
 }
 
-/* LEDs */
-#if defined(CONFIG_NEW_LEDS) && defined(CONFIG_LEDS_CLASS)
-struct assabet_led {
-	struct led_classdev cdev;
-	u32 mask;
-};
-
-/*
- * The triggers lines up below will only be used if the
- * LED triggers are compiled in.
- */
-static const struct {
-	const char *name;
-	const char *trigger;
-} assabet_leds[] = {
-	{ "assabet:red", "cpu0",},
-	{ "assabet:green", "heartbeat", },
-};
-
-/*
- * The LED control in Assabet is reversed:
- *  - setting bit means turn off LED
- *  - clearing bit means turn on LED
- */
-static void assabet_led_set(struct led_classdev *cdev,
-		enum led_brightness b)
-{
-	struct assabet_led *led = container_of(cdev,
-			struct assabet_led, cdev);
-
-	if (b != LED_OFF)
-		ASSABET_BCR_clear(led->mask);
-	else
-		ASSABET_BCR_set(led->mask);
-}
-
-static enum led_brightness assabet_led_get(struct led_classdev *cdev)
-{
-	struct assabet_led *led = container_of(cdev,
-			struct assabet_led, cdev);
-
-	return (ASSABET_BCR & led->mask) ? LED_OFF : LED_FULL;
-}
-
-static int __init assabet_leds_init(void)
-{
-	int i;
-
-	if (!machine_is_assabet())
-		return -ENODEV;
-
-	for (i = 0; i < ARRAY_SIZE(assabet_leds); i++) {
-		struct assabet_led *led;
-
-		led = kzalloc(sizeof(*led), GFP_KERNEL);
-		if (!led)
-			break;
-
-		led->cdev.name = assabet_leds[i].name;
-		led->cdev.brightness_set = assabet_led_set;
-		led->cdev.brightness_get = assabet_led_get;
-		led->cdev.default_trigger = assabet_leds[i].trigger;
-
-		if (!i)
-			led->mask = ASSABET_BCR_LED_RED;
-		else
-			led->mask = ASSABET_BCR_LED_GREEN;
-
-		if (led_classdev_register(NULL, &led->cdev) < 0) {
-			kfree(led);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * Since we may have triggers on any subsystem, defer registration
- * until after subsystem_init.
- */
-fs_initcall(assabet_leds_init);
-#endif
-
 void __init assabet_init_irq(void)
 {
 	unsigned int assabet_gpio_base;
@@ -872,6 +808,9 @@ void __init assabet_init_irq(void)
 	assabet_gpio_base = assabet_init_gpio((void *)&ASSABET_BCR, def_val);
 
 	assabet_cf_vcc_pdata.gpio = assabet_gpio_base + 0;
+
+	assabet_leds[0].gpio = assabet_gpio_base + 13;
+	assabet_leds[1].gpio = assabet_gpio_base + 14;
 }
 
 MACHINE_START(ASSABET, "Intel-Assabet")
-- 
2.1.0
