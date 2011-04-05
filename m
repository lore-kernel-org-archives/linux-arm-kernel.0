From: jiri.pinkava@vscht.cz (jiri.pinkava at vscht.cz)
Date: Wed, 6 Apr 2011 01:06:07 +0200
Subject: [PATCH 5/6] n30: Add touchscreen support for Acer n30 / n35
In-Reply-To: <1302044768-7774-1-git-send-email-jiri.pinkava@vscht.cz>
References: <1302044768-7774-1-git-send-email-jiri.pinkava@vscht.cz>
Message-ID: <1302044768-7774-6-git-send-email-jiri.pinkava@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiri Pinkava <jiri.pinkava@vscht.cz>

Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/Kconfig    |    1 +
 arch/arm/mach-s3c2410/mach-n30.c |   13 +++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
index 7245a55..1d55349 100644
--- a/arch/arm/mach-s3c2410/Kconfig
+++ b/arch/arm/mach-s3c2410/Kconfig
@@ -100,6 +100,7 @@ config MACH_N30
 	select MACH_N35
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C2410_SETUP_TS
 	help
 	  Say Y here if you want suppt for the Acer N30, Acer N35,
 	  Navman PiN570, Yakumo AlphaX or Airis NC05 PDAs.
diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 6396827..00afa2f 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -49,6 +49,7 @@
 #include <plat/devs.h>
 #include <plat/mci.h>
 #include <plat/s3c2410.h>
+#include <plat/ts.h>
 #include <plat/udc.h>
 
 static struct map_desc n30_iodesc[] __initdata = {
@@ -100,6 +101,13 @@ static struct s3c2410_udc_mach_info n30_udc_cfg __initdata = {
 	.pullup_pin		= S3C2410_GPB(3),
 };
 
+static struct s3c2410_ts_mach_info n30_ts_cfg __initdata = {
+	.delay = 16383,
+	.presc = 49,
+	.oversampling_shift = 3,
+	.cfg_gpio = s3c24xx_ts_cfg_gpio,
+};
+
 static struct gpio_keys_button n30_buttons[] = {
 	{
 		.gpio		= S3C2410_GPF(0),
@@ -375,6 +383,8 @@ static struct platform_device *n30_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_usbgadget,
 	&s3c_device_sdi,
+	&s3c_device_adc,
+	&s3c_device_ts,
 	&n30_button_device,
 	&n30_blue_led,
 	&n30_warning_led,
@@ -388,6 +398,8 @@ static struct platform_device *n35_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_usbgadget,
 	&s3c_device_sdi,
+	&s3c_device_adc,
+	&s3c_device_ts,
 	&n35_button_device,
 	&n35_blue_led,
 	&n35_warning_led,
@@ -550,6 +562,7 @@ static void __init n30_init(void)
 	WARN_ON(gpio_request(S3C2410_GPG(4), "mmc power"));
 
 	s3c24xx_fb_set_platdata(&n30_fb_info);
+	s3c24xx_ts_set_platdata(&n30_ts_cfg);
 	s3c24xx_udc_set_platdata(&n30_udc_cfg);
 	s3c24xx_mci_set_platdata(&n30_mci_cfg);
 	s3c_i2c0_set_platdata(&n30_i2ccfg);
-- 
1.7.4.2
