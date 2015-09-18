From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 18 Sep 2015 03:18:34 +0200
Subject: [PATCH v3 19/26] ARM: pxa: magician: Add support for Omnivision
 OV9640 camera
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Message-ID: <55FB666A.7040103@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for an OV9640 camera to the HTC Magician machine.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 450f35f..d844b9c 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -49,6 +49,9 @@
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/ads7846.h>
 
+#include <linux/platform_data/camera-pxa.h>
+#include <media/soc_camera.h>
+
 #include "devices.h"
 #include "generic.h"
 
@@ -960,6 +963,60 @@ static struct spi_board_info ads7846_spi_board_info[] __initdata = {
 };
 
 /*
+ * SoC Camera for OV9640 chip
+ */
+
+static struct pxacamera_platform_data magician_pxacamera_pdata = {
+	.flags		= PXA_CAMERA_MASTER | PXA_CAMERA_DATAWIDTH_8 |
+		PXA_CAMERA_PCLK_EN | PXA_CAMERA_MCLK_EN,
+	.mclk_10khz	= 4800,
+};
+
+static int magician_camera_power(struct device *dev, int power)
+{
+	pr_debug("Camera power = %i\n", power);
+
+	gpio_set_value(GPIO116_MAGICIAN_nCAM_EN, !power);
+	mdelay(3);
+
+	return 0;
+}
+
+static int magician_camera_reset(struct device *dev)
+{
+	pr_debug("Camera reset\n");
+
+	gpio_set_value(GPIO57_MAGICIAN_CAM_RESET, 1);
+	mdelay(3);
+	gpio_set_value(GPIO57_MAGICIAN_CAM_RESET, 0);
+	mdelay(3);
+
+	return 0;
+}
+
+static struct i2c_board_info magician_camera_i2c_board_info = {
+	I2C_BOARD_INFO("ov9640", 0x30),
+	.flags = I2C_CLIENT_SCCB,
+};
+
+static struct soc_camera_link magician_camera_iclink = {
+	.bus_id		= 0,
+	.flags		= SOCAM_DATAWIDTH_8,
+	.i2c_adapter_id	= 0,
+	.board_info	= &magician_camera_i2c_board_info,
+	.power		= magician_camera_power,
+	.reset		= magician_camera_reset,
+};
+
+static struct platform_device magician_camera = {
+	.name	= "soc-camera-pdrv",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &magician_camera_iclink,
+	},
+};
+
+/*
  * Platform devices
  */
 
@@ -974,6 +1031,7 @@ static struct platform_device *devices[] __initdata = {
 	&power_supply,
 	&strataflash,
 	&leds_gpio,
+	&magician_camera,
 };
 
 static struct gpio magician_global_gpios[] = {
@@ -984,6 +1042,8 @@ static struct gpio magician_global_gpios[] = {
 	{ GPIO106_MAGICIAN_LCD_DCDC_NRESET, GPIOF_OUT_INIT_LOW, "LCD DCDC nreset" },
 	{ GPIO104_MAGICIAN_LCD_VOFF_EN, GPIOF_OUT_INIT_LOW, "LCD VOFF enable" },
 	{ GPIO105_MAGICIAN_LCD_VON_EN, GPIOF_OUT_INIT_LOW, "LCD VON enable" },
+	{ GPIO57_MAGICIAN_CAM_RESET, GPIOF_OUT_INIT_HIGH, "Camera reset" },
+	{ GPIO116_MAGICIAN_nCAM_EN, GPIOF_OUT_INIT_HIGH, "Camera power" },
 };
 
 static void __init magician_init(void)
@@ -1030,6 +1090,7 @@ static void __init magician_init(void)
 	pxa2xx_set_spi_info(2, &magician_spi_info);
 	spi_register_board_info(ARRAY_AND_SIZE(ads7846_spi_board_info));
 
+	pxa_set_camera_info(&magician_pxacamera_pdata);
 }
 
 MACHINE_START(MAGICIAN, "HTC Magician")
-- 
1.7.12.1
