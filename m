From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Jul 2018 18:44:51 +0100
Subject: [PATCH v2 2/2] regulator: uniphier: add regulator driver for
 UniPhier SoC
In-Reply-To: <1531186037-16630-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1531186037-16630-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1531186037-16630-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20180710174451.GE8104@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:27:17AM +0900, Kunihiko Hayashi wrote:

> +static int uniphier_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct uniphier_regulator_priv *priv = rdev_get_drvdata(rdev);
> +
> +	return regmap_update_bits(priv->regmap, rdev->desc->enable_reg,
> +				  rdev->desc->enable_mask,
> +				  rdev->desc->enable_val);
> +}

This is just regulator_enable_regmap() isn't it?  Same for disable,
unless I'm missing something (which is possible).

> +static int uniphier_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct uniphier_regulator_priv *priv = rdev_get_drvdata(rdev);
> +	unsigned int val;
> +	int ret = -EINVAL;
> +
> +	regmap_read(priv->regmap, rdev->desc->enable_reg, &val);
> +	val &= rdev->desc->enable_mask;
> +
> +	if (val == rdev->desc->enable_val)
> +		ret = 1;
> +	else if (val == rdev->desc->disable_val)
> +		ret = 0;
> +
> +	return ret;
> +}

This isn't *quite* regulator_is_enabled_regmap() as it explicitly checks
if the disable value is set and errors otherwise which would be a good
fix for that.  Could you do a patch for that?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/99184ecf/attachment.sig>
