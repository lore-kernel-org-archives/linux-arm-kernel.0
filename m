From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Apr 2015 20:45:52 +0100
Subject: [PATCH 2/2] Regulator: add driver for Freescale MC34708
In-Reply-To: <20150428141740.16243.79036.stgit@localhost>
References: <20150428141740.16243.79036.stgit@localhost>
Message-ID: <20150430194552.GE22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 04:17:40PM +0200, Martin Fuzzey wrote:
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>

Please use subject lines reflecting the style for the subsystem.

> +static int mc34708_read_bits(struct mc34708_regulator *mc34708_reg,
> +			     unsigned int reg, u32 mask)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret = mc13xxx_reg_read(mc34708_reg->mc13xxx, reg, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val &= mask;
> +	val >>= ffs(mask) - 1;

Ick, this looks confusing - it's wrapping something which should hopefully
be a regmap in multiple layer.  The bitfield access helper does seem
reasonable though.

> +static int mc34708_update_bits(struct mc34708_regulator *mc34708_reg,
> +			       unsigned int reg, u32 mask, u32 val)
> +{
> +	val <<= ffs(mask) - 1;
> +
> +	return mc13xxx_reg_rmw(mc34708_reg->mc13xxx, reg, mask, val);

This is a wrapper for the widely used _update_bits() interface which has
a different interface - that's *definitely* confusing.

> +static int mc34708_get_voltage_sel(struct regulator_dev *rdev)
> +{
> +	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
> +
> +	return mc34708_read_bits(mc34708_reg,
> +				rdev->desc->vsel_reg, rdev->desc->vsel_mask);
> +}

Don't open code this, use the standard regmap helpers.

> +	val = mc34708_read_bits(mc34708_reg,
> +				mc34708_reg->def->mode_reg,
> +				mc34708_reg->def->mode_mask);
> +	if (val < 0)
> +		return ERR_PTR(val);
> +
> +	BUG_ON(val >= mc34708_reg->def->kind->num_hw_modes);

This is too severe, could be a hardware error.

> +static int mc34708_sw_find_hw_mode_sel(
> +	const struct mc34708_regulator_kind *kind,
> +	unsigned int normal,
> +	unsigned int standby)
> +{
> +	const struct mc34708_hw_mode *mode;
> +	int i;
> +
> +	for (i = 0, mode = kind->hw_modes;
> +			i < kind->num_hw_modes; i++, mode++) {
> +		if (mode->normal == -1 || mode->standby == -1)
> +			continue;
> +
> +		if (mode->standby != standby)
> +			continue;
> +
> +		if ((mode->normal == normal) ||
> +		    (normal && (mode->alt_normal == normal)))
> +			return i;
> +	}

I honestly don't really know what the above is supposed to do.  It's
mapping something to something but what exactly is unclear...  skipping
most of the rest of the mode code.

> +static int mc34708_swbst_mode_to_hwmode(unsigned int mode)
> +{
> +	switch (mode) {
> +	case REGULATOR_MODE_IDLE:
> +	case REGULATOR_MODE_STANDBY:
> +		return  MC34708_SW_OPMODE_PFM;

No, this is broken - you're mapping two different modes to one hardware
setting.  If the device doesn't support something it just doesn't
support it, let the upper layers work out how to handle that.

Also an extra space there.

> +static int mc34708_swbst_setup(struct mc34708_regulator *mc34708_reg)
> +{
> +	int val, mode;
> +
> +	val = mc34708_read_bits(mc34708_reg,
> +				mc34708_reg->def->mode_reg,
> +				mc34708_reg->def->mode_mask);
> +	if (val < 0)
> +		return val;
> +
> +	if (val > 0) {
> +		mode = mc34708_swbst_hwmode_to_mode(val);
> +		if (mode < 0)
> +			return mode;
> +
> +		mc34708_reg->req_mode_normal = mode;
> +	} else {
> +		/*
> +		 * If regulator is intially off we don't know the mode
> +		 * but we need a mode to be able to enable it later.
> +		 */
> +		mc34708_reg->req_mode_normal = REGULATOR_MODE_NORMAL;
> +	}

I don't really understand what the above is supposed to do, some
comments would probably help.

> +static int mc34708_swbst_enable(struct regulator_dev *rdev)
> +{
> +	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
> +
> +	return mc34708_update_bits(mc34708_reg,
> +					mc34708_reg->def->mode_reg,
> +					mc34708_reg->def->mode_mask,
> +					mc34708_reg->req_mode_normal);
> +}

Again use the standard regmap helpers.

> +static int mc34708_ldo_set_suspend_enable(struct regulator_dev *rdev)
> +{
> +	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
> +	int ret;
> +
> +	ret = mc34708_update_hw_mode(mc34708_reg,
> +				     mc34708_reg->req_mode_normal,
> +				     mc34708_reg->req_mode_standby);
> +	if (!ret)
> +		mc34708_reg->suspend_off = false;

This looks like it should be a noop.  It also seems very familiar from
some of the other code.

> +static int mc34708_ldo_set_suspend_mode(struct regulator_dev *rdev,
> +					unsigned int mode)
> +{
> +	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
> +	int ret;
> +
> +	if (!mc34708_ldo_has_mode_bit(mc34708_reg))
> +		return 0;

Again, if the driver doesn't support something don't implement it.

> +static const unsigned int mc34708_vgen1_volt_table[] = {
> +	1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000, 1550000
> +};

This looks like a linear mapping, use the standard helpers please.

> +/*
> + * Setting some LDO standby states also requires changing the normal state.
> + * Therefore save the LDO configuration register on suspend and restore it
> + * on resume.
> + *
> + * This works because .set_suspend_X are called by the platform suspend handler
> + * AFTER device suspend
> + */

That's not something you can rely on, I suggest omitting this for now
and doing it separately.

> +	num_regs = of_get_child_count(regs_np);
> +	mc34708_data = devm_kzalloc(dev, sizeof(*mc34708_data) +
> +					num_regs * sizeof(*mc34708_reg),
> +					GFP_KERNEL);
> +	if (!mc34708_data) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	dev_set_drvdata(dev, mc34708_data);
> +
> +	mc34708_reg = mc34708_data->regulators;
> +	for_each_child_of_node(regs_np, reg_np) {

No, this is broken - your driver should like all the others register all
the regulators on the device uncondtionally.  It should also be using
.of_match to allow the core to look up the init data.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150430/2c35161e/attachment.sig>
