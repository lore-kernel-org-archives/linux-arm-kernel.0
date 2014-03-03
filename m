From: broonie@kernel.org (Mark Brown)
Date: Mon, 3 Mar 2014 10:56:16 +0900
Subject: [PATCH 6/7] regulator: AXP20x: Add support for regulators
 subsystem
In-Reply-To: <1393692352-10839-7-git-send-email-carlo@caione.org>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-7-git-send-email-carlo@caione.org>
Message-ID: <20140303015616.GN2411@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 01, 2014 at 05:45:51PM +0100, Carlo Caione wrote:

> index d59c826..0cef101 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -69,3 +69,4 @@ CONFIG_NFS_FS=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_NLS=y
>  CONFIG_PRINTK_TIME=y
> +CONFIG_REGULATOR_AXP20X=y

If you want to update the defconfig do it in a separate patch.

> +static int axp20x_set_suspend_voltage(struct regulator_dev *rdev, int uV)
> +{
> +	return regulator_set_voltage_sel_regmap(rdev, 0);
> +}

I'm not entirely clear what this is supposed to do but it's broken - it
both ignores the voltage that is passed in and immediately writes to the
normal voltage select register which will presumably distrupt the system.

> +static int axp20x_io_enable_regmap(struct regulator_dev *rdev)
> +{
> +	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
> +				  rdev->desc->enable_mask, AXP20X_IO_ENABLED);
> +}

Please make some helpers for this (or extend the existing ones to cope
with more than a single bit control) - there's several other devices
which have similar multi-bit controls so we should factor this out
rather than open coding.

> +	np = of_node_get(pdev->dev.parent->of_node);
> +	if (!np)
> +		return 0;
> +
> +	regulators = of_find_node_by_name(np, "regulators");
> +	if (!regulators) {
> +		dev_err(&pdev->dev, "regulators node not found\n");
> +		return -EINVAL;
> +	}

The driver should be able to start up with no configuration provided at
all except for the device being registered - the user won't be able to
change anything but they will be able to read the current state of the
hardware which can be useful for diagnostics.

> +static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 workmode)
> +{
> +	unsigned int mask = AXP20X_WORKMODE_DCDC2_MASK;
> +
> +	if ((id != AXP20X_DCDC2) && (id != AXP20X_DCDC3))
> +		return -EINVAL;
> +
> +	if (id == AXP20X_DCDC3)
> +		mask = AXP20X_WORKMODE_DCDC3_MASK;
> +
> +	return regmap_update_bits(rdev->regmap, AXP20X_DCDC_MODE, mask, workmode);
> +}

What is a workmode?

> +		pmic->rdev[i] = regulator_register(&pmic->rdesc[i], &config);
> +		if (IS_ERR(pmic->rdev[i])) {

Use devm_regulator_register() and then you don't need to clean up the
regulators either.

> +static int __init axp20x_regulator_init(void)
> +{
> +	return platform_driver_register(&axp20x_regulator_driver);
> +}
> +
> +subsys_initcall(axp20x_regulator_init);

module_platform_driver().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/19ba4f02/attachment.sig>
