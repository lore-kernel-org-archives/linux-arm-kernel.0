From: ben@simtec.co.uk (Ben Dooks)
Date: Thu, 29 Jul 2010 23:48:26 +0100
Subject: [PATCH 1/2] ARM: S5PV210: Add audio support to Aquila
In-Reply-To: <4C4F9E4C.7000001@samsung.com>
References: <4C4F9E4C.7000001@samsung.com>
Message-ID: <4C52053A.8090400@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/07/10 04:04, Chanwoo Choi wrote:

[snip]


> +/* GPIO I2C AP 1.8V */
> +#define AP_I2C_GPIO_BUS_5	5
> +static struct i2c_gpio_platform_data i2c_gpio5_data = {
> +	.sda_pin	= S5PV210_MP05(3),	/* XM0ADDR_11 */
> +	.scl_pin	= S5PV210_MP05(2),	/* XM0ADDR_10 */
> +};
> +
> +static struct platform_device i2c_gpio5 = {
> +	.name		= "i2c-gpio",
> +	.id		= AP_I2C_GPIO_BUS_5,
> +	.dev		= {
> +		.platform_data	= &i2c_gpio5_data,
> +	},
> +};
> +
> +static struct i2c_board_info i2c_gpio5_devs[] __initdata = {
> +	{
> +		/* CS/ADDR = low 0x34 (FYI: high = 0x36) */
> +		I2C_BOARD_INFO("wm8994", 0x34 >> 1),
> +		.platform_data	= &wm8994_platform_data,
> +	},
> +};
> +
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

gpio_direction_output() should have done the cfgpin()
call.

> +	/* CLKOUT[9:8] set to 0x3(XUSBXTI) of 0xE010E000(OTHERS)
> +	 * for 24MHZ
> +	 */
> +	writel(readl(S5P_OTHERS) | (0x3 << 8), S5P_OTHERS);

Not sure if this should be being done directly? will it affect
the current clock tree?
