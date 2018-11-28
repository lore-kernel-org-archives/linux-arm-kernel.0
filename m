From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 28 Nov 2018 14:09:30 +0000
Subject: [PATCH 2/3] ARM: sa1100/assabet: switch to using gpio leds
In-Reply-To: <20181128140842.GH30658@n2100.armlinux.org.uk>
References: <20181128140842.GH30658@n2100.armlinux.org.uk>
Message-ID: <E1gS0Ww-0000u3-2Z@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch over to using gpio leds now that we have the gpio driver for
the assabet board register in place.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/Kconfig   |   1 +
 arch/arm/mach-sa1100/assabet.c | 113 ++++++++++-------------------------------
 2 files changed, 28 insertions(+), 86 deletions(-)

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index fde7ef1ab192..ab0a71c8b10e 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -6,6 +6,7 @@ config SA1100_ASSABET
 	bool "Assabet"
 	select ARM_SA1110_CPUFREQ
 	select GPIO_REG
+	select LEDS_GPIO_REGISTER
 	select REGULATOR
 	select REGULATOR_FIXED_VOLTAGE
 	help
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 53afea52a961..dfa42496ec27 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -102,7 +102,7 @@ static int __init assabet_init_gpio(void __iomem *reg, u32 def_val)
 
 	assabet_bcr_gc = gc;
 
-	return 0;
+	return gc->base;
 }
 
 /*
@@ -480,6 +480,25 @@ static struct gpiod_lookup_table assabet_cf_vcc_gpio_table = {
 	},
 };
 
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
@@ -563,6 +582,8 @@ static void __init assabet_init(void)
 					  &assabet_keys_pdata,
 					  sizeof(assabet_keys_pdata));
 
+	gpio_led_register_device(-1, &assabet_leds_pdata);
+
 #ifndef ASSABET_PAL_VIDEO
 	sa11x0_register_lcd(&lq039q2ds54_info);
 #else
@@ -756,92 +777,9 @@ static void __init assabet_map_io(void)
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
+	unsigned int assabet_gpio_base;
 	u32 def_val;
 
 	sa1100_init_irq();
@@ -856,7 +794,10 @@ void __init assabet_init_irq(void)
 	 *
 	 * This must precede any driver calls to BCR_set() or BCR_clear().
 	 */
-	assabet_init_gpio((void *)&ASSABET_BCR, def_val);
+	assabet_gpio_base = assabet_init_gpio((void *)&ASSABET_BCR, def_val);
+
+	assabet_leds[0].gpio = assabet_gpio_base + 13;
+	assabet_leds[1].gpio = assabet_gpio_base + 14;
 }
 
 MACHINE_START(ASSABET, "Intel-Assabet")
-- 
2.7.4
