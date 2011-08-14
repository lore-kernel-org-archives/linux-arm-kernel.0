From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 14 Aug 2011 16:01:48 +0100
Subject: [PATCH] ARM: EXYNOS4: Configure MAX8997 PMIC for Origen
In-Reply-To: <1313034965-21286-1-git-send-email-inderpal.singh@linaro.org>
References: <1313034965-21286-1-git-send-email-inderpal.singh@linaro.org>
Message-ID: <20110814150148.GB25504@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 09:26:05AM +0530, Inderpal Singh wrote:

> +static struct regulator_consumer_supply __initdata ldo7_consumer[] = {
> +	REGULATOR_SUPPLY("avdd", "soc-audio"), /* Reatek ALC5625*/
> +};

Ick, no.  The soc-audio device is a virtual device within Linux and is
being phased out, any driver adding new soc-audio devices will be
rejected.  The CODEC driver should deal with its own power.

> +static struct regulator_init_data __initdata max8997_ldo3_data = {
> +	.constraints	= {
> +		.name		= "VMIPI_1.1V",
> +		.min_uV		= 1100000,
> +		.max_uV		= 1100000,
> +		.apply_uV	= 1,
> +		.always_on	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,

The regulator is always enabled but the consumers can change its status?

> +		.name		= "DVDD_SWB_2.8V",
> +		.min_uV		= 2800000,
> +		.max_uV		= 2800000,
> +		.apply_uV	= 1,
> +		.always_on	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,

The regulator has a fixed voltage but the consumers can change it?

> +static struct i2c_board_info i2c0_devs[] __initdata = {
> +[I2C0_MAX8997] = {
> +	I2C_BOARD_INFO("max8997", (0xCC >> 1)),
> +	.platform_data = &origen_max8997_pdata,
> +	},
> +};

Why are you assigning the array index?  That's very unusual.

> +static void __init origen_power_init(void)
> +{
> +	int gpio;
> +	int irq_base = IRQ_GPIO_END + 1;
> +
> +	origen_max8997_pdata.irq_base = irq_base;

Why is this not just set statically in the pdata?

> +	gpio = EXYNOS4_GPX0(4);
> +	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
> +	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);

A define for the GPIO would be a bit more common.

> +	s3c_i2c0_set_platdata(NULL);
> +	i2c0_devs[I2C0_MAX8997].irq = gpio_to_irq(EXYNOS4_GPX0(4));

There should be defines to do this statically.
