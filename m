From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Nov 2016 17:29:18 +0100
Subject: [PATCH] ARM: pxa: ezx: fix a910 camera data
Message-ID: <20161124162955.3887066-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The camera_supply_dummy_device definition is shared between a780 and a910,
but only provided when the first is enabled and fails to build for a
configuration with only a910:

arch/arm/mach-pxa/ezx.c:1097:3: error: 'camera_supply_dummy_device' undeclared here (not in a function)

This moves the definition into its own section.

Fixes: 6c1b417adc8f ("ARM: pxa: ezx: use the new pxa_camera platform_data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/ezx.c | 56 ++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 0b8300e6fca3..a057cf9c0e7b 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -696,32 +696,7 @@ static struct pxa27x_keypad_platform_data e2_keypad_platform_data = {
 };
 #endif /* CONFIG_MACH_EZX_E2 */
 
-#ifdef CONFIG_MACH_EZX_A780
-/* gpio_keys */
-static struct gpio_keys_button a780_buttons[] = {
-	[0] = {
-		.code       = SW_LID,
-		.gpio       = GPIO12_A780_FLIP_LID,
-		.active_low = 0,
-		.desc       = "A780 flip lid",
-		.type       = EV_SW,
-		.wakeup     = 1,
-	},
-};
-
-static struct gpio_keys_platform_data a780_gpio_keys_platform_data = {
-	.buttons  = a780_buttons,
-	.nbuttons = ARRAY_SIZE(a780_buttons),
-};
-
-static struct platform_device a780_gpio_keys = {
-	.name = "gpio-keys",
-	.id   = -1,
-	.dev  = {
-		.platform_data = &a780_gpio_keys_platform_data,
-	},
-};
-
+#if defined(CONFIG_MACH_EZX_A780) || defined(CONFIG_MACH_EZX_A910)
 /* camera */
 static struct regulator_consumer_supply camera_dummy_supplies[] = {
 	REGULATOR_SUPPLY("vdd", "0-005d"),
@@ -750,6 +725,35 @@ static struct platform_device camera_supply_dummy_device = {
 		.platform_data = &camera_dummy_config,
 	},
 };
+#endif
+
+#ifdef CONFIG_MACH_EZX_A780
+/* gpio_keys */
+static struct gpio_keys_button a780_buttons[] = {
+	[0] = {
+		.code       = SW_LID,
+		.gpio       = GPIO12_A780_FLIP_LID,
+		.active_low = 0,
+		.desc       = "A780 flip lid",
+		.type       = EV_SW,
+		.wakeup     = 1,
+	},
+};
+
+static struct gpio_keys_platform_data a780_gpio_keys_platform_data = {
+	.buttons  = a780_buttons,
+	.nbuttons = ARRAY_SIZE(a780_buttons),
+};
+
+static struct platform_device a780_gpio_keys = {
+	.name = "gpio-keys",
+	.id   = -1,
+	.dev  = {
+		.platform_data = &a780_gpio_keys_platform_data,
+	},
+};
+
+/* camera */
 static int a780_camera_reset(struct device *dev)
 {
 	gpio_set_value(GPIO19_GEN1_CAM_RST, 0);
-- 
2.9.0
