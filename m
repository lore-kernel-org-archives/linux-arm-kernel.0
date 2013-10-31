From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 31 Oct 2013 11:20:46 +0100 (CET)
Subject: [PATCH] ARM: pcm037: convert custom GPIO-based power function to a
 regulator
Message-ID: <Pine.LNX.4.64.1310311118370.30523@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a fixed-voltage GPIO-enabled regulator to switch the camera on and off
instead of using a .power() platform callback.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Only tested to grab the regulator during probing, couldn't test 
functionality due to the lack of an mt9t031 sensor.

 arch/arm/mach-imx/mach-pcm037.c |   50 ++++++++++++++++++++++++++++-----------
 1 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 639a3df..6c19eb1 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -288,12 +288,39 @@ static struct at24_platform_data board_eeprom = {
 	.flags = AT24_FLAG_ADDR16,
 };
 
-static int pcm037_camera_power(struct device *dev, int on)
-{
-	/* disable or enable the camera in X7 or X8 PCM970 connector */
-	gpio_set_value(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), !on);
-	return 0;
-}
+/* Fixed 3.3V regulator to be used by cameras */
+static struct regulator_consumer_supply vcc_cam_consumers[] = {
+	REGULATOR_SUPPLY("vcc", "soc-camera-pdrv.0"),
+};
+
+static struct regulator_init_data vcc_cam_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(vcc_cam_consumers),
+	.consumer_supplies      = vcc_cam_consumers,
+};
+
+static struct fixed_voltage_config vcc_cam_info = {
+	.supply_name = "Camera Vcc",
+	.microvolts = 2800000,
+	.gpio = IOMUX_TO_GPIO(MX31_PIN_CSI_D5),
+	.init_data = &vcc_cam_init_data,
+};
+
+static struct platform_device vcc_cam = {
+	.name = "reg-fixed-voltage",
+	.id   = 1,
+	.dev  = {
+		.platform_data = &vcc_cam_info,
+	},
+};
+
+static struct regulator_bulk_data cam_supply[] = {
+	{
+		.supply = "vcc",
+	},
+};
 
 static struct i2c_board_info pcm037_i2c_camera[] = {
 	{
@@ -311,7 +338,8 @@ static struct soc_camera_link iclink_mt9v022 = {
 
 static struct soc_camera_link iclink_mt9t031 = {
 	.bus_id		= 0,		/* Must match with the camera ID */
-	.power		= pcm037_camera_power,
+	.num_regulators	= ARRAY_SIZE(cam_supply),
+	.regulators	= cam_supply,
 	.board_info	= &pcm037_i2c_camera[0],
 	.i2c_adapter_id	= 2,
 };
@@ -436,6 +464,7 @@ err:
 static struct platform_device *devices[] __initdata = {
 	&pcm037_flash,
 	&pcm037_sram_device,
+	&vcc_cam,
 	&pcm037_mt9t031,
 	&pcm037_mt9v022,
 };
@@ -647,13 +676,6 @@ static void __init pcm037_init(void)
 	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	/* CSI */
-	/* Camera power: default - off */
-	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), "mt9t031-power");
-	if (!ret)
-		gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), 1);
-	else
-		iclink_mt9t031.power = NULL;
-
 	pcm037_init_camera();
 
 	pcm970_sja1000_resources[1].start =
-- 
1.7.2.5
