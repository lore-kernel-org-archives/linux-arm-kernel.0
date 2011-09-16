From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 16 Sep 2011 12:27:53 +0200
Subject: [PATCH 4/4] ARM: S5PV210: UNIVERSAL_C210: Add support for M-5MOLS
	image sensor
In-Reply-To: <1316168873-22257-1-git-send-email-s.nawrocki@samsung.com>
References: <1316168873-22257-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1316168873-22257-5-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add voltage regulator definitions for M-5MOLS camera, platform data
definition for the sensor and MIPI-CSI receiver drivers.
Add CAM power domain dependencies for FIMC and CSIS devices.
Define required I2C0 bus timings. Setup camera port A GPIO.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig               |    3 +
 arch/arm/mach-exynos4/mach-universal_c210.c |  211 ++++++++++++++++++++++++++-
 2 files changed, 206 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 7c109e8..4085858 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -178,6 +178,7 @@ config MACH_UNIVERSAL_C210
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
 	select S5P_DEV_FIMC3
+	select S5P_DEV_CSIS0
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
@@ -193,6 +194,8 @@ config MACH_UNIVERSAL_C210
 	select EXYNOS4_SETUP_I2C3
 	select EXYNOS4_SETUP_I2C5
 	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_SETUP_FIMC
+	select S5P_SETUP_MIPIPHY
 	help
 	  Machine support for Samsung Mobile Universal S5PC210 Reference
 	  Board.
diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-exynos4/mach-universal_c210.c
index e9dbe79..6a27dee 100644
--- a/arch/arm/mach-exynos4/mach-universal_c210.c
+++ b/arch/arm/mach-exynos4/mach-universal_c210.c
@@ -34,9 +34,16 @@
 #include <plat/mfc.h>
 #include <plat/sdhci.h>
 #include <plat/pd.h>
+#include <plat/fimc-core.h>
+#include <plat/camport.h>
+#include <plat/mipi_csis.h>
 
 #include <mach/map.h>
 
+#include <media/v4l2-mediabus.h>
+#include <media/s5p_fimc.h>
+#include <media/m5mols.h>
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define UNIVERSAL_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -189,6 +196,7 @@ static struct regulator_init_data lp3974_ldo2_data = {
 static struct regulator_consumer_supply lp3974_ldo3_consumer[] = {
 	REGULATOR_SUPPLY("vdd", "exynos4-hdmi"),
 	REGULATOR_SUPPLY("vdd_pll", "exynos4-hdmi"),
+	REGULATOR_SUPPLY("vdd11", "s5p-mipi-csis.0"),
 };
 
 static struct regulator_init_data lp3974_ldo3_data = {
@@ -251,6 +259,10 @@ static struct regulator_init_data lp3974_ldo6_data = {
 	},
 };
 
+static struct regulator_consumer_supply lp3974_ldo7_consumer[] = {
+	REGULATOR_SUPPLY("vdd18", "s5p-mipi-csis.0"),
+};
+
 static struct regulator_init_data lp3974_ldo7_data = {
 	.constraints	= {
 		.name		= "VLCD+VMIPI_1.8V",
@@ -262,6 +274,8 @@ static struct regulator_init_data lp3974_ldo7_data = {
 			.disabled	= 1,
 		},
 	},
+	.num_consumer_supplies	= ARRAY_SIZE(lp3974_ldo7_consumer),
+	.consumer_supplies	= lp3974_ldo7_consumer,
 };
 
 static struct regulator_consumer_supply lp3974_ldo8_consumer[] = {
@@ -310,6 +324,9 @@ static struct regulator_init_data lp3974_ldo10_data = {
 	},
 };
 
+static struct regulator_consumer_supply lp3974_ldo11_consumer =
+	REGULATOR_SUPPLY("dig_28", "0-001f");
+
 static struct regulator_init_data lp3974_ldo11_data = {
 	.constraints	= {
 		.name		= "CAM_AF_3.3V",
@@ -321,6 +338,8 @@ static struct regulator_init_data lp3974_ldo11_data = {
 			.disabled	= 1,
 		},
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &lp3974_ldo11_consumer,
 };
 
 static struct regulator_init_data lp3974_ldo12_data = {
@@ -349,6 +368,9 @@ static struct regulator_init_data lp3974_ldo13_data = {
 	},
 };
 
+static struct regulator_consumer_supply lp3974_ldo14_consumer =
+	REGULATOR_SUPPLY("dig_18", "0-001f");
+
 static struct regulator_init_data lp3974_ldo14_data = {
 	.constraints	= {
 		.name		= "CAM_I_HOST_1.8V",
@@ -360,8 +382,14 @@ static struct regulator_init_data lp3974_ldo14_data = {
 			.disabled	= 1,
 		},
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &lp3974_ldo14_consumer,
 };
 
+
+static struct regulator_consumer_supply lp3974_ldo15_consumer =
+	REGULATOR_SUPPLY("dig_12", "0-001f");
+
 static struct regulator_init_data lp3974_ldo15_data = {
 	.constraints	= {
 		.name		= "CAM_S_DIG+FM33_CORE_1.2V",
@@ -373,6 +401,12 @@ static struct regulator_init_data lp3974_ldo15_data = {
 			.disabled	= 1,
 		},
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &lp3974_ldo15_consumer,
+};
+
+static struct regulator_consumer_supply lp3974_ldo16_consumer[] = {
+	REGULATOR_SUPPLY("a_sensor", "0-001f"),
 };
 
 static struct regulator_init_data lp3974_ldo16_data = {
@@ -386,6 +420,8 @@ static struct regulator_init_data lp3974_ldo16_data = {
 			.disabled	= 1,
 		},
 	},
+	.num_consumer_supplies	= ARRAY_SIZE(lp3974_ldo16_consumer),
+	.consumer_supplies	= lp3974_ldo16_consumer,
 };
 
 static struct regulator_init_data lp3974_ldo17_data = {
@@ -496,6 +532,15 @@ static struct max8998_platform_data universal_lp3974_pdata = {
 	.wakeup			= true,
 };
 
+
+enum fixed_regulator_id {
+	FIXED_REG_ID_MMC0,
+	FIXED_REG_ID_HDMI_5V,
+	FIXED_REG_ID_CAM_S_IF,
+	FIXED_REG_ID_CAM_I_CORE,
+	FIXED_REG_ID_CAM_VT_DIO,
+};
+
 static struct regulator_consumer_supply hdmi_fixed_consumer =
 	REGULATOR_SUPPLY("hdmi-en", "exynos4-hdmi");
 
@@ -518,7 +563,7 @@ static struct fixed_voltage_config hdmi_fixed_voltage_config = {
 
 static struct platform_device hdmi_fixed_voltage = {
 	.name			= "reg-fixed-voltage",
-	.id			= 6,
+	.id			= FIXED_REG_ID_HDMI_5V,
 	.dev			= {
 		.platform_data	= &hdmi_fixed_voltage_config,
 	},
@@ -625,6 +670,12 @@ static void __init universal_touchkey_init(void)
 	gpio_direction_output(gpio, 1);
 }
 
+
+static struct s3c2410_platform_i2c universal_i2c0_platdata __initdata = {
+	.frequency	= 350 * 1000,
+	.sda_delay	= 200,
+};
+
 /* GPIO KEYS */
 static struct gpio_keys_button universal_gpio_keys_tables[] = {
 	{
@@ -710,7 +761,7 @@ static struct fixed_voltage_config mmc0_fixed_voltage_config = {
 
 static struct platform_device mmc0_fixed_voltage = {
 	.name			= "reg-fixed-voltage",
-	.id			= 0,
+	.id			= FIXED_REG_ID_MMC0,
 	.dev			= {
 		.platform_data	= &mmc0_fixed_voltage_config,
 	},
@@ -744,18 +795,149 @@ static void __init universal_sdhci_init(void)
 	s3c_sdhci3_set_platdata(&universal_hsmmc3_data);
 }
 
-/* I2C0 */
-static struct i2c_board_info i2c0_devs[] __initdata = {
-	/* Camera, To be updated */
-};
-
 /* I2C1 */
 static struct i2c_board_info i2c1_devs[] __initdata = {
 	/* Gyro, To be updated */
 };
 
+static struct regulator_consumer_supply cam_i_core_supply =
+	REGULATOR_SUPPLY("core", "0-001f");
+
+static struct regulator_init_data cam_i_core_reg_init_data = {
+	.constraints = { .valid_ops_mask = REGULATOR_CHANGE_STATUS },
+	.num_consumer_supplies = 1,
+	.consumer_supplies = &cam_i_core_supply,
+};
+
+static struct fixed_voltage_config cam_i_core_fixed_voltage_cfg = {
+	.supply_name	= "CAM_I_CORE_1.2V",
+	.microvolts	= 1200000,
+	.gpio		= EXYNOS4_GPE2(2), /* CAM_8M_CORE_EN */
+	.enable_high	= 1,
+	.init_data	= &cam_i_core_reg_init_data,
+};
+
+static struct platform_device cam_i_core_fixed_reg_dev = {
+	.name = "reg-fixed-voltage", .id = FIXED_REG_ID_CAM_I_CORE,
+	.dev = { .platform_data	= &cam_i_core_fixed_voltage_cfg },
+};
+
+static struct regulator_consumer_supply cam_s_if_supply =
+	REGULATOR_SUPPLY("d_sensor", "0-001f");
+
+static struct regulator_init_data cam_s_if_reg_init_data = {
+	.constraints = { .valid_ops_mask = REGULATOR_CHANGE_STATUS },
+	.num_consumer_supplies = 1,
+	.consumer_supplies = &cam_s_if_supply,
+};
+
+static struct fixed_voltage_config cam_s_if_fixed_voltage_cfg = {
+	.supply_name	= "CAM_S_IF_1.8V",
+	.microvolts	= 1800000,
+	.gpio		= EXYNOS4_GPE3(0), /* CAM_PWR_EN1 */
+	.enable_high	= 1,
+	.init_data	= &cam_s_if_reg_init_data,
+};
+
+static struct platform_device cam_s_if_fixed_reg_dev = {
+	.name = "reg-fixed-voltage", .id = FIXED_REG_ID_CAM_S_IF,
+	.dev = { .platform_data	= &cam_s_if_fixed_voltage_cfg },
+};
+
+static struct s5p_platform_mipi_csis mipi_csis_platdata = {
+        .clk_rate       = 166000000UL,
+        .lanes          = 2,
+        .alignment      = 32,
+        .hs_settle      = 12,
+        .phy_enable     = s5p_csis_phy_enable,
+};
+
+static int m5mols_set_power(struct device *dev, int on)
+{
+	gpio_set_value(EXYNOS4_GPE4(4), !on);  /* CAM_LEVEL_EN1 */
+	gpio_set_value(EXYNOS4_GPE4(5), !!on); /* CAM_LEVEL_EN2 */
+	return 0;
+}
+
+static struct m5mols_platform_data m5mols_platdata = {
+	.gpio_reset	= EXYNOS4_GPE2(5), /* CAM_MEGA_nRST */
+	.reset_polarity	= 0,
+	.irq		= IRQ_EINT(13),
+	.set_power	= m5mols_set_power,
+};
+
+static struct i2c_board_info m5mols_board_info = {
+	I2C_BOARD_INFO("M5MOLS", 0x1F),
+	.platform_data = &m5mols_platdata,
+	.irq = IRQ_EINT(13),
+};
+
+static struct s5p_fimc_isp_info universal_camera_sensors[] = {
+	{
+		.mux_id		= 0,
+		.flags		= V4L2_MBUS_PCLK_SAMPLE_FALLING |
+				  V4L2_MBUS_VSYNC_ACTIVE_LOW,
+		.bus_type	= FIMC_MIPI_CSI2,
+		.board_info	= &m5mols_board_info,
+		.i2c_bus_num	= 0,
+		.clk_frequency	= 21600000UL,
+		.csi_data_align	= 32,
+	},
+};
+
+static struct s5p_platform_fimc fimc_md_platdata = {
+	.isp_info       = universal_camera_sensors,
+	.num_clients    = ARRAY_SIZE(universal_camera_sensors),
+};
+
+struct platform_device s5p_device_fimc_md = {
+	.name	= "s5p-fimc-md",
+	.id	= -1,
+};
+
+static void universal_camera_init(void)
+{
+	int gpio;
+
+	s3c_set_platdata(&mipi_csis_platdata, sizeof(mipi_csis_platdata),
+			 &s5p_device_mipi_csis0);
+	s3c_set_platdata(&fimc_md_platdata,  sizeof(fimc_md_platdata),
+			 &s5p_device_fimc_md);
+	exynos4_fimc_setup_gpio(S5P_CAMPORT_A);
+	/*
+	 * Configure the I2C level shifter inhibit pins. These are
+	 * controlled through the sensor driver set_power callbacks.
+	 */
+	gpio = EXYNOS4_GPE4(4);
+	gpio_request(gpio, "CAM_LVL_EN1");
+	gpio_direction_output(gpio, 1);
+	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
+	gpio_free(gpio);
+
+	gpio = EXYNOS4_GPE4(5);
+	gpio_request(gpio, "CAM_LVL_EN2");
+	gpio_direction_output(gpio, 0);
+	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_DOWN);
+	gpio_free(gpio);
+
+	/* Initialize GPIOs controlled directly by the sensor drivers. */
+	gpio = EXYNOS4_GPE2(5), /* CAM_MEGA_nRST */
+	gpio_request(gpio, "CAM_8M_NRST");
+	gpio_direction_output(gpio, 0);
+	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_DOWN);
+	gpio_free(gpio);
+
+	gpio = EXYNOS4_GPX1(5);
+	gpio_request(gpio, "8M_ISP_INT");
+	s5p_register_gpio_interrupt(gpio);
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
+	gpio_free(gpio);
+
+}
+
 static struct platform_device *universal_devices[] __initdata = {
 	/* Samsung Platform Devices */
+	&s5p_device_mipi_csis0,
 	&s5p_device_fimc0,
 	&s5p_device_fimc1,
 	&s5p_device_fimc2,
@@ -764,6 +946,7 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc2,
 	&s3c_device_hsmmc3,
+	&s3c_device_i2c0,
 	&s3c_device_i2c3,
 	&s3c_device_i2c5,
 	&s5p_device_i2c_hdmiphy,
@@ -781,6 +964,9 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s5p_device_mfc_l,
 	&s5p_device_mfc_r,
 	&exynos4_device_pd[PD_MFC],
+	&exynos4_device_pd[PD_CAM],
+	&cam_i_core_fixed_reg_dev,
+	&cam_s_if_fixed_reg_dev,
 };
 
 static void __init universal_map_io(void)
@@ -814,7 +1000,7 @@ static void __init universal_machine_init(void)
 	universal_sdhci_init();
 	s5p_tv_setup();
 
-	i2c_register_board_info(0, i2c0_devs, ARRAY_SIZE(i2c0_devs));
+	s3c_i2c0_set_platdata(&universal_i2c0_platdata);
 	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
 
 	universal_tsp_init();
@@ -829,9 +1015,18 @@ static void __init universal_machine_init(void)
 	i2c_register_board_info(I2C_GPIO_BUS_12, i2c_gpio12_devs,
 			ARRAY_SIZE(i2c_gpio12_devs));
 
+	universal_camera_init();
+
 	/* Last */
 	platform_add_devices(universal_devices, ARRAY_SIZE(universal_devices));
+
 	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
+
+	s5p_device_fimc0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	s5p_device_fimc1.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	s5p_device_fimc2.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	s5p_device_fimc3.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	s5p_device_mipi_csis0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
 }
 
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
-- 
1.7.6
