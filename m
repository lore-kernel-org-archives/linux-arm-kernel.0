From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Sep 2010 16:01:08 +0100
Subject: [PATCH] mfd: regulator: max8998: BUCK1/2 control augmented by
	GPIO pins
In-Reply-To: <1285078695-24753-1-git-send-email-l.majewski@samsung.com>
References: <1285078695-24753-1-git-send-email-l.majewski@samsung.com>
Message-ID: <20100921150107.GA32476@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 21, 2010 at 04:18:15PM +0200, Lukasz Majewski wrote:
> This patch facilitates the faster voltage change for BUCK1/2 regulators. It uses
> MAX8998 GPIO pins to control output voltage. This feature is extremely useful
> for Dynamic Voltage Scalling (DVS) implementation.
> This patch has been tested at Samsung GONI and AQUILA targets.
> Corresponding platform code will be submitted in a separate patch.

This would be easier to review if split out into a series - there's at
least one change here which is basic code motion, splitting the LDO and
DCDC handling into separate functions, and probably more.

> +	unsigned int		buck1_idx;
> +	unsigned int		buck2_idx;

Comments explaining what this is for might help.

> +	previous_vol = max8998_get_voltage(rdev);
> +
> +	/* Check if voltage needs to be changed */
> +	/* if previous_voltage equal new voltage, return */
> +	if (previous_vol == max8998_list_voltage(rdev, i)) {
> +		dev_dbg(max8998->dev, "No voltage change, old:%d, new:%d\n",
> +			previous_vol, max8998_list_voltage(rdev, i));
> +		return ret;
> +	}
> +	if (ldo == MAX8998_BUCK1) {

Some blank lines would help a lot with the legibility of the code, as
would using something other than ldo as the variable identifying the
DCDC.  Also, this series of if statements should be a switch statement.

> +		dvs_arm_no = ARRAY_SIZE(pdata->dvsarm);
> +		dev_dbg(max8998->dev,
> +			"BUCK1, i:%d, dvs1:%d, dvs2:%d, dvs3:%d, dvs4:%d\n",
> +			i, pdata->dvsarm[0], pdata->dvsarm[1],
> +			pdata->dvsarm[2], pdata->dvsarm[3]);

All this code is assuming that BUCK1 is supplying the ARM core.  While
this may be likely the code shouldn't be making that assumption.

> +	/* Wait until voltage is stabilized */
> +	max8998_read_reg(i2c, MAX8998_REG_ONOFF4, &val);
> +	/* lp3974 hasn't got ENRAMP bit - ramp is assumed as true */
> +	dev_dbg(max8998->dev, "name:%s\n", i2c->name);
> +	if (max8998->iodev->type == TYPE_LP3974) {
> +		difference = desc->min + desc->step*i - previous_vol/1000;
>  		if (difference > 0)
>  			udelay(difference / ((val & 0x0f) + 1));
>  	}

This code shouldn't be here, you should be providing an enable_time()
function.

> +	/* Check if platform data for max8998 has been declared */
> +	if (pdata->dvsarm[0] != 0 && pdata->dvsarm[1] != 0 &&
> +	    pdata->dvsarm[2] != 0 && pdata->dvsarm[3] != 0 &&
> +	    pdata->dvsint[0] != 0 && pdata->dvsint[1] != 0) {

Why must GPIOs be specified for both regulators?  The user should be
able to set only one up to use GPIOs.

> +			/* Set default values */
> +			max8998->buck1_idx = 3;
> +			max8998->buck2_idx = 1;

This looks awfully like it should come from platform data.

> +	if (pdata->set1 != 0 && pdata->set2 != 0 && pdata->set3 != 0) {

gpio_is_valid().

> +			gpio_request(pdata->set1, "PMIC SET1");
> +			gpio_direction_output(pdata->set1,
> +					      max8998->buck1_idx & 0x1);

Use the name of the chip rather than PMIC, there may be more than one
PMIC.

> +enum {
> +	MAX8998_DVS_750mV,

I suspect the actual values for this enum are important, I'd expect to
see them forced with an explicit = somewhere.  I'd also expect this to
be hidden in the driver code and users just to specify voltages
directly.  You already have the code to map voltages into these enums
inside the driver so no need to expose it to users.

>  /**
>   * max8998_regulator_data - regulator data
>   * @id: regulator id
> @@ -76,6 +111,13 @@ struct max8998_platform_data {
>  	int				num_regulators;
>  	int				irq_base;
>  	int				ono;
> +	u8              dvsarm[4];
> +	u8		dvsint[2];
> +	u8              dvsarm_init;
> +	u8              dvsint_init;

As mentioned previously these should be named after the regulators, not
after their uses on your boards.  You also need some documentation
explaining what to do with these fields, they're not immediately
obvious.  

For the voltage selection values I'm somewhat surprised to see them
specified in the platform data - I would instead expect to see them
figured out at runtime based on the voltages that are being set.

> +	int		set1;
> +	int		set2;
> +	int		set3;

These need documentation too.
