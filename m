From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 29 Jul 2010 05:16:19 +0200
Subject: [PATCH 03/13] [ARM] pxa/palm: Add core pmic support for Palm27x
In-Reply-To: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1280373389-32475-3-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/palm27x.c |   57 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index ff5ee8c..a1009ec 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -21,6 +21,7 @@
 #include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
+#include <linux/regulator/max1586.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -35,6 +36,8 @@
 #include <mach/palmasoc.h>
 #include <mach/palm27x.h>
 
+#include <plat/i2c.h>
+
 #include "generic.h"
 #include "devices.h"
 
@@ -458,6 +461,59 @@ static void __init palm27x_power_init(int ac, int usb)
 static inline void palm27x_power_init(int ac, int usb) {}
 #endif
 
+/******************************************************************************
+ * Core power regulator
+ ******************************************************************************/
+#if defined(CONFIG_REGULATOR_MAX1586) || \
+    defined(CONFIG_REGULATOR_MAX1586_MODULE)
+static struct regulator_consumer_supply palm27x_max1587a_consumers[] = {
+	{
+		.supply	= "vcc_core",
+	}
+};
+
+static struct regulator_init_data palm27x_max1587a_v3_info = {
+	.constraints = {
+		.name		= "vcc_core range",
+		.min_uV		= 900000,
+		.max_uV		= 1705000,
+		.always_on	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.consumer_supplies	= palm27x_max1587a_consumers,
+	.num_consumer_supplies	= ARRAY_SIZE(palm27x_max1587a_consumers),
+};
+
+static struct max1586_subdev_data palm27x_max1587a_subdevs[] = {
+	{
+		.name		= "vcc_core",
+		.id		= MAX1586_V3,
+		.platform_data	= &palm27x_max1587a_v3_info,
+	}
+};
+
+static struct max1586_platform_data palm27x_max1587a_info = {
+	.subdevs     = palm27x_max1587a_subdevs,
+	.num_subdevs = ARRAY_SIZE(palm27x_max1587a_subdevs),
+	.v3_gain     = MAX1586_GAIN_R24_3k32, /* 730..1550 mV */
+};
+
+static struct i2c_board_info __initdata palm27x_pi2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("max1586", 0x14),
+		.platform_data	= &palm27x_max1587a_info,
+	},
+};
+
+static void __init palm27x_pmic_init(void)
+{
+	i2c_register_board_info(1, ARRAY_AND_SIZE(palm27x_pi2c_board_info));
+	pxa27x_set_i2c_power_info(NULL);
+}
+#else
+static inline void palm27x_pmic_init(void) {}
+#endif
+
 void __init palm27x_common_init(struct palm27x_handheld *palm)
 {
 	pxa_set_ffuart_info(NULL);
@@ -472,4 +528,5 @@ void __init palm27x_common_init(struct palm27x_handheld *palm)
 	palm27x_ac97_init(palm->batt_minv, palm->batt_maxv, palm->jack_gpio);
 	palm27x_pwm_init(palm->bl_bl, palm->bl_lcd);
 	palm27x_power_init(palm->power_ac, palm->power_usb);
+	palm27x_pmic_init();
 }
-- 
1.7.1
