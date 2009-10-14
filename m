From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 14 Oct 2009 09:20:18 +0200
Subject: [PATCH 01/10] [ARM] pxa/cm-x300: add revision difference handling
In-Reply-To: <cover.1255504387.git.mike@compulab.co.il>
References: <cover.1255504387.git.mike@compulab.co.il>
Message-ID: <ee3f63191a1b3e1dae9b0d4b5961ac5c7508efb5.1255504387.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Igor Grinberg <grinberg@compulab.co.il>

Different revisions of CM-X300 use different pins for several functions.
Make the kernel aware of it.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index aac2cda..256cfac 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -137,7 +137,6 @@ static mfp_cfg_t cm_x300_mfp_cfg[] __initdata = {
 	GPIO36_UART1_DTR,
 
 	/* GPIOs */
-	GPIO79_GPIO,			/* LED */
 	GPIO82_GPIO | MFP_PULL_HIGH,	/* MMC CD */
 	GPIO85_GPIO,			/* MMC WP */
 	GPIO99_GPIO,			/* Ethernet IRQ */
@@ -153,6 +152,20 @@ static mfp_cfg_t cm_x300_mfp_cfg[] __initdata = {
 	GPIO22_I2C_SDA,
 };
 
+static mfp_cfg_t cm_x300_rev_lt130_mfp_cfg[] __initdata = {
+	/* GPIOs */
+	GPIO79_GPIO,			/* LED */
+	GPIO77_GPIO,			/* WiFi reset */
+	GPIO78_GPIO,			/* BT reset */
+};
+
+static mfp_cfg_t cm_x300_rev_ge130_mfp_cfg[] __initdata = {
+	/* GPIOs */
+	GPIO76_GPIO,			/* LED */
+	GPIO71_GPIO,			/* WiFi reset */
+	GPIO70_GPIO,			/* BT reset */
+};
+
 #if defined(CONFIG_DM9000) || defined(CONFIG_DM9000_MODULE)
 static struct resource dm9000_resources[] = {
 	[0] = {
@@ -351,7 +364,6 @@ static struct gpio_led cm_x300_leds[] = {
 	[0] = {
 		.name = "cm-x300:green",
 		.default_trigger = "heartbeat",
-		.gpio = 79,
 		.active_low = 1,
 	},
 };
@@ -371,6 +383,11 @@ static struct platform_device cm_x300_led_device = {
 
 static void __init cm_x300_init_leds(void)
 {
+	if (system_rev < 130)
+		cm_x300_leds[0].gpio = 79;
+	else
+		cm_x300_leds[0].gpio = 76;
+
 	platform_device_register(&cm_x300_led_device);
 }
 #else
@@ -433,11 +450,20 @@ static void __init cm_x300_init_rtc(void)
 static inline void cm_x300_init_rtc(void) {}
 #endif
 
-static void __init cm_x300_init(void)
+static void __init cm_x300_init_mfp(void)
 {
 	/* board-processor specific GPIO initialization */
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(cm_x300_mfp_cfg));
 
+	if (system_rev < 130)
+		pxa3xx_mfp_config(ARRAY_AND_SIZE(cm_x300_rev_lt130_mfp_cfg));
+	else
+		pxa3xx_mfp_config(ARRAY_AND_SIZE(cm_x300_rev_ge130_mfp_cfg));
+}
+
+static void __init cm_x300_init(void)
+{
+	cm_x300_init_mfp();
 	cm_x300_init_dm9000();
 	cm_x300_init_lcd();
 	cm_x300_init_ohci();
-- 
1.6.0.6
