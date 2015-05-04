From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 May 2015 13:36:48 +0100
Subject: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
In-Reply-To: <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20150504123648.GU15510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 10:32:26PM +0000, Stefan Wahren wrote:

> +static struct regulator_ops mxs_dcdc_ops = {
> +	.is_enabled		= regulator_is_enabled_regmap,
> +};

Why do we have an is_enabled() operation but no enable or disable
operation?  I'm also not 100% clear what code the DCDCs and LDOs are
sharing here...

> +	initdata = of_get_regulator_init_data(dev, dev->of_node, &info->desc);
> +	if (!initdata) {
> +		dev_err(dev, "missing regulator init data\n");
> +		return -EINVAL;
> +	}

This is not an error, init data is totally optional.

> +	rdev = devm_regulator_register(dev, &info->desc, &config);
> +	if (IS_ERR(rdev)) {
> +		int ret = PTR_ERR(rdev);
> +
> +		dev_err(dev, "%s: failed to register regulator(%d)\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	if (!of_property_read_u32(dev->of_node, "switching-frequency",
> +				  &switch_freq))
> +		mxs_set_dcdc_freq(rdev, switch_freq);

why are we registering the regulator before we've finished parsing the
DT - I'd expect us to do this first rather than have things potentially
start using the regulator with the confguration not completed.

> +	platform_set_drvdata(pdev, rdev);

This looks unsafe - either we don't need to set this at all or one of
the ops could be invoked when the regulator is registered and try to use
the driver data before it is set.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150504/083c0c5d/attachment.sig>
