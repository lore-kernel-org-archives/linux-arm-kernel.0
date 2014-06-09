From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Jun 2014 20:38:49 +0100
Subject: [PATCH 2/5] regulator: Add driver for Maxim 77802 PMIC regulators
In-Reply-To: <1402306670-17041-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1402306670-17041-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402306670-17041-3-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140609193849.GE5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 09, 2014 at 11:37:47AM +0200, Javier Martinez Canillas wrote:

> +	case REGULATOR_MODE_STANDBY:			/* switch off */
> +		if (id != MAX77802_LDO1 && id != MAX77802_LDO20 &&
> +			id != MAX77802_LDO21 && id != MAX77802_LDO3) {
> +			val = MAX77802_OPMODE_STANDBY;
> +			break;
> +		}
> +		/* no break */

This sounds very broken...

> +		/* OK if some GPIOs aren't defined */
> +		if (!gpio_is_valid(gpio))
> +			continue;
> +
> +		/* If a GPIO is valid, we'd better be able to claim it */
> +		ret = devm_gpio_request_one(dev, gpio, GPIOF_OUT_INIT_HIGH,
> +					    "max77802 selb");
> +		if (ret) {
> +			dev_err(dev, "can't claim gpio[%d]: %d\n", i, ret);
> +			return ret;
> +		}

Can this use the GPIO descriptor API?

> +static void max77802_copy_reg(struct device *dev, struct regmap *regmap,
> +			      int from_reg, int to_reg)
> +{
> +	int val;
> +	int ret;
> +
> +	if (from_reg == to_reg)
> +		return;
> +
> +	ret = regmap_read(regmap, from_reg, &val);
> +	if (!ret)
> +		ret = regmap_write(regmap, to_reg, val);
> +
> +	if (ret)
> +		dev_warn(dev, "Copy err %d => %d (%d)\n",
> +			 from_reg, to_reg, ret);
> +}

This doesn't look at all device specific, better implement it in generic
code.

> +	if (pdata->num_regulators != MAX77802_MAX_REGULATORS) {
> +		dev_err(&pdev->dev,
> +			"Invalid initial data for regulator's initialiation: " \
> +			"expected %d, pdata/dt provided %d\n",
> +			MAX77802_MAX_REGULATORS,
> +			pdata->num_regulators);
> +		return -EINVAL;
> +	}

Don't split log messages over multiple lines so people can find the log
message in the kernel source with grep, though in any case checking for
this is a bug - the driver should always be at least able to read the
current state from the hardware.

> +static int __init max77802_pmic_init(void)
> +{
> +	return platform_driver_register(&max77802_pmic_driver);
> +}
> +subsys_initcall(max77802_pmic_init);

module_platform_driver().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140609/7365afd5/attachment.sig>
