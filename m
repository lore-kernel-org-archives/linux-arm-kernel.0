From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Jul 2010 10:38:26 -0700
Subject: [PATCH 1/2] ARM: S5PV210: Add audio support to Aquila
In-Reply-To: <4C4F9E4C.7000001@samsung.com>
References: <4C4F9E4C.7000001@samsung.com>
Message-ID: <20100729173825.GE24781@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 12:04:44PM +0900, Chanwoo Choi wrote:

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

All these fixed voltage regulators seem a bit suspicous for a mobile
phone - I'd have expected that the supplies would all be being provided
by your PMIC except for things taken directly from the battery supply
(like the speakers tend to be, for example)?  There's no problem with
the code itself, it just looks a bit odd.

> +static struct i2c_board_info i2c_gpio5_devs[] __initdata = {
> +	{
> +		/* CS/ADDR = low 0x34 (FYI: high = 0x36) */
> +		I2C_BOARD_INFO("wm8994", 0x34 >> 1),
> +		.platform_data	= &wm8994_platform_data,
> +	},
> +};

Probably clearer for generic Linux use to specify the address as 0x1a
directly.

> +static void __init aquila_sound_init(void)
> +{
> +	unsigned int gpio;
> +
> +	/* CODEC_XTAL_EN */
> +	gpio = S5PV210_GPH3(2);		/* XEINT_26 */
> +	gpio_request(gpio, "CODEC_XTAL_EN");
> +	s3c_gpio_cfgpin(gpio, S3C_GPIO_OUTPUT);
> +	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> +	gpio_direction_output(gpio, 1);

Might be as well to provide some or all this stuff in your audio machine
driver?

> +	/* MICBIAS_EN */
> +	gpio = S5PV210_GPJ4(2);			/* XMSMRN */
> +	gpio_request(gpio, "MICBIAS_EN");
> +	s3c_gpio_cfgpin(gpio, S3C_GPIO_OUTPUT);
> +	gpio_direction_output(gpio, 1);

This in particular would benefit from keeping the request of the GPIO
joined up with the driver that uses it.

> +	/* ADC_EN */
> +	gpio = S5PV210_GPJ3(2);
> +	gpio_request(gpio, "ADC_EN");
> +	s3c_gpio_cfgpin(gpio, S3C_GPIO_OUTPUT);
> +	gpio_direction_output(gpio, 1);

I'm not sure what this does?
