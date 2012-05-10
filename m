From: l.majewski@samsung.com (Lukasz Majewski)
Date: Thu, 10 May 2012 18:29:30 +0200
Subject: [PATCH RESEND 4/4] ARM: EXYNOS: Add s3c-hsotg device support for
 Universal C210 board
In-Reply-To: <1336667370-2039-1-git-send-email-l.majewski@samsung.com>
References: <1336667370-2039-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1336667370-2039-5-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds platform data for using S3C-HSOTG driver at
Universal_C210 target.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/Kconfig               |    2 ++
 arch/arm/mach-exynos/mach-universal_c210.c |   10 ++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 5e64728..56d0e7e 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -246,6 +246,7 @@ config MACH_UNIVERSAL_C210
 	select S3C_DEV_I2C1
 	select S3C_DEV_I2C3
 	select S3C_DEV_I2C5
+	select S3C_DEV_USB_HSOTG
 	select S5P_DEV_I2C_HDMIPHY
 	select S5P_DEV_MFC
 	select S5P_DEV_ONENAND
@@ -259,6 +260,7 @@ config MACH_UNIVERSAL_C210
 	select EXYNOS4_SETUP_SDHCI
 	select EXYNOS4_SETUP_FIMC
 	select S5P_SETUP_MIPIPHY
+	select EXYNOS4_SETUP_USB_PHY
 	help
 	  Machine support for Samsung Mobile Universal S5PC210 Reference
 	  Board.
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index add55b4..9781669 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -204,6 +204,7 @@ static struct regulator_init_data lp3974_ldo2_data = {
 };
 
 static struct regulator_consumer_supply lp3974_ldo3_consumer[] = {
+	REGULATOR_SUPPLY("vusb_a", "s3c-hsotg"),
 	REGULATOR_SUPPLY("vdd", "exynos4-hdmi"),
 	REGULATOR_SUPPLY("vdd_pll", "exynos4-hdmi"),
 	REGULATOR_SUPPLY("vdd11", "s5p-mipi-csis.0"),
@@ -289,6 +290,7 @@ static struct regulator_init_data lp3974_ldo7_data = {
 };
 
 static struct regulator_consumer_supply lp3974_ldo8_consumer[] = {
+	REGULATOR_SUPPLY("vusb_d", "s3c-hsotg"),
 	REGULATOR_SUPPLY("vdd33a_dac", "s5p-sdo"),
 };
 
@@ -485,7 +487,10 @@ static struct regulator_init_data lp3974_vichg_data = {
 static struct regulator_init_data lp3974_esafeout1_data = {
 	.constraints	= {
 		.name		= "SAFEOUT1",
+		.min_uV		= 4800000,
+		.max_uV		= 4800000,
 		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.always_on	= 1,
 		.state_mem	= {
 			.enabled	= 1,
 		},
@@ -991,6 +996,9 @@ static struct gpio universal_camera_gpios[] = {
 	{ GPIO_CAM_VGA_NSTBY,	GPIOF_OUT_INIT_LOW,  "CAM_VGA_NSTBY" },
 };
 
+/* USB OTG */
+static struct s3c_hsotg_plat universal_hsotg_pdata;
+
 static void __init universal_camera_init(void)
 {
 	s3c_set_platdata(&mipi_csis_platdata, sizeof(mipi_csis_platdata),
@@ -1046,6 +1054,7 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s5p_device_onenand,
 	&s5p_device_fimd0,
 	&s5p_device_jpeg,
+	&s3c_device_usb_hsotg,
 	&s5p_device_mfc,
 	&s5p_device_mfc_l,
 	&s5p_device_mfc_r,
@@ -1098,6 +1107,7 @@ static void __init universal_machine_init(void)
 	i2c_register_board_info(I2C_GPIO_BUS_12, i2c_gpio12_devs,
 			ARRAY_SIZE(i2c_gpio12_devs));
 
+	s3c_hsotg_set_platdata(&universal_hsotg_pdata);
 	universal_camera_init();
 
 	/* Last */
-- 
1.7.2.3
