From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Mon, 11 May 2015 11:04:39 +0200
Subject: [PATCH 2/2] Regulator: add driver for Freescale MC34708
In-Reply-To: <20150430194552.GE22845@sirena.org.uk>
References: <20150428141740.16243.79036.stgit@localhost>
 <20150430194552.GE22845@sirena.org.uk>
Message-ID: <555070A7.2060808@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for the review.

On 30/04/15 21:45, Mark Brown wrote:
> On Tue, Apr 28, 2015 at 04:17:40PM +0200, Martin Fuzzey wrote:
>> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> Please use subject lines reflecting the style for the subsystem.
>
You mean
regulator: mc34708: Add driver?

I ommitted the mc34708 part because it's a new driver

>> +static int mc34708_read_bits(struct mc34708_regulator *mc34708_reg,
>> +			     unsigned int reg, u32 mask)
>> +{
>> +	int ret;
>> +	u32 val;
>> +
>> +	ret = mc13xxx_reg_read(mc34708_reg->mc13xxx, reg, &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	val &= mask;
>> +	val >>= ffs(mask) - 1;
> Ick, this looks confusing - it's wrapping something which should hopefully
> be a regmap in multiple layer.  The bitfield access helper does seem
> reasonable though.

The reason for this wrapping stuff is that this is not a standalone 
driver, rather a "subdriver" of the mc13xxx MFD driver.
That already exists and supports the mc34708 (for the RTC for example) 
but not yet the regulator parts.
It does not expose regmap (although it does use it internally).
>> +static int mc34708_update_bits(struct mc34708_regulator *mc34708_reg,
>> +			       unsigned int reg, u32 mask, u32 val)
>> +{
>> +	val <<= ffs(mask) - 1;
>> +
>> +	return mc13xxx_reg_rmw(mc34708_reg->mc13xxx, reg, mask, val);
> This is a wrapper for the widely used _update_bits() interface which has
> a different interface - that's *definitely* confusing.
You are referring to the fact that the "val" parameter in my function is 
the non shifted value?
I think this makes the call sites much cleaner.
I get your point about it having the same name but different semantics 
as other functions though.
Would you be happier if I rename this to mc34708_set_bitfield() for example?


>> +static int mc34708_get_voltage_sel(struct regulator_dev *rdev)
>> +{
>> +	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
>> +
>> +	return mc34708_read_bits(mc34708_reg,
>> +				rdev->desc->vsel_reg, rdev->desc->vsel_mask);
>> +}
> Don't open code this, use the standard regmap helpers.
See above.
>
>> +	val = mc34708_read_bits(mc34708_reg,
>> +				mc34708_reg->def->mode_reg,
>> +				mc34708_reg->def->mode_mask);
>> +	if (val < 0)
>> +		return ERR_PTR(val);
>> +
>> +	BUG_ON(val >= mc34708_reg->def->kind->num_hw_modes);
> This is too severe, could be a hardware error.
The purpose of this function is to read a number of bits from the 
hardware and convert this to a hardware mode based on a lookup table.
The size of this lookup table should encompase all the possible values 
read from that bitfield.
Hence a hardware error alone won't trigger this unless the table size 
itself is wrong (a code BUG, not a hardware error).

I could change the check to use the mask though, rather than the value 
read from hardware to make this clearer.
>> +static int mc34708_sw_find_hw_mode_sel(
>> +	const struct mc34708_regulator_kind *kind,
>> +	unsigned int normal,
>> +	unsigned int standby)
>> +{
>> +	const struct mc34708_hw_mode *mode;
>> +	int i;
>> +
>> +	for (i = 0, mode = kind->hw_modes;
>> +			i < kind->num_hw_modes; i++, mode++) {
>> +		if (mode->normal == -1 || mode->standby == -1)
>> +			continue;
>> +
>> +		if (mode->standby != standby)
>> +			continue;
>> +
>> +		if ((mode->normal == normal) ||
>> +		    (normal && (mode->alt_normal == normal)))
>> +			return i;
>> +	}
> I honestly don't really know what the above is supposed to do.  It's
> mapping something to something but what exactly is unclear...  skipping
> most of the rest of the mode code.
The mode code is indeed complicated, but mostly because the hardware 
doesn't map directly nor orthogonally to the regulator framework concepts.

I tried to explain this in the block comments at the start of each the 
code for each type of regulator.
Looks like I failed :(

For the switching regulators:
There is a  4 bit "mode" field (which I call hwmode to distinguish from 
the regulator framework concept of mode.
This field encodes:
* The enable / disable state when the standby signal is not asserted 
(there is no seperate enable bit)
* The enable / disable state when the standby signal is not asserted
* The operating mode when the standby signal is asserted
* The operating mode when the standby signal is not asserted

Not all of the 16 possible values are valid. There is no documented or 
discernable direct mapping of the individual bits.

For the LDO regulators:
There is a dedicated enable bit (ouf)
There are 2 bits (VxMode, VxSTBY) controlling the regulator operating 
mode when the standaby signal is or is not asserted. However these bits 
are not seperate.
 From the comment block:

  *    VxMODE    VxSTBY        Normal    Standby
  *    0    0        ON    ON
  *    0    1        ON    OFF
  *    1    0        LP    LP
  *    1    1        ON    LP
  *

So, the function above takes the desired regulator modes for the normal 
and standby states (or 0 for off) and finds the corresponding hwmode 
(value to write to the register bits).

Then the way I handle all this is just use mc34708_sw_find_hw_mode_sel() 
to recalculate the hardware mode by walking the tables every time 
something needs to change.
The table is different depending on the regulator type.

This turned out to be *much* simpler that the initial open code approach 
I first tried.


>> +static int mc34708_swbst_mode_to_hwmode(unsigned int mode)
>> +{
>> +	switch (mode) {
>> +	case REGULATOR_MODE_IDLE:
>> +	case REGULATOR_MODE_STANDBY:
>> +		return  MC34708_SW_OPMODE_PFM;
> No, this is broken - you're mapping two different modes to one hardware
> setting.  If the device doesn't support something it just doesn't
> support it, let the upper layers work out how to handle that.
Ok
> Also an extra space there.
>
>> +static int mc34708_swbst_setup(struct mc34708_regulator *mc34708_reg)
>> +{
>> +	int val, mode;
>> +
>> +	val = mc34708_read_bits(mc34708_reg,
>> +				mc34708_reg->def->mode_reg,
>> +				mc34708_reg->def->mode_mask);
>> +	if (val < 0)
>> +		return val;
>> +
>> +	if (val > 0) {
>> +		mode = mc34708_swbst_hwmode_to_mode(val);
>> +		if (mode < 0)
>> +			return mode;
>> +
>> +		mc34708_reg->req_mode_normal = mode;
>> +	} else {
>> +		/*
>> +		 * If regulator is intially off we don't know the mode
>> +		 * but we need a mode to be able to enable it later.
>> +		 */
>> +		mc34708_reg->req_mode_normal = REGULATOR_MODE_NORMAL;
>> +	}
> I don't really understand what the above is supposed to do, some
> comments would probably help.
We need to store the desired modes (for normal and standby state) since 
.set_mode() and .set_suspend_mode() are not always called before 
enable() / disable().
For example, for a .enable() on a switching regulator requires the 
desired normal and standby mode to be known (to find the appropriate 
value for the hardware mode bits since there is no hardware enable bit.
I try to determine the current mode at startup to initialise the desired 
mode for a later enable by reading the registers but that is only 
possible if the regulator is already enabled.
The hardware has no concept of "disabled but will be in PFM mode when 
enabled" for example.

>> +static int mc34708_ldo_set_suspend_enable(struct regulator_dev *rdev)
>> +{
>> +	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
>> +	int ret;
>> +
>> +	ret = mc34708_update_hw_mode(mc34708_reg,
>> +				     mc34708_reg->req_mode_normal,
>> +				     mc34708_reg->req_mode_standby);
>> +	if (!ret)
>> +		mc34708_reg->suspend_off = false;
> This looks like it should be a noop.  It also seems very familiar from
> some of the other code.
It's not a noop.

If .set_suspend_disable() is called then later .set_suspend_enable() the 
regulator needs to be recofigured.
Note that neither .set_suspend_enable(), nor .set_suspend_disable() 
change the stored modes (req_mode_normal, req_mode_standby) since the 
regulator framework seperates the concept of enable and mode but this 
hardware does not.
>> +static int mc34708_ldo_set_suspend_mode(struct regulator_dev *rdev,
>> +					unsigned int mode)
>> +{
>> +	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
>> +	int ret;
>> +
>> +	if (!mc34708_ldo_has_mode_bit(mc34708_reg))
>> +		return 0;
> Again, if the driver doesn't support something don't implement it.
>
Ok
>> +static const unsigned int mc34708_vgen1_volt_table[] = {
>> +	1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000, 1550000
>> +};
> This looks like a linear mapping, use the standard helpers please.
Ok
>> +/*
>> + * Setting some LDO standby states also requires changing the normal state.
>> + * Therefore save the LDO configuration register on suspend and restore it
>> + * on resume.
>> + *
>> + * This works because .set_suspend_X are called by the platform suspend handler
>> + * AFTER device suspend
>> + */
> That's not something you can rely on, I suggest omitting this for now
> and doing it separately.
>
>> +	num_regs = of_get_child_count(regs_np);
>> +	mc34708_data = devm_kzalloc(dev, sizeof(*mc34708_data) +
>> +					num_regs * sizeof(*mc34708_reg),
>> +					GFP_KERNEL);
>> +	if (!mc34708_data) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	dev_set_drvdata(dev, mc34708_data);
>> +
>> +	mc34708_reg = mc34708_data->regulators;
>> +	for_each_child_of_node(regs_np, reg_np) {
> No, this is broken - your driver should like all the others register all
> the regulators on the device uncondtionally.  It should also be using
> .of_match to allow the core to look up the init data.
Ok
