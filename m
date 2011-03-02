From: banajit.g@samsung.com (Banajit Goswami)
Date: Wed,  2 Mar 2011 16:27:24 +0900
Subject: [PATCH V2 3/6] ARM: SAMSUNG: Add PWM backlight support on Samsung
	S5P6440
In-Reply-To: <1299050847-16148-1-git-send-email-banajit.g@samsung.com>
References: <1299050847-16148-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1299050847-16148-2-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for LCD backlight control using PWM timer
for Samsung SMDK6440 board.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
Changes since v1:
- Used common GPIO macro
- Removed redundant timers

 arch/arm/mach-s5p64x0/Kconfig         |    1 +
 arch/arm/mach-s5p64x0/mach-smdk6440.c |   43 +++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 164d278..be5888a 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -34,6 +34,7 @@ config MACH_SMDK6440
 	select S3C_DEV_WDT
 	select S3C64XX_DEV_SPI
 	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
 	select S5P64X0_SETUP_I2C1
 	help
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index e5beb84..58941d7 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/pwm_backlight.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -32,6 +33,7 @@
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <mach/i2c.h>
+#include <mach/regs-gpio.h>
 
 #include <plat/regs-serial.h>
 #include <plat/gpio-cfg.h>
@@ -88,6 +90,45 @@ static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
 	},
 };
 
+static int smdk6440_backlight_init(struct device *dev)
+{
+	int ret;
+
+	ret = gpio_request(S5P6440_GPF(15), "Backlight");
+	if (ret) {
+		printk(KERN_ERR "failed to request GPF for PWM-OUT1\n");
+		return ret;
+	}
+
+	/* Configure GPIO pin with S5P6440_GPF15_PWM_TOUT1 */
+	s3c_gpio_cfgpin(S5P6440_GPF(15), S3C_GPIO_SFN(2));
+
+	return 0;
+}
+
+static void smdk6440_backlight_exit(struct device *dev)
+{
+	s3c_gpio_cfgpin(S5P6440_GPF(15), S3C_GPIO_OUTPUT);
+	gpio_free(S5P6440_GPF(15));
+}
+
+static struct platform_pwm_backlight_data smdk6440_backlight_data = {
+	.pwm_id		= 1,
+	.max_brightness	= 255,
+	.dft_brightness	= 255,
+	.pwm_period_ns	= 78770,
+	.init		= smdk6440_backlight_init,
+	.exit		= smdk6440_backlight_exit,
+};
+
+static struct platform_device smdk6440_backlight_device = {
+	.name		= "pwm-backlight",
+	.dev		= {
+		.parent		= &s3c_device_timer[1].dev,
+		.platform_data	= &smdk6440_backlight_data,
+	},
+};
+
 static struct platform_device *smdk6440_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_rtc,
@@ -97,6 +138,8 @@ static struct platform_device *smdk6440_devices[] __initdata = {
 	&s3c_device_wdt,
 	&samsung_asoc_dma,
 	&s5p6440_device_iis,
+	&s3c_device_timer[1],
+	&smdk6440_backlight_device,
 };
 
 static struct s3c2410_platform_i2c s5p6440_i2c0_data __initdata = {
-- 
1.6.5.2
