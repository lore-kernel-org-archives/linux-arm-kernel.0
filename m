From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 23 Sep 2016 22:30:53 +0200
Subject: [PATCH 2/3] ARM: pxa: ezx: use the new pxa_camera platform_data
In-Reply-To: <1474662654-23263-1-git-send-email-robert.jarzmik@free.fr>
References: <1474662654-23263-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1474662654-23263-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa_camera has transitioned from a soc_camera driver to a standalone
v4l2 driver. Amend the device declaration accordingly.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/ezx.c | 176 ++++++++++++++++++++----------------------------
 1 file changed, 72 insertions(+), 104 deletions(-)

diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 34ad0a89d4a9..0b8300e6fca3 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -17,14 +17,14 @@
 #include <linux/delay.h>
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds-lp3944.h>
 #include <linux/i2c/pxa-i2c.h>
 
-#include <media/soc_camera.h>
-
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -723,6 +723,42 @@ static struct platform_device a780_gpio_keys = {
 };
 
 /* camera */
+static struct regulator_consumer_supply camera_dummy_supplies[] = {
+	REGULATOR_SUPPLY("vdd", "0-005d"),
+};
+
+static struct regulator_init_data camera_dummy_initdata = {
+	.consumer_supplies = camera_dummy_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(camera_dummy_supplies),
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct fixed_voltage_config camera_dummy_config = {
+	.supply_name		= "camera_vdd",
+	.microvolts		= 2800000,
+	.gpio			= GPIO50_nCAM_EN,
+	.enable_high		= 0,
+	.init_data		= &camera_dummy_initdata,
+};
+
+static struct platform_device camera_supply_dummy_device = {
+	.name	= "reg-fixed-voltage",
+	.id	= 1,
+	.dev	= {
+		.platform_data = &camera_dummy_config,
+	},
+};
+static int a780_camera_reset(struct device *dev)
+{
+	gpio_set_value(GPIO19_GEN1_CAM_RST, 0);
+	msleep(10);
+	gpio_set_value(GPIO19_GEN1_CAM_RST, 1);
+
+	return 0;
+}
+
 static int a780_camera_init(void)
 {
 	int err;
@@ -731,73 +767,36 @@ static int a780_camera_init(void)
 	 * GPIO50_nCAM_EN is active low
 	 * GPIO19_GEN1_CAM_RST is active on rising edge
 	 */
-	err = gpio_request(GPIO50_nCAM_EN, "nCAM_EN");
-	if (err) {
-		pr_err("%s: Failed to request nCAM_EN\n", __func__);
-		goto fail;
-	}
-
 	err = gpio_request(GPIO19_GEN1_CAM_RST, "CAM_RST");
 	if (err) {
 		pr_err("%s: Failed to request CAM_RST\n", __func__);
-		goto fail_gpio_cam_rst;
+		return err;
 	}
 
-	gpio_direction_output(GPIO50_nCAM_EN, 1);
 	gpio_direction_output(GPIO19_GEN1_CAM_RST, 0);
-
-	return 0;
-
-fail_gpio_cam_rst:
-	gpio_free(GPIO50_nCAM_EN);
-fail:
-	return err;
-}
-
-static int a780_camera_power(struct device *dev, int on)
-{
-	gpio_set_value(GPIO50_nCAM_EN, !on);
-	return 0;
-}
-
-static int a780_camera_reset(struct device *dev)
-{
-	gpio_set_value(GPIO19_GEN1_CAM_RST, 0);
-	msleep(10);
-	gpio_set_value(GPIO19_GEN1_CAM_RST, 1);
+	a780_camera_reset(NULL);
 
 	return 0;
 }
 
 struct pxacamera_platform_data a780_pxacamera_platform_data = {
 	.flags  = PXA_CAMERA_MASTER | PXA_CAMERA_DATAWIDTH_8 |
-		PXA_CAMERA_PCLK_EN | PXA_CAMERA_MCLK_EN,
+		PXA_CAMERA_PCLK_EN | PXA_CAMERA_MCLK_EN |
+		PXA_CAMERA_PCP,
 	.mclk_10khz = 5000,
+	.sensor_i2c_adapter_id = 0,
+	.sensor_i2c_address = 0x5d,
 };
 
-static struct i2c_board_info a780_camera_i2c_board_info = {
-	I2C_BOARD_INFO("mt9m111", 0x5d),
-};
-
-static struct soc_camera_link a780_iclink = {
-	.bus_id         = 0,
-	.flags          = SOCAM_SENSOR_INVERT_PCLK,
-	.i2c_adapter_id = 0,
-	.board_info     = &a780_camera_i2c_board_info,
-	.power          = a780_camera_power,
-	.reset          = a780_camera_reset,
-};
-
-static struct platform_device a780_camera = {
-	.name   = "soc-camera-pdrv",
-	.id     = 0,
-	.dev    = {
-		.platform_data = &a780_iclink,
+static struct i2c_board_info a780_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("mt9m111", 0x5d),
 	},
 };
 
 static struct platform_device *a780_devices[] __initdata = {
 	&a780_gpio_keys,
+	&camera_supply_dummy_device,
 };
 
 static void __init a780_init(void)
@@ -811,19 +810,19 @@ static void __init a780_init(void)
 	pxa_set_stuart_info(NULL);
 
 	pxa_set_i2c_info(NULL);
+	i2c_register_board_info(0, ARRAY_AND_SIZE(a780_i2c_board_info));
 
 	pxa_set_fb_info(NULL, &ezx_fb_info_1);
 
 	pxa_set_keypad_info(&a780_keypad_platform_data);
 
-	if (a780_camera_init() == 0) {
+	if (a780_camera_init() == 0)
 		pxa_set_camera_info(&a780_pxacamera_platform_data);
-		platform_device_register(&a780_camera);
-	}
 
 	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(a780_devices));
+	regulator_has_full_constraints();
 }
 
 MACHINE_START(EZX_A780, "Motorola EZX A780")
@@ -1001,6 +1000,15 @@ static struct platform_device a910_gpio_keys = {
 };
 
 /* camera */
+static int a910_camera_reset(struct device *dev)
+{
+	gpio_set_value(GPIO28_GEN2_CAM_RST, 0);
+	msleep(10);
+	gpio_set_value(GPIO28_GEN2_CAM_RST, 1);
+
+	return 0;
+}
+
 static int a910_camera_init(void)
 {
 	int err;
@@ -1009,68 +1017,25 @@ static int a910_camera_init(void)
 	 * GPIO50_nCAM_EN is active low
 	 * GPIO28_GEN2_CAM_RST is active on rising edge
 	 */
-	err = gpio_request(GPIO50_nCAM_EN, "nCAM_EN");
-	if (err) {
-		pr_err("%s: Failed to request nCAM_EN\n", __func__);
-		goto fail;
-	}
-
 	err = gpio_request(GPIO28_GEN2_CAM_RST, "CAM_RST");
 	if (err) {
 		pr_err("%s: Failed to request CAM_RST\n", __func__);
-		goto fail_gpio_cam_rst;
+		return err;
 	}
 
-	gpio_direction_output(GPIO50_nCAM_EN, 1);
 	gpio_direction_output(GPIO28_GEN2_CAM_RST, 0);
-
-	return 0;
-
-fail_gpio_cam_rst:
-	gpio_free(GPIO50_nCAM_EN);
-fail:
-	return err;
-}
-
-static int a910_camera_power(struct device *dev, int on)
-{
-	gpio_set_value(GPIO50_nCAM_EN, !on);
-	return 0;
-}
-
-static int a910_camera_reset(struct device *dev)
-{
-	gpio_set_value(GPIO28_GEN2_CAM_RST, 0);
-	msleep(10);
-	gpio_set_value(GPIO28_GEN2_CAM_RST, 1);
+	a910_camera_reset(NULL);
 
 	return 0;
 }
 
 struct pxacamera_platform_data a910_pxacamera_platform_data = {
 	.flags  = PXA_CAMERA_MASTER | PXA_CAMERA_DATAWIDTH_8 |
-		PXA_CAMERA_PCLK_EN | PXA_CAMERA_MCLK_EN,
+		PXA_CAMERA_PCLK_EN | PXA_CAMERA_MCLK_EN |
+		PXA_CAMERA_PCP,
 	.mclk_10khz = 5000,
-};
-
-static struct i2c_board_info a910_camera_i2c_board_info = {
-	I2C_BOARD_INFO("mt9m111", 0x5d),
-};
-
-static struct soc_camera_link a910_iclink = {
-	.bus_id         = 0,
-	.i2c_adapter_id = 0,
-	.board_info     = &a910_camera_i2c_board_info,
-	.power          = a910_camera_power,
-	.reset          = a910_camera_reset,
-};
-
-static struct platform_device a910_camera = {
-	.name   = "soc-camera-pdrv",
-	.id     = 0,
-	.dev    = {
-		.platform_data = &a910_iclink,
-	},
+	.sensor_i2c_adapter_id = 0,
+	.sensor_i2c_address = 0x5d,
 };
 
 /* leds-lp3944 */
@@ -1122,10 +1087,14 @@ static struct i2c_board_info __initdata a910_i2c_board_info[] = {
 		I2C_BOARD_INFO("lp3944", 0x60),
 		.platform_data = &a910_lp3944_leds,
 	},
+	{
+		I2C_BOARD_INFO("mt9m111", 0x5d),
+	},
 };
 
 static struct platform_device *a910_devices[] __initdata = {
 	&a910_gpio_keys,
+	&camera_supply_dummy_device,
 };
 
 static void __init a910_init(void)
@@ -1145,14 +1114,13 @@ static void __init a910_init(void)
 
 	pxa_set_keypad_info(&a910_keypad_platform_data);
 
-	if (a910_camera_init() == 0) {
+	if (a910_camera_init() == 0)
 		pxa_set_camera_info(&a910_pxacamera_platform_data);
-		platform_device_register(&a910_camera);
-	}
 
 	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(a910_devices));
+	regulator_has_full_constraints();
 }
 
 MACHINE_START(EZX_A910, "Motorola EZX A910")
-- 
2.1.4
