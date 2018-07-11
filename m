From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed, 11 Jul 2018 11:31:35 +0900
Subject: [PATCH v2 2/2] regulator: uniphier: add regulator driver for
 UniPhier SoC
In-Reply-To: <20180710174451.GE8104@sirena.org.uk>
References: <1531186037-16630-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20180710174451.GE8104@sirena.org.uk>
Message-ID: <20180711113134.497A.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 10 Jul 2018 18:44:51 +0100 <broonie@kernel.org> wrote:

> On Tue, Jul 10, 2018 at 10:27:17AM +0900, Kunihiko Hayashi wrote:
> 
> > +static int uniphier_regulator_enable(struct regulator_dev *rdev)
> > +{
> > +	struct uniphier_regulator_priv *priv = rdev_get_drvdata(rdev);
> > +
> > +	return regmap_update_bits(priv->regmap, rdev->desc->enable_reg,
> > +				  rdev->desc->enable_mask,
> > +				  rdev->desc->enable_val);
> > +}
> 
> This is just regulator_enable_regmap() isn't it?  Same for disable,
> unless I'm missing something (which is possible).

Exactly, it's reasonable to replace this with the helper function.
I'll check and apply it.

> > +static int uniphier_regulator_is_enabled(struct regulator_dev *rdev)
> > +{
> > +	struct uniphier_regulator_priv *priv = rdev_get_drvdata(rdev);
> > +	unsigned int val;
> > +	int ret = -EINVAL;
> > +
> > +	regmap_read(priv->regmap, rdev->desc->enable_reg, &val);
> > +	val &= rdev->desc->enable_mask;
> > +
> > +	if (val == rdev->desc->enable_val)
> > +		ret = 1;
> > +	else if (val == rdev->desc->disable_val)
> > +		ret = 0;
> > +
> > +	return ret;
> > +}
> 
> This isn't *quite* regulator_is_enabled_regmap() as it explicitly checks
> if the disable value is set and errors otherwise which would be a good
> fix for that.  Could you do a patch for that?

Although I'm worried that the register have a value that is neither
enable_val or disable_val, the "is_enabled" function returns whether
the regulator is enabled or not, so I can apply regulator_is_enabled_regmap().
I'll apply it in v3.

Thank you,

---
Best Regards,
Kunihiko Hayashi
