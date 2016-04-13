From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 Apr 2016 07:15:14 +0100
Subject: [PATCH 2/5] regulator: st-flashss: Add a regulator driver for
 flashss vsense.
In-Reply-To: <1460474204-5351-3-git-send-email-peter.griffin@linaro.org>
References: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
 <1460474204-5351-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160413061514.GI14664@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 04:16:41PM +0100, Peter Griffin wrote:

> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 61bfbb9..10be29b 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -108,6 +108,6 @@ obj-$(CONFIG_REGULATOR_WM831X) += wm831x-ldo.o
>  obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8994) += wm8994-regulator.o
> -
> +obj-$(CONFIG_REGULATOR_ST_FLASHSS) += st-flashss.o

Please keep Kconfig and Makefile sorted.  :/

> +static int st_set_voltage_sel(struct regulator_dev *dev, unsigned int selector)

This and the get_voltage_sel() look like you can just use a MMIO regmap.

> +	voltage = st_type_voltages[selector];

No bounds checking on the array, though since you're working with
selectors it doesn't seem like there's any need to do this.

> +	value |= vsense->en_psw_mask;

Enable should be a separate operation.

> +static void st_get_satinize_powerup_voltage(struct st_vsense *vsense)
> +{
> +	void __iomem *ioaddr = vsense->ioaddr;
> +	u32 value = readl_relaxed(ioaddr);
> +
> +	dev_dbg(vsense->dev, "Initial start-up value: (0x%08x)\n", value);
> +
> +	/* Sanitize voltage values forcing what is provided from start-up */
> +	if (value & TOP_VSENSE_CONFIG_LATCHED_PSW_EMMC)
> +		value |= TOP_VSENSE_CONFIG_REG_PSW_EMMC;
> +	else
> +		value &= ~TOP_VSENSE_CONFIG_REG_PSW_EMMC;
> +
> +	if (value & TOP_VSENSE_CONFIG_LATCHED_PSW_NAND)
> +		value |= TOP_VSENSE_CONFIG_REG_PSW_NAND;
> +	else
> +		value &= ~TOP_VSENSE_CONFIG_REG_PSW_NAND;
> +
> +	if (value & TOP_VSENSE_CONFIG_LATCHED_PSW_SPI)
> +		value |= TOP_VSENSE_CONFIG_REG_PSW_SPI;
> +	else
> +		value &= ~TOP_VSENSE_CONFIG_REG_PSW_SPI;

This looks like a very complicated way of writing

	value &= TOP_VSENSE_CONFIG_LATCHED_PSW_SPI | 
		TOP_VSENSE_CONFIG_LATCHED_PSW_NAND |
		TOP_VSENSE_CONFIG_REG_PSW_EMMC

or am I missing something?  Why do we need to do this anyway, it's very
surprsing?

> +	if (device->data) {
> +		const struct st_vsense *data = device->data;
> +
> +		vsense->en_psw_mask = data->en_psw_mask;
> +		vsense->psw_mask = data->psw_mask;
> +		vsense->latched_mask = data->latched_mask;
> +	} else
> +		return -ENODEV;

Coding style, { } on both sides.

> +
> +	if (of_property_read_string(np, "regulator-name",
> +				    (const char **)&vsense->name))
> +		return -EINVAL;

Don't make this mandatory, that's not what it's for.  Use the compatible
if you really need something, or just make the framework cope with a
missing name (eg, by using dev_name() or something).

> +	config.init_data = of_get_regulator_init_data(&pdev->dev, np, rdesc);
> +	if (!config.init_data) {
> +		dev_err(dev, "Failed to parse regulator init data\n");
> +		return -ENOMEM;
> +	}

Don't error out, carry on and let the driver work in read only mode for
diagnostics.

> +	/* register regulator */
> +	rdev = regulator_register(rdesc, &config);

devm_regulator_register().

> +	dev_info(dev, "%s  vsense voltage regulator registered\n", rdesc->name);

Remove this, it's just making the boot noisy.

> +static int __init st_vsense_init(void)
> +{
> +	return platform_driver_register(&st_vsense_driver);
> +}
> +
> +subsys_initcall(st_vsense_init);

module_platform_driver().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160413/e7c0ce72/attachment.sig>
