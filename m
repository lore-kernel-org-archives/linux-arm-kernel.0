From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Thu, 6 May 2010 15:22:28 +0200
Subject: [PATCH 6/8] Add support for MMC card reader on Acer n30 / Acer n35
In-Reply-To: <4BE2C26E.2080508@vscht.cz>
References: <4BE1EBFE.9080601@vscht.cz> <4BE1ED3E.1050201@vscht.cz>
	<4BE1ED86.3010506@vscht.cz> <4BE1EE5F.5090402@vscht.cz>
	<4BE1EE8C.8040900@vscht.cz>
	<20100506012258.GZ6684@trinity.fluff.org>
	<4BE2C18E.6080207@vscht.cz> <4BE2C1D7.4030408@vscht.cz>
	<4BE2C224.7080907@vscht.cz> <4BE2C24C.9050008@vscht.cz>
	<4BE2C26E.2080508@vscht.cz>
Message-ID: <4BE2C294.7030300@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index d63b48f..81973aa 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -26,6 +26,7 @@
 #include <linux/serial_core.h>
 #include <linux/timer.h>
 #include <linux/io.h>
+#include <linux/mmc/host.h>

 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -46,6 +47,7 @@
 #include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/mci.h>
 #include <plat/s3c2410.h>
 #include <plat/udc.h>

@@ -350,6 +352,12 @@ static struct s3c2410fb_mach_info n30_fb_info __initdata = {
 	.lpcsel		= 0x06,
 };

+static struct s3c24xx_mci_pdata n30_mci_cfg __initdata = {
+	.gpio_detect	= S3C2410_GPF(1),
+	.gpio_wprotect  = S3C2410_GPG(10),
+	.ocr_avail	= MMC_VDD_32_33,
+};
+
 static struct platform_device *n30_devices[] __initdata = {
 	&s3c_device_lcd,
 	&s3c_device_wdt,
@@ -358,6 +366,7 @@ static struct platform_device *n30_devices[] __initdata = {
 	&s3c_device_ohci,
 	&s3c_device_rtc,
 	&s3c_device_usbgadget,
+	&s3c_device_sdi,
 	&n30_button_device,
 	&n30_blue_led,
 	&n30_warning_led,
@@ -370,6 +379,7 @@ static struct platform_device *n35_devices[] __initdata = {
 	&s3c_device_iis,
 	&s3c_device_rtc,
 	&s3c_device_usbgadget,
+	&s3c_device_sdi,
 	&n35_button_device,
 	&n35_blue_led,
 	&n35_warning_led,
@@ -538,6 +548,7 @@ static void __init n30_init(void)
 {
 	s3c24xx_fb_set_platdata(&n30_fb_info);
 	s3c24xx_udc_set_platdata(&n30_udc_cfg);
+	s3c24xx_mci_set_platdata(&n30_mci_cfg);
 	s3c_i2c0_set_platdata(&n30_i2ccfg);

 	/* Turn off suspend on both USB ports, and switch the
-- 
1.7.1
