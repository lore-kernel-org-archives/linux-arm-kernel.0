From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 16 Sep 2011 12:27:51 +0200
Subject: [PATCH v2 2/4] ARM: S5PV210: Add support for NOON010PC30 sensor on
	GONI board
In-Reply-To: <1316168873-22257-1-git-send-email-s.nawrocki@samsung.com>
References: <1316168873-22257-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1316168873-22257-3-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform data for CIF camera sensor and FIMC platform data
entries for it. Add platform device for s5p-fimc media device
driver and the camera port A I/O pins initialization.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Kgene, the previous version of this patch should be dropped. I've updated
this version to use generioc signal polarity flags. 

Thanks, S.
---
 arch/arm/mach-s5pv210/Kconfig     |    1 +
 arch/arm/mach-s5pv210/mach-goni.c |   53 +++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index ab6a87c..b4c0621 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -100,6 +100,7 @@ config MACH_GONI
 	select S5PV210_SETUP_I2C2
 	select S5PV210_SETUP_KEYPAD
 	select S5PV210_SETUP_SDHCI
+	select S5PV210_SETUP_FIMC
 	help
 	  Machine support for Samsung GONI board
 	  S5PC110(MCP) is one of package option of S5PV210
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 14578f5..01e4867 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -48,6 +48,11 @@
 #include <plat/s5p-time.h>
 #include <plat/mfc.h>
 #include <plat/regs-fb-v4.h>
+#include <plat/camport.h>
+
+#include <media/v4l2-mediabus.h>
+#include <media/s5p_fimc.h>
+#include <media/noon010pc30.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define GONI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -272,6 +277,14 @@ static void __init goni_tsp_init(void)
 	i2c2_devs[0].irq = gpio_to_irq(gpio);
 }
 
+static void goni_camera_init(void)
+{
+	s5pv210_fimc_setup_gpio(S5P_CAMPORT_A);
+
+	/* Set max driver strength on CAM_A_CLKOUT pin. */
+	s5p_gpio_set_drvstr(S5PV210_GPE1(3), S5P_GPIO_DRVSTR_LV4);
+}
+
 /* MAX8998 regulators */
 #if defined(CONFIG_REGULATOR_MAX8998) || defined(CONFIG_REGULATOR_MAX8998_MODULE)
 
@@ -808,6 +821,39 @@ static void goni_setup_sdhci(void)
 	s3c_sdhci2_set_platdata(&goni_hsmmc2_data);
 };
 
+static struct noon010pc30_platform_data noon010pc30_pldata = {
+	.clk_rate	= 16000000UL,
+	.gpio_nreset	= S5PV210_GPB(2), /* CAM_CIF_NRST */
+	.gpio_nstby	= S5PV210_GPB(0), /* CAM_CIF_NSTBY */
+};
+
+static struct i2c_board_info noon010pc30_board_info = {
+	I2C_BOARD_INFO("NOON010PC30", 0x60 >> 1),
+	.platform_data = &noon010pc30_pldata,
+};
+
+static struct s5p_fimc_isp_info goni_camera_sensors[] = {
+	{
+		.mux_id		= 0,
+		.flags		= V4L2_MBUS_PCLK_SAMPLE_FALLING |
+				  V4L2_MBUS_VSYNC_ACTIVE_LOW,
+		.bus_type	= FIMC_ITU_601,
+		.board_info	= &noon010pc30_board_info,
+		.i2c_bus_num	= 0,
+		.clk_frequency	= 16000000UL,
+	},
+};
+
+struct s5p_platform_fimc goni_fimc_md_platdata __initdata = {
+	.isp_info	= goni_camera_sensors,
+	.num_clients	= ARRAY_SIZE(goni_camera_sensors),
+};
+
+struct platform_device s5p_device_fimc_md = {
+	.name		= "s5p-fimc-md",
+	.id		= -1,
+};
+
 static struct platform_device *goni_devices[] __initdata = {
 	&s3c_device_fb,
 	&s5p_device_onenand,
@@ -825,6 +871,7 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s5p_device_fimc0,
 	&s5p_device_fimc1,
 	&s5p_device_fimc2,
+	&s5p_device_fimc_md,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
@@ -893,6 +940,12 @@ static void __init goni_machine_init(void)
 	/* FB */
 	s3c_fb_set_platdata(&goni_lcd_pdata);
 
+	/* FIMC */
+	s3c_set_platdata(&goni_fimc_md_platdata, sizeof(goni_fimc_md_platdata),
+			 &s5p_device_fimc_md);
+
+	goni_camera_init();
+
 	/* SPI */
 	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
 
-- 
1.7.6
