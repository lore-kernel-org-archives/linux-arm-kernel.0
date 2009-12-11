From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 11 Dec 2009 14:29:06 +0100 (CET)
Subject: [PATCH] mx3: add support for the mt9v022 camera sensor to pcm037
	platform
Message-ID: <Pine.LNX.4.64.0912111428290.5084@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-mx3/pcm037.c |   32 +++++++++++++++++++++++++-------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx3/pcm037.c b/arch/arm/mach-mx3/pcm037.c
index 6cbaabe..5be3969 100644
--- a/arch/arm/mach-mx3/pcm037.c
+++ b/arch/arm/mach-mx3/pcm037.c
@@ -322,16 +322,25 @@ static int pcm037_camera_power(struct device *dev, int on)
 	return 0;
 }
 
-static struct i2c_board_info pcm037_i2c_2_devices[] = {
+static struct i2c_board_info pcm037_i2c_camera[] = {
 	{
 		I2C_BOARD_INFO("mt9t031", 0x5d),
+	}, {
+		I2C_BOARD_INFO("mt9v022", 0x48),
 	},
 };
 
-static struct soc_camera_link iclink = {
+static struct soc_camera_link iclink_mt9v022 = {
+	.bus_id		= 0,		/* Must match with the camera ID */
+	.board_info	= &pcm037_i2c_camera[1],
+	.i2c_adapter_id	= 2,
+	.module_name	= "mt9v022",
+};
+
+static struct soc_camera_link iclink_mt9t031 = {
 	.bus_id		= 0,		/* Must match with the camera ID */
 	.power		= pcm037_camera_power,
-	.board_info	= &pcm037_i2c_2_devices[0],
+	.board_info	= &pcm037_i2c_camera[0],
 	.i2c_adapter_id	= 2,
 	.module_name	= "mt9t031",
 };
@@ -345,11 +354,19 @@ static struct i2c_board_info pcm037_i2c_devices[] = {
 	}
 };
 
-static struct platform_device pcm037_camera = {
+static struct platform_device pcm037_mt9t031 = {
 	.name	= "soc-camera-pdrv",
 	.id	= 0,
 	.dev	= {
-		.platform_data = &iclink,
+		.platform_data = &iclink_mt9t031,
+	},
+};
+
+static struct platform_device pcm037_mt9v022 = {
+	.name	= "soc-camera-pdrv",
+	.id	= 1,
+	.dev	= {
+		.platform_data = &iclink_mt9v022,
 	},
 };
 
@@ -449,7 +466,8 @@ static int __init pcm037_camera_alloc_dma(const size_t buf_size)
 static struct platform_device *devices[] __initdata = {
 	&pcm037_flash,
 	&pcm037_sram_device,
-	&pcm037_camera,
+	&pcm037_mt9t031,
+	&pcm037_mt9v022,
 };
 
 static struct ipu_platform_data mx3_ipu_data = {
@@ -599,7 +617,7 @@ static void __init mxc_board_init(void)
 	if (!ret)
 		gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), 1);
 	else
-		iclink.power = NULL;
+		iclink_mt9t031.power = NULL;
 
 	if (!pcm037_camera_alloc_dma(4 * 1024 * 1024))
 		mxc_register_device(&mx3_camera, &camera_pdata);
-- 
1.6.2.4
