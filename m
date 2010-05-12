From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Wed, 12 May 2010 15:18:36 +0200
Subject: [PATCH 8/8] Add support for backlight regulation on Acer n35
In-Reply-To: <20100507003504.GV2589@trinity.fluff.org>
References: <4BE1EE8C.8040900@vscht.cz>
	<20100506012258.GZ6684@trinity.fluff.org>
	<4BE2C18E.6080207@vscht.cz> <4BE2C1D7.4030408@vscht.cz>
	<4BE2C224.7080907@vscht.cz> <4BE2C24C.9050008@vscht.cz>
	<4BE2C26E.2080508@vscht.cz> <4BE2C294.7030300@vscht.cz>
	<4BE2C2CC.2010003@vscht.cz> <4BE2C2FF.8020404@vscht.cz>
	<20100507003504.GV2589@trinity.fluff.org>
Message-ID: <4BEAAAAC.9070003@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for backlight regulation on Acer n35 using generic PWM driver.

Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |   71 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index f25275e..efa7fa8 100644
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
@@ -352,6 +353,74 @@ static struct s3c2410fb_mach_info n30_fb_info __initdata = {
 	.lpcsel		= 0x06,
 };

+static int n35_backlight_init(struct device *dev)
+{
+	int ret;
+
+	ret = gpio_request(S3C2410_GPB(0), "Backlight PWM output");
+	if(ret)
+		goto request_gpb0_fail;
+	ret = gpio_request(S3C2410_GPB(1), "Backlight power");
+	if(ret)
+		goto request_gpb1_fail;
+
+	/* set GPB0 as output of PWM timer */
+	gpio_set_value(S3C2410_GPB(0), 0);
+	s3c2410_gpio_pullup(S3C2410_GPB(0), 0);
+	s3c2410_gpio_cfgpin(S3C2410_GPB(0), S3C2410_GPB0_TOUT0);
+
+	/* backlight power */
+	ret = gpio_direction_output(S3C2410_GPB(1), 1);
+	if(ret)
+		goto direction_gpb1_fail;
+	s3c2410_gpio_pullup(S3C2410_GPB(1), 1);
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
+	/* power off backlight, values less than 12 are useless */
+	gpio_set_value(S3C2410_GPB(1), brightness > 12 ? 1 : 0);
+	return (brightness > 12 ? brightness : 0);
+}
+
+static void n35_backlight_exit(struct device *dev)
+{
+	gpio_direction_output(S3C2410_GPB(0), 0);
+	gpio_free(S3C2410_GPB(0));
+
+	gpio_set_value(S3C2410_GPB(1), 0);
+	s3c2410_gpio_pullup(S3C2410_GPB(1), 0);
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
 static void n30_sdi_set_power(unsigned char power_mode, unsigned short vdd)
 {
 	switch (power_mode) {
@@ -395,6 +464,8 @@ static struct platform_device *n35_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_usbgadget,
 	&s3c_device_sdi,
+	&s3c_device_timer[0],
+	&n35_backlight,
 	&n35_button_device,
 	&n35_blue_led,
 	&n35_warning_led,
-- 
1.7.1
