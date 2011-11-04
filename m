From: rajeshwari.s@samsung.com (Rajeshwari Shinde)
Date: Fri, 04 Nov 2011 19:27:00 +0530
Subject: [PATCH 3/3] ARM: S5P64X0: Enable SDHCI support
In-Reply-To: <1320415020-7439-1-git-send-email-rajeshwari.s@samsung.com>
References: <1320415020-7439-1-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <1320415020-7439-4-git-send-email-rajeshwari.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables SDHCI supports for SMDK6440 and SMDK6450.

Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 arch/arm/mach-s5p64x0/mach-smdk6440.c |   25 +++++++++++++++++++++++++
 arch/arm/mach-s5p64x0/mach-smdk6450.c |   26 +++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index d828fd3..79967d1 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
 #include <linux/fb.h>
+#include <linux/mmc/host.h>
 
 #include <video/platform_lcd.h>
 
@@ -53,6 +54,7 @@
 #include <plat/fb.h>
 #include <plat/regs-fb.h>
 #include <plat/s3c64xx-spi.h>
+#include <plat/sdhci.h>
 
 #define SMDK6440_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -162,6 +164,25 @@ static struct platform_device *smdk6440_devices[] __initdata = {
 	&s5p6440_device_iis,
 	&s3c_device_fb,
 	&smdk6440_lcd_lte480wv,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
+};
+
+static struct s3c_sdhci_platdata smdk6440_hsmmc0_pdata __initdata = {
+	.cd_type	= S3C_SDHCI_CD_NONE,
+};
+
+static struct s3c_sdhci_platdata smdk6440_hsmmc1_pdata __initdata = {
+	.cd_type	= S3C_SDHCI_CD_INTERNAL,
+#if defined(CONFIG_S5P64X0_SD_CH1_8BIT)
+	.max_width	= 8,
+	.host_caps	= MMC_CAP_8_BIT_DATA,
+#endif
+};
+
+static struct s3c_sdhci_platdata smdk6440_hsmmc2_pdata __initdata = {
+	.cd_type	= S3C_SDHCI_CD_NONE,
 };
 
 static struct s3c2410_platform_i2c s5p6440_i2c0_data __initdata = {
@@ -253,6 +274,10 @@ static void __init smdk6440_machine_init(void)
 	s5p6440_set_lcd_interface();
 	s3c_fb_set_platdata(&smdk6440_lcd_pdata);
 
+	s3c_sdhci0_set_platdata(&smdk6440_hsmmc0_pdata);
+	s3c_sdhci1_set_platdata(&smdk6440_hsmmc1_pdata);
+	s3c_sdhci2_set_platdata(&smdk6440_hsmmc2_pdata);
+
 	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
 }
 
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 73224b2..6a4d41c 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
 #include <linux/fb.h>
+#include <linux/mmc/host.h>
 
 #include <video/platform_lcd.h>
 
@@ -53,6 +54,7 @@
 #include <plat/fb.h>
 #include <plat/regs-fb.h>
 #include <plat/s3c64xx-spi.h>
+#include <plat/sdhci.h>
 
 #define SMDK6450_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -180,10 +182,28 @@ static struct platform_device *smdk6450_devices[] __initdata = {
 	&s5p6450_device_iis0,
 	&s3c_device_fb,
 	&smdk6450_lcd_lte480wv,
-
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
 	/* s5p6450_device_spi0 will be added */
 };
 
+static struct s3c_sdhci_platdata smdk6450_hsmmc0_pdata __initdata = {
+	.cd_type	= S3C_SDHCI_CD_NONE,
+};
+
+static struct s3c_sdhci_platdata smdk6450_hsmmc1_pdata __initdata = {
+	.cd_type	= S3C_SDHCI_CD_NONE,
+#if defined(CONFIG_S5P64X0_SD_CH1_8BIT)
+	.max_width	= 8,
+	.host_caps	= MMC_CAP_8_BIT_DATA,
+#endif
+};
+
+static struct s3c_sdhci_platdata smdk6450_hsmmc2_pdata __initdata = {
+	.cd_type	= S3C_SDHCI_CD_NONE,
+};
+
 static struct s3c2410_platform_i2c s5p6450_i2c0_data __initdata = {
 	.flags		= 0,
 	.slave_addr	= 0x10,
@@ -273,6 +293,10 @@ static void __init smdk6450_machine_init(void)
 	s5p6450_set_lcd_interface();
 	s3c_fb_set_platdata(&smdk6450_lcd_pdata);
 
+	s3c_sdhci0_set_platdata(&smdk6450_hsmmc0_pdata);
+	s3c_sdhci1_set_platdata(&smdk6450_hsmmc1_pdata);
+	s3c_sdhci2_set_platdata(&smdk6450_hsmmc2_pdata);
+
 	platform_add_devices(smdk6450_devices, ARRAY_SIZE(smdk6450_devices));
 }
 
-- 
1.7.4.4
