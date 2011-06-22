From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 22 Jun 2011 16:10:26 +0900
Subject: [PATCH RESEND] ARM: EXYNOS4: Add PWM backlight support on Samsung
	SMDKC210
Message-ID: <1308726626-19635-1-git-send-email-jg1.han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for LCD backlight control using PWM timer
for Samsung's SMDKC210 board.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig         |    1 +
 arch/arm/mach-exynos4/mach-smdkc210.c |   43 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 1435fc3..a66896c 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -110,6 +110,7 @@ config MACH_SMDKC210
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
+	select SAMSUNG_DEV_PWM
 	select EXYNOS4_DEV_PD
 	select EXYNOS4_DEV_SYSMMU
 	select EXYNOS4_SETUP_I2C1
diff --git a/arch/arm/mach-exynos4/mach-smdkc210.c b/arch/arm/mach-exynos4/mach-smdkc210.c
index e645f7a..bcd368c 100644
--- a/arch/arm/mach-exynos4/mach-smdkc210.c
+++ b/arch/arm/mach-exynos4/mach-smdkc210.c
@@ -15,6 +15,7 @@
 #include <linux/smsc911x.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
+#include <linux/pwm_backlight.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -27,6 +28,7 @@
 #include <plat/sdhci.h>
 #include <plat/iic.h>
 #include <plat/pd.h>
+#include <plat/gpio-cfg.h>
 
 #include <mach/map.h>
 
@@ -146,6 +148,45 @@ static struct i2c_board_info i2c_devs1[] __initdata = {
 	{I2C_BOARD_INFO("wm8994", 0x1a),},
 };
 
+static int smdkc210_backlight_init(struct device *dev)
+{
+	int ret;
+
+	ret = gpio_request(EXYNOS4_GPD0(1), "Backlight");
+	if (ret) {
+		printk(KERN_ERR "failed to request GPD for PWM-OUT 1\n");
+		return ret;
+	}
+
+	/* Configure GPIO pin with EXYNOS4_GPD_0_1_TOUT_1 */
+	s3c_gpio_cfgpin(EXYNOS4_GPD0(1), S3C_GPIO_SFN(2));
+
+	return 0;
+}
+
+static void smdkc210_backlight_exit(struct device *dev)
+{
+	s3c_gpio_cfgpin(EXYNOS4_GPD0(1), S3C_GPIO_OUTPUT);
+	gpio_free(EXYNOS4_GPD0(1));
+}
+
+static struct platform_pwm_backlight_data smdkc210_backlight_data = {
+	.pwm_id		= 1,
+	.max_brightness	= 255,
+	.dft_brightness	= 255,
+	.pwm_period_ns	= 1000,
+	.init		= smdkc210_backlight_init,
+	.exit		= smdkc210_backlight_exit,
+};
+
+static struct platform_device smdkc210_backlight_device = {
+	.name		= "pwm-backlight",
+	.dev		= {
+		.parent		= &s3c_device_timer[1].dev,
+		.platform_data	= &smdkc210_backlight_data,
+	},
+};
+
 static struct platform_device *smdkc210_devices[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
@@ -166,6 +207,8 @@ static struct platform_device *smdkc210_devices[] __initdata = {
 	&exynos4_device_sysmmu,
 	&samsung_asoc_dma,
 	&smdkc210_smsc911x,
+	&s3c_device_timer[1],
+	&smdkc210_backlight_device,
 };
 
 static void __init smdkc210_smsc911x_init(void)
-- 
1.7.1
