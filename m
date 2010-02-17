From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Feb 2010 18:19:31 +0000
Subject: [PATCH 3/3] ARM: SMDK6410: Add support for PMIC LED on WM1192-EV1
	PMIC module
In-Reply-To: <1266430771-6037-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1266430771-6037-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1266430771-6037-3-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMIC LED on the SMDK6410 CPU board is driven by GPIO4 of the
WM8312 PMIC. Provide software control of this LED.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index b397ad8..6176243 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
+#include <linux/leds.h>
 #include <linux/fb.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
@@ -33,6 +34,7 @@
 #endif
 
 #ifdef CONFIG_SMDK6410_WM1192_EV1
+#include <linux/mfd/wm831x/core.h>
 #include <linux/mfd/wm831x/pdata.h>
 #endif
 
@@ -473,11 +475,38 @@ static struct wm8350_platform_data __initdata smdk6410_wm8350_pdata = {
 #endif
 
 #ifdef CONFIG_SMDK6410_WM1192_EV1
+static struct gpio_led wm1192_pmic_leds[] = {
+	{
+		.name = "PMIC:red:power",
+		.gpio = GPIO_BOARD_START + 3,
+		.default_state = LEDS_GPIO_DEFSTATE_ON,
+	},
+};
+
+static struct gpio_led_platform_data wm1192_pmic_led = {
+	.num_leds = ARRAY_SIZE(wm1192_pmic_leds),
+	.leds = wm1192_pmic_leds,
+};
+
+static struct platform_device wm1192_pmic_led_dev = {
+	.name          = "leds-gpio",
+	.id            = -1,
+	.dev = {
+		.platform_data = &wm1192_pmic_led,
+	},
+};
+
 static int wm1192_pre_init(struct wm831x *wm831x)
 {
+	int ret;
+
 	/* Configure the IRQ line */
 	s3c_gpio_setpull(S3C64XX_GPN(12), S3C_GPIO_PULL_UP);
 
+	ret = platform_device_register(&wm1192_pmic_led_dev);
+	if (ret != 0)
+		dev_err(wm831x->dev, "Failed to add PMIC LED: %d\n", ret);
+
 	return 0;
 }
 
@@ -524,6 +553,7 @@ static struct wm831x_pdata smdk6410_wm1192_pdata = {
 		&smdk6410_vddint,  /* DCDC2 */
 		&wm1192_dcdc3,
 	},
+	.gpio_base = GPIO_BOARD_START,
 	.ldo = {
 		 &wm1192_ldo1,        /* LDO1 */
 		 &smdk6410_vdduh_mmc, /* LDO2 */
-- 
1.6.6.1
