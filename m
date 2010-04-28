From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Apr 2010 14:52:55 +0100
Subject: [PATCH 10/10] mmp: append device support in jasper
In-Reply-To: <i2x771cded01004280523g5e3b567aled05b1fea293587a@mail.gmail.com>
References: <i2x771cded01004280523g5e3b567aled05b1fea293587a@mail.gmail.com>
Message-ID: <20100428135255.GB8960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 08:23:24AM -0400, Haojian Zhuang wrote:

> +static struct regulator_consumer_supply regulator_supply[] = {

You shouldn't have all your consumer supplies in one big array, each
regulator should have its own set of supplies for the devices connected
to it.

> +	[MAX8925_ID_SD1]	= REGULATOR_SUPPLY("v_sd1", NULL),
> +	[MAX8925_ID_SD2]	= REGULATOR_SUPPLY("v_sd2", NULL),
> +	[MAX8925_ID_SD3]	= REGULATOR_SUPPLY("v_sd3", NULL),
> +	[MAX8925_ID_LDO1]	= REGULATOR_SUPPLY("v_ldo1", NULL),
> +	[MAX8925_ID_LDO2]	= REGULATOR_SUPPLY("v_ldo2", NULL),

None of these supplies should be being defined at all - the supplies
from regulators are for hooking up individual device supplies to the
regulators, you should only have supplies with null devices in
exceptional cases like CPUfreq where no usable struct device exists.

I'm fairly sure this has been pointed out with regard to previous
machines you have submitted regulator support for, it is disappointing
to see the same issue coming up again.

> +#define REG_INIT(_name, _min, _max, _always, _boot)		\
> +{								\
> +	.constraints = {					\
> +		.name		= __stringify(_name),		\
> +		.min_uV		= _min,				\
> +		.max_uV		= _max,				\
> +		.always_on	= _always,			\
> +		.boot_on	= _boot,			\
> +		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,	\
> +	},							\
> +	.num_consumer_supplies	= 1,				\
> +	.consumer_supplies	= &regulator_supply[MAX8925_ID_##_name], \

This macro shouldn't be assuming that there are devices being supplied,
and definitely needs to be able to cope with more than one regulator
using the supply.

> +static struct regulator_init_data regulator_data[] = {
> +	[MAX8925_ID_SD1] = REG_INIT(SD1, 637500, 1425000, 0, 0),
> +	[MAX8925_ID_SD2] = REG_INIT(SD2, 650000, 2225000, 1, 1),
> +	[MAX8925_ID_SD3] = REG_INIT(SD3, 750000, 3900000, 1, 1),
> +	[MAX8925_ID_LDO1] = REG_INIT(LDO1, 750000, 3900000, 1, 1),
> +	[MAX8925_ID_LDO2] = REG_INIT(LDO2, 650000, 2250000, 1, 1),

Have all the voltage ranges you're specifying here been audited against
the board design?  It would be very unusual for every single supply on
the board have such wide voltage ranges - it looks awfully like the
ranges here are the supported ranges for the regulators themselves.
