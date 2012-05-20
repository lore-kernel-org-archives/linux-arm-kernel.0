From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 20 May 2012 11:00:15 +0100
Subject: [PATCH v2 2/2] regulator: Add support for MAX77686.
In-Reply-To: <1337261967-26004-3-git-send-email-yadi.brar@samsung.com>
References: <1337261967-26004-1-git-send-email-yadi.brar@samsung.com>
 <1337261967-26004-3-git-send-email-yadi.brar@samsung.com>
Message-ID: <20120520100015.GC20652@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 07:09:27PM +0530, Yadwinder Singh Brar wrote:

Looks mostly good.  A couple of fairly small things:

> +static int max77686_get_voltage_sel(struct regulator_dev *rdev)
> +{

This looks like it should be regulator_get_voltage_sel_regmap().

> +static int max77686_set_voltage_sel(struct regulator_dev *rdev,
> +					unsigned sel)
> +{

This looks like it should be regulator_set_voltage_sel_regmap().

> +	max77686->ramp_delay = pdata->ramp_delay - 1;
> +	max77686_update_reg(i2c, MAX77686_REG_BUCK2CTRL1,
> +		RAMP_VALUE, RAMP_MASK);
> +	max77686_update_reg(i2c, MAX77686_REG_BUCK3CTRL1,
> +		RAMP_VALUE, RAMP_MASK);
> +	max77686_update_reg(i2c, MAX77686_REG_BUCK4CTRL1,
> +		RAMP_VALUE, RAMP_MASK);

This code is unclear because RAMP_VALUE looks like a constant that has
nothing to do with ramp_delay when in fact it's actually this:

> +#define RAMP_VALUE (max77686->ramp_delay << 6)

which isn't constant - this is why I queried this last time.  Just
remove the define and write this out directly.  The way the code is
written@the minute it looks like ramp_delay is just stored and not
referred to unless you go searching around the rest of the driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120520/bb6500c2/attachment.sig>
