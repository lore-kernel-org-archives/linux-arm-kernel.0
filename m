From: augulis.darius@gmail.com (Darius Augulis)
Date: Wed, 29 Sep 2010 22:37:04 +0300
Subject: [PATCH 9/9] ARM: S3C64XX: add touchscreen support for mach-mini6410
In-Reply-To: <20100929192354.25307.40197.stgit@darius-desktop>
References: <20100929192354.25307.40197.stgit@darius-desktop>
Message-ID: <20100929193649.25307.66741.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add touchscreen device support for mach-mini6410

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---
 arch/arm/mach-s3c64xx/Kconfig         |    2 ++
 arch/arm/mach-s3c64xx/mach-mini6410.c |   12 ++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index b514e3a..fe1fd30 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -108,6 +108,8 @@ config MACH_MINI6410
 	select S3C_DEV_NAND
 	select S3C_DEV_FB
 	select S3C64XX_SETUP_FB_24BPP
+	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_TS
 	help
 	  Machine support for the FriendlyARM MINI6410
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 90f1976..2c585a7 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -35,11 +35,14 @@
 #include <mach/regs-srom.h>
 #include <mach/s3c6410.h>
 
+#include <plat/adc.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/fb.h>
 #include <plat/nand.h>
 #include <plat/regs-serial.h>
+#include <plat/ts.h>
+
 #include <video/platform_lcd.h>
 
 #define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
@@ -202,6 +205,12 @@ static struct platform_device mini6410_lcd_powerdev = {
 	.dev.platform_data	= &mini6410_lcd_power_data,
 };
 
+static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
+	.delay			= 10000,
+	.presc			= 49,
+	.oversampling_shift	= 2,
+};
+
 static struct platform_device *mini6410_devices[] __initdata = {
 	&mini6410_device_eth,
 	&s3c_device_hsmmc0,
@@ -210,6 +219,8 @@ static struct platform_device *mini6410_devices[] __initdata = {
 	&s3c_device_nand,
 	&s3c_device_fb,
 	&mini6410_lcd_powerdev,
+	&s3c_device_adc,
+	&s3c_device_ts,
 };
 
 static void __init mini6410_map_io(void)
@@ -308,6 +319,7 @@ static void __init mini6410_machine_init(void)
 
 	s3c_nand_set_platdata(&mini6410_nand_info);
 	s3c_fb_set_platdata(&mini6410_lcd_pdata);
+	s3c24xx_ts_set_platdata(&s3c_ts_platform);
 
 	/* configure nCS1 width to 16 bits */
 
