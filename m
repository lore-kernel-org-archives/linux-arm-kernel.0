From: achew@nvidia.com (Andrew Chew)
Date: Mon, 1 Apr 2013 14:53:22 -0700
Subject: [PATCH V6 3/9] ARM: pxa: Provide regulator to pwm-backlight
In-Reply-To: <1364853208-32503-1-git-send-email-achew@nvidia.com>
References: <1364853208-32503-1-git-send-email-achew@nvidia.com>
Message-ID: <1364853208-32503-4-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 arch/arm/mach-pxa/cm-x300.c               |  7 +++++++
 arch/arm/mach-pxa/colibri-pxa270-income.c |  8 ++++++++
 arch/arm/mach-pxa/ezx.c                   |  9 +++++++++
 arch/arm/mach-pxa/hx4700.c                |  8 ++++++++
 arch/arm/mach-pxa/lpd270.c                |  9 +++++++++
 arch/arm/mach-pxa/magician.c              |  8 ++++++++
 arch/arm/mach-pxa/mainstone.c             | 13 ++++++++++++-
 arch/arm/mach-pxa/mioa701.c               |  8 ++++++++
 arch/arm/mach-pxa/palm27x.c               |  8 ++++++++
 arch/arm/mach-pxa/palmtc.c                |  8 ++++++++
 arch/arm/mach-pxa/palmte2.c               |  9 +++++++++
 arch/arm/mach-pxa/pcm990-baseboard.c      |  8 ++++++++
 arch/arm/mach-pxa/raumfeld.c              |  6 ++++++
 arch/arm/mach-pxa/tavorevb.c              | 11 +++++++++++
 arch/arm/mach-pxa/viper.c                 |  8 ++++++++
 arch/arm/mach-pxa/z2.c                    | 10 ++++++++++
 arch/arm/mach-pxa/zylonite.c              |  7 +++++++
 17 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 8091aac..7e1887a 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -34,6 +34,7 @@
 
 #include <linux/mfd/da903x.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/power_supply.h>
 #include <linux/apm-emulation.h>
 
@@ -305,6 +306,10 @@ static inline void cm_x300_init_lcd(void) {}
 #endif
 
 #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight.0");
+
 static struct platform_pwm_backlight_data cm_x300_backlight_data = {
 	.pwm_id		= 2,
 	.max_brightness	= 100,
@@ -322,6 +327,8 @@ static struct platform_device cm_x300_backlight_device = {
 
 static void cm_x300_init_bl(void)
 {
+	regulator_register_always_on(-1, "backlight-power",
+		&backlight_supply, 1, 0);
 	platform_device_register(&cm_x300_backlight_device);
 }
 #else
diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
index 2d4a7b4..108f2a7 100644
--- a/arch/arm/mach-pxa/colibri-pxa270-income.c
+++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
@@ -20,6 +20,8 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 #include <linux/i2c/pxa-i2c.h>
 
@@ -184,6 +186,10 @@ static inline void income_lcd_init(void) {}
  * Backlight
  ******************************************************************************/
 #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight.0");
+
 static struct platform_pwm_backlight_data income_backlight_data = {
 	.pwm_id		= 0,
 	.max_brightness	= 0x3ff,
@@ -201,6 +207,8 @@ static struct platform_device income_backlight = {
 
 static void __init income_pwm_init(void)
 {
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
 	platform_device_register(&income_backlight);
 }
 #else
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index dca1070..2b39d5f 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -15,6 +15,8 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
@@ -49,6 +51,10 @@
 #define GPIO19_GEN1_CAM_RST		19
 #define GPIO28_GEN2_CAM_RST		28
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight.0");
+
 static struct platform_pwm_backlight_data ezx_backlight_data = {
 	.pwm_id		= 0,
 	.max_brightness	= 1023,
@@ -792,6 +798,9 @@ static void __init a780_init(void)
 		platform_device_register(&a780_camera);
 	}
 
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
+
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(a780_devices));
 }
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 133109e..b2f444a 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -33,6 +33,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/gpio-regulator.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/max1586.h>
 #include <linux/spi/ads7846.h>
 #include <linux/spi/spi.h>
@@ -556,6 +557,10 @@ static struct platform_device hx4700_lcd = {
  * Backlight
  */
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight");
+
 static struct platform_pwm_backlight_data backlight_data = {
 	.pwm_id         = -1,	/* Superseded by pwm_lookup */
 	.max_brightness = 200,
@@ -876,6 +881,9 @@ static void __init hx4700_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	pwm_add_table(hx4700_pwm_lookup, ARRAY_SIZE(hx4700_pwm_lookup));
 
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index 1255ee0..985f622 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -23,6 +23,8 @@
 #include <linux/ioport.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 
 #include <asm/types.h>
@@ -264,6 +266,10 @@ static struct platform_device lpd270_flash_device[2] = {
 	},
 };
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight.0");
+
 static struct platform_pwm_backlight_data lpd270_backlight_data = {
 	.pwm_id		= 0,
 	.max_brightness	= 1,
@@ -466,6 +472,9 @@ static void __init lpd270_init(void)
 	 */
 	ARB_CNTRL = ARB_CORE_PARK | 0x234;
 
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
+
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 
 	pxa_set_ac97_info(NULL);
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index f44532f..dcae8cc 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -27,6 +27,7 @@
 #include <linux/pwm_backlight.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/gpio-regulator.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/i2c/pxa-i2c.h>
@@ -373,6 +374,10 @@ static void magician_backlight_exit(struct device *dev)
 	gpio_free_array(ARRAY_AND_SIZE(magician_bl_gpios));
 }
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight");
+
 static struct platform_pwm_backlight_data backlight_data = {
 	.pwm_id         = 0,
 	.max_brightness = 272,
@@ -742,6 +747,9 @@ static void __init magician_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
+
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 
 	pxa_set_ficp_info(&magician_ficp_info);
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 7a12c1b..c7b13be 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -25,6 +25,8 @@
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 #include <linux/smc91x.h>
 #include <linux/i2c/pxa-i2c.h>
@@ -333,6 +335,10 @@ static struct platform_device mst_flash_device[2] = {
 };
 
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight.0");
+
 static struct platform_pwm_backlight_data mainstone_backlight_data = {
 	.pwm_id		= 0,
 	.max_brightness	= 1023,
@@ -350,7 +356,12 @@ static struct platform_device mainstone_backlight_device = {
 
 static void __init mainstone_backlight_register(void)
 {
-	int ret = platform_device_register(&mainstone_backlight_device);
+	int ret;
+
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
+
+	ret = platform_device_register(&mainstone_backlight_device);
 	if (ret)
 		printk(KERN_ERR "mainstone: failed to register backlight device: %d\n", ret);
 }
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index f8979b9..ba9e1cb 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -37,6 +37,8 @@
 #include <linux/wm97xx.h>
 #include <linux/mtd/physmap.h>
 #include <linux/usb/gpio_vbus.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/max1586.h>
 #include <linux/slab.h>
 #include <linux/i2c/pxa-i2c.h>
@@ -179,6 +181,10 @@ static unsigned long mioa701_pin_config[] = {
 	MFP_CFG_OUT(GPIO116, AF0, DRIVE_HIGH),
 };
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight");
+
 /* LCD Screen and Backlight */
 static struct platform_pwm_backlight_data mioa701_backlight_data = {
 	.pwm_id		= 0,
@@ -739,6 +745,8 @@ static void __init mioa701_machine_init(void)
 	pxa_set_udc_info(&mioa701_udc_info);
 	pxa_set_ac97_info(&mioa701_ac97_info);
 	pm_power_off = mioa701_poweroff;
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	gsm_init();
 
diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 17d4c53..fc34f2b 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -20,6 +20,8 @@
 #include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/max1586.h>
 #include <linux/i2c/pxa-i2c.h>
 
@@ -317,6 +319,10 @@ static void palm27x_backlight_exit(struct device *dev)
 		gpio_free(palm_lcd_power);
 }
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight.0");
+
 static struct platform_pwm_backlight_data palm27x_backlight_data = {
 	.pwm_id		= 0,
 	.max_brightness	= 0xfe,
@@ -339,6 +345,8 @@ void __init palm27x_pwm_init(int bl, int lcd)
 {
 	palm_bl_power	= bl;
 	palm_lcd_power	= lcd;
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
 	platform_device_register(&palm27x_backlight);
 }
 #endif
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 100b176f..b6b241c 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -18,6 +18,8 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/input.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
 #include <linux/input/matrix_keypad.h>
@@ -197,6 +199,10 @@ static void palmtc_backlight_exit(struct device *dev)
 	gpio_free(GPIO_NR_PALMTC_BL_POWER);
 }
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight.0");
+
 static struct platform_pwm_backlight_data palmtc_backlight_data = {
 	.pwm_id		= 1,
 	.max_brightness	= PALMTC_MAX_INTENSITY,
@@ -217,6 +223,8 @@ static struct platform_device palmtc_backlight = {
 
 static void __init palmtc_pwm_init(void)
 {
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
 	platform_device_register(&palmtc_backlight);
 }
 #else
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 0742721..d181f65 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -21,6 +21,8 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/pda_power.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
 #include <linux/wm97xx.h>
@@ -160,6 +162,10 @@ static void palmte2_backlight_exit(struct device *dev)
 	gpio_free_array(ARRAY_AND_SIZE(palmte_bl_gpios));
 }
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight.0");
+
 static struct platform_pwm_backlight_data palmte2_backlight_data = {
 	.pwm_id		= 0,
 	.max_brightness	= PALMTE2_MAX_INTENSITY,
@@ -354,6 +360,9 @@ static void __init palmte2_init(void)
 	pxa_set_ac97_info(&palmte2_ac97_pdata);
 	pxa_set_ficp_info(&palmte2_ficp_platform_data);
 
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index fb7f1d1..25c480d 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -24,6 +24,8 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 
 #include <media/mt9v022.h>
@@ -148,6 +150,10 @@ static struct pxafb_mach_info pcm990_fbinfo __initdata = {
 };
 #endif
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight.0");
+
 static struct platform_pwm_backlight_data pcm990_backlight_data = {
 	.pwm_id		= 0,
 	.max_brightness	= 1023,
@@ -539,6 +545,8 @@ void __init pcm990_baseboard_init(void)
 #ifndef CONFIG_PCM990_DISPLAY_NONE
 	pxa_set_fb_info(NULL, &pcm990_fbinfo);
 #endif
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
 	platform_device_register(&pcm990_backlight_device);
 
 	/* MMC */
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index af41888..aff0947 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -531,6 +531,10 @@ static void __init raumfeld_w1_init(void)
  * Framebuffer device
  */
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight.0");
+
 /* PWM controlled backlight */
 static struct platform_pwm_backlight_data raumfeld_pwm_backlight_data = {
 	.pwm_id		= 0,
@@ -617,6 +621,8 @@ static void __init raumfeld_lcd_init(void)
 	} else {
 		mfp_cfg_t raumfeld_pwm_pin_config = GPIO17_PWM0_OUT;
 		pxa3xx_mfp_config(&raumfeld_pwm_pin_config, 1);
+		regulator_register_always_on(-1, "backlight-power",
+					     &backlight_supply, 1, 0);
 		platform_device_register(&raumfeld_pwm_backlight_device);
 	}
 
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index f55979c..db61de5 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -18,6 +18,8 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/smc91x.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 
 #include <asm/mach-types.h>
@@ -164,6 +166,12 @@ static inline void tavorevb_init_keypad(void) {}
 #endif /* CONFIG_KEYBOARD_PXA27x || CONFIG_KEYBOARD_PXA27x_MODULE */
 
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply[] = {
+	REGULATOR_SUPPLY("power", "pwm-backlight.0"),
+	REGULATOR_SUPPLY("power", "pwm-backlight.1"),
+};
+
 static struct platform_pwm_backlight_data tavorevb_backlight_data[] = {
 	[0] = {
 		/* primary backlight */
@@ -464,6 +472,9 @@ static struct pxafb_mach_info tavorevb_lcd_info = {
 
 static void __init tavorevb_init_lcd(void)
 {
+	regulator_register_always_on(-1, "backlight-power",
+				     backlight_supply,
+				     ARRAY_SIZE(backlight_supply), 0);
 	platform_device_register(&tavorevb_backlight_devices[0]);
 	platform_device_register(&tavorevb_backlight_devices[1]);
 	pxa_set_fb_info(NULL, &tavorevb_lcd_info);
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 9c363c0..ed625d9 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -39,6 +39,8 @@
 #include <linux/i2c/pxa-i2c.h>
 #include <linux/serial_8250.h>
 #include <linux/smc91x.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 #include <linux/usb/isp116x.h>
 #include <linux/mtd/mtd.h>
@@ -396,6 +398,10 @@ static void viper_backlight_exit(struct device *dev)
 	gpio_free(VIPER_BCKLIGHT_EN_GPIO);
 }
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight.0");
+
 static struct platform_pwm_backlight_data viper_backlight_data = {
 	.pwm_id		= 0,
 	.max_brightness	= 100,
@@ -940,6 +946,8 @@ static void __init viper_init(void)
 		smc91x_device.num_resources--;
 
 	pxa_set_i2c_info(NULL);
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
 	platform_add_devices(viper_devs, ARRAY_SIZE(viper_devs));
 
 	viper_init_vcore_gpios();
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 989903a..a7ff8a8 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -29,6 +29,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/delay.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/i2c/pxa-i2c.h>
 
 #include <asm/mach-types.h>
@@ -199,6 +200,12 @@ static inline void z2_nor_init(void) {}
  * Backlight
  ******************************************************************************/
 #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply[] = {
+	REGULATOR_SUPPLY("power", "pwm-backlight.0"),
+	REGULATOR_SUPPLY("power", "pwm-backlight.1"),
+};
+
 static struct platform_pwm_backlight_data z2_backlight_data[] = {
 	[0] = {
 		/* Keypad Backlight */
@@ -234,6 +241,9 @@ static struct platform_device z2_backlight_devices[2] = {
 };
 static void __init z2_pwm_init(void)
 {
+	regulator_register_always_on(-1, "backlight-power",
+				     backlight_supply,
+				     ARRAY_SIZE(backlight_supply), 0);
 	platform_device_register(&z2_backlight_devices[0]);
 	platform_device_register(&z2_backlight_devices[1]);
 }
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 1f00d65..04409f1 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -120,6 +120,10 @@ static inline void zylonite_init_leds(void) {}
 #endif
 
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight.0");
+
 static struct platform_pwm_backlight_data zylonite_backlight_data = {
 	.pwm_id		= 3,
 	.max_brightness	= 100,
@@ -205,6 +209,9 @@ static struct pxafb_mach_info zylonite_sharp_lcd_info = {
 
 static void __init zylonite_init_lcd(void)
 {
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
+
 	platform_device_register(&zylonite_backlight_device);
 
 	if (lcd_id & 0x20) {
-- 
1.8.1.5
