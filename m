From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 25 Apr 2018 07:41:35 +0800
Subject: [PATCH v3 2/3] regulator: add support for SY8106A regulator
In-Reply-To: <20180424170733.GD22073@sirena.org.uk>
References: <20180423144657.63264-1-icenowy@aosc.io>
 <20180423144657.63264-3-icenowy@aosc.io>
 <20180424170733.GD22073@sirena.org.uk>
Message-ID: <C0C1F042-221A-420F-A8C1-5FADCFC687F1@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?4?25? GMT+08:00 ??1:07:33, Mark Brown <broonie@kernel.org> ??:
>On Mon, Apr 23, 2018 at 10:46:56PM +0800, Icenowy Zheng wrote:
>
>> --- /dev/null
>> +++ b/drivers/regulator/sy8106a-regulator.c
>> @@ -0,0 +1,176 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * sy8106a-regulator.c - Regulator device driver for SY8106A
>
>Just make the entire thing a C++ comment so it looks consistent and
>joined up.

SPDX identifier is special -- it should be in a seperated
comment block.

>
>> +static int sy8106a_set_voltage_sel(struct regulator_dev *rdev,
>unsigned int sel)
>> +{
>> +	/* We use our set_voltage_sel in order to avoid unnecessary I2C
>> +	 * chatter, because the regulator_get_voltage_sel_regmap using
>> +	 * apply_bit would perform 4 unnecessary transfers instead of one,
>> +	 * increasing the chance of error.
>> +	 */
>> +	return regmap_write(rdev->regmap, rdev->desc->vsel_reg,
>> +			    sel | SY8106A_GO_BIT);
>
>Why would it do these extra transfers?  Is this just the fact that you
>didn't set up a register cache (though the r/m/w cycle should only add
>the read)?  We could put some logic in the core regmap code to detect
>that an _update_bits() call is going to write to the whole register,
>though it'd be even easier to just let this register be cached.
>
>Generally if we can usefully optimize things we should do it at the
>framework level.

Oh maybe the comment needs to be changed, but it's
needed to enable it to change voltage, as it might be
not enabled at boot.

>
>> +	if (reg & SY8106A_GO_BIT)
>> +		return reg & rdev->desc->vsel_mask;
>> +	else
>> +		return (chip->fixed_voltage - rdev->desc->min_uV) /
>> +		       rdev->desc->uV_step;
>
>You could use the standard get_voltage_sel() if you provide a mapping
>operation that set everything with _GO_BIT set to return the fixed
>voltage.  Though looking at this it seems that the fixed voltage will
>always be one that could be set via the register anyway so I'm
>wondering
>if the easiest thing here isn't to just have the driver turn off
>_GO_BIT

Do you mean "turn on" here?

>during probe() and not worry about the special case at runtime.
