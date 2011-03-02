From: dh09.lee@samsung.com (Donghwa Lee)
Date: Wed, 02 Mar 2011 10:17:50 +0900
Subject: [PATCH] ARM: EXYNOS4: enabled lcd and backlight in NURI board
Message-ID: <1299028671-9062-1-git-send-email-dh09.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables lcd and backlight drivers in NURI board.

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
------
 arch/arm/configs/exynos4_nuri_defconfig |    9 +++-
 arch/arm/mach-exynos4/Kconfig           |    1 +
 arch/arm/mach-exynos4/mach-nuri.c       |   62 +++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/exynos4_nuri_defconfig b/arch/arm/configs/exynos4_nuri_defconfig
index 5f03027..e2f0bfb 100644
--- a/arch/arm/configs/exynos4_nuri_defconfig
+++ b/arch/arm/configs/exynos4_nuri_defconfig
@@ -786,8 +786,13 @@ CONFIG_REGULATOR=y
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_FB=y
+CONFIG_FB_S3C=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_LCD_PLATFORM=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_PWM=y
 
 #
 # Display device support
diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 5bf00b9..1d0d222 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -135,6 +135,7 @@ config MACH_NURI
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C5
 	select EXYNOS4_SETUP_SDHCI
+	select HAVE_PWM
 	help
 	  Machine support for Samsung Mobile NURI Board.
 
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index 28010bd..d06cc91 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -17,6 +17,10 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/mmc/host.h>
+#include <linux/fb.h>
+#include <linux/pwm_backlight.h>
+
+#include <video/platform_lcd.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -26,6 +30,8 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/sdhci.h>
+#include <plat/fb.h>
+#include <plat/regs-fb.h>
 
 #include <mach/map.h>
 
@@ -181,6 +187,60 @@ static struct platform_device nuri_gpio_keys = {
 	},
 };
 
+static int lcd_power_on(struct lcd_device *ld, int enable)
+{
+	int gpio = EXYNOS4_GPE1(5);
+
+	gpio_request(gpio, "LVDS_nSHDN");
+
+	if (enable)
+		gpio_direction_output(gpio, 1);
+	else
+		gpio_direction_output(gpio, 0);
+
+	return 0;
+}
+
+static int backlight_init(struct device *dev)
+{
+	return 0;
+}
+
+/* nuri pwm backlight */
+static struct platform_pwm_backlight_data nuri_backlight_data = {
+	.pwm_id			= 0,
+	.pwm_period_ns		= 30000,
+	.max_brightness		= 100,
+	.dft_brightness		= 50,
+	.init			= backlight_init,
+};
+
+static struct platform_device nuri_backlight_device = {
+	.name			= "pwm-backlight",
+	.id			= -1,
+	.dev			= {
+		.platform_data	= &nuri_backlight_data,
+	},
+};
+
+static struct plat_lcd_data nuri_lcd_platform_data = {
+	.set_power		= lcd_power_on,
+};
+
+static struct platform_device nuri_lcd_device = {
+	.name			= "platform-lcd",
+	.id			= -1,
+	.dev			= {
+		.platform_data	= (void *) &nuri_lcd_platform_data,
+	},
+};
+
+static void __init nuri_fb_init(void)
+{
+	platform_device_register(&nuri_lcd_device);
+	platform_device_register(&nuri_backlight_device);
+}
+
 /* I2C1 */
 static struct i2c_board_info i2c1_devs[] __initdata = {
 	/* Gyro, To be updated */
@@ -201,6 +261,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s3c_device_wdt,
 #endif
 
+	&s3c_device_timer[0],
 	/* NURI Devices */
 	&nuri_gpio_keys,
 };
@@ -219,6 +280,7 @@ static void __init nuri_machine_init(void)
 	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
 	i2c_register_board_info(5, i2c5_devs, ARRAY_SIZE(i2c5_devs));
 
+	nuri_fb_init();
 	/* Last */
 	platform_add_devices(nuri_devices, ARRAY_SIZE(nuri_devices));
 }
-- 
1.6.0.4
