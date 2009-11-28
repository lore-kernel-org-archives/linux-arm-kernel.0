From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 28 Nov 2009 04:05:29 +0100
Subject: [PATCH] ARM: gta02: Add button support
In-Reply-To: <1259377532-8012-1-git-send-email-lars@metafoo.de>
References: <1259377532-8012-1-git-send-email-lars@metafoo.de>
Message-ID: <1259377532-8012-2-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gta02 has two buttons which are connected to gpio pins and thus can get
supported by using the generic gpio-keys driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-By: Nelson Castillo <arhuaco@freaks-unidos.net>
---
 arch/arm/mach-s3c2442/mach-gta02.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2442/mach-gta02.c b/arch/arm/mach-s3c2442/mach-gta02.c
index 0fb385b..0f0c619 100644
--- a/arch/arm/mach-s3c2442/mach-gta02.c
+++ b/arch/arm/mach-s3c2442/mach-gta02.c
@@ -58,6 +58,8 @@
 #include <linux/mfd/pcf50633/gpio.h>
 #include <linux/mfd/pcf50633/pmic.h>
 
+#include <linux/gpio_keys.h>
+
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -550,6 +552,36 @@ static struct s3c2410_hcd_info gta02_usb_info = {
 	},
 };
 
+/* Buttons */
+static struct gpio_keys_button gta02_buttons[] = {
+	{
+		.gpio = GTA02_GPIO_AUX_KEY,
+		.code = KEY_PHONE,
+		.desc = "Aux",
+		.type = EV_KEY,
+		.debounce_interval = 100,
+	},
+	{
+		.gpio = GTA02_GPIO_HOLD_KEY,
+		.code = KEY_PAUSE,
+		.desc = "Hold",
+		.type = EV_KEY,
+		.debounce_interval = 100,
+	},
+};
+
+static struct gpio_keys_platform_data gta02_buttons_pdata = {
+	.buttons = gta02_buttons,
+	.nbuttons = ARRAY_SIZE(gta02_buttons),
+};
+
+static struct platform_device gta02_buttons_device = {
+	.name = "gpio-keys",
+	.id = -1,
+	.dev = {
+		.platform_data = &gta02_buttons_pdata,
+	},
+};
 
 static void __init gta02_map_io(void)
 {
@@ -571,6 +603,7 @@ static struct platform_device *gta02_devices[] __initdata = {
 	&s3c24xx_pwm_device,
 	&s3c_device_iis,
 	&s3c_device_i2c0,
+	&gta02_buttons_device,
 };
 
 /* These guys DO need to be children of PMU. */
-- 
1.5.6.5
