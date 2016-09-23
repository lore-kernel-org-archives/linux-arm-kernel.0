From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 23 Sep 2016 22:30:54 +0200
Subject: [PATCH 3/3] ARM: pxa: em-x270: use the new pxa_camera platform_data
In-Reply-To: <1474662654-23263-1-git-send-email-robert.jarzmik@free.fr>
References: <1474662654-23263-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1474662654-23263-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa_camera has transitioned from a soc_camera driver to a standalone
v4l2 driver. Amend the device declaration accordingly.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/em-x270.c | 85 ++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 03354c21e1f2..2d7762ab1d70 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -34,8 +34,6 @@
 #include <linux/i2c/pxa-i2c.h>
 #include <linux/regulator/userspace-consumer.h>
 
-#include <media/soc_camera.h>
-
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -969,81 +967,52 @@ static int em_x270_sensor_init(void)
 		return ret;
 
 	gpio_direction_output(cam_reset, 0);
-
-	em_x270_camera_ldo = regulator_get(NULL, "vcc cam");
-	if (em_x270_camera_ldo == NULL) {
-		gpio_free(cam_reset);
-		return -ENODEV;
-	}
-
-	ret = regulator_enable(em_x270_camera_ldo);
-	if (ret) {
-		regulator_put(em_x270_camera_ldo);
-		gpio_free(cam_reset);
-		return ret;
-	}
-
 	gpio_set_value(cam_reset, 1);
 
 	return 0;
 }
 
-struct pxacamera_platform_data em_x270_camera_platform_data = {
-	.flags  = PXA_CAMERA_MASTER | PXA_CAMERA_DATAWIDTH_8 |
-		PXA_CAMERA_PCLK_EN | PXA_CAMERA_MCLK_EN,
-	.mclk_10khz = 2600,
+static struct regulator_consumer_supply camera_dummy_supplies[] = {
+	REGULATOR_SUPPLY("vdd", "0-005d"),
 };
 
-static int em_x270_sensor_power(struct device *dev, int on)
-{
-	int ret;
-	int is_on = regulator_is_enabled(em_x270_camera_ldo);
-
-	if (on == is_on)
-		return 0;
-
-	gpio_set_value(cam_reset, !on);
-
-	if (on)
-		ret = regulator_enable(em_x270_camera_ldo);
-	else
-		ret = regulator_disable(em_x270_camera_ldo);
-
-	if (ret)
-		return ret;
-
-	gpio_set_value(cam_reset, on);
-
-	return 0;
-}
-
-static struct i2c_board_info em_x270_i2c_cam_info[] = {
-	{
-		I2C_BOARD_INFO("mt9m111", 0x48),
+static struct regulator_init_data camera_dummy_initdata = {
+	.consumer_supplies = camera_dummy_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(camera_dummy_supplies),
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 	},
 };
 
-static struct soc_camera_link iclink = {
-	.bus_id		= 0,
-	.power		= em_x270_sensor_power,
-	.board_info	= &em_x270_i2c_cam_info[0],
-	.i2c_adapter_id	= 0,
+static struct fixed_voltage_config camera_dummy_config = {
+	.supply_name		= "camera_vdd",
+	.input_supply		= "vcc cam",
+	.microvolts		= 2800000,
+	.gpio			= GPIO56_MT9M111_nOE,
+	.enable_high		= 0,
+	.init_data		= &camera_dummy_initdata,
 };
 
-static struct platform_device em_x270_camera = {
-	.name	= "soc-camera-pdrv",
-	.id	= -1,
+static struct platform_device camera_supply_dummy_device = {
+	.name	= "reg-fixed-voltage",
+	.id	= 1,
 	.dev	= {
-		.platform_data = &iclink,
+		.platform_data = &camera_dummy_config,
 	},
 };
 
+struct pxacamera_platform_data em_x270_camera_platform_data = {
+	.flags  = PXA_CAMERA_MASTER | PXA_CAMERA_DATAWIDTH_8 |
+		PXA_CAMERA_PCLK_EN | PXA_CAMERA_MCLK_EN,
+	.mclk_10khz = 2600,
+	.sensor_i2c_adapter_id = 0,
+	.sensor_i2c_address = 0x5d,
+};
+
 static void  __init em_x270_init_camera(void)
 {
-	if (em_x270_sensor_init() == 0) {
+	if (em_x270_sensor_init() == 0)
 		pxa_set_camera_info(&em_x270_camera_platform_data);
-		platform_device_register(&em_x270_camera);
-	}
 }
 #else
 static inline void em_x270_init_camera(void) {}
-- 
2.1.4
