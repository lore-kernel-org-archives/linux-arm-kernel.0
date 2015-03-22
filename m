From: broonie@kernel.org (Mark Brown)
Date: Sun, 22 Mar 2015 16:14:25 +0000
Subject: [PATCH 4/7] regulator: add mxs regulator driver
In-Reply-To: <1426984203-9133-5-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-5-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20150322161425.GC6643@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 22, 2015 at 12:30:00AM +0000, Stefan Wahren wrote:

> +	/* Accept only values recommend by Freescale */
> +	switch (khz) {
> +	case 19200:
> +		val |= HW_POWER_MISC_FREQSEL_19200_KHZ << SHIFT_FREQSEL;
> +		break;
> +	case 20000:
> +		val |= HW_POWER_MISC_FREQSEL_20000_KHZ << SHIFT_FREQSEL;
> +		break;
> +	case 24000:
> +		val |= HW_POWER_MISC_FREQSEL_24000_KHZ << SHIFT_FREQSEL;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	if (ret)
> +		return ret;

Just return directly, it'd be a bit easier to follow.  It'd also be
better to print an error message saying we're rejecting the value - that
will make it easier for someone writing a DT to figure out that they
have made a typo or whatever.

> +static int mxs_ldo_set_voltage_sel(struct regulator_dev *reg, unsigned sel)
> +{
> +	struct mxs_ldo *ldo = rdev_get_drvdata(reg);
> +	struct regulator_desc *desc = &ldo->desc;
> +	unsigned long start;
> +	u32 regs;
> +	int uV;
> +	u8 power_source = HW_POWER_UNKNOWN_SOURCE;
> +
> +	uV = regulator_list_voltage_linear(reg, sel);

This would be strange execpt uV doesn't seem to be referenced at all so
it could be removed instead.

> +	if (ldo->get_power_source)
> +		power_source = ldo->get_power_source(reg);
> +
> +	switch (power_source) {
> +	case HW_POWER_LINREG_DCDC_OFF:
> +	case HW_POWER_LINREG_DCDC_READY:
> +	case HW_POWER_EXTERNAL_SOURCE_5V:
> +		usleep_range(1000, 2000);
> +		return 0;
> +	}

I'd expect the switch to be in the if here?

> +
> +	usleep_range(15, 20);
> +	start = jiffies;
> +	while (1) {
> +		if (readl(ldo->status_addr) & BM_POWER_STS_DC_OK)
> +			return 0;
> +
> +		if (time_after(jiffies, start +	msecs_to_jiffies(20)))
> +			break;
> +
> +		schedule();
> +	}

So, this isn't actually quite a busy wait because we do a schedule()
rather than a cpu_relax() but still it could devolve into that - 20ms
seems a long time to burn doing that.  If we're expecting this to finish
very quickly can we do an initial busy wait then fall back to something
with an actual sleep or soemthing?

> +static int mxs_ldo_get_voltage_sel(struct regulator_dev *reg)
> +{
> +	struct mxs_ldo *ldo = rdev_get_drvdata(reg);
> +	struct regulator_desc *desc = &ldo->desc;
> +	int ret, uV;
> +
> +	ret = readl(ldo->base_addr) & desc->vsel_mask;
> +	uV = regulator_list_voltage_linear(reg, ret);
> +
> +	return ret;
> +}

Again with the uV lookup...

> +static int mxs_ldo_is_enabled(struct regulator_dev *reg)
> +{
> +	struct mxs_ldo *ldo = rdev_get_drvdata(reg);
> +	u8 power_source = HW_POWER_UNKNOWN_SOURCE;
> +
> +	if (ldo->get_power_source)
> +		power_source = ldo->get_power_source(reg);
> +
> +	switch (power_source) {
> +	case HW_POWER_LINREG_DCDC_OFF:
> +	case HW_POWER_LINREG_DCDC_READY:
> +	case HW_POWER_DCDC_LINREG_ON:
> +		return 1;
> +	}
> +
> +	return 0;
> +}

Some comments explaining what the logic here is might be helpful, it's
all a bit surprising.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150322/ff18cbbb/attachment.sig>
