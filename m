From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 07 Oct 2011 15:53:10 +0200
Subject: [PATCH] ARM: EXYNOS4: Add support for M-5MOLS camera on Nuri board
Message-ID: <1317995590-2289-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add voltage regulator and platform data definition for M-5MOLS sensor
and MIPI-CSI receiver drivers. Add CAM power domain dependencies for
FIMC device and set up camera port A GPIO. Configure I2C0 bus timings.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: HeungJun, Kim <riverful.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
This is to enable M-5MOLS camera on Exynos4 Nuri board. The patch is
based of off git://github.com/kgene/linux-samsung.git for-next.

Thanks,
 Sylwester
---
 arch/arm/mach-exynos4/Kconfig     |    8 ++
 arch/arm/mach-exynos4/mach-nuri.c |  158 +++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index dd660eb..afa6cb5 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -215,9 +215,15 @@ config MACH_UNIVERSAL_C210
 config MACH_NURI
 	bool "Mobile NURI Board"
 	select CPU_EXYNOS4210
+	select S5P_GPIO_INT
 	select S3C_DEV_WDT
 	select S3C_DEV_RTC
 	select S5P_DEV_FIMD0
+	select S5P_DEV_FIMC0
+	select S5P_DEV_FIMC1
+	select S5P_DEV_FIMC2
+	select S5P_DEV_FIMC3
+	select S5P_DEV_CSIS0
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
@@ -233,6 +239,8 @@ config MACH_NURI
 	select EXYNOS4_SETUP_I2C5
 	select EXYNOS4_SETUP_SDHCI
 	select EXYNOS4_SETUP_USB_PHY
+	select EXYNOS4_SETUP_FIMC
+	select S5P_SETUP_MIPIPHY
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_ADC
 	help
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index bbd13f4..62c18ab 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -45,9 +45,16 @@
 #include <plat/iic.h>
 #include <plat/mfc.h>
 #include <plat/pd.h>
+#include <plat/fimc-core.h>
+#include <plat/camport.h>
+#include <plat/mipi_csis.h>
 
 #include <mach/map.h>
 
+#include <media/m5mols.h>
+#include <media/s5p_fimc.h>
+#include <media/v4l2-mediabus.h>
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define NURI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -65,6 +72,8 @@
 enum fixed_regulator_id {
 	FIXED_REG_ID_MMC = 0,
 	FIXED_REG_ID_MAX8903,
+	FIXED_REG_ID_CAM_A28V,
+	FIXED_REG_ID_CAM_12V,
 };
 
 static struct s3c2410_uartcfg nuri_uartcfgs[] __initdata = {
@@ -1117,10 +1126,146 @@ static void __init nuri_ehci_init(void)
 	s5p_ehci_set_platdata(pdata);
 }
 
+/* CAMERA */
+static struct regulator_consumer_supply cam_vdda_supply[] = {
+	REGULATOR_SUPPLY("a_sensor", "0-001f"),
+};
+
+static struct regulator_init_data cam_vdda_reg_init_data = {
+	.constraints = { .valid_ops_mask = REGULATOR_CHANGE_STATUS },
+	.num_consumer_supplies = ARRAY_SIZE(cam_vdda_supply),
+	.consumer_supplies = cam_vdda_supply,
+};
+
+static struct fixed_voltage_config cam_vdda_fixed_voltage_cfg = {
+	.supply_name	= "CAM_IO_EN",
+	.microvolts	= 2800000,
+	.gpio		= EXYNOS4_GPE2(1), /* CAM_IO_EN */
+	.enable_high	= 1,
+	.init_data	= &cam_vdda_reg_init_data,
+};
+
+static struct platform_device cam_vdda_fixed_rdev = {
+	.name = "reg-fixed-voltage", .id = FIXED_REG_ID_CAM_A28V,
+	.dev = { .platform_data	= &cam_vdda_fixed_voltage_cfg },
+};
+
+static struct regulator_consumer_supply camera_8m_12v_supply =
+	REGULATOR_SUPPLY("dig_12", "0-001f");
+
+static struct regulator_init_data cam_8m_12v_reg_init_data = {
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &camera_8m_12v_supply,
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS
+	},
+};
+
+static struct fixed_voltage_config cam_8m_12v_fixed_voltage_cfg = {
+	.supply_name	= "8M_1.2V",
+	.microvolts	= 1200000,
+	.gpio		= EXYNOS4_GPE2(5), /* 8M_1.2V_EN */
+	.enable_high	= 1,
+	.init_data	= &cam_8m_12v_reg_init_data,
+};
+
+static struct platform_device cam_8m_12v_fixed_rdev = {
+	.name = "reg-fixed-voltage", .id = FIXED_REG_ID_CAM_12V,
+	.dev = { .platform_data = &cam_8m_12v_fixed_voltage_cfg },
+};
+
+static struct s5p_platform_mipi_csis mipi_csis_platdata = {
+	.clk_rate       = 166000000UL,
+	.lanes          = 2,
+	.alignment      = 32,
+	.hs_settle      = 12,
+	.phy_enable     = s5p_csis_phy_enable,
+};
+
+#define GPIO_CAM_MEGA_RST	EXYNOS4_GPY3(7) /* ISP_RESET */
+#define GPIO_CAM_8M_ISP_INT	EXYNOS4_GPL2(5)
+
+static struct m5mols_platform_data m5mols_platdata = {
+	.gpio_reset = GPIO_CAM_MEGA_RST,
+};
+
+static struct i2c_board_info m5mols_board_info = {
+	I2C_BOARD_INFO("M5MOLS", 0x1F),
+	.platform_data	= &m5mols_platdata,
+};
+
+static struct s5p_fimc_isp_info nuri_camera_sensors[] = {
+	{
+		.flags		= V4L2_MBUS_PCLK_SAMPLE_FALLING |
+				  V4L2_MBUS_VSYNC_ACTIVE_LOW,
+		.bus_type       = FIMC_MIPI_CSI2,
+		.board_info     = &m5mols_board_info,
+		.clk_frequency  = 24000000UL,
+		.csi_data_align = 32,
+	},
+};
+
+static struct s5p_platform_fimc fimc_md_platdata = {
+	.isp_info	= nuri_camera_sensors,
+	.num_clients	= ARRAY_SIZE(nuri_camera_sensors),
+};
+
+struct platform_device s5p_device_fimc_md = {
+	.name	= "s5p-fimc-md",
+	.id	= -1,
+};
+
+static struct gpio nuri_camera_gpios[] = {
+	{ GPIO_CAM_8M_ISP_INT,	GPIOF_IN,           "8M_ISP_INT"  },
+	{ GPIO_CAM_MEGA_RST,	GPIOF_OUT_INIT_LOW, "CAM_8M_NRST" },
+};
+
+static void nuri_camera_init(void)
+{
+	s3c_set_platdata(&mipi_csis_platdata, sizeof(mipi_csis_platdata),
+			 &s5p_device_mipi_csis0);
+	s3c_set_platdata(&fimc_md_platdata,  sizeof(fimc_md_platdata),
+			 &s5p_device_fimc_md);
+
+	if (gpio_request_array(nuri_camera_gpios,
+			       ARRAY_SIZE(nuri_camera_gpios))) {
+		pr_err("%s: GPIO request failed\n", __func__);
+		return;
+	}
+
+	m5mols_board_info.irq = s5p_register_gpio_interrupt(GPIO_CAM_8M_ISP_INT);
+	if (!IS_ERR_VALUE(m5mols_board_info.irq))
+		s3c_gpio_cfgpin(GPIO_CAM_8M_ISP_INT, S3C_GPIO_SFN(0xF));
+	else
+		pr_err("%s: Failed to configure 8M_ISP_INT GPIO\n", __func__);
+
+	/* Free GPIOs controlled directly by the sensor drivers. */
+	gpio_free(GPIO_CAM_MEGA_RST);
+	gpio_free(GPIO_CAM_8M_ISP_INT);
+
+	if (exynos4_fimc_setup_gpio(S5P_CAMPORT_A)) {
+		pr_err("%s: Camera port A setup failed\n", __func__);
+		return;
+	}
+	/* Increase drive strength of the sensor clock output */
+	s5p_gpio_set_drvstr(EXYNOS4_GPJ1(3), S5P_GPIO_DRVSTR_LV4);
+}
+
+static struct s3c2410_platform_i2c nuri_i2c0_platdata __initdata = {
+	.frequency	= 400000U,
+	.sda_delay	= 200,
+};
+
 static struct platform_device *nuri_devices[] __initdata = {
 	/* Samsung Platform Devices */
 	&s3c_device_i2c5, /* PMIC should initialize first */
+	&s3c_device_i2c0,
 	&emmc_fixed_voltage,
+	&s5p_device_mipi_csis0,
+	&s5p_device_fimc0,
+	&s5p_device_fimc1,
+	&s5p_device_fimc2,
+	&s5p_device_fimc3,
 	&s5p_device_fimd0,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc2,
@@ -1137,6 +1282,8 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s5p_device_mfc_r,
 	&exynos4_device_pd[PD_MFC],
 	&exynos4_device_pd[PD_LCD0],
+	&exynos4_device_pd[PD_CAM],
+	&s5p_device_fimc_md,
 
 	/* NURI Devices */
 	&nuri_gpio_keys,
@@ -1144,6 +1291,8 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&nuri_backlight_device,
 	&max8903_fixed_reg_dev,
 	&nuri_max8903_device,
+	&cam_vdda_fixed_rdev,
+	&cam_8m_12v_fixed_rdev,
 };
 
 static void __init nuri_map_io(void)
@@ -1164,6 +1313,7 @@ static void __init nuri_machine_init(void)
 	nuri_tsp_init();
 	nuri_power_init();
 
+	s3c_i2c0_set_platdata(&nuri_i2c0_platdata);
 	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
 	s3c_i2c3_set_platdata(&i2c3_data);
 	i2c_register_board_info(3, i2c3_devs, ARRAY_SIZE(i2c3_devs));
@@ -1175,6 +1325,8 @@ static void __init nuri_machine_init(void)
 
 	s5p_fimd0_set_platdata(&nuri_fb_pdata);
 
+	nuri_camera_init();
+
 	nuri_ehci_init();
 	clk_xusbxti.rate = 24000000;
 
@@ -1182,6 +1334,12 @@ static void __init nuri_machine_init(void)
 	platform_add_devices(nuri_devices, ARRAY_SIZE(nuri_devices));
 	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
 	s5p_device_fimd0.dev.parent = &exynos4_device_pd[PD_LCD0].dev;
+
+	s5p_device_fimc0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	s5p_device_fimc1.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	s5p_device_fimc2.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	s5p_device_fimc3.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	s5p_device_mipi_csis0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
 }
 
 MACHINE_START(NURI, "NURI")
-- 
1.7.6.3
