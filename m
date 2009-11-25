From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:29 +0100
Subject: [PATCH 15/17] ARM: pxa/raumfeld: add support for I2C controlled
	devices
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-16-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/raumfeld.c |   75 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 9a234e7..9b1b52c 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -26,10 +26,12 @@
 #include <linux/input.h>
 #include <linux/rotary_encoder.h>
 #include <linux/gpio_keys.h>
+#include <linux/input/eeti_ts.h>
 #include <linux/leds.h>
 #include <linux/w1-gpio.h>
 #include <linux/sched.h>
 #include <linux/pwm_backlight.h>
+#include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
 #include <linux/lis3lv02d.h>
@@ -37,6 +39,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pda_power.h>
 #include <linux/power_supply.h>
+#include <linux/regulator/max8660.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -49,6 +52,7 @@
 #include <mach/ohci.h>
 #include <mach/pxafb.h>
 #include <mach/mmc.h>
+#include <plat/i2c.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -116,6 +120,10 @@ static mfp_cfg_t raumfeld_pin_config[] __initdata = {
 	GPIO0_2_USBH_PEN,
 	GPIO1_2_USBH_PWR,
 
+	/* I2C */
+	GPIO21_I2C_SCL | MFP_LPM_FLOAT | MFP_PULL_FLOAT,
+	GPIO22_I2C_SDA | MFP_LPM_FLOAT | MFP_PULL_FLOAT,
+
 	/* SPI */
 	GPIO34_GPIO,	/* SPDIF_CS */
 	GPIO96_GPIO,	/* MCLK_CS */
@@ -778,6 +786,64 @@ static void __init raumfeld_power_init(void)
 		platform_device_register(&raumfeld_power_supply);
 }
 
+/**
+ * Regulator support for vcc_wifi
+ */
+
+static struct regulator_consumer_supply vcc_wifi_supply =
+	REGULATOR_SUPPLY("vcc_wifi", "pxa2xx-mci.0");
+
+static struct regulator_init_data vcc_wifi_init_data = {
+	.constraints = {
+		.min_uV = WIFI_VOLTAGE,
+		.max_uV = WIFI_VOLTAGE,
+		.valid_modes_mask = REGULATOR_MODE_NORMAL,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS |
+				  REGULATOR_CHANGE_VOLTAGE,
+	},
+	.consumer_supplies = &vcc_wifi_supply,
+	.num_consumer_supplies = 1,
+};
+
+struct max8660_subdev_data max8660_v6_subdev_data = {
+	.id		= MAX8660_V6,
+	.name		= "vcc_wifi",
+	.platform_data	= &vcc_wifi_init_data,
+};
+
+static struct max8660_platform_data max8660_pdata = {
+	.subdevs = &max8660_v6_subdev_data,
+	.num_subdevs = 1,
+};
+
+/**
+ * I2C devices
+ */
+
+static struct i2c_board_info raumfeld_pwri2c_board_info = {
+	.type		= "max8660",
+	.addr		= 0x34,
+	.platform_data	= &max8660_pdata,
+};
+
+static struct i2c_board_info raumfeld_connector_i2c_board_info[] __initdata = {
+	{
+		.type	= "cs4270",
+		.addr	= 0x48,
+	},
+};
+
+static struct eeti_ts_platform_data eeti_ts_pdata = {
+	.irq_active_high = 1,
+};
+
+static struct i2c_board_info raumfeld_controller_i2c_board_info __initdata = {
+	.type	= "eeti_ts",
+	.addr	= 0x0a,
+	.irq	= gpio_to_irq(mfp_to_gpio(GPIO_TOUCH_IRQ)),
+	.platform_data = &eeti_ts_pdata,
+};
+
 static struct platform_device *raumfeld_common_devices[] = {
 	&raumfeld_gpio_keys_device,
 	&raumfeld_led_device,
@@ -813,6 +879,9 @@ static void __init raumfeld_common_init(void)
 	platform_add_devices(ARRAY_AND_SIZE(raumfeld_common_devices));
 	pxa3xx_set_nand_info(&raumfeld_nand_info);
 	pxa_set_mci_info(&raumfeld_mci_platform_data);
+	pxa_set_i2c_info(NULL);
+	pxa3xx_set_i2c_power_info(NULL);
+	i2c_register_board_info(1, &raumfeld_pwri2c_board_info, 1);
 }
 
 static void __init raumfeld_controller_init(void)
@@ -835,6 +904,7 @@ static void __init raumfeld_controller_init(void)
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_controller_pin_config));
 	platform_add_devices(ARRAY_AND_SIZE(raumfeld_controller_devices));
 	spi_register_board_info(ARRAY_AND_SIZE(controller_spi_devices));
+	i2c_register_board_info(0, &raumfeld_controller_i2c_board_info, 1);
 
 	gpio_request(mfp_to_gpio(GPIO_SHUTDOWN_BATT), "battery shutdown");
 	gpio_direction_output(mfp_to_gpio(GPIO_SHUTDOWN_BATT), 0);
@@ -850,6 +920,9 @@ static void __init raumfeld_connector_init(void)
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_ssp1_pin_config));
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_ssp2_pin_config));
 	spi_register_board_info(ARRAY_AND_SIZE(connector_spi_devices));
+	i2c_register_board_info(0,
+			ARRAY_AND_SIZE(raumfeld_connector_i2c_board_info));
+
 	raumfeld_common_init();
 	raumfeld_eth_init();
 
@@ -866,6 +939,8 @@ static void __init raumfeld_speaker_init(void)
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_ssp1_pin_config));
 	platform_add_devices(ARRAY_AND_SIZE(raumfeld_speaker_devices));
 	spi_register_board_info(ARRAY_AND_SIZE(speaker_spi_devices));
+	i2c_register_board_info(0,
+			ARRAY_AND_SIZE(raumfeld_connector_i2c_board_info));
 
 	raumfeld_common_init();
 	raumfeld_eth_init();
-- 
1.6.5.2
