From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 23 Jul 2010 16:46:47 +0200
Subject: [PATCH] ARM: S5PV210: Add SDHCI devices for Aquila board
Message-ID: <1279896407-29571-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for SDHCI blocks on Samsung Aquila board. The
following host controllers are defined:
1. Internal MoviNAND device (permanently wired to the controller)
2. Internal WiFI SDIO device (card is activated by power regualor)
3. External MMC/SD socket (card detection is provided by external
gpio interrupt)

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig       |    4 +++
 arch/arm/mach-s5pv210/mach-aquila.c |   39 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 12a2c6b..c64dff1 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -60,8 +60,12 @@ config MACH_AQUILA
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
 	select S5PV210_SETUP_FB_24BPP
+	select S5PV210_SETUP_SDHCI
 	select S3C_DEV_FB
 	select S5PC110_DEV_ONENAND
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_HSMMC2
 	help
 	  Machine support for the Samsung Aquila target based on S5PC110 SoC
 
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 0992618..a1f8d07 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -35,6 +35,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb.h>
+#include <plat/sdhci.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -440,11 +441,47 @@ static void __init aquila_pmic_init(void)
 	s3c_gpio_setpull(S5PV210_GPH2(6), S3C_GPIO_PULL_UP);
 }
 
+/* MoviNAND */
+static struct s3c_sdhci_platdata aquila_hsmmc0_data __initdata = {
+	.max_width		= 4,
+	.cd_type		= S3C_SDHCI_CD_PERMANENT,
+};
+
+/* Wireless LAN */
+static struct s3c_sdhci_platdata aquila_hsmmc1_data __initdata = {
+	.max_width		= 4,
+	.cd_type		= S3C_SDHCI_CD_EXTERNAL,
+	/* ext_cd_{init,cleanup} callbacks will be added later */
+};
+
+/* External Flash */
+#define AQUILA_EXT_FLASH_EN	S5PV210_MP05(4)
+#define AQUILA_EXT_FLASH_CD	S5PV210_GPH3(4)
+static struct s3c_sdhci_platdata aquila_hsmmc2_data __initdata = {
+	.max_width		= 4,
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= AQUILA_EXT_FLASH_CD,
+	.ext_cd_gpio_invert	= 1,
+};
+
+static void aquila_setup_sdhci(void)
+{
+	gpio_request(AQUILA_EXT_FLASH_EN, "FLASH_EN");
+	gpio_direction_output(AQUILA_EXT_FLASH_EN, 1);
+
+	s3c_sdhci0_set_platdata(&aquila_hsmmc0_data);
+	s3c_sdhci1_set_platdata(&aquila_hsmmc1_data);
+	s3c_sdhci2_set_platdata(&aquila_hsmmc2_data);
+};
+
 static struct platform_device *aquila_devices[] __initdata = {
 	&aquila_i2c_gpio_pmic,
 	&aquila_device_gpiokeys,
 	&s3c_device_fb,
 	&s5pc110_device_onenand,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
 };
 
 static void __init aquila_map_io(void)
@@ -460,6 +497,8 @@ static void __init aquila_machine_init(void)
 	aquila_pmic_init();
 	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4, i2c_gpio_pmic_devs,
 			ARRAY_SIZE(i2c_gpio_pmic_devs));
+	/* SDHCI */
+	aquila_setup_sdhci();
 
 	/* FB */
 	s3c_fb_set_platdata(&aquila_lcd_pdata);
-- 
1.7.1.569.g6f426
