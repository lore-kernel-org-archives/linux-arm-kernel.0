From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 28 Jul 2010 12:04:44 +0900
Subject: [PATCH 1/2] ARM: S5PV210: Add audio support to Aquila
Message-ID: <4C4F9E4C.7000001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch the I2C board information for the WM8994 used in the Aquila
as audio codec and adds the I2C/I2S platform drivers. Additionlly, to
control power consumption have registerd the voltage consumer of WM8994
to the regulator framework. I initialize gpio settting relevant to
operation of audio codec. I explain following comment concering gpio
setting:
- CODEC_XTAL_EN : This gpio enables that the main clock is provided
  to operate audio codec.
- MICBIAS_EN : This gpio enable the microphone to input analog
- ADC_EN : This gpio enable the ADC device which is used to detect
  the kind of jack. (SND_JACK_HEADPHONE/HEADSET/MECHANICAL/AVOUT)
  According to the kind of jack, an electric current is changed.

Signed-off-by : Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by : Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by : Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/mach-aquila.c |  177 +++++++++++++++++++++++++++++++++++
 1 files changed, 177 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index f0f960f..d027f9d 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -17,9 +17,11 @@
 #include <linux/i2c-gpio.h>
 #include <linux/i2c/mcs.h>
 #include <linux/mfd/max8998.h>
+#include <linux/mfd/wm8994/pdata.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/regulator/fixed.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -397,6 +399,120 @@ static struct max8998_platform_data aquila_max8998_pdata = {
 };
 #endif
 
+static struct regulator_consumer_supply wm8994_fixed_voltage0_supplies[] = {
+	{
+		.dev_name	= "5-001a",
+		.supply		= "DBVDD",
+	}, {
+		.dev_name	= "5-001a",
+		.supply		= "AVDD2",
+	}, {
+		.dev_name	= "5-001a",
+		.supply		= "CPVDD",
+	},
+
+};
+
+static struct regulator_consumer_supply wm8994_fixed_voltage1_supplies[] = {
+	{
+		.dev_name	= "5-001a",
+		.supply		= "SPKVDD1",
+	}, {
+		.dev_name	= "5-001a",
+		.supply		= "SPKVDD2",
+	},
+};
+
+static struct regulator_init_data wm8994_fixed_voltage0_init_data = {
+	.constraints = {
+		.always_on = 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(wm8994_fixed_voltage0_supplies),
+	.consumer_supplies	= wm8994_fixed_voltage0_supplies,
+};
+
+static struct regulator_init_data wm8994_fixed_voltage1_init_data = {
+	.constraints = {
+		.always_on = 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(wm8994_fixed_voltage1_supplies),
+	.consumer_supplies	= wm8994_fixed_voltage1_supplies,
+};
+
+static struct fixed_voltage_config wm8994_fixed_voltage0_config = {
+	.supply_name	= "VCC_1.8V_PDA",
+	.microvolts	= 1800000,
+	.gpio		= -EINVAL,
+	.init_data	= &wm8994_fixed_voltage0_init_data,
+};
+
+static struct fixed_voltage_config wm8994_fixed_voltage1_config = {
+	.supply_name	= "V_BAT",
+	.microvolts	= 3700000,
+	.gpio		= -EINVAL,
+	.init_data	= &wm8994_fixed_voltage1_init_data,
+};
+
+static struct platform_device wm8994_fixed_voltage0 = {
+	.name		= "reg-fixed-voltage",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &wm8994_fixed_voltage0_config,
+	},
+};
+
+static struct platform_device wm8994_fixed_voltage1 = {
+	.name		= "reg-fixed-voltage",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &wm8994_fixed_voltage1_config,
+	},
+};
+
+static struct regulator_consumer_supply wm8994_avdd1_supply = {
+	.dev_name	= "5-001a",
+	.supply		= "AVDD1",
+};
+
+static struct regulator_consumer_supply wm8994_dcvdd_supply = {
+	.dev_name	= "5-001a",
+	.supply		= "DCVDD",
+};
+
+static struct regulator_init_data wm8994_ldo1_data = {
+	.constraints	= {
+		.name		= "AVDD1_3.0V",
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &wm8994_avdd1_supply,
+};
+
+static struct regulator_init_data wm8994_ldo2_data = {
+	.constraints	= {
+		.name		= "DCVDD_1.0V",
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &wm8994_dcvdd_supply,
+};
+
+static struct wm8994_pdata wm8994_platform_data = {
+	/* configure gpio1 function: 0x0001(Logic level input/output) */
+	.gpio_defaults[0] = 0x0001,
+	/* configure gpio3/4/5/7 function for AIF2 voice */
+	.gpio_defaults[2] = 0x8100,
+	.gpio_defaults[3] = 0x8100,
+	.gpio_defaults[4] = 0x8100,
+	.gpio_defaults[6] = 0x0100,
+	/* configure gpio8/9/10/11 function for AIF3 BT */
+	.gpio_defaults[7] = 0x8100,
+	.gpio_defaults[8] = 0x0100,
+	.gpio_defaults[9] = 0x0100,
+	.gpio_defaults[10] = 0x0100,
+	.ldo[0]	= { S5PV210_MP03(6), NULL, &wm8994_ldo1_data },	/* XM0FRNB_2 */
+	.ldo[1]	= { 0, NULL, &wm8994_ldo2_data },
+};
+
 /* GPIO I2C PMIC */
 #define AP_I2C_GPIO_PMIC_BUS_4	4
 static struct i2c_gpio_platform_data aquila_i2c_gpio_pmic_data = {
@@ -422,6 +538,58 @@ static struct i2c_board_info i2c_gpio_pmic_devs[] __initdata = {
 #endif
 };
 
+/* GPIO I2C AP 1.8V */
+#define AP_I2C_GPIO_BUS_5	5
+static struct i2c_gpio_platform_data i2c_gpio5_data = {
+	.sda_pin	= S5PV210_MP05(3),	/* XM0ADDR_11 */
+	.scl_pin	= S5PV210_MP05(2),	/* XM0ADDR_10 */
+};
+
+static struct platform_device i2c_gpio5 = {
+	.name		= "i2c-gpio",
+	.id		= AP_I2C_GPIO_BUS_5,
+	.dev		= {
+		.platform_data	= &i2c_gpio5_data,
+	},
+};
+
+static struct i2c_board_info i2c_gpio5_devs[] __initdata = {
+	{
+		/* CS/ADDR = low 0x34 (FYI: high = 0x36) */
+		I2C_BOARD_INFO("wm8994", 0x34 >> 1),
+		.platform_data	= &wm8994_platform_data,
+	},
+};
+
+static void __init aquila_sound_init(void)
+{
+	unsigned int gpio;
+
+	/* CODEC_XTAL_EN */
+	gpio = S5PV210_GPH3(2);		/* XEINT_26 */
+	gpio_request(gpio, "CODEC_XTAL_EN");
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_OUTPUT);
+	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	gpio_direction_output(gpio, 1);
+
+	/* CLKOUT[9:8] set to 0x3(XUSBXTI) of 0xE010E000(OTHERS)
+	 * for 24MHZ
+	 */
+	writel(readl(S5P_OTHERS) | (0x3 << 8), S5P_OTHERS);
+
+	/* MICBIAS_EN */
+	gpio = S5PV210_GPJ4(2);			/* XMSMRN */
+	gpio_request(gpio, "MICBIAS_EN");
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_OUTPUT);
+	gpio_direction_output(gpio, 1);
+
+	/* ADC_EN */
+	gpio = S5PV210_GPJ3(2);
+	gpio_request(gpio, "ADC_EN");
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_OUTPUT);
+	gpio_direction_output(gpio, 1);
+}
+
 /* PMIC Power button */
 static struct gpio_keys_button aquila_gpio_keys_table[] = {
 	{
@@ -523,6 +691,10 @@ static struct platform_device *aquila_devices[] __initdata = {
 	&s5pc110_device_onenand,
 	&samsung_device_keypad,
 	&i2c_gpio10,
+	&wm8994_fixed_voltage0,
+	&wm8994_fixed_voltage1,
+	&s5pv210_device_iis0,
+	&i2c_gpio5,
 };
 
 static void __init aquila_map_io(void)
@@ -539,6 +711,11 @@ static void __init aquila_machine_init(void)
 	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4, i2c_gpio_pmic_devs,
 			ARRAY_SIZE(i2c_gpio_pmic_devs));
 
+	/* SOUND */
+	i2c_register_board_info(AP_I2C_GPIO_BUS_5, i2c_gpio5_devs,
+			ARRAY_SIZE(i2c_gpio5_devs));
+	aquila_sound_init();
+
 	/* FB */
 	s3c_fb_set_platdata(&aquila_lcd_pdata);
 
-- 
1.6.3.3
