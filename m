From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 25 Jan 2012 15:23:24 +0100
Subject: [PATCH 3/6] ARM: SAMSUNG: Add support for S5K6AAFX camera on Nuri
 board
In-Reply-To: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
References: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1327501407-1927-4-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add voltage regulator and platform data definitions for S5K6AAFX
sensor driver and configure I2C6 bus timings.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: HeungJun Kim <riverful.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/Kconfig     |    2 +
 arch/arm/mach-exynos/mach-nuri.c |   65 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index bd4600e..9a427bc 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -269,6 +269,7 @@ config MACH_NURI
 	select S3C_DEV_I2C1
 	select S3C_DEV_I2C3
 	select S3C_DEV_I2C5
+	select S3C_DEV_I2C6
 	select S5P_DEV_CSIS0
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
@@ -285,6 +286,7 @@ config MACH_NURI
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C3
 	select EXYNOS4_SETUP_I2C5
+	select EXYNOS4_SETUP_I2C6
 	select EXYNOS4_SETUP_SDHCI
 	select EXYNOS4_SETUP_USB_PHY
 	select S5P_SETUP_MIPIPHY
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 165c876..cc8d2f6 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -28,6 +28,7 @@
 
 #include <video/platform_lcd.h>
 #include <media/m5mols.h>
+#include <media/s5k6aa.h>
 #include <media/s5p_fimc.h>
 #include <media/v4l2-mediabus.h>
 
@@ -75,6 +76,7 @@ enum fixed_regulator_id {
 	FIXED_REG_ID_MAX8903,
 	FIXED_REG_ID_CAM_A28V,
 	FIXED_REG_ID_CAM_12V,
+	FIXED_REG_ID_CAM_VT_15V,
 };
 
 static struct s3c2410_uartcfg nuri_uartcfgs[] __initdata = {
@@ -399,6 +401,9 @@ static struct regulator_consumer_supply __initdata max8997_ldo4_[] = {
 static struct regulator_consumer_supply __initdata max8997_ldo5_[] = {
 	REGULATOR_SUPPLY("vhsic", "modemctl"), /* MODEM */
 };
+static struct regulator_consumer_supply nuri_max8997_ldo6_consumer[] = {
+	REGULATOR_SUPPLY("vdd_reg", "6-003c"), /* S5K6AA camera */
+};
 static struct regulator_consumer_supply __initdata max8997_ldo7_[] = {
 	REGULATOR_SUPPLY("dig_18", "0-001f"), /* HCD803 */
 };
@@ -546,6 +551,8 @@ static struct regulator_init_data __initdata max8997_ldo6_data = {
 			.enabled	= 1,
 		},
 	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo6_consumer),
+	.consumer_supplies	= nuri_max8997_ldo6_consumer,
 };
 
 static struct regulator_init_data __initdata max8997_ldo7_data = {
@@ -1116,7 +1123,30 @@ static void __init nuri_ehci_init(void)
 }
 
 /* CAMERA */
+static struct regulator_consumer_supply cam_vt_cam15_supply =
+	REGULATOR_SUPPLY("vdd_core", "6-003c");
+
+static struct regulator_init_data cam_vt_cam15_reg_init_data = {
+	.constraints = { .valid_ops_mask = REGULATOR_CHANGE_STATUS },
+	.num_consumer_supplies = 1,
+	.consumer_supplies = &cam_vt_cam15_supply,
+};
+
+static struct fixed_voltage_config cam_vt_cam15_fixed_voltage_cfg = {
+	.supply_name	= "VT_CAM_1.5V",
+	.microvolts	= 1500000,
+	.gpio		= EXYNOS4_GPE2(2), /* VT_CAM_1.5V_EN */
+	.enable_high	= 1,
+	.init_data	= &cam_vt_cam15_reg_init_data,
+};
+
+static struct platform_device cam_vt_cam15_fixed_rdev = {
+	.name = "reg-fixed-voltage", .id = FIXED_REG_ID_CAM_VT_15V,
+	.dev = { .platform_data	= &cam_vt_cam15_fixed_voltage_cfg },
+};
+
 static struct regulator_consumer_supply cam_vdda_supply[] = {
+	REGULATOR_SUPPLY("vdda", "6-003c"),
 	REGULATOR_SUPPLY("a_sensor", "0-001f"),
 };
 
@@ -1173,6 +1203,21 @@ static struct s5p_platform_mipi_csis mipi_csis_platdata = {
 
 #define GPIO_CAM_MEGA_RST	EXYNOS4_GPY3(7) /* ISP_RESET */
 #define GPIO_CAM_8M_ISP_INT	EXYNOS4_GPL2(5)
+#define GPIO_CAM_VT_NSTBY	EXYNOS4_GPL2(0)
+#define GPIO_CAM_VT_NRST	EXYNOS4_GPL2(1)
+
+static struct s5k6aa_platform_data s5k6aa_pldata = {
+	.mclk_frequency	= 24000000UL,
+	.gpio_reset	= { GPIO_CAM_VT_NRST, 0 },
+	.gpio_stby	= { GPIO_CAM_VT_NSTBY, 0 },
+	.bus_type	= V4L2_MBUS_PARALLEL,
+	.horiz_flip	= 1,
+};
+
+static struct i2c_board_info s5k6aa_board_info = {
+	I2C_BOARD_INFO("S5K6AA", 0x3c),
+	.platform_data = &s5k6aa_pldata,
+};
 
 static struct m5mols_platform_data m5mols_platdata = {
 	.gpio_reset = GPIO_CAM_MEGA_RST,
@@ -1185,6 +1230,13 @@ static struct i2c_board_info m5mols_board_info = {
 
 static struct s5p_fimc_isp_info nuri_camera_sensors[] = {
 	{
+		.flags		= V4L2_MBUS_PCLK_SAMPLE_RISING |
+				  V4L2_MBUS_VSYNC_ACTIVE_LOW,
+		.bus_type	= FIMC_ITU_601,
+		.board_info	= &s5k6aa_board_info,
+		.clk_frequency	= 24000000UL,
+		.i2c_bus_num	= 6,
+	}, {
 		.flags		= V4L2_MBUS_PCLK_SAMPLE_FALLING |
 				  V4L2_MBUS_VSYNC_ACTIVE_LOW,
 		.bus_type	= FIMC_MIPI_CSI2,
@@ -1200,6 +1252,8 @@ static struct s5p_platform_fimc fimc_md_platdata = {
 };
 
 static struct gpio nuri_camera_gpios[] = {
+	{ GPIO_CAM_VT_NSTBY,	GPIOF_OUT_INIT_LOW, "CAM_VGA_NSTBY" },
+	{ GPIO_CAM_VT_NRST,	GPIOF_OUT_INIT_LOW, "CAM_VGA_NRST"  },
 	{ GPIO_CAM_8M_ISP_INT,	GPIOF_IN,           "8M_ISP_INT"  },
 	{ GPIO_CAM_MEGA_RST,	GPIOF_OUT_INIT_LOW, "CAM_8M_NRST" },
 };
@@ -1224,6 +1278,8 @@ static void nuri_camera_init(void)
 		pr_err("%s: Failed to configure 8M_ISP_INT GPIO\n", __func__);
 
 	/* Free GPIOs controlled directly by the sensor drivers. */
+	gpio_free(GPIO_CAM_VT_NRST);
+	gpio_free(GPIO_CAM_VT_NSTBY);
 	gpio_free(GPIO_CAM_MEGA_RST);
 
 	if (exynos4_fimc_setup_gpio(S5P_CAMPORT_A)) {
@@ -1234,6 +1290,12 @@ static void nuri_camera_init(void)
 	s5p_gpio_set_drvstr(EXYNOS4_GPJ1(3), S5P_GPIO_DRVSTR_LV4);
 }
 
+static struct s3c2410_platform_i2c nuri_i2c6_platdata __initdata = {
+	.frequency	= 400000U,
+	.sda_delay	= 200,
+	.bus_num	= 6,
+};
+
 static struct s3c2410_platform_i2c nuri_i2c0_platdata __initdata = {
 	.frequency	= 400000U,
 	.sda_delay	= 200,
@@ -1243,6 +1305,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	/* Samsung Platform Devices */
 	&s3c_device_i2c5, /* PMIC should initialize first */
 	&s3c_device_i2c0,
+	&s3c_device_i2c6,
 	&emmc_fixed_voltage,
 	&s5p_device_mipi_csis0,
 	&s5p_device_fimc0,
@@ -1275,6 +1338,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&nuri_backlight_device,
 	&max8903_fixed_reg_dev,
 	&nuri_max8903_device,
+	&cam_vt_cam15_fixed_rdev,
 	&cam_vdda_fixed_rdev,
 	&cam_8m_12v_fixed_rdev,
 };
@@ -1306,6 +1370,7 @@ static void __init nuri_machine_init(void)
 	i2c_register_board_info(5, i2c5_devs, ARRAY_SIZE(i2c5_devs));
 	i2c9_devs[I2C9_MAX17042].irq = gpio_to_irq(EXYNOS4_GPX2(3));
 	i2c_register_board_info(9, i2c9_devs, ARRAY_SIZE(i2c9_devs));
+	s3c_i2c6_set_platdata(&nuri_i2c6_platdata);
 
 	s5p_fimd0_set_platdata(&nuri_fb_pdata);
 
-- 
1.7.8.3
