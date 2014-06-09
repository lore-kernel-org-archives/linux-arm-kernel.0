From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 10 Jun 2014 01:29:17 +0200
Subject: [PATCH 2/5] regulator: Add driver for Maxim 77802 PMIC regulators
In-Reply-To: <20140609193849.GE5099@sirena.org.uk>
References: <1402306670-17041-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402306670-17041-3-git-send-email-javier.martinez@collabora.co.uk>
 <20140609193849.GE5099@sirena.org.uk>
Message-ID: <5396434D.3020402@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

Thanks a lot for your feedback.

On 06/09/2014 09:38 PM, Mark Brown wrote:
> On Mon, Jun 09, 2014 at 11:37:47AM +0200, Javier Martinez Canillas wrote:
> 
>> +	case REGULATOR_MODE_STANDBY:			/* switch off */
>> +		if (id != MAX77802_LDO1 && id != MAX77802_LDO20 &&
>> +			id != MAX77802_LDO21 && id != MAX77802_LDO3) {
>> +			val = MAX77802_OPMODE_STANDBY;
>> +			break;
>> +		}
>> +		/* no break */
> 
> This sounds very broken...
>

The problem is that not all regulators supports the same operational modes. For
instance regulators LDO 1, 20, 21 and 3 does not support REGULATOR_MODE_STANDBY
so if the condition is not met a break is not needed since the default case is
to warn that the mode is not supported.

But I'll rework that logic on v2 to make it cleaner and have a break on each
case and don't rely on case cascading.

>> +		/* OK if some GPIOs aren't defined */
>> +		if (!gpio_is_valid(gpio))
>> +			continue;
>> +
>> +		/* If a GPIO is valid, we'd better be able to claim it */
>> +		ret = devm_gpio_request_one(dev, gpio, GPIOF_OUT_INIT_HIGH,
>> +					    "max77802 selb");
>> +		if (ret) {
>> +			dev_err(dev, "can't claim gpio[%d]: %d\n", i, ret);
>> +			return ret;
>> +		}
> 
> Can this use the GPIO descriptor API?
> 

Ok, I'll use gpiod_request() on v2.

>> +static void max77802_copy_reg(struct device *dev, struct regmap *regmap,
>> +			      int from_reg, int to_reg)
>> +{
>> +	int val;
>> +	int ret;
>> +
>> +	if (from_reg == to_reg)
>> +		return;
>> +
>> +	ret = regmap_read(regmap, from_reg, &val);
>> +	if (!ret)
>> +		ret = regmap_write(regmap, to_reg, val);
>> +
>> +	if (ret)
>> +		dev_warn(dev, "Copy err %d => %d (%d)\n",
>> +			 from_reg, to_reg, ret);
>> +}
> 
> This doesn't look at all device specific, better implement it in generic
> code.
> 

Ok, will do.

>> +	if (pdata->num_regulators != MAX77802_MAX_REGULATORS) {
>> +		dev_err(&pdev->dev,
>> +			"Invalid initial data for regulator's initialiation: " \
>> +			"expected %d, pdata/dt provided %d\n",
>> +			MAX77802_MAX_REGULATORS,
>> +			pdata->num_regulators);
>> +		return -EINVAL;
>> +	}
> 
> Don't split log messages over multiple lines so people can find the log
> message in the kernel source with grep, though in any case checking for
> this is a bug - the driver should always be at least able to read the
> current state from the hardware.
> 

Ok.

>> +static int __init max77802_pmic_init(void)
>> +{
>> +	return platform_driver_register(&max77802_pmic_driver);
>> +}
>> +subsys_initcall(max77802_pmic_init);
> 
> module_platform_driver().
> 

Ok.

Best regards,
Javier
