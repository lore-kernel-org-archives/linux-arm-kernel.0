From: petr.cvek@tul.cz (Petr Cvek)
Date: Tue, 18 Aug 2015 00:04:16 +0200
Subject: [PATCH v2 16/21] ARM: pxa: magician: Add support for alternative LCD
 backlight
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Message-ID: <55D25A60.7000900@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for alternative LCD backlight with GPIO (no brightness).

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 2ec630e..780cc3d 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -102,6 +102,8 @@
 #include <mach/udc.h>
 #include <mach/pxa27x-udc.h>
 
+#include <linux/platform_data/gpio_backlight.h>
+
 #include "devices.h"
 #include "generic.h"
 
@@ -549,6 +551,21 @@ static struct regulator_consumer_supply pwm_backlight_supply[] = {
 	REGULATOR_SUPPLY("power", "pwm_backlight"),
 };
 
+/* Backlight controlled by single GPIO (alternative) */
+static struct gpio_backlight_platform_data gpio_backlight_data = {
+/* .fbdev = &pxa_device_fb.dev, */
+	.gpio		= EGPIO_MAGICIAN_BL_POWER,
+	.def_value	= 1,
+	.name		= "backlight",
+};
+
+static struct platform_device gpio_backlight = {
+	.name = "gpio-backlight",
+	.dev = {
+		.platform_data = &gpio_backlight_data,
+	},
+};
+
 /*
  * LEDs
  */
@@ -1269,7 +1286,6 @@ static struct platform_device *devices[] __initdata = {
 	&gpio_keys,
 	&egpio,
 	&strataflash,
-	&pwm_backlight,
 	&pasic3,
 	&vads7846_device,
 	&bq24022,
@@ -1285,6 +1301,10 @@ static struct platform_device *devices[] __initdata = {
 #if !(IS_ENABLED(CONFIG_USB_PXA27X))
 	&gpio_vbus,
 #endif
+
+	/* NOTICE mutually exclusive */
+	&pwm_backlight,
+	&gpio_backlight,
 };
 
 /*
-- 
1.7.12.1
