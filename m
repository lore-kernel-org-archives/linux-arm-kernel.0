From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Sep 2015 18:58:57 +0100
Subject: [PATCH 4/8] regulator: Hi655x: Add support for Hi655x regulator
In-Reply-To: <1443611111-3196-5-git-send-email-w.f@huawei.com>
References: <1443611111-3196-1-git-send-email-w.f@huawei.com>
 <1443611111-3196-5-git-send-email-w.f@huawei.com>
Message-ID: <20150930175857.GK15635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 07:05:07PM +0800, Fei Wang wrote:

> +config REGULATOR_HI655X
> +        tristate "Hisilicon HI655X PMIC regulators support"
> +        depends on ARCH_HISI
> +	depends on MFD_HI655X_PMIC && OF

You've got some tab/space confusion above.  Also, can't we have an ||
COMPILE_TEST here?

> +#define REG_VALUE_SETBITS(reg_value, pos, bits, bits_value) \
> +		(reg_value = (reg_value & \
> +		~((((unsigned int)1 << bits) - 1) << pos)) | \
> +		((unsigned int)(bits_value & \
> +		(((unsigned int)1 << bits) - 1)) << pos))
> +
> +#define REG_VALUE_GETBITS(reg_value, pos, bits) \
> +			((reg_value >> pos) & (((unsigned int)1 << bits) - 1))

These are just really hard to read, sorry, and they appear to duplicate
existing regmap functionality.  If there is a strong reason to add them
consider doing so in the core and if you can then please@least make
them regular inline functions rather than using macros.  It's much safer
and more readable.

> +static int hi655x_regulator_pmic_is_enabled(struct regulator_dev *rdev)
> +{
> +	int ret = 0;
> +	unsigned int value = 0;
> +
> +	struct hi655x_regulator *sreg = rdev_get_drvdata(rdev);
> +	struct hi655x_regulator_ctrl_regs  *ctrl_regs = &(sreg->ctrl_regs);
> +	struct hi655x_regulator_ctrl_data  *ctrl_data = &(sreg->ctrl_data);
> +
> +	/*
> +	* regulator is all set,but the pmu is only subset.
> +	* maybe this "buck"/"ldo"/"lvs" is not contrl by a core.
> +	* and in regulator have a "status" member ("okey" or "disable").
> +	*/

I'm having a hard time parsing the above comment.  Please also use the
normal kernel comment style (this is a problem throughout the driver).

> +	regmap_read(rdev->regmap, ctrl_regs->status_reg, &value);
> +	ret = (int)REG_VALUE_GETBITS(value, ctrl_data->shift,
> +					ctrl_data->mask);

This appears to just duplicate regulator core functionality for reading
enable state from a bitfield?  Also note that the cast here isn't a
great advert for the macros above.

> +static int hi655x_regulator_pmic_enable(struct regulator_dev *rdev)
> +{
> +	int ret = 0;
> +	unsigned char value_u8 = 0;
> +	unsigned int value_u32 = 0;
> +	struct hi655x_regulator *sreg = rdev_get_drvdata(rdev);
> +	struct hi655x_regulator_ctrl_regs  *ctrl_regs = &(sreg->ctrl_regs);
> +	struct hi655x_regulator_ctrl_data  *ctrl_data = &(sreg->ctrl_data);
> +
> +	REG_VALUE_SETBITS(value_u32, ctrl_data->shift, ctrl_data->mask, 0x1);
> +	value_u8  = (unsigned char)value_u32;
> +	regmap_write(rdev->regmap, ctrl_regs->enable_reg, value_u8);

I'm not *entirely* sure what this is supposed to be doing but it looks
like it's duplicating core functionality in a fashion that's really
quite hard to read.  Why not just use the core functions for setting
bits?

> +	udelay(sreg->off_on_delay);

Use the regualtor core delay functionality please.

> +static int hi655x_regulator_pmic_list_voltage_linear(struct regulator_dev *rdev,
> +				  unsigned int selector)

This is *definitely* duplicating core functionality, I think you want to
use regulator_list_voltage_linear_range() or possibly just plain
_linear() and use separate operations for the LVS regulator.

We at least need to restructure the code so that the core helper
functions are used and we don't have regulator type decisions everywhere
- the whole goal of having per regulator ops is to avoid having to open
code decisions about which regulator we're dealing with into each op
function.

> +static unsigned int hi655x_regulator_pmic_get_mode(
> +			struct regulator_dev *rdev)
> +{
> +	return REGULATOR_MODE_NORMAL;
> +}

Don't implement empty functions, remove all these.

> +	num_consumer_supplies = of_get_property(np,
> +				"hisilicon,num_consumer_supplies", NULL);
> +
> +	if ((NULL == num_consumer_supplies) || (0 == *num_consumer_supplies)) {
> +		dev_warn(dev, "%s no consumer_supplies\n", __func__);
> +		return init_data;
> +	}

Obviously the binding is completely undocumented but this is setting off
alarm bells - why is the driver even considering consumers?  Please make
sure you are using the core regulator bindings rather than open coding
something which translates into platform data (which is what this looks
like).

I'm not going to review any more of the DT code without binding
documentation.

> +	/*
> +	*initdata mem will release auto;
> +	*this is kernel 3.10 import.
> +	*/

Remove anything related to your vendor kernel support, this is not
relevant to upstream.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/0666e632/attachment.sig>
