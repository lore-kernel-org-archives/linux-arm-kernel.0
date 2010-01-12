From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 12 Jan 2010 11:51:56 +0000
Subject: [PATCH 01/01] regulator: support max8649
In-Reply-To: <771cded01001120051l44fd76bx80d2fd4b6f60bd0b@mail.gmail.com>
References: <771cded01001120041ue24edabk8e4638ef7151c947@mail.gmail.com>
	<771cded01001120051l44fd76bx80d2fd4b6f60bd0b@mail.gmail.com>
Message-ID: <20100112115156.GA546@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 03:51:09AM -0500, Haojian Zhuang wrote:

> Enable Maxim max8649 regulator driver.

This seems basically fine but there's a few relatively minor issues
below, mostly coding style rather than anything serious.

> +static int max8649_list_voltage(struct regulator_dev *rdev, unsigned index)
> +{
> +	return MAX8649_DCDC_VMIN + index * MAX8649_DCDC_STEP;
> +}

Brackets here would help legibility even if not strictly required.

> +	data= (min_uV - MAX8649_DCDC_VMIN + MAX8649_DCDC_STEP - 1)
> +		/ MAX8649_DCDC_STEP;

Should be "data ="

> +static struct regulator_desc dcdc_desc = {
> +	.name		= "DCDC",

MAX8649 might be a better name but it doesn't really make any odds.

> +	.ops		= &max8649_dcdc_ops,
> +	.type		= REGULATOR_VOLTAGE,
> +	.n_voltages	= 1 << 7,

Use the max index value you have above?

> +	info->vol_reg = (info->mode == 0) ? MAX8649_MODE0
> +			: ((info->mode == 1) ? MAX8649_MODE1
> +			: ((info->mode == 2) ? MAX8649_MODE2
> +			: MAX8649_MODE3));

This should really be a switch statement for legibility.  In general the
ternery operator should be used very sparingly, and if you've got more
than one of them it's not a good sign.

> +	/* enable/disable auto enter power save mode */
> +	info->powersave = pdata->powersave;
> +	data = (info->powersave) ? 0 : MAX8649_POWER_SAVE;
> +	max8649_set_bits(info->i2c, info->vol_reg, MAX8649_POWER_SAVE, data);

I'm not sure what this power save mode is but I suspect it'd map well
onto the regulator_set_mode() API - normal mode for power saving, fast
mode for power saving disabled.

> +	if (pdata->ramp_timing) {
> +		info->ramp_timing = pdata->ramp_timing;
> +		max8649_set_bits(info->i2c, MAX8649_RAMP, MAX8649_RAMP_MASK,
> +				 info->ramp_timing << 5);
> +	}

You might want to implement the new enable_time() API for this.

> +	pr_info("Max8649 regulator device is detected.\n");

This should be at most debug level, and should be dev_() to distinguish
between multiple devices.
