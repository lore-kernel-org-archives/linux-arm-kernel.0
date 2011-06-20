From: rajeshwari.s@samsung.com (Rajeshwari Shinde)
Date: Mon, 20 Jun 2011 17:27:29 +0530
Subject: [PATCH 3/3] ARM: S5P64X0: Enable SDHCI support
In-Reply-To: <1308571049-4412-1-git-send-email-rajeshwari.s@samsung.com>
References: <1308571049-4412-1-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <1308571049-4412-4-git-send-email-rajeshwari.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: rajeshwari.s <rajeshwari.s@samsung.com>

Enables SDHCI supports for S5P6440 and S5P6450.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Rajeshwari.S <rajeshwari.s@samsung.com>
---
 arch/arm/mach-s5p64x0/mach-smdk6440.c |   27 +++++++++++++++++++++++++++
 arch/arm/mach-s5p64x0/mach-smdk6450.c |   27 +++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 2d559f1..78c744f 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
+#include <linux/mmc/host.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -46,6 +47,7 @@
 #include <plat/adc.h>
 #include <plat/ts.h>
 #include <plat/s5p-time.h>
+#include <plat/sdhci.h>
 
 #define SMDK6440_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -141,6 +143,28 @@ static struct platform_device *smdk6440_devices[] __initdata = {
 	&s5p6440_device_iis,
 	&s3c_device_timer[1],
 	&smdk6440_backlight_device,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
+};
+
+static struct s3c_sdhci_platdata smdk6440_hsmmc0_pdata __initdata = {
+	.cd_type	= S3C_SDHCI_CD_NONE,
+	.clk_type	= S3C_SDHCI_CLK_DIV_EXTERNAL,
+};
+
+static struct s3c_sdhci_platdata smdk6440_hsmmc1_pdata __initdata = {
+	.cd_type	= S3C_SDHCI_CD_INTERNAL,
+#if defined(CONFIG_S5P64X0_SD_CH1_8BIT)
+	.max_width	= 8,
+	.host_caps	= MMC_CAP_8_BIT_DATA,
+#endif
+	.clk_type	= S3C_SDHCI_CLK_DIV_EXTERNAL,
+};
+
+static struct s3c_sdhci_platdata smdk6440_hsmmc2_pdata __initdata = {
+	.cd_type	= S3C_SDHCI_CD_NONE,
+	.clk_type	= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct s3c2410_platform_i2c s5p6440_i2c0_data __initdata = {
@@ -194,6 +218,9 @@ static void __init smdk6440_machine_init(void)
 	i2c_register_board_info(1, smdk6440_i2c_devs1,
 			ARRAY_SIZE(smdk6440_i2c_devs1));
 
+	s3c_sdhci0_set_platdata(&smdk6440_hsmmc0_pdata);
+	s3c_sdhci1_set_platdata(&smdk6440_hsmmc1_pdata);
+	s3c_sdhci2_set_platdata(&smdk6440_hsmmc2_pdata);
 	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
 }
 
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index d19c469..099ca20 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
+#include <linux/mmc/host.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -46,6 +47,7 @@
 #include <plat/adc.h>
 #include <plat/ts.h>
 #include <plat/s5p-time.h>
+#include <plat/sdhci.h>
 
 #define SMDK6450_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -159,9 +161,31 @@ static struct platform_device *smdk6450_devices[] __initdata = {
 	&s5p6450_device_iis0,
 	&s3c_device_timer[1],
 	&smdk6450_backlight_device,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
 	/* s5p6450_device_spi0 will be added */
 };
 
+static struct s3c_sdhci_platdata smdk6450_hsmmc0_pdata __initdata = {
+	.cd_type	= S3C_SDHCI_CD_NONE,
+	.clk_type	= S3C_SDHCI_CLK_DIV_EXTERNAL,
+};
+
+static struct s3c_sdhci_platdata smdk6450_hsmmc1_pdata __initdata = {
+	.cd_type	= S3C_SDHCI_CD_NONE,
+#if defined(CONFIG_S5P64X0_SD_CH1_8BIT)
+	.max_width	= 8,
+	.host_caps	= MMC_CAP_8_BIT_DATA,
+#endif
+	.clk_type	= S3C_SDHCI_CLK_DIV_EXTERNAL,
+};
+
+static struct s3c_sdhci_platdata smdk6450_hsmmc2_pdata __initdata = {
+	.cd_type	= S3C_SDHCI_CD_NONE,
+	.clk_type	= S3C_SDHCI_CLK_DIV_EXTERNAL,
+};
+
 static struct s3c2410_platform_i2c s5p6450_i2c0_data __initdata = {
 	.flags		= 0,
 	.slave_addr	= 0x10,
@@ -213,6 +237,9 @@ static void __init smdk6450_machine_init(void)
 	i2c_register_board_info(1, smdk6450_i2c_devs1,
 			ARRAY_SIZE(smdk6450_i2c_devs1));
 
+	s3c_sdhci0_set_platdata(&smdk6450_hsmmc0_pdata);
+	s3c_sdhci1_set_platdata(&smdk6450_hsmmc1_pdata);
+	s3c_sdhci2_set_platdata(&smdk6450_hsmmc2_pdata);
 	platform_add_devices(smdk6450_devices, ARRAY_SIZE(smdk6450_devices));
 }
 
-- 
1.7.0.4
