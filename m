From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Fri, 26 Aug 2011 15:12:11 +0200
Subject: [PATCH 2/2] ARM: i.MX27 pca100: Add camera support for mt9m111
In-Reply-To: <1314364331-4526-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1314364331-4526-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1314364331-4526-2-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This glue code for the pca100 implements support for the mt9m111
LVDS connected camera.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig       |    1 +
 arch/arm/mach-imx/mach-pca100.c |   59 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0519dd7..4697ed3 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -328,6 +328,7 @@ config MACH_PCA100
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select IMX_HAVE_PLATFORM_MX2_CAMERA
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for phyCARD-s (aka pca100) platform. This
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 71083aa..e67a41b 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -30,6 +30,8 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
+#include <media/soc_camera.h>
+
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/common.h>
@@ -153,6 +155,19 @@ static const int pca100_pins[] __initconst = {
 	GPIO_PORTC | 31 | GPIO_GPIO | GPIO_IN, /* GPIO0_IRQ */
 	GPIO_PORTC | 25 | GPIO_GPIO | GPIO_IN, /* GPIO1_IRQ */
 	GPIO_PORTE | 5 | GPIO_GPIO | GPIO_IN, /* GPIO2_IRQ */
+	/* Camera */
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
 };
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
@@ -175,6 +190,17 @@ static struct at24_platform_data board_eeprom = {
 	.flags = AT24_FLAG_ADDR16,
 };
 
+static unsigned long pbaa01_camera_query_bus_param(struct soc_camera_link *icl)
+{
+	return SOCAM_DATAWIDTH_8;
+}
+
+static int pbaa01_camera_set_bus_param(struct soc_camera_link *icl,
+		unsigned long flags)
+{
+	return 0;
+}
+
 static struct i2c_board_info pca100_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("at24", 0x52), /* E0=0, E1=1, E2=0 */
@@ -301,6 +327,34 @@ static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 
 static int otg_mode_host;
 
+static struct i2c_board_info __initdata pbaa01_camera_mt9m131 = {
+		I2C_BOARD_INFO("mt9m111", 0x48),
+		.type = "mt9m111",
+};
+
+static struct soc_camera_link iclink_mt9m131 = {
+	.bus_id		= 0,		/* Must match with the camera ID */
+	.board_info	= &pbaa01_camera_mt9m131,
+	.i2c_adapter_id	= 0,
+	.module_name	= "mt9m111",
+	.query_bus_param = pbaa01_camera_query_bus_param,
+	.set_bus_param	= pbaa01_camera_set_bus_param,
+};
+
+static struct platform_device pca100_mt9m131 = {
+	.name	= "soc-camera-pdrv",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &iclink_mt9m131,
+	},
+};
+
+struct mx2_camera_platform_data pca100_camera = {
+	.clk  = 26600000,
+	.flags = MX2_CAMERA_HSYNC_HIGH | MX2_CAMERA_GATED_CLOCK |
+		MX2_CAMERA_PACK_DIR_MSB,
+};
+
 static int __init pca100_otg_mode(char *options)
 {
 	if (!strcmp(options, "host"))
@@ -388,8 +442,11 @@ static void __init pca100_init(void)
 	i2c_register_board_info(1, pca100_i2c_devices,
 				ARRAY_SIZE(pca100_i2c_devices));
 
+	imx27_add_imx_i2c(0, &pca100_i2c1_data);
 	imx27_add_imx_i2c(1, &pca100_i2c1_data);
 
+	platform_device_register(&pca100_mt9m131);
+
 	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_IN);
 	mxc_gpio_mode(GPIO_PORTD | 27 | GPIO_GPIO | GPIO_IN);
 	spi_register_board_info(pca100_spi_board_info,
@@ -423,6 +480,8 @@ static void __init pca100_init(void)
 	imx27_add_fec(NULL);
 	imx27_add_imx2_wdt(NULL);
 	imx27_add_mxc_w1(NULL);
+
+	imx27_add_mx2_camera(&pca100_camera);
 }
 
 static void __init pca100_timer_init(void)
-- 
1.7.5.4
