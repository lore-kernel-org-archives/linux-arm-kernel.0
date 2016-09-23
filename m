From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 23 Sep 2016 22:30:52 +0200
Subject: [PATCH 1/3] ARM: pxa: mioa701: use the new pxa_camera platform_data
Message-ID: <1474662654-23263-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa_camera has transitioned from a soc_camera driver to a standalone
v4l2 driver. Amend the device declaration accordingly.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/mioa701.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 38a96a193dc4..8a5d0491e73c 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -57,7 +57,6 @@
 #include <linux/platform_data/media/camera-pxa.h>
 #include <mach/audio.h>
 #include <mach/smemc.h>
-#include <media/soc_camera.h>
 
 #include "mioa701.h"
 
@@ -627,6 +626,8 @@ struct pxacamera_platform_data mioa701_pxacamera_platform_data = {
 	.flags  = PXA_CAMERA_MASTER | PXA_CAMERA_DATAWIDTH_8 |
 		PXA_CAMERA_PCLK_EN | PXA_CAMERA_MCLK_EN,
 	.mclk_10khz = 5000,
+	.sensor_i2c_adapter_id = 0,
+	.sensor_i2c_address = 0x5d,
 };
 
 static struct i2c_board_info __initdata mioa701_pi2c_devices[] = {
@@ -643,12 +644,6 @@ static struct i2c_board_info mioa701_i2c_devices[] = {
 	},
 };
 
-static struct soc_camera_link iclink = {
-	.bus_id		= 0, /* Match id in pxa27x_device_camera in device.c */
-	.board_info	= &mioa701_i2c_devices[0],
-	.i2c_adapter_id	= 0,
-};
-
 struct i2c_pxa_platform_data i2c_pdata = {
 	.fast_mode = 1,
 };
@@ -684,7 +679,6 @@ MIO_SIMPLE_DEV(mioa701_sound,	  "mioa701-wm9713", NULL)
 MIO_SIMPLE_DEV(mioa701_board,	  "mioa701-board",  NULL)
 MIO_SIMPLE_DEV(wm9713_acodec,	  "wm9713-codec",   NULL);
 MIO_SIMPLE_DEV(gpio_vbus,	  "gpio-vbus",      &gpio_vbus_data);
-MIO_SIMPLE_DEV(mioa701_camera,	  "soc-camera-pdrv",&iclink);
 
 static struct platform_device *devices[] __initdata = {
 	&mioa701_gpio_keys,
@@ -696,7 +690,6 @@ static struct platform_device *devices[] __initdata = {
 	&power_dev,
 	&docg3,
 	&gpio_vbus,
-	&mioa701_camera,
 	&mioa701_board,
 };
 
@@ -761,6 +754,7 @@ static void __init mioa701_machine_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	gsm_init();
 
+	i2c_register_board_info(0, ARRAY_AND_SIZE(mioa701_i2c_devices));
 	i2c_register_board_info(1, ARRAY_AND_SIZE(mioa701_pi2c_devices));
 	pxa_set_i2c_info(&i2c_pdata);
 	pxa27x_set_i2c_power_info(NULL);
@@ -769,6 +763,7 @@ static void __init mioa701_machine_init(void)
 	regulator_register_always_on(0, "fixed-5.0V", fixed_5v0_consumers,
 				     ARRAY_SIZE(fixed_5v0_consumers),
 				     5000000);
+	regulator_has_full_constraints();
 }
 
 static void mioa701_machine_exit(void)
-- 
2.1.4
