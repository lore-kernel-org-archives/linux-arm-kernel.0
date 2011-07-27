From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Wed, 27 Jul 2011 13:31:17 -0400
Subject: [PATCH V3 6/7] ARM: S5P6440: Enable LCD-LTE480 and Framebuffer support
In-Reply-To: <1311787878-16193-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1311787878-16193-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1311787878-16193-7-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables s3c-fb support and platform-lcd support for SMDK6440.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/mach-s5p64x0/Kconfig         |    3 +++
 arch/arm/mach-s5p64x0/mach-smdk6440.c |    5 +++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 00d5873..41a751f 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -42,6 +42,7 @@ config SMDK64X0_COMMON_FB
 config MACH_SMDK6440
 	bool "SMDK6440"
 	select CPU_S5P6440
+	select S3C_DEV_FB
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
@@ -50,7 +51,9 @@ config MACH_SMDK6440
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
+	select S5P64X0_SETUP_FB
 	select S5P64X0_SETUP_I2C1
+	select SMDK64X0_COMMON_FB
 	help
 	  Machine support for the Samsung SMDK6440
 
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 346f8df..106bc8f 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -34,6 +34,7 @@
 #include <mach/regs-clock.h>
 #include <mach/i2c.h>
 #include <mach/regs-gpio.h>
+#include <mach/smdk64x0-common-fb.h>
 
 #include <plat/regs-serial.h>
 #include <plat/gpio-cfg.h>
@@ -101,6 +102,8 @@ static struct platform_device *smdk6440_devices[] __initdata = {
 	&s3c_device_wdt,
 	&samsung_asoc_dma,
 	&s5p6440_device_iis,
+	&s3c_device_fb,
+	&smdk64x0_lcd_lte480wv,
 };
 
 static struct s3c2410_platform_i2c s5p6440_i2c0_data __initdata = {
@@ -165,6 +168,8 @@ static void __init smdk6440_machine_init(void)
 			ARRAY_SIZE(smdk6440_i2c_devs1));
 
 	samsung_bl_set(&smdk6440_bl_gpio_info, &smdk6440_bl_data);
+	s3c_fb_set_platdata(&smdk64x0_lcd_pdata);
+	s5p64x0_fb_init(S5P64X0_SPCON0_LCD_SEL_RGB);
 
 	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
 }
-- 
1.7.0.4
