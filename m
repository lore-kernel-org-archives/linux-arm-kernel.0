From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 20 Mar 2014 10:28:37 -0500
Subject: [PATCH 1/1] regulator: Add new driver for ST's PWM controlled
 voltage regulators
In-Reply-To: <1395324654-8235-1-git-send-email-lee.jones@linaro.org>
References: <1395324654-8235-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140320152837.GW18529@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Lee-

A few minor things below.

On Thu, Mar 20, 2014 at 02:10:54PM +0000, Lee Jones wrote:
> On some STMicroelectronics hardware reside regulators consisting
> partly of a PWM input connected to the feedback loop. As the PWM
> duty-cycle is varied the output voltage adapts. This driver
> allows us to vary the output voltage by adapting the PWM input
> duty-cycle.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> --- /dev/null
> +++ b/drivers/regulator/st-pwm.c
> +static int st_pwm_regulator_set_voltage(struct regulator_dev *dev,
> +					int min_uV, int max_uV,
> +					unsigned *selector)
> +{
> +	struct st_pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
> +	int dutycycle, best_val = INT_MAX;
> +	int sel, ret;
> +
> +	for (sel = 0; sel < dev->desc->n_voltages; sel++) {
> +		if (drvdata->duty_cycle_table[sel].uV < best_val &&
> +		    drvdata->duty_cycle_table[sel].uV >= min_uV &&
> +		    drvdata->duty_cycle_table[sel].uV <= max_uV) {
> +			best_val = drvdata->duty_cycle_table[sel].uV;
> +			if (selector)
> +				*selector = sel;
> +		}
> +	}

If you implement .set_voltage_sel() instead and set map_voltage to
regulator_map_voltage_iterate, the core can take care of this.

> +
> +	if (best_val == INT_MAX)
> +		return -EINVAL;
> +
> +	dutycycle = (ST_PWM_REG_PERIOD / 100) *
> +		drvdata->duty_cycle_table[sel].dutycycle;

Considering (ST_PWM_REG_PERIOD / 100) is constant, could you get away
with dropping this calculation by just putting the already-adjusted
values into your duty cycle table?

> +
> +	ret = pwm_config(drvdata->pwm, dutycycle, ST_PWM_REG_PERIOD);
> +	if (ret) {
> +		dev_err(&dev->dev, "Failed to configure PWM\n");
> +		return ret;
> +	}
> +
> +	drvdata->state = sel;
> +
> +	if (!drvdata->enabled) {
> +		ret = pwm_enable(drvdata->pwm);
> +		if (ret) {
> +			dev_err(&dev->dev, "Failed to enable PWM\n");
> +			return ret;
> +		}
> +		drvdata->enabled = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int st_pwm_regulator_list_voltage(struct regulator_dev *dev,
> +					 unsigned selector)
> +{
> +	struct st_pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
> +
> +	if (selector >= dev->desc->n_voltages)
> +		return -EINVAL;
> +
> +	return drvdata->duty_cycle_table[selector].uV;
> +}
> +
> +static struct regulator_ops st_pwm_regulator_voltage_ops = {
> +	.get_voltage  = st_pwm_regulator_get_voltage,
> +	.set_voltage  = st_pwm_regulator_set_voltage,
> +	.list_voltage = st_pwm_regulator_list_voltage,
> +};
> +
> +static struct st_pwm_voltages b2105_duty_cycle_table[] = {
> +	{ .uV = 1114000, .dutycycle = 0,  },
> +	{ .uV = 1095000, .dutycycle = 10, },
> +	{ .uV = 1076000, .dutycycle = 20, },
> +	{ .uV = 1056000, .dutycycle = 30, },
> +	{ .uV = 1036000, .dutycycle = 40, },
> +	{ .uV =  996000, .dutycycle = 50, },
> +	/* WARNING: Values above 50% duty-cycle cause boot failures. */
> +};
> +
> +static struct regulator_desc b2105_desc = {
> +	.name		= "b2105-pwm-regulator",
> +	.ops		= &st_pwm_regulator_voltage_ops,
> +	.type		= REGULATOR_VOLTAGE,
> +	.owner		= THIS_MODULE,
> +	.n_voltages	= ARRAY_SIZE(b2105_duty_cycle_table),
> +	.supply_name    = "pwm",
> +};
> +
> +static struct st_pwm_regulator_data b2105_info = {
> +	.desc		  = &b2105_desc,
> +	.duty_cycle_table = b2105_duty_cycle_table,
> +};
> +
> +static struct of_device_id st_pwm_of_match[] = {

const.  At least the regulator_desc and duty cycle table should be const
as well. (see my comments below about b2105_info).

> +	{ .compatible = "st,b2105-pwm-regulator", .data = &b2105_info, },
> +	{ },
> +};

You may want a MODULE_DEVICE_TABLE(of, ...); here if you want to be able
to be autoloaded.

> +
> +static int st_pwm_regulator_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct st_pwm_regulator_data *drvdata;
> +	const struct of_device_id *of_match;
> +	struct regulator_dev *regulator;
> +	struct regulator_config config = { };
> +
> +	if (!np) {
> +		dev_err(&pdev->dev, "Device Tree node missing\n");
> +		return -EINVAL;
> +	}
> +
> +	of_match = of_match_device(st_pwm_of_match, &pdev->dev);
> +	if (!of_match) {
> +		dev_err(&pdev->dev, "failed to match of device\n");
> +		return -ENODEV;
> +	}
> +	drvdata =  (struct st_pwm_regulator_data *) of_match->data;

Hrm, I typed "cast not necessary here", but then I realized it is
necessary since you using it to cast away constness.

Are you safe assuming that there will only be one of these devices in a
system?  It doesn't seem like much a burden to just allocate a new
object and use it instead of a statically allocated one.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
