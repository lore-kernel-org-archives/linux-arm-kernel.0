From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 15 Jan 2011 02:17:57 +0100
Subject: [PATCH v2] ARM: pxa: PalmZ72: Add OV9640 camera support
Message-ID: <1295054277-7879-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework of patch from 2009:
PalmZ72: Add support for OV9640 camera sensor

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
v2: Use gpio_request_array()/gpio_free_array() array

 arch/arm/mach-pxa/include/mach/palmz72.h |    5 +
 arch/arm/mach-pxa/palmz72.c              |  127 ++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/palmz72.h b/arch/arm/mach-pxa/include/mach/palmz72.h
index 2bbcf70..0d4700a 100644
--- a/arch/arm/mach-pxa/include/mach/palmz72.h
+++ b/arch/arm/mach-pxa/include/mach/palmz72.h
@@ -44,6 +44,11 @@
 #define GPIO_NR_PALMZ72_BT_POWER		17
 #define GPIO_NR_PALMZ72_BT_RESET		83
 
+/* Camera */
+#define GPIO_NR_PALMZ72_CAM_PWDN		56
+#define GPIO_NR_PALMZ72_CAM_RESET		57
+#define GPIO_NR_PALMZ72_CAM_POWER		91
+
 /** Initial values **/
 
 /* Battery */
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 7bf4017..27a8e6d 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -30,6 +30,7 @@
 #include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
+#include <linux/i2c-gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -47,6 +48,9 @@
 #include <mach/palm27x.h>
 
 #include <mach/pm.h>
+#include <mach/camera.h>
+
+#include <media/soc_camera.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -103,6 +107,28 @@ static unsigned long palmz72_pin_config[] __initdata = {
 	GPIO22_GPIO,	/* LCD border color */
 	GPIO96_GPIO,	/* lcd power */
 
+	/* PXA Camera */
+	GPIO81_CIF_DD_0,
+	GPIO48_CIF_DD_5,
+	GPIO50_CIF_DD_3,
+	GPIO51_CIF_DD_2,
+	GPIO52_CIF_DD_4,
+	GPIO53_CIF_MCLK,
+	GPIO54_CIF_PCLK,
+	GPIO55_CIF_DD_1,
+	GPIO84_CIF_FV,
+	GPIO85_CIF_LV,
+	GPIO93_CIF_DD_6,
+	GPIO108_CIF_DD_7,
+
+	GPIO56_GPIO,	/* OV9640 Powerdown */
+	GPIO57_GPIO,	/* OV9640 Reset */
+	GPIO91_GPIO,	/* OV9640 Power */
+
+	/* I2C */
+	GPIO117_GPIO,	/* I2C_SCL */
+	GPIO118_GPIO,	/* I2C_SDA */
+
 	/* Misc. */
 	GPIO0_GPIO	| WAKEUP_ON_LEVEL_HIGH,	/* power detect */
 	GPIO88_GPIO,				/* green led */
@@ -254,6 +280,106 @@ device_initcall(palmz72_pm_init);
 #endif
 
 /******************************************************************************
+ * SoC Camera
+ ******************************************************************************/
+#if defined(CONFIG_SOC_CAMERA_OV9640) || \
+	defined(CONFIG_SOC_CAMERA_OV9640_MODULE)
+static struct pxacamera_platform_data palmz72_pxacamera_platform_data = {
+	.flags		= PXA_CAMERA_MASTER | PXA_CAMERA_DATAWIDTH_8 |
+			PXA_CAMERA_PCLK_EN | PXA_CAMERA_MCLK_EN,
+	.mclk_10khz	= 2600,
+};
+
+/* Board I2C devices. */
+static struct i2c_board_info palmz72_i2c_device[] = {
+	{
+		I2C_BOARD_INFO("ov9640", 0x30),
+	}
+};
+
+static int palmz72_camera_power(struct device *dev, int power)
+{
+	gpio_set_value(GPIO_NR_PALMZ72_CAM_PWDN, !power);
+	mdelay(50);
+	return 0;
+}
+
+static int palmz72_camera_reset(struct device *dev)
+{
+	gpio_set_value(GPIO_NR_PALMZ72_CAM_RESET, 1);
+	mdelay(50);
+	gpio_set_value(GPIO_NR_PALMZ72_CAM_RESET, 0);
+	mdelay(50);
+	return 0;
+}
+
+static struct soc_camera_link palmz72_iclink = {
+	.bus_id		= 0, /* Match id in pxa27x_device_camera in device.c */
+	.board_info	= &palmz72_i2c_device[0],
+	.i2c_adapter_id	= 0,
+	.module_name	= "ov96xx",
+	.power		= &palmz72_camera_power,
+	.reset		= &palmz72_camera_reset,
+	.flags		= SOCAM_DATAWIDTH_8,
+};
+
+static struct i2c_gpio_platform_data palmz72_i2c_bus_data = {
+	.sda_pin	= 118,
+	.scl_pin	= 117,
+	.udelay		= 10,
+	.timeout	= 100,
+};
+
+static struct platform_device palmz72_i2c_bus_device = {
+	.name		= "i2c-gpio",
+	.id		= 0, /* we use this as a replacement for i2c-pxa */
+	.dev		= {
+		.platform_data	= &palmz72_i2c_bus_data,
+	}
+};
+
+static struct platform_device palmz72_camera = {
+	.name	= "soc-camera-pdrv",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &palmz72_iclink,
+	},
+};
+
+/* Here we request the camera GPIOs and configure them. We power up the camera
+ * module, deassert the reset pin, but put it into powerdown (low to no power
+ * consumption) mode. This allows us to later bring the module up fast. */
+static struct gpio palmz72_camera_gpios[] = {
+	{ GPIO_NR_PALMZ72_CAM_POWER,	GPIOF_INIT_HIGH,"Camera DVDD" },
+	{ GPIO_NR_PALMZ72_CAM_RESET,	GPIOF_INIT_LOW,	"Camera RESET" },
+	{ GPIO_NR_PALMZ72_CAM_PWDN,	GPIOF_INIT_LOW,	"Camera PWDN" },
+};
+
+static inline void __init palmz72_cam_gpio_init(void)
+{
+	int ret;
+
+	ret = gpio_request_array(ARRAY_AND_SIZE(palmz72_camera_gpios));
+	if (!ret)
+		gpio_free_array(ARRAY_AND_SIZE(palmz72_camera_gpios));
+	else
+		printk(KERN_ERR "Camera GPIO init failed!\n");
+
+	return;
+}
+
+static void __init palmz72_camera_init(void)
+{
+	palmz72_cam_gpio_init();
+	pxa_set_camera_info(&palmz72_pxacamera_platform_data);
+	platform_device_register(&palmz72_i2c_bus_device);
+	platform_device_register(&palmz72_camera);
+}
+#else
+static inline void palmz72_camera_init(void) {}
+#endif
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void __init palmz72_init(void)
@@ -276,6 +402,7 @@ static void __init palmz72_init(void)
 	palm27x_pmic_init();
 	palmz72_kpc_init();
 	palmz72_leds_init();
+	palmz72_camera_init();
 }
 
 MACHINE_START(PALMZ72, "Palm Zire72")
-- 
1.7.2.3
