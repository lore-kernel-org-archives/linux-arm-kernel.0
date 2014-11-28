From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Nov 2014 15:22:47 +0000
Subject: [PATCH v2 3/8] regulator: MT6397: Add support for MT6397 regulator
In-Reply-To: <1417146874-5232-4-git-send-email-flora.fu@mediatek.com>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
 <1417146874-5232-4-git-send-email-flora.fu@mediatek.com>
Message-ID: <20141128152247.GR7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 11:54:29AM +0800, Flora Fu wrote:

> @@ -96,5 +97,4 @@ obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8994) += wm8994-regulator.o
>  
> -
>  ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG

Random whitespace change here...

> +	/* For HW design, buck voltage control register has two parts.
> +	 * part 1: vsel_reg for register mode
> +	 * part 2: voselon_reg or hw control mode
> +	 * Both parts should be updated and sync when user set voltage.
> +	 */

Why does nothing else in the driver know about this "hw control mode" -
what does it actually mean, shouldn't it affect some of the other
operations?

> +	ret = regmap_update_bits(rdev->regmap, info->desc.vsel_reg,
> +		info->desc.vsel_mask, sel);
> +	if (ret != 0) {
> +		dev_err(&rdev->dev, "Failed to update vsel: %d\n", ret);
> +		return ret;
> +	}
> +	ret = regmap_update_bits(rdev->regmap, info->voselon_reg,

Missing blank line between these blocks.

> +static int mt6397_buck_get_voltage_sel(struct regulator_dev *rdev)
> +{

> +static int mt6397_regulator_is_enabled(struct regulator_dev *rdev)
> +{

To repeat my comments on the last version: please use the generic regmap
operations rather than copying them.

> +	np = of_node_get(pdev->dev.parent->of_node);
> +	if (!np)
> +		return -EINVAL;
> +
> +	regulators = of_get_child_by_name(np, "regulators");

To further repeat my previous review comments:

| Define regulators_node and of_match in the regulator desc and you can
| remove both this table and all your DT matching code in the driver, the
| core will handle it for you.

Please don't ignore review comments.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/71cdd44e/attachment-0001.sig>
