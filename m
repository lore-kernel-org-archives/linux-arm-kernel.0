From: Jiri.Pinkava@vscht.cz (=?ISO-8859-2?Q?Ji=F8=ED_Pinkava?=)
Date: Mon, 4 Oct 2010 02:32:08 +0200
Subject: [PATCH 6/6] n35: Add LCD backlight regulation
In-Reply-To: <4CA92044.9010902@vscht.cz>
References: <4CA91E6F.3010704@vscht.cz> <4CA91EDA.80009@vscht.cz>
	<4CA91F05.3040602@vscht.cz> <4CA91F4F.8080204@vscht.cz>
	<4CA91FF7.7020908@vscht.cz> <4CA92044.9010902@vscht.cz>
Message-ID: <4CA92088.4060806@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
  arch/arm/mach-s3c2410/mach-n30.c |   71 
++++++++++++++++++++++++++++++++++++++
  1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c 
b/arch/arm/mach-s3c2410/mach-n30.c
index be5235d..4199143 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -23,6 +23,7 @@
  #include <linux/input.h>
  #include <linux/interrupt.h>
  #include <linux/platform_device.h>
+#include <linux/pwm_backlight.h>
  #include <linux/serial_core.h>
  #include <linux/timer.h>
  #include <linux/io.h>
@@ -369,6 +370,74 @@ static struct s3c2410fb_mach_info n30_fb_info 
__initdata = {
  	.lpcsel		= 0x06,
  };

+static int n35_backlight_init(struct device *dev)
+{
+	int ret;
+
+	ret = gpio_request(S3C2410_GPB(0), "Backlight PWM output");
+	if (ret)
+		goto request_gpb0_fail;
+	ret = gpio_request(S3C2410_GPB(1), "Backlight power");
+	if (ret)
+		goto request_gpb1_fail;
+
+	/* set GPB0 as output of PWM timer */
+	gpio_set_value(S3C2410_GPB(0), 0);
+	s3c_gpio_setpull(S3C2410_GPB(0), S3C_GPIO_PULL_DOWN);
+	s3c_gpio_cfgpin(S3C2410_GPB(0), S3C2410_GPB0_TOUT0);
+
+	/* backlight power */
+	ret = gpio_direction_output(S3C2410_GPB(1), 1);
+	if (ret)
+		goto direction_gpb1_fail;
+	s3c_gpio_setpull(S3C2410_GPB(1), S3C_GPIO_PULL_UP);
+
+	return 0;
+
+direction_gpb1_fail:
+	gpio_free(S3C2410_GPB(1));
+request_gpb1_fail:
+	gpio_free(S3C2410_GPB(0));
+request_gpb0_fail:
+	return ret;
+}
+
+static int n35_backlight_notify(struct device *dev, int brightness)
+{
+	/* power off backlight, values less than 14 are useless */
+	gpio_set_value(S3C2410_GPB(1), brightness > 14 ? 1 : 0);
+	return (brightness > 14 ? brightness : 0);
+}
+
+static void n35_backlight_exit(struct device *dev)
+{
+	gpio_direction_output(S3C2410_GPB(0), 0);
+	gpio_free(S3C2410_GPB(0));
+
+	gpio_set_value(S3C2410_GPB(1), 0);
+	s3c_gpio_setpull(S3C2410_GPB(1), S3C_GPIO_PULL_UP);
+	gpio_free(S3C2410_GPB(1));
+}
+
+static struct platform_pwm_backlight_data backlight_data = {
+	.pwm_id         = 0,
+	.max_brightness = 100,
+	.dft_brightness = 50,
+	.pwm_period_ns  = 3*1000*1000,
+	.init           = n35_backlight_init,
+	.notify         = n35_backlight_notify,
+	.exit           = n35_backlight_exit,
+};
+
+static struct platform_device n35_backlight = {
+	.name = "pwm-backlight",
+	.dev  = {
+		.parent = &s3c_device_timer[0].dev,
+		.platform_data = &backlight_data,
+	},
+	.id   = -1,
+};
+
  static void n30_sdi_set_power(unsigned char power_mode, unsigned short 
vdd)
  {
  	switch (power_mode) {
@@ -416,6 +485,8 @@ static struct platform_device *n35_devices[] 
__initdata = {
  	&s3c_device_sdi,
  	&s3c_device_adc,
  	&s3c_device_ts,
+	&s3c_device_timer[0],
+	&n35_backlight,
  	&n35_button_device,
  	&n35_blue_led,
  	&n35_warning_led,
-- 
1.7.3.1
