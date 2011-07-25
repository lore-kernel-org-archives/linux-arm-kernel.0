From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Mon, 25 Jul 2011 16:00:25 -0400
Subject: [PATCH V2 7/7] ARM: S5P6450: Enable LCD-LTE480 and Framebuffer support
In-Reply-To: <1311624025-2643-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1311624025-2643-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1311624025-2643-8-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables s3c-fb support and platform-lcd support for SMDK6450.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/mach-s5p64x0/Kconfig         |    3 +++
 arch/arm/mach-s5p64x0/mach-smdk6450.c |    5 +++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 0596673..620e6af 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -60,6 +60,7 @@ config MACH_SMDK6440
 config MACH_SMDK6450
 	bool "SMDK6450"
 	select CPU_S5P6450
+	select S3C_DEV_FB
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
@@ -68,7 +69,9 @@ config MACH_SMDK6450
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
+	select S5P64X0_SETUP_FB
 	select S5P64X0_SETUP_I2C1
+	select COMMON_FB
 	help
 	  Machine support for the Samsung SMDK6450
 
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 33f2adf..8108963 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -34,6 +34,7 @@
 #include <mach/regs-clock.h>
 #include <mach/i2c.h>
 #include <mach/regs-gpio.h>
+#include <mach/common-fb.h>
 
 #include <plat/regs-serial.h>
 #include <plat/gpio-cfg.h>
@@ -119,6 +120,8 @@ static struct platform_device *smdk6450_devices[] __initdata = {
 	&s3c_device_wdt,
 	&samsung_asoc_dma,
 	&s5p6450_device_iis0,
+	&s3c_device_fb,
+	&smdk64x0_lcd_lte480wv,
 	/* s5p6450_device_spi0 will be added */
 };
 
@@ -184,6 +187,8 @@ static void __init smdk6450_machine_init(void)
 			ARRAY_SIZE(smdk6450_i2c_devs1));
 
 	samsung_bl_set(&smdk6450_bl_gpio_info, &smdk6450_bl_data);
+	s3c_fb_set_platdata(&smdk64x0_lcd_pdata);
+	s5p64x0_fb_init(S5P64X0_SPCON0_LCD_SEL_RGB);
 
 	platform_add_devices(smdk6450_devices, ARRAY_SIZE(smdk6450_devices));
 }
-- 
1.7.0.4
