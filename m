From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Apr 2018 18:07:33 +0100
Subject: [PATCH v3 2/3] regulator: add support for SY8106A regulator
In-Reply-To: <20180423144657.63264-3-icenowy@aosc.io>
References: <20180423144657.63264-1-icenowy@aosc.io>
 <20180423144657.63264-3-icenowy@aosc.io>
Message-ID: <20180424170733.GD22073@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 10:46:56PM +0800, Icenowy Zheng wrote:

> --- /dev/null
> +++ b/drivers/regulator/sy8106a-regulator.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * sy8106a-regulator.c - Regulator device driver for SY8106A

Just make the entire thing a C++ comment so it looks consistent and
joined up.

> +static int sy8106a_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
> +{
> +	/* We use our set_voltage_sel in order to avoid unnecessary I2C
> +	 * chatter, because the regulator_get_voltage_sel_regmap using
> +	 * apply_bit would perform 4 unnecessary transfers instead of one,
> +	 * increasing the chance of error.
> +	 */
> +	return regmap_write(rdev->regmap, rdev->desc->vsel_reg,
> +			    sel | SY8106A_GO_BIT);

Why would it do these extra transfers?  Is this just the fact that you
didn't set up a register cache (though the r/m/w cycle should only add
the read)?  We could put some logic in the core regmap code to detect
that an _update_bits() call is going to write to the whole register,
though it'd be even easier to just let this register be cached.

Generally if we can usefully optimize things we should do it at the
framework level.

> +	if (reg & SY8106A_GO_BIT)
> +		return reg & rdev->desc->vsel_mask;
> +	else
> +		return (chip->fixed_voltage - rdev->desc->min_uV) /
> +		       rdev->desc->uV_step;

You could use the standard get_voltage_sel() if you provide a mapping
operation that set everything with _GO_BIT set to return the fixed
voltage.  Though looking at this it seems that the fixed voltage will
always be one that could be set via the register anyway so I'm wondering
if the easiest thing here isn't to just have the driver turn off _GO_BIT
during probe() and not worry about the special case at runtime.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/e2fc3aec/attachment.sig>
