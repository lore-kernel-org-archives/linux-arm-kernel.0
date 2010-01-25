From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Jan 2010 13:56:28 +0000
Subject: [PATCH 01/01] regulator: support max8649
In-Reply-To: <771cded01001250301q465a9f8ma484f597ae9a292f@mail.gmail.com>
References: <771cded01001120041ue24edabk8e4638ef7151c947@mail.gmail.com>
	<771cded01001120051l44fd76bx80d2fd4b6f60bd0b@mail.gmail.com>
	<20100112115156.GA546@rakim.wolfsonmicro.main>
	<771cded01001250301q465a9f8ma484f597ae9a292f@mail.gmail.com>
Message-ID: <20100125135628.GB26613@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 06:01:41AM -0500, Haojian Zhuang wrote:
> On Tue, Jan 12, 2010 at 6:51 AM, Mark Brown

> >> + ? ? if (pdata->ramp_timing) {
> >> + ? ? ? ? ? ? info->ramp_timing = pdata->ramp_timing;
> >> + ? ? ? ? ? ? max8649_set_bits(info->i2c, MAX8649_RAMP, MAX8649_RAMP_MASK,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?info->ramp_timing << 5);
> >> + ? ? }

> > You might want to implement the new enable_time() API for this.

> This ramp timing is the time interval of each step on adjusting
> voltage. I just want to control the timing in initialization.

If this applies to any voltage change at all then rather than just power
on I need to finish off the stuff I've been sitting on for handling slew
times for voltage changes.  If the regulator hasn't yet reached the
requested output when the consumer tries using it the consumer might get
broken.

If the ramp also gets applied when initially turning on the regulator
you'd still want to implement enable_time() for the same reason.

> enable_time() is only called before enabling regulator. And I don't
> understand what would be done in enable_time().

You'd return the amount of time taken to turn on the regulator and get
the output voltage stable in the current configuration.  This will then
be used by the core to ensure that the consumer only tries to use the
regulator once it's fully enabled.

> +static int max8649_set_mode(struct regulator_dev *rdev, unsigned int mode)
> +{
> +	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
> +
> +	switch (mode) {
> +	case REGULATOR_MODE_FAST:
> +	case REGULATOR_MODE_NORMAL:
> +		max8649_set_bits(info->i2c, info->vol_reg, MAX8649_FORCE_PWM,
> +				 MAX8649_FORCE_PWM);
> +		break;

Are you sure about this?  I'd expect to see force PWM used only for
_FAST, for _NORMAL pulse skipping is usually desired behaviour.

> +	case REGULATOR_MODE_IDLE:
> +	case REGULATOR_MODE_STANDBY:
> +		max8649_set_bits(info->i2c, info->vol_reg,
> +				 MAX8649_FORCE_PWM, 0);

I'd just leave these unimplemented (there's no need to support all
modes) and make sure that this ties in with...

> +static unsigned int max8649_get_mode(struct regulator_dev *rdev)
> +{
> +	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
> +	int ret;
> +
> +	ret = max8649_reg_read(info->i2c, info->vol_reg);
> +	if (ret & MAX8649_FORCE_PWM)
> +		return REGULATOR_MODE_NORMAL;
> +	return REGULATOR_MODE_IDLE;

...this.
