From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 25 Jan 2012 15:23:23 +0100
Subject: [PATCH 2/6] ARM: SAMSUNG: Add support for S5K6AAFX image sensor on
 Universal C210 board
In-Reply-To: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
References: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1327501407-1927-3-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add voltage regulator and platform data definitions for S5K6AAFX
image sensor driver.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-universal_c210.c |   74 ++++++++++++++++++++++++++--
 1 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 0e01f04..44fc43e 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -46,6 +46,7 @@
 #include <media/v4l2-mediabus.h>
 #include <media/s5p_fimc.h>
 #include <media/m5mols.h>
+#include <media/s5k6aa.h>
 
 #include "common.h"
 
@@ -122,8 +123,10 @@ static struct regulator_consumer_supply lp3974_buck1_consumer =
 static struct regulator_consumer_supply lp3974_buck2_consumer =
 	REGULATOR_SUPPLY("vddg3d", NULL);
 
-static struct regulator_consumer_supply lp3974_buck3_consumer =
-	REGULATOR_SUPPLY("vdet", "s5p-sdo");
+static struct regulator_consumer_supply lp3974_buck3_consumer[] = {
+	REGULATOR_SUPPLY("vdet", "s5p-sdo"),
+	REGULATOR_SUPPLY("vdd_reg", "0-003c"),
+};
 
 static struct regulator_init_data lp3974_buck1_data = {
 	.constraints	= {
@@ -168,8 +171,8 @@ static struct regulator_init_data lp3974_buck3_data = {
 			.enabled	= 1,
 		},
 	},
-	.num_consumer_supplies = 1,
-	.consumer_supplies = &lp3974_buck3_consumer,
+	.num_consumer_supplies = ARRAY_SIZE(lp3974_buck3_consumer),
+	.consumer_supplies = lp3974_buck3_consumer,
 };
 
 static struct regulator_init_data lp3974_buck4_data = {
@@ -302,6 +305,9 @@ static struct regulator_init_data lp3974_ldo8_data = {
 	.consumer_supplies = lp3974_ldo8_consumer,
 };
 
+static struct regulator_consumer_supply lp3974_ldo9_consumer =
+	REGULATOR_SUPPLY("vddio", "0-003c");
+
 static struct regulator_init_data lp3974_ldo9_data = {
 	.constraints	= {
 		.name		= "VCC_2.8V",
@@ -313,6 +319,8 @@ static struct regulator_init_data lp3974_ldo9_data = {
 			.enabled	= 1,
 		},
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &lp3974_ldo9_consumer,
 };
 
 static struct regulator_init_data lp3974_ldo10_data = {
@@ -411,6 +419,7 @@ static struct regulator_init_data lp3974_ldo15_data = {
 };
 
 static struct regulator_consumer_supply lp3974_ldo16_consumer[] = {
+	REGULATOR_SUPPLY("vdda", "0-003c"),
 	REGULATOR_SUPPLY("a_sensor", "0-001f"),
 };
 
@@ -830,6 +839,28 @@ static struct s3c_fb_platdata universal_lcd_pdata __initdata = {
 	.setup_gpio	= exynos4_fimd0_gpio_setup_24bpp,
 };
 
+static struct regulator_consumer_supply cam_vt_dio_supply =
+	REGULATOR_SUPPLY("vdd_core", "0-003c");
+
+static struct regulator_init_data cam_vt_dio_reg_init_data = {
+	.constraints = { .valid_ops_mask = REGULATOR_CHANGE_STATUS },
+	.num_consumer_supplies = 1,
+	.consumer_supplies = &cam_vt_dio_supply,
+};
+
+static struct fixed_voltage_config cam_vt_dio_fixed_voltage_cfg = {
+	.supply_name	= "CAM_VT_D_IO",
+	.microvolts	= 2800000,
+	.gpio		= EXYNOS4_GPE2(1), /* CAM_PWR_EN2 */
+	.enable_high	= 1,
+	.init_data	= &cam_vt_dio_reg_init_data,
+};
+
+static struct platform_device cam_vt_dio_fixed_reg_dev = {
+	.name = "reg-fixed-voltage", .id = FIXED_REG_ID_CAM_VT_DIO,
+	.dev = { .platform_data	= &cam_vt_dio_fixed_voltage_cfg },
+};
+
 static struct regulator_consumer_supply cam_i_core_supply =
 	REGULATOR_SUPPLY("core", "0-001f");
 
@@ -885,6 +916,28 @@ static struct s5p_platform_mipi_csis mipi_csis_platdata = {
 #define GPIO_CAM_LEVEL_EN(n)	EXYNOS4_GPE4(n + 3)
 #define GPIO_CAM_8M_ISP_INT	EXYNOS4_GPX1(5)	/* XEINT_13 */
 #define GPIO_CAM_MEGA_nRST	EXYNOS4_GPE2(5)
+#define GPIO_CAM_VGA_NRST	EXYNOS4_GPE4(7)
+#define GPIO_CAM_VGA_NSTBY	EXYNOS4_GPE4(6)
+
+static int s5k6aa_set_power(int on)
+{
+	gpio_set_value(GPIO_CAM_LEVEL_EN(2), !!on);
+	return 0;
+}
+
+static struct s5k6aa_platform_data s5k6aa_platdata = {
+	.mclk_frequency	= 21600000UL,
+	.gpio_reset	= { GPIO_CAM_VGA_NRST, 0 },
+	.gpio_stby	= { GPIO_CAM_VGA_NSTBY, 0 },
+	.bus_type	= V4L2_MBUS_PARALLEL,
+	.horiz_flip	= 1,
+	.set_power	= s5k6aa_set_power,
+};
+
+static struct i2c_board_info s5k6aa_board_info = {
+	I2C_BOARD_INFO("S5K6AA", 0x3C),
+	.platform_data = &s5k6aa_platdata,
+};
 
 static int m5mols_set_power(struct device *dev, int on)
 {
@@ -909,6 +962,14 @@ static struct s5p_fimc_isp_info universal_camera_sensors[] = {
 		.mux_id		= 0,
 		.flags		= V4L2_MBUS_PCLK_SAMPLE_FALLING |
 				  V4L2_MBUS_VSYNC_ACTIVE_LOW,
+		.bus_type	= FIMC_ITU_601,
+		.board_info	= &s5k6aa_board_info,
+		.i2c_bus_num	= 0,
+		.clk_frequency	= 24000000UL,
+	}, {
+		.mux_id		= 0,
+		.flags		= V4L2_MBUS_PCLK_SAMPLE_FALLING |
+				  V4L2_MBUS_VSYNC_ACTIVE_LOW,
 		.bus_type	= FIMC_MIPI_CSI2,
 		.board_info	= &m5mols_board_info,
 		.i2c_bus_num	= 0,
@@ -927,6 +988,8 @@ static struct gpio universal_camera_gpios[] = {
 	{ GPIO_CAM_LEVEL_EN(2),	GPIOF_OUT_INIT_LOW,  "CAM_LVL_EN2" },
 	{ GPIO_CAM_8M_ISP_INT,	GPIOF_IN,            "8M_ISP_INT"  },
 	{ GPIO_CAM_MEGA_nRST,	GPIOF_OUT_INIT_LOW,  "CAM_8M_NRST" },
+	{ GPIO_CAM_VGA_NRST,	GPIOF_OUT_INIT_LOW,  "CAM_VGA_NRST"  },
+	{ GPIO_CAM_VGA_NSTBY,	GPIOF_OUT_INIT_LOW,  "CAM_VGA_NSTBY" },
 };
 
 static void universal_camera_init(void)
@@ -950,6 +1013,8 @@ static void universal_camera_init(void)
 	/* Free GPIOs controlled directly by the sensor drivers. */
 	gpio_free(GPIO_CAM_MEGA_nRST);
 	gpio_free(GPIO_CAM_8M_ISP_INT);
+	gpio_free(GPIO_CAM_VGA_NRST);
+	gpio_free(GPIO_CAM_VGA_NSTBY);
 
 	if (exynos4_fimc_setup_gpio(S5P_CAMPORT_A))
 		pr_err("Camera port A setup failed\n");
@@ -988,6 +1053,7 @@ static struct platform_device *universal_devices[] __initdata = {
 	&exynos4_device_pd[PD_MFC],
 	&exynos4_device_pd[PD_LCD0],
 	&exynos4_device_pd[PD_CAM],
+	&cam_vt_dio_fixed_reg_dev,
 	&cam_i_core_fixed_reg_dev,
 	&cam_s_if_fixed_reg_dev,
 	&s5p_device_fimc_md,
-- 
1.7.8.3
