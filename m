From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 9 Feb 2012 11:24:39 +0000
Subject: [PATCH v4 2/2] Regulator: Add Anatop regulator driver
In-Reply-To: <1328734286-30091-2-git-send-email-paul.liu@linaro.org>
References: <1328734286-30091-2-git-send-email-paul.liu@linaro.org>
Message-ID: <20120209112439.GC3058@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2012 at 04:51:26AM +0800, Ying-Chun Liu (PaulLiu) wrote:

Overall this is looking pretty good, a few issues but relatively minor.

> +	if (uv < anatop_reg->rdata->min_voltage
> +	    || uv > anatop_reg->rdata->max_voltage) {
> +		if (max_uV > anatop_reg->rdata->min_voltage)
> +			uv = anatop_reg->rdata->min_voltage;
> +		else
> +			return -EINVAL;
> +	}

This looks buggy (and is quite hard to follow).  The check for the
voltage being above the minimum voltage is fine but surely if the
voltage is too high then the first if statement will be true and max_uV
will be greater than the minimum voltage so the second if will be true.
This will cause us to choose the minimum voltage that the regulator can
do which is less than the minimum voltage requested.

You probably shouldn't be checking for the upper end of the range at all
here...

> +	if (anatop_reg->rdata->control_reg) {
> +		sel = (uv - anatop_reg->rdata->min_voltage) / 25000;
> +		val = anatop_reg->rdata->min_bit_val + sel;
> +		*selector = sel;
> +		pr_debug("%s: calculated val %d\n", __func__, val);

...instead check that selector is in range here.

> +		anatop_reg->rdata->mfd->write(anatop_reg->rdata->mfd,
> +					      anatop_reg->rdata->control_reg,
> +					      anatop_reg->rdata->vol_bit_shift,
> +					      anatop_reg->rdata->vol_bit_size,
> +					      val);

Just have a write() function in the MFD.

> +	memset(rdesc, 0, sizeof(struct regulator_desc));
> +	rdesc->name = kstrdup(of_get_property(np, "regulator-name", NULL),
> +			      GFP_KERNEL);

You should add binding documentation for the device since it's OF based.

> +	sreg->rdata->name = kstrdup(rdesc->name, GFP_KERNEL);

Can't you just point to rdesc->name?

> +	if (IS_ERR(rdev)) {
> +		dev_err(&pdev->dev, "failed to register %s\n",
> +			rdesc->name);
> +		return PTR_ERR(rdev);
> +	}

All your kstrdup()s need to be unwound in error and free cases.

> +int anatop_regulator_init(void)
> +{
> +	return platform_driver_register(&anatop_regulator);
> +}
> +
> +void anatop_regulator_exit(void)
> +{
> +	platform_driver_unregister(&anatop_regulator);
> +}
> +
> +postcore_initcall(anatop_regulator_init);
> +module_exit(anatop_regulator_exit);

These should be adjacent to the functions.

> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");

Either omit this or put one or more humans as the author.

> +struct anatop_regulator {
> +       struct regulator_desc *regulator;
> +       struct regulator_init_data *initdata;
> +       struct anatop_regulator_data *rdata;
> +};

May as well just merge the regulator data in here - it's not ever used
except with a 1:1 relationship between them.  Could also directly
embed the desc and init_data, then you just have one allocation for the
data rather than a series to error check.

> +int anatop_register_regulator(
> +		struct anatop_regulator *reg_data, int reg,
> +		      struct regulator_init_data *initdata);

This looks like it's not defined any more so could be removed and since
you only appear to support OF the entire header could be merged into the
driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120209/06f638d6/attachment.sig>
