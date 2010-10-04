From: Jiri.Pinkava@vscht.cz (=?ISO-8859-2?Q?Ji=F8=ED_Pinkava?=)
Date: Mon, 4 Oct 2010 02:31:00 +0200
Subject: [PATCH 5/6] n30: Add touchscreen support for Ace n35
In-Reply-To: <4CA91FF7.7020908@vscht.cz>
References: <4CA91E6F.3010704@vscht.cz> <4CA91EDA.80009@vscht.cz>
	<4CA91F05.3040602@vscht.cz> <4CA91F4F.8080204@vscht.cz>
	<4CA91FF7.7020908@vscht.cz>
Message-ID: <4CA92044.9010902@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


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
diff --git a/arch/arm/mach-s3c2410/mach-n30.c 
b/arch/arm/mach-s3c2410/mach-n30.c
index ecc039a..be5235d 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -49,6 +49,7 @@
  #include <plat/devs.h>
  #include <plat/mci.h>
  #include <plat/s3c2410.h>
+#include <plat/ts.h>
  #include <plat/udc.h>

  static struct map_desc n30_iodesc[] __initdata = {
@@ -116,6 +117,13 @@ static struct s3c2410_udc_mach_info n30_udc_cfg 
__initdata = {
  	.vbus_pin_inverted	= 0,
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
@@ -391,6 +399,8 @@ static struct platform_device *n30_devices[] 
__initdata = {
  	&s3c_device_rtc,
  	&s3c_device_usbgadget,
  	&s3c_device_sdi,
+	&s3c_device_adc,
+	&s3c_device_ts,
  	&n30_button_device,
  	&n30_blue_led,
  	&n30_warning_led,
@@ -404,6 +414,8 @@ static struct platform_device *n35_devices[] 
__initdata = {
  	&s3c_device_rtc,
  	&s3c_device_usbgadget,
  	&s3c_device_sdi,
+	&s3c_device_adc,
+	&s3c_device_ts,
  	&n35_button_device,
  	&n35_blue_led,
  	&n35_warning_led,
@@ -566,6 +578,7 @@ static void __init n30_init(void)
  	WARN_ON(gpio_request(S3C2410_GPG(4), "mmc power"));

  	s3c24xx_fb_set_platdata(&n30_fb_info);
+	s3c24xx_ts_set_platdata(&n30_ts_cfg);
  	s3c24xx_udc_set_platdata(&n30_udc_cfg);
  	s3c24xx_mci_set_platdata(&n30_mci_cfg);
  	s3c_i2c0_set_platdata(&n30_i2ccfg);
-- 
1.7.3.1
