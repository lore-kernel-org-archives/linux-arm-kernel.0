From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 17 Sep 2010 10:30:59 +0900
Subject: [PATCH] ARM: S5PV210: Add audio support to Goni and Aquila board
In-Reply-To: <4C8D8233.2060602@samsung.com>
References: <4C8D8233.2060602@samsung.com>
Message-ID: <4C92C4D3.4010106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben,

Don't you have any comment this patch?
Please give your commont for this patch.

Chanwoo Choi

Chanwoo Choi wrote:
> This patch the I2C board information for the WM8994 used in the Goni/Aquila
> as audio codec and adds the I2C/I2S platform drivers. Additionlly, to
> control power consumption have registerd the voltage consumer of WM8994
> to the regulator framework.
> 
> Additionally, I explain the constraints of the regulator of WM8994 codec.
> All these consumer supply of WM8994 codec connected the regulator(VCC_1.8V)
> on a circuit diagram. "VCC_1.8V" regulator is always enabled, because it is
> used to many devices on Goni/Aquila board. This is required especially
> when there are many devices physically attached to "VCC_1.8V" and some of
> they did not "register" as consumers to "VCC_1.8V". "VCC_1.8V" might be
> turned off by those who are registered while "unregistered" are still active.
> 
> Signed-off-by : Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by : Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by : Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/mach-aquila.c |  170 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-s5pv210/mach-goni.c   |  157 ++++++++++++++++++++++++++++++++
>  2 files changed, 327 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
> index 0dda801..0d61e73 100644
> --- a/arch/arm/mach-s5pv210/mach-aquila.c
> +++ b/arch/arm/mach-s5pv210/mach-aquila.c
> @@ -16,6 +16,8 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c-gpio.h>
>  #include <linux/mfd/max8998.h>
> +#include <linux/mfd/wm8994/pdata.h>
> +#include <linux/regulator/fixed.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/input.h>
>  #include <linux/gpio.h>
> @@ -379,6 +381,120 @@ static struct max8998_platform_data aquila_max8998_pdata = {
>  };
>  #endif
>  
> +static struct regulator_consumer_supply wm8994_fixed_voltage0_supplies[] = {
> +	{
> +		.dev_name	= "5-001a",
> +		.supply		= "DBVDD",
> +	}, {
> +		.dev_name	= "5-001a",
> +		.supply		= "AVDD2",
> +	}, {
> +		.dev_name	= "5-001a",
> +		.supply		= "CPVDD",
> +	},
> +
> +};
> +
> +static struct regulator_consumer_supply wm8994_fixed_voltage1_supplies[] = {
> +	{
> +		.dev_name	= "5-001a",
> +		.supply		= "SPKVDD1",
> +	}, {
> +		.dev_name	= "5-001a",
> +		.supply		= "SPKVDD2",
> +	},
> +};
> +
> +static struct regulator_init_data wm8994_fixed_voltage0_init_data = {
> +	.constraints = {
> +		.always_on = 1,
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(wm8994_fixed_voltage0_supplies),
> +	.consumer_supplies	= wm8994_fixed_voltage0_supplies,
> +};
> +
> +static struct regulator_init_data wm8994_fixed_voltage1_init_data = {
> +	.constraints = {
> +		.always_on = 1,
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(wm8994_fixed_voltage1_supplies),
> +	.consumer_supplies	= wm8994_fixed_voltage1_supplies,
> +};
> +
> +static struct fixed_voltage_config wm8994_fixed_voltage0_config = {
> +	.supply_name	= "VCC_1.8V_PDA",
> +	.microvolts	= 1800000,
> +	.gpio		= -EINVAL,
> +	.init_data	= &wm8994_fixed_voltage0_init_data,
> +};
> +
> +static struct fixed_voltage_config wm8994_fixed_voltage1_config = {
> +	.supply_name	= "V_BAT",
> +	.microvolts	= 3700000,
> +	.gpio		= -EINVAL,
> +	.init_data	= &wm8994_fixed_voltage1_init_data,
> +};
> +
> +static struct platform_device wm8994_fixed_voltage0 = {
> +	.name		= "reg-fixed-voltage",
> +	.id		= 0,
> +	.dev		= {
> +		.platform_data	= &wm8994_fixed_voltage0_config,
> +	},
> +};
> +
> +static struct platform_device wm8994_fixed_voltage1 = {
> +	.name		= "reg-fixed-voltage",
> +	.id		= 1,
> +	.dev		= {
> +		.platform_data	= &wm8994_fixed_voltage1_config,
> +	},
> +};
> +
> +static struct regulator_consumer_supply wm8994_avdd1_supply = {
> +	.dev_name	= "5-001a",
> +	.supply		= "AVDD1",
> +};
> +
> +static struct regulator_consumer_supply wm8994_dcvdd_supply = {
> +	.dev_name	= "5-001a",
> +	.supply		= "DCVDD",
> +};
> +
> +static struct regulator_init_data wm8994_ldo1_data = {
> +	.constraints	= {
> +		.name		= "AVDD1_3.0V",
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	= &wm8994_avdd1_supply,
> +};
> +
> +static struct regulator_init_data wm8994_ldo2_data = {
> +	.constraints	= {
> +		.name		= "DCVDD_1.0V",
> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	= &wm8994_dcvdd_supply,
> +};
> +
> +static struct wm8994_pdata wm8994_platform_data = {
> +	/* configure gpio1 function: 0x0001(Logic level input/output) */
> +	.gpio_defaults[0] = 0x0001,
> +	/* configure gpio3/4/5/7 function for AIF2 voice */
> +	.gpio_defaults[2] = 0x8100,
> +	.gpio_defaults[3] = 0x8100,
> +	.gpio_defaults[4] = 0x8100,
> +	.gpio_defaults[6] = 0x0100,
> +	/* configure gpio8/9/10/11 function for AIF3 BT */
> +	.gpio_defaults[7] = 0x8100,
> +	.gpio_defaults[8] = 0x0100,
> +	.gpio_defaults[9] = 0x0100,
> +	.gpio_defaults[10] = 0x0100,
> +	.ldo[0]	= { S5PV210_MP03(6), NULL, &wm8994_ldo1_data },	/* XM0FRNB_2 */
> +	.ldo[1]	= { 0, NULL, &wm8994_ldo2_data },
> +};
> +
>  /* GPIO I2C PMIC */
>  #define AP_I2C_GPIO_PMIC_BUS_4	4
>  static struct i2c_gpio_platform_data aquila_i2c_gpio_pmic_data = {
> @@ -404,6 +520,29 @@ static struct i2c_board_info i2c_gpio_pmic_devs[] __initdata = {
>  #endif
>  };
>  
> +/* GPIO I2C AP 1.8V */
> +#define AP_I2C_GPIO_BUS_5	5
> +static struct i2c_gpio_platform_data aquila_i2c_gpio5_data = {
> +	.sda_pin	= S5PV210_MP05(3),	/* XM0ADDR_11 */
> +	.scl_pin	= S5PV210_MP05(2),	/* XM0ADDR_10 */
> +};
> +
> +static struct platform_device aquila_i2c_gpio5 = {
> +	.name		= "i2c-gpio",
> +	.id		= AP_I2C_GPIO_BUS_5,
> +	.dev		= {
> +		.platform_data	= &aquila_i2c_gpio5_data,
> +	},
> +};
> +
> +static struct i2c_board_info i2c_gpio5_devs[] __initdata = {
> +	{
> +		/* CS/ADDR = low 0x34 (FYI: high = 0x36) */
> +		I2C_BOARD_INFO("wm8994", 0x1a),
> +		.platform_data	= &wm8994_platform_data,
> +	},
> +};
> +
>  /* PMIC Power button */
>  static struct gpio_keys_button aquila_gpio_keys_table[] = {
>  	{
> @@ -475,6 +614,7 @@ static void aquila_setup_sdhci(void)
>  
>  static struct platform_device *aquila_devices[] __initdata = {
>  	&aquila_i2c_gpio_pmic,
> +	&aquila_i2c_gpio5,
>  	&aquila_device_gpiokeys,
>  	&s3c_device_fb,
>  	&s5pc110_device_onenand,
> @@ -484,8 +624,33 @@ static struct platform_device *aquila_devices[] __initdata = {
>  	&s5p_device_fimc0,
>  	&s5p_device_fimc1,
>  	&s5p_device_fimc2,
> +	&wm8994_fixed_voltage0,
> +	&wm8994_fixed_voltage1,
> +	&s5pv210_device_iis0,
>  };
>  
> +static void __init aquila_sound_init(void)
> +{
> +	unsigned int gpio;
> +
> +	/* CODEC_XTAL_EN 
> +	 *
> +	 * The Aquila board have a oscillator which provide main clock
> +	 * to WM8994 codec. The oscillator provide 24MHz clock to WM8994
> +	 * clock. Set gpio setting of "CODEC_XTAL_EN" to enable a oscillator.
> +	 * */
> +	gpio = S5PV210_GPH3(2);		/* XEINT_26 */
> +	gpio_request(gpio, "CODEC_XTAL_EN");
> +	s3c_gpio_cfgpin(gpio, S3C_GPIO_OUTPUT);
> +	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> +
> +	/* Ths main clock of WM8994 codec uses the output of CLKOUT pin.
> +	 * The CLKOUT[9:8] set to 0x3(XUSBXTI) of 0xE010E000(OTHERS) 
> +	 * because it needs 24MHz clock to operate WM8994 codec.
> +	 */
> +	writel(readl(S5P_OTHERS) | (0x3 << 8), S5P_OTHERS);
> +}
> +
>  static void __init aquila_map_io(void)
>  {
>  	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
> @@ -506,6 +671,11 @@ static void __init aquila_machine_init(void)
>  	s3c_fimc_setname(1, "s5p-fimc");
>  	s3c_fimc_setname(2, "s5p-fimc");
>  
> +	/* SOUND */
> +	aquila_sound_init();
> +	i2c_register_board_info(AP_I2C_GPIO_BUS_5, i2c_gpio5_devs,
> +			ARRAY_SIZE(i2c_gpio5_devs));
> +
>  	/* FB */
>  	s3c_fb_set_platdata(&aquila_lcd_pdata);
>  
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
> index 53754d7..eb68591 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -16,6 +16,8 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c-gpio.h>
>  #include <linux/mfd/max8998.h>
> +#include <linux/mfd/wm8994/pdata.h>
> +#include <linux/regulator/fixed.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/input.h>
>  #include <linux/gpio.h>
> @@ -360,6 +362,120 @@ static struct max8998_platform_data goni_max8998_pdata = {
>  };
>  #endif
>  
> +static struct regulator_consumer_supply wm8994_fixed_voltage0_supplies[] = {
> +	{
> +		.dev_name	= "5-001a",
> +		.supply		= "DBVDD",
> +	}, {
> +		.dev_name	= "5-001a",
> +		.supply		= "AVDD2",
> +	}, {
> +		.dev_name	= "5-001a",
> +		.supply		= "CPVDD",
> +	},
> +
> +};
> +
> +static struct regulator_consumer_supply wm8994_fixed_voltage1_supplies[] = {
> +	{
> +		.dev_name	= "5-001a",
> +		.supply		= "SPKVDD1",
> +	}, {
> +		.dev_name	= "5-001a",
> +		.supply		= "SPKVDD2",
> +	},
> +};
> +
> +static struct regulator_init_data wm8994_fixed_voltage0_init_data = {
> +	.constraints = {
> +		.always_on = 1,
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(wm8994_fixed_voltage0_supplies),
> +	.consumer_supplies	= wm8994_fixed_voltage0_supplies,
> +};
> +
> +static struct regulator_init_data wm8994_fixed_voltage1_init_data = {
> +	.constraints = {
> +		.always_on = 1,
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(wm8994_fixed_voltage1_supplies),
> +	.consumer_supplies	= wm8994_fixed_voltage1_supplies,
> +};
> +
> +static struct fixed_voltage_config wm8994_fixed_voltage0_config = {
> +	.supply_name	= "VCC_1.8V_PDA",
> +	.microvolts	= 1800000,
> +	.gpio		= -EINVAL,
> +	.init_data	= &wm8994_fixed_voltage0_init_data,
> +};
> +
> +static struct fixed_voltage_config wm8994_fixed_voltage1_config = {
> +	.supply_name	= "V_BAT",
> +	.microvolts	= 3700000,
> +	.gpio		= -EINVAL,
> +	.init_data	= &wm8994_fixed_voltage1_init_data,
> +};
> +
> +static struct platform_device wm8994_fixed_voltage0 = {
> +	.name		= "reg-fixed-voltage",
> +	.id		= 0,
> +	.dev		= {
> +		.platform_data	= &wm8994_fixed_voltage0_config,
> +	},
> +};
> +
> +static struct platform_device wm8994_fixed_voltage1 = {
> +	.name		= "reg-fixed-voltage",
> +	.id		= 1,
> +	.dev		= {
> +		.platform_data	= &wm8994_fixed_voltage1_config,
> +	},
> +};
> +
> +static struct regulator_consumer_supply wm8994_avdd1_supply = {
> +	.dev_name	= "5-001a",
> +	.supply		= "AVDD1",
> +};
> +
> +static struct regulator_consumer_supply wm8994_dcvdd_supply = {
> +	.dev_name	= "5-001a",
> +	.supply		= "DCVDD",
> +};
> +
> +static struct regulator_init_data wm8994_ldo1_data = {
> +	.constraints	= {
> +		.name		= "AVDD1_3.0V",
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	= &wm8994_avdd1_supply,
> +};
> +
> +static struct regulator_init_data wm8994_ldo2_data = {
> +	.constraints	= {
> +		.name		= "DCVDD_1.0V",
> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	= &wm8994_dcvdd_supply,
> +};
> +
> +static struct wm8994_pdata wm8994_platform_data = {
> +	/* configure gpio1 function: 0x0001(Logic level input/output) */
> +	.gpio_defaults[0] = 0x0001,
> +	/* configure gpio3/4/5/7 function for AIF2 voice */
> +	.gpio_defaults[2] = 0x8100,
> +	.gpio_defaults[3] = 0x8100,
> +	.gpio_defaults[4] = 0x8100,
> +	.gpio_defaults[6] = 0x0100,
> +	/* configure gpio8/9/10/11 function for AIF3 BT */
> +	.gpio_defaults[7] = 0x8100,
> +	.gpio_defaults[8] = 0x0100,
> +	.gpio_defaults[9] = 0x0100,
> +	.gpio_defaults[10] = 0x0100,
> +	.ldo[0]	= { S5PV210_GPF3(4), NULL, &wm8994_ldo1_data },	/* XVVSYNC_LDI */
> +	.ldo[1]	= { 0, NULL, &wm8994_ldo2_data },
> +};
> +
>  /* GPIO I2C PMIC */
>  #define AP_I2C_GPIO_PMIC_BUS_4	4
>  static struct i2c_gpio_platform_data goni_i2c_gpio_pmic_data = {
> @@ -385,6 +501,29 @@ static struct i2c_board_info i2c_gpio_pmic_devs[] __initdata = {
>  #endif
>  };
>  
> +/* GPIO I2C AP 1.8V */
> +#define AP_I2C_GPIO_BUS_5	5
> +static struct i2c_gpio_platform_data goni_i2c_gpio5_data = {
> +	.sda_pin	= S5PV210_MP05(3),	/* XM0ADDR_11 */
> +	.scl_pin	= S5PV210_MP05(2),	/* XM0ADDR_10 */
> +};
> +
> +static struct platform_device goni_i2c_gpio5 = {
> +	.name		= "i2c-gpio",
> +	.id		= AP_I2C_GPIO_BUS_5,
> +	.dev		= {
> +		.platform_data	= &goni_i2c_gpio5_data,
> +	},
> +};
> +
> +static struct i2c_board_info i2c_gpio5_devs[] __initdata = {
> +	{
> +		/* CS/ADDR = low 0x34 (FYI: high = 0x36) */
> +		I2C_BOARD_INFO("wm8994", 0x1a),
> +		.platform_data	= &wm8994_platform_data,
> +	},
> +};
> +
>  /* PMIC Power button */
>  static struct gpio_keys_button goni_gpio_keys_table[] = {
>  	{
> @@ -458,6 +597,7 @@ static struct platform_device *goni_devices[] __initdata = {
>  	&s3c_device_fb,
>  	&s5pc110_device_onenand,
>  	&goni_i2c_gpio_pmic,
> +	&goni_i2c_gpio5,
>  	&goni_device_gpiokeys,
>  	&s5p_device_fimc0,
>  	&s5p_device_fimc1,
> @@ -465,8 +605,20 @@ static struct platform_device *goni_devices[] __initdata = {
>  	&s3c_device_hsmmc0,
>  	&s3c_device_hsmmc1,
>  	&s3c_device_hsmmc2,
> +	&wm8994_fixed_voltage0,
> +	&wm8994_fixed_voltage1,
> +	&s5pv210_device_iis0,
>  };
>  
> +static void __init goni_sound_init(void)
> +{
> +	/* Ths main clock of WM8994 codec uses the output of CLKOUT pin.
> +	 * The CLKOUT[9:8] set to 0x3(XUSBXTI) of 0xE010E000(OTHERS) 
> +	 * because it needs 24MHz clock to operate WM8994 codec.
> +	 */
> +	writel(readl(S5P_OTHERS) | (0x3 << 8), S5P_OTHERS);
> +}
> +
>  static void __init goni_map_io(void)
>  {
>  	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
> @@ -483,6 +635,11 @@ static void __init goni_machine_init(void)
>  	/* SDHCI */
>  	goni_setup_sdhci();
>  
> +	/* SOUND */
> +	goni_sound_init();
> +	i2c_register_board_info(AP_I2C_GPIO_BUS_5, i2c_gpio5_devs,
> +			ARRAY_SIZE(i2c_gpio5_devs));
> +
>  	/* FB */
>  	s3c_fb_set_platdata(&goni_lcd_pdata);
>  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
