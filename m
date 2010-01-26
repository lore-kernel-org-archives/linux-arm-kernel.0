From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jan 2010 11:04:20 +0000
Subject: [PATCH 01/01] regulator: support max8649
In-Reply-To: <771cded01001252226k342723b3p3ea235fe79c46843@mail.gmail.com>
References: <771cded01001120041ue24edabk8e4638ef7151c947@mail.gmail.com>
	<771cded01001120051l44fd76bx80d2fd4b6f60bd0b@mail.gmail.com>
	<20100112115156.GA546@rakim.wolfsonmicro.main>
	<771cded01001250301q465a9f8ma484f597ae9a292f@mail.gmail.com>
	<20100125135628.GB26613@rakim.wolfsonmicro.main>
	<771cded01001252226k342723b3p3ea235fe79c46843@mail.gmail.com>
Message-ID: <20100126110420.GI15759@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 01:26:08AM -0500, Haojian Zhuang wrote:

This all looks good except...

> +static int max8649_enable_time(struct regulator_dev *rdev)
> +{

...

> +	return (voltage / step);

I'd expect the time taken to enable to be the voltage multipled by the
step size rather than divided by the step size?

> +static int max8649_set_mode(struct regulator_dev *rdev, unsigned int mode)
> +{
> +	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
> +
> +	switch (mode) {
> +	case REGULATOR_MODE_FAST:
> +		max8649_set_bits(info->i2c, info->vol_reg, MAX8649_FORCE_PWM,
> +				 MAX8649_FORCE_PWM);
> +		break;
> +	case REGULATOR_MODE_NORMAL:
> +		max8649_set_bits(info->i2c, info->vol_reg,
> +				 MAX8649_FORCE_PWM, 0);
> +		break;

This should really have a default case which rejects other modes.
