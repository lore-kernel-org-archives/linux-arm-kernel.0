From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 29 Oct 2016 21:39:48 +0200
Subject: [PATCH v2] ARM: pxa: em-x270: use the new pxa_camera platform_data
Message-ID: <1477769988-19945-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa_camera has transitioned from a soc_camera driver to a standalone
v4l2 driver. Amend the device declaration accordingly.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: add regulator platform_device and missing include
---
 arch/arm/mach-pxa/em-x270.c | 89 +++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 03354c21e1f2..811a7317f3ea 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/mfd/da903x.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/tdo24m.h>
 #include <linux/spi/libertas_spi.h>
@@ -34,8 +35,6 @@
 #include <linux/i2c/pxa-i2c.h>
 #include <linux/regulator/userspace-consumer.h>
 
-#include <media/soc_camera.h>
-
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -958,8 +957,6 @@ static inline void em_x270_init_gpio_keys(void) {}
 
 /* Quick Capture Interface and sensor setup */
 #if defined(CONFIG_VIDEO_PXA27x) || defined(CONFIG_VIDEO_PXA27x_MODULE)
-static struct regulator *em_x270_camera_ldo;
-
 static int em_x270_sensor_init(void)
 {
 	int ret;
@@ -969,81 +966,53 @@ static int em_x270_sensor_init(void)
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
+	.gpio			= -1,
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
+	platform_device_register(&camera_supply_dummy_device);
 }
 #else
 static inline void em_x270_init_camera(void) {}
-- 
2.1.4
