From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 15 Feb 2012 19:36:10 -0200
Subject: [PATCH 1/2] ARM: mx27_3ds: Add camera support
Message-ID: <1329341771-13749-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx27_3ds has an OV2640 camera connected on i2c0.

Add support for it.

Tested through the following Gstreamer pipeline:

gst-launch -v v4l2src device=/dev/video0 ! video/x-raw-yuv,width=320,height=240,framerate=25/1 ! ffmpegcolorspace ! fbdevsink

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c |  110 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4defb97..f7da872 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -304,6 +304,7 @@ config MACH_MX27_3DS
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MX2_CAMERA
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 18f3581..1573fe4 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -31,6 +31,8 @@
 #include <linux/regulator/machine.h>
 #include <linux/spi/l4f00242t03.h>
 
+#include <media/soc_camera.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -52,6 +54,8 @@
 #define SD1_CD			IMX_GPIO_NR(2, 26)
 #define LCD_RESET		IMX_GPIO_NR(1, 3)
 #define LCD_ENABLE		IMX_GPIO_NR(1, 31)
+#define CSI_PWRDWN		IMX_GPIO_NR(4, 19)
+#define CSI_RESET		IMX_GPIO_NR(3, 6)
 
 static const int mx27pdk_pins[] __initconst = {
 	/* UART1 */
@@ -141,6 +145,26 @@ static const int mx27pdk_pins[] __initconst = {
 	PA30_PF_CONTRAST,
 	LCD_ENABLE | GPIO_GPIO | GPIO_OUT,
 	LCD_RESET | GPIO_GPIO | GPIO_OUT,
+	/* CSI */
+	PB10_PF_CSI_D0,
+	PB11_PF_CSI_D1,
+	PB12_PF_CSI_D2,
+	PB13_PF_CSI_D3,
+	PB14_PF_CSI_D4,
+	PB15_PF_CSI_MCLK,
+	PB16_PF_CSI_PIXCLK,
+	PB17_PF_CSI_D5,
+	PB18_PF_CSI_D6,
+	PB19_PF_CSI_D7,
+	PB20_PF_CSI_VSYNC,
+	PB21_PF_CSI_HSYNC,
+	CSI_PWRDWN | GPIO_GPIO | GPIO_OUT,
+	CSI_RESET | GPIO_GPIO | GPIO_OUT,
+};
+
+static struct gpio mx27_3ds_camera_gpios[] = {
+	{ CSI_PWRDWN, GPIOF_OUT_INIT_HIGH, "camera-power" },
+	{ CSI_RESET, GPIOF_OUT_INIT_HIGH, "camera-reset" },
 };
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
@@ -242,6 +266,7 @@ static struct regulator_init_data gpo_init = {
 
 static struct regulator_consumer_supply vmmc1_consumers[] = {
 	REGULATOR_SUPPLY("vcore", "spi0.0"),
+	REGULATOR_SUPPLY("cmos_2v8", "soc-camera-pdrv.0"),
 };
 
 static struct regulator_init_data vmmc1_init = {
@@ -270,6 +295,22 @@ static struct regulator_init_data vgen_init = {
 	.consumer_supplies = vgen_consumers,
 };
 
+static struct regulator_consumer_supply vvib_consumers[] = {
+	REGULATOR_SUPPLY("cmos_vcore", "soc-camera-pdrv.0"),
+};
+
+static struct regulator_init_data vvib_init = {
+	.constraints = {
+		.min_uV = 1300000,
+		.max_uV = 1300000,
+		.apply_uV = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+				  REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(vvib_consumers),
+	.consumer_supplies = vvib_consumers,
+};
+
 static struct mc13xxx_regulator_init_data mx27_3ds_regulators[] = {
 	{
 		.id = MC13783_REG_VMMC1,
@@ -283,7 +324,10 @@ static struct mc13xxx_regulator_init_data mx27_3ds_regulators[] = {
 	}, {
 		.id = MC13783_REG_GPO3, /* Turn on 3.3V */
 		.init_data = &gpo_init,
-	},
+	}, {
+		.id = MC13783_REG_VVIB,  /* Power OV2640 */
+		.init_data = &vvib_init,
+	},
 };
 
 /* MC13783 */
@@ -311,6 +355,51 @@ static const struct spi_imx_master spi2_pdata __initconst = {
 	.num_chipselect	= ARRAY_SIZE(spi2_chipselect),
 };
 
+static int mx27_3ds_camera_power(struct device *dev, int on)
+{
+	/* enable or disable the camera */
+	pr_debug("%s: %s the camera\n", __func__, on ? "ENABLE" : "DISABLE");
+	gpio_set_value(CSI_PWRDWN, on ? 0 : 1);
+
+	if (!on)
+		goto out;
+
+	/* If enabled, give a reset impulse */
+	gpio_set_value(CSI_RESET, 0);
+	msleep(20);
+	gpio_set_value(CSI_RESET, 1);
+	msleep(100);
+
+out:
+	return 0;
+}
+
+static struct i2c_board_info mx27_3ds_i2c_camera = {
+	I2C_BOARD_INFO("ov2640", 0x30),
+};
+
+static struct regulator_bulk_data mx27_3ds_camera_regs[] = {
+	{ .supply = "cmos_vcore" },
+	{ .supply = "cmos_2v8" },
+};
+
+static struct soc_camera_link iclink_ov2640 = {
+	.bus_id		= 0,
+	.board_info	= &mx27_3ds_i2c_camera,
+	.i2c_adapter_id	= 0,
+	.power		= mx27_3ds_camera_power,
+	.regulators	= mx27_3ds_camera_regs,
+	.num_regulators	= ARRAY_SIZE(mx27_3ds_camera_regs),
+};
+
+static struct platform_device mx27_3ds_ov2640 = {
+	.name	= "soc-camera-pdrv",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &iclink_ov2640,
+	},
+};
+
 static struct imx_fb_videomode mx27_3ds_modes[] = {
 	{	/* 480x640 @ 60 Hz */
 		.mode = {
@@ -367,12 +456,21 @@ static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
 	},
 };
 
+static struct platform_device *devices[] __initdata = {
+	&mx27_3ds_ov2640,
+};
+
+static const struct mx2_camera_platform_data mx27_3ds_cam_pdata __initconst = {
+	.clk = 26000000,
+};
+
 static const struct imxi2c_platform_data mx27_3ds_i2c0_data __initconst = {
 	.bitrate = 100000,
 };
 
 static void __init mx27pdk_init(void)
 {
+	int ret;
 	imx27_soc_init();
 
 	mxc_gpio_setup_multiple_pins(mx27pdk_pins, ARRAY_SIZE(mx27pdk_pins),
@@ -404,7 +502,17 @@ static void __init mx27pdk_init(void)
 	if (mxc_expio_init(MX27_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		pr_warn("Init of the debugboard failed, all devices on the debugboard are unusable.\n");
 	imx27_add_imx_i2c(0, &mx27_3ds_i2c0_data);
+	platform_add_devices(devices, ARRAY_SIZE(devices));
 	imx27_add_imx_fb(&mx27_3ds_fb_data);
+
+	ret = gpio_request_array(mx27_3ds_camera_gpios,
+				 ARRAY_SIZE(mx27_3ds_camera_gpios));
+	if (ret) {
+		pr_err("Failed to request camera gpios");
+		iclink_ov2640.power = NULL;
+	}
+
+	imx27_add_mx2_camera(&mx27_3ds_cam_pdata);
 }
 
 static void __init mx27pdk_timer_init(void)
-- 
1.7.1
