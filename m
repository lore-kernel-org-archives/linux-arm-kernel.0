From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Tue,  3 Aug 2010 11:20:45 +0200
Subject: [PATCH 2/2] ARM: i.MX27 pca100: Add camera support
In-Reply-To: <1280827245-5762-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1280827245-5762-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1280827245-5762-3-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The glue code for the pca100 to implement the serial LVDS camera. Based
on the camera glue code for pcm970.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-imx/mach-pca100.c |  135 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index a389d11..30a4c02 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -31,6 +31,10 @@
 #include <linux/usb/ulpi.h>
 #include <linux/fsl_devices.h>
 
+#include <media/soc_camera.h>
+
+#include <mach/mx2_cam.h>
+
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/common.h>
@@ -160,6 +164,19 @@ static int pca100_pins[] = {
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
@@ -188,6 +205,20 @@ static struct at24_platform_data board_eeprom = {
 	.flags = AT24_FLAG_ADDR16,
 };
 
+/* count of GPIOs that are occupied by the CPU itself */
+#define MAX_INTERNAL_GPIO 192
+
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
@@ -316,6 +347,91 @@ static struct fsl_usb2_platform_data otg_device_pdata = {
 
 static int otg_mode_host;
 
+static struct i2c_board_info __initdata pbaa01_camera_mt9m001 = {
+		I2C_BOARD_INFO("mt9m001", 0x5d),
+		.type = "mt9m001",
+};
+
+static struct i2c_board_info __initdata pbaa01_camera_mt9v022 = {
+		I2C_BOARD_INFO("mt9v022", 0x48),
+		.type = "mt9v022",
+};
+
+static struct i2c_board_info __initdata pbaa01_camera_mt9m131 = {
+		I2C_BOARD_INFO("mt9m111", 0x48),
+		.type = "mt9m111",
+};
+
+static struct soc_camera_link iclink_mt9m001 = {
+	.bus_id		= 0,		/* Must match with the camera ID */
+	.board_info	= &pbaa01_camera_mt9m001,
+	.i2c_adapter_id	= 0,
+	.module_name	= "mt9m001",
+	.query_bus_param = pbaa01_camera_query_bus_param,
+	.set_bus_param	= pbaa01_camera_set_bus_param,
+};
+
+static struct soc_camera_link iclink_mt9v022 = {
+	.bus_id		= 0,		/* Must match with the camera ID */
+	.board_info	= &pbaa01_camera_mt9v022,
+	.i2c_adapter_id	= 0,
+	.module_name	= "mt9v022",
+	.query_bus_param = pbaa01_camera_query_bus_param,
+	.set_bus_param	= pbaa01_camera_set_bus_param,
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
+static struct platform_device pca100_mt9m001 = {
+	.name	= "soc-camera-pdrv",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &iclink_mt9m001,
+	},
+};
+
+static struct platform_device pca100_mt9v022 = {
+	.name	= "soc-camera-pdrv",
+	.id	= 1,
+	.dev	= {
+		.platform_data = &iclink_mt9v022,
+	},
+};
+
+static struct platform_device pca100_mt9m131 = {
+	.name	= "soc-camera-pdrv",
+	.id	= 2,
+	.dev	= {
+		.platform_data = &iclink_mt9m131,
+	},
+};
+
+/*
+ * Ok, we have to deal with several situations here. We connect
+ * 10bit image sensors to a 8bit interface and we must make sure
+ * that the upper 8bit from the sensor are connected to the image
+ * interface. Some sensors have a i2c GPIO expander which controls
+ * a bus switch to fixup the routing. Mapper boards >= 1285.2 do
+ * the fixup without the need of a gpio switch.
+ * Set this parameter to '1' to use a camera with gpio switch on a
+ * newer mapper board to prevent the fixup being done twice.
+ */
+static int use_camera_gpio;
+/* core_param(use_camera_gpio, use_camera_gpio, int, 0444); */
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
@@ -398,10 +514,14 @@ static void __init pca100_init(void)
 	imx27_add_mxc_nand(&pca100_nand_board_info);
 
 	/* only the i2c master 1 is used on this CPU card */
-	i2c_register_board_info(1, pca100_i2c_devices,
+	i2c_register_board_info(0, pca100_i2c_devices,
 				ARRAY_SIZE(pca100_i2c_devices));
 
-	imx27_add_i2c_imx1(&pca100_i2c1_data);
+	platform_device_register(&pca100_mt9m001);
+	platform_device_register(&pca100_mt9v022);
+	platform_device_register(&pca100_mt9m131);
+
+	imx27_add_i2c_imx0(&pca100_i2c1_data);
 
 #if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
 	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_IN);
@@ -436,6 +556,17 @@ static void __init pca100_init(void)
 
 	mxc_register_device(&mxc_fb_device, &pca100_fb_data);
 
+	mxc_register_device(&mx27_camera_device, &pca100_camera);
+
+	ret = gpio_request(MAX_INTERNAL_GPIO, "camera");
+	if (!ret) {
+		printk(KERN_INFO "pca100 camera: Found GPIO expander on camera, %susing it\n",
+				use_camera_gpio ? "" : "not ");
+		gpio_direction_output(MAX_INTERNAL_GPIO, !!use_camera_gpio);
+	} else
+		printk(KERN_INFO "pca100 camera: No GPIO expander on camera found\n");
+
+
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
-- 
1.7.1
