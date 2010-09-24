From: l.majewski@samsung.com (Lukasz Majewski)
Date: Fri, 24 Sep 2010 11:08:25 +0200
Subject: [PATCH] mfd: regulator: max8998: BUCK1/2 control augmented by GPIO
	pins
In-Reply-To: <20100921150107.GA32476@sirena.org.uk>
References: <1285078695-24753-1-git-send-email-l.majewski@samsung.com>
	<20100921150107.GA32476@sirena.org.uk>
Message-ID: <20100924110825.138ce87f@lmajewski.digital.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

I'd like to discus the issue with checking if GPIO has been defined
at platform code.

As you pointed out user is NOT obliged to define GPIOs (buck1_set1/2 and
buck2_set3) at platform data.
It is completely valid to have following definition at platform code:

static struct max8998_platform_data goni_max8998_pdata = {
	.num_regulators	= ARRAY_SIZE(goni_regulators),
	.regulators	= goni_regulators,
};

so for the above  
struct max8998_platform_data {
	struct max8998_regulator_data	*regulators;
	int				num_regulators;
	int				irq_base;
	int				ono;
	int				buck1_set1;
	int				buck1_set2;
	int				buck2_set3;
};

buck1_set1/2, buck2_set3 are equal to 0.

In the driver it is necessary to distinguish this to choose proper
execution path:
1. No GPIOs have been defined at platform - use I2C and default GPIO
settings to set voltage for BUCK regulators. It is important to note,
that max8998 regulator driver must not alter the GPIOs.
2. GPIOs have been defined at platform data. Use GPIOs to choose proper
output voltage for BUCK regulators.

Unfortunately there is problem with this distinction and use of
gpio_is_valid.

The gpio_is_valid is simply defined as  

return ((unsigned)number) < ARCH_NR_GPIOS;

For which 0 is also a valid GPIO.
One workaround for this is to check explicitly the condition:
pdata->buck1_set1 != 0 , but this is neither elegant nor it prevents
the situation when on some architecture GPIO 0 is valid.

In my opinion, better is to define following bitfield to struct
max8998_platform_data:
int buck1_set1_gpio_defined :1;
int buck1_set2_gpio_defined :1;
int buck2_set3_gpio_defined :1;

Checking if this is 0 (in a case of not defined GPIO) would solve the
problem in a nice way. The quesion is if this solution would be
accepted to mainline?

Another, less critical issue:
> > +		for (j = 0; j < ARRAY_SIZE(pdata->buck1_vol); j++)
> > {
> > +			if (pdata->buck1_vol[j] == i) {
> > +				max8998->buck1_idx = j;
> > +				buck1_gpio_set(pdata->buck1_set1,
> > +					       pdata->buck1_set2,
> > j);
> > +				break;
> > +			}
> > +			if (j == (ARRAY_SIZE(pdata->buck1_vol) -
> > 1)) {
> > +				/* no predefine regulator found */
> > +				max8998->buck1_idx = j;
> > +				ret =
> > max8998_get_voltage_register(rdev, &reg,
> > +
> > &shift,
> > +
> > &mask);
> > +				ret = max8998_write_reg(i2c, reg,
> > i);
> > +				buck1_gpio_set(pdata->buck1_set1,
> > +					       pdata->buck1_set2,
> > j);
> > +			}  
> 
> So this essentially reserves one of the voltage selections for
> register written values and requires the others to be specified as
> platform data or from the hardware?  It'd be nicer to do this using
> something like rotating through the slots or (better yet) LRU so that
> the driver just figures out which voltages are being used by the
> consumer rather than the platform data having to know exactly which
> voltages will be set by the consumers in advance.

is the replacement algorithm. I think that circular buffer
implementation would be a feasible solution for 4/2 bytes elements
array.

With more extended functionality, when more voltage levels would be
available, more sophisticated approach (like LRU) may be used.

-- 
Best regards,

Lukasz Majewski

Samsung Poland R&D Center
Platform Group
