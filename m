From: banajit.g@samsung.com (Banajit Goswami)
Date: Wed, 22 Jun 2011 12:11:15 +0530
Subject: [PATCH] ARM: EXYNOS4: Add PWM backlight support on Samsung SMDKV310
Message-ID: <1308724875-32724-1-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for LCD backlight using PWM timer for
Samsung SMDKV310 board.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig         |    1 +
 arch/arm/mach-exynos4/mach-smdkv310.c |   43 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 1435fc3..9ab53bc 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -128,6 +128,7 @@ config MACH_SMDKV310
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
 	select SAMSUNG_DEV_KEYPAD
+	select SAMSUNG_DEV_PWM
 	select EXYNOS4_DEV_PD
 	select EXYNOS4_DEV_SYSMMU
 	select EXYNOS4_SETUP_I2C1
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index 7e3ee6c..b097ef6 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
+#include <linux/pwm_backlight.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -29,6 +30,7 @@
 #include <plat/sdhci.h>
 #include <plat/iic.h>
 #include <plat/pd.h>
+#include <plat/gpio-cfg.h>
 
 #include <mach/map.h>
 
@@ -172,6 +174,45 @@ static struct i2c_board_info i2c_devs1[] __initdata = {
 	{I2C_BOARD_INFO("wm8994", 0x1a),},
 };
 
+static int smdkv310_backlight_init(struct device *dev)
+{
+	int ret = 0;
+
+	ret = gpio_request(EXYNOS4_GPD0(1), "Backlight");
+	if (ret) {
+		printk(KERN_ERR "failed to request GPD for PWM-OUT0\n");
+		return ret;
+	}
+
+	/* Configure GPIO pin with EXYNOS4_GPD_0_1_TOUT_0 */
+	s3c_gpio_cfgpin(EXYNOS4_GPD0(1), S3C_GPIO_SFN(2));
+
+	return 0;
+}
+
+static void smdkv310_backlight_exit(struct device *dev)
+{
+	s3c_gpio_cfgpin(EXYNOS4_GPD0(1), S3C_GPIO_OUTPUT);
+	gpio_free(EXYNOS4_GPD0(1));
+}
+
+static struct platform_pwm_backlight_data smdkv310_backlight_data = {
+	.pwm_id		= 1,
+	.max_brightness	= 255,
+	.dft_brightness	= 255,
+	.pwm_period_ns	= 78770,
+	.init		= smdkv310_backlight_init,
+	.exit		= smdkv310_backlight_exit,
+};
+
+static struct platform_device smdkv310_backlight_device = {
+	.name		= "pwm-backlight",
+	.dev		= {
+		.parent		= &s3c_device_timer[1].dev,
+		.platform_data	= &smdkv310_backlight_data,
+	},
+};
+
 static struct platform_device *smdkv310_devices[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
@@ -195,6 +236,8 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&samsung_asoc_dma,
 	&smdkv310_smsc911x,
 	&smdkv310_pcm_device,
+	&s3c_device_timer[1],
+	&smdkv310_backlight_device,
 };
 
 static void __init smdkv310_smsc911x_init(void)
-- 
1.6.5.2
