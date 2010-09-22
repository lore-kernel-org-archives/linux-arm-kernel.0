From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Sep 2010 17:11:05 +0100
Subject: [PATCH v2 1/3] mfd: regulator: max8998: set_voltage_buck
	routine added
In-Reply-To: <1285169410-22343-2-git-send-email-l.majewski@samsung.com>
References: <1285169410-22343-1-git-send-email-l.majewski@samsung.com>
	<1285169410-22343-2-git-send-email-l.majewski@samsung.com>
Message-ID: <20100922161104.GL26395@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 22, 2010 at 05:30:08PM +0200, Lukasz Majewski wrote:
> Separate routine for setting BUCK regulators voltage.

This is doing more than that...

> +	unsigned int		buck1_idx; /* voltage index (0 to 3) */
> +	unsigned int		buck2_idx; /* voltage index (0 to 1) */

...it's also changing things over to use this new GPIO based selection
scheme.  This is rather missing the point of my suggestion to split the
code reorganisation out from the new functionality - the goal is to just
have the code motion and then separately add the new functionality.

See also my comments about ensuring each patch in the series is
buildable.

> +		for (j = 0; j < ARRAY_SIZE(pdata->buck1_vol); j++) {
> +			if (pdata->buck1_vol[j] == i) {
> +				max8998->buck1_idx = j;
> +				buck1_gpio_set(pdata->buck1_set1,
> +					       pdata->buck1_set2, j);
> +				break;
> +			}
> +			if (j == (ARRAY_SIZE(pdata->buck1_vol) - 1)) {
> +				/* no predefine regulator found */
> +				max8998->buck1_idx = j;
> +				ret = max8998_get_voltage_register(rdev, &reg,
> +								   &shift,
> +								   &mask);
> +				ret = max8998_write_reg(i2c, reg, i);
> +				buck1_gpio_set(pdata->buck1_set1,
> +					       pdata->buck1_set2, j);
> +			}

So this essentially reserves one of the voltage selections for register
written values and requires the others to be specified as platform data
or from the hardware?  It'd be nicer to do this using something like
rotating through the slots or (better yet) LRU so that the driver just
figures out which voltages are being used by the consumer rather than
the platform data having to know exactly which voltages will be set by
the consumers in advance.

> +		if (pdata->buck2_vol[0] == i) {
> +			max8998->buck1_idx = 0;
> +			buck2_gpio_set(pdata->buck2_set3, 0);
> +		} else {
> +			max8998->buck1_idx = 1;
> +			ret = max8998_get_voltage_register(rdev, &reg,
> +							   &shift, &mask);
> +			ret = max8998_write_reg(i2c, reg, i);
> +			buck2_gpio_set(pdata->buck2_set3, 1);
> +		}

Ditto here.  The WM831x driver is an example of being smarter about
this.
