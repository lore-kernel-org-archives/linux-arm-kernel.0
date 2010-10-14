From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Oct 2010 09:37:02 +0900
Subject: [PATCH 3/3] ARM: S5PV210: Add voltage consumer of WM8994 to the
	regulator framework
In-Reply-To: <4CA5623D.3000002@samsung.com>
References: <4CA5623D.3000002@samsung.com>
Message-ID: <003801cb6b37$edeb8680$c9c29380$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chanwoo Choi wrote:
> 
> This patch add cose related to regulator. To control powre consumeption
> have registered the voltage consumer of WM8994 to the regulator framework.
> 
> Additionally, I explain the constraints of the regulator of WM8994 codec.
> All these consumer supply of WM8994 codec connected the regulator(VCC_1.8V)
> on a circuit diagram. "VCC_1.8V" regulator is always enabled, because it is
> used to many devices on Goni/Aquila board. This is required especially
> when there are many devices physically attached to "VCC_1.8V" and some of
> they did not "register" as consumers to "VCC_1.8V". "VCC_1.8V" might be
> turned off by those who are registered while "unregistered" are still active
> 
> Signed-off-by : Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by : Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by : Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/mach-aquila.c |  119
> +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-s5pv210/mach-goni.c   |  119
> +++++++++++++++++++++++++++++++++++
>  2 files changed, 238 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-
> aquila.c
> index 92dad41..825d70c 100644
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
> @@ -379,6 +381,120 @@ static struct max8998_platform_data
> aquila_max8998_pdata = {
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
> +	.num_consumer_supplies	=
> ARRAY_SIZE(wm8994_fixed_voltage0_supplies),
> +	.consumer_supplies	= wm8994_fixed_voltage0_supplies,
> +};
> +
> +static struct regulator_init_data wm8994_fixed_voltage1_init_data = {
> +	.constraints = {
> +		.always_on = 1,
> +	},
> +	.num_consumer_supplies	=
> ARRAY_SIZE(wm8994_fixed_voltage1_supplies),
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
> +	.ldo[0]	= { S5PV210_MP03(6), NULL, &wm8994_ldo1_data },	/*
> XM0FRNB_2 */
> +	.ldo[1]	= { 0, NULL, &wm8994_ldo2_data },
> +};
> +
>  /* GPIO I2C PMIC */
>  #define AP_I2C_GPIO_PMIC_BUS_4	4
>  static struct i2c_gpio_platform_data aquila_i2c_gpio_pmic_data = {
> @@ -423,6 +539,7 @@ static struct i2c_board_info i2c_gpio5_devs[] __initdata = {
>  	{
>  		/* CS/ADDR = low 0x34 (FYI: high = 0x36) */
>  		I2C_BOARD_INFO("wm8994", 0x1a),
> +		.platform_data	= &wm8994_platform_data,
>  	},
>  };
> 
> @@ -508,6 +625,8 @@ static struct platform_device *aquila_devices[] __initdata =
> {
>  	&s5p_device_fimc1,
>  	&s5p_device_fimc2,
>  	&s5pv210_device_iis0,
> +	&wm8994_fixed_voltage0,
> +	&wm8994_fixed_voltage1,
>  };
> 
>  static void __init aquila_sound_init(void)
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-
> goni.c
> index d3bab85..667d453 100644
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
> @@ -360,6 +362,120 @@ static struct max8998_platform_data
> goni_max8998_pdata = {
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
> +	.num_consumer_supplies	=
> ARRAY_SIZE(wm8994_fixed_voltage0_supplies),
> +	.consumer_supplies	= wm8994_fixed_voltage0_supplies,
> +};
> +
> +static struct regulator_init_data wm8994_fixed_voltage1_init_data = {
> +	.constraints = {
> +		.always_on = 1,
> +	},
> +	.num_consumer_supplies	=
> ARRAY_SIZE(wm8994_fixed_voltage1_supplies),
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
> +	.ldo[0]	= { S5PV210_MP03(6), NULL, &wm8994_ldo1_data },	/*
> XM0FRNB_2 */
> +	.ldo[1]	= { 0, NULL, &wm8994_ldo2_data },
> +};
> +
>  /* GPIO I2C PMIC */
>  #define AP_I2C_GPIO_PMIC_BUS_4	4
>  static struct i2c_gpio_platform_data goni_i2c_gpio_pmic_data = {
> @@ -404,6 +520,7 @@ static struct i2c_board_info i2c_gpio5_devs[] __initdata = {
>  	{
>  		/* CS/ADDR = low 0x34 (FYI: high = 0x36) */
>  		I2C_BOARD_INFO("wm8994", 0x1a),
> +		.platform_data	= &wm8994_platform_data,
>  	},
>  };
> 
> @@ -489,6 +606,8 @@ static struct platform_device *goni_devices[] __initdata = {
>  	&s3c_device_hsmmc1,
>  	&s3c_device_hsmmc2,
>  	&s5pv210_device_iis0,
> +	&wm8994_fixed_voltage0,
> +	&wm8994_fixed_voltage1,
>  };
> 
>  static void __init goni_sound_init(void)
> --

Ok...will apply after re-submitting your other patches together.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
