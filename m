From: broonie@kernel.org (Mark Brown)
Date: Fri, 29 Jun 2018 12:03:41 +0100
Subject: [PATCH 2/2] regulator: uniphier: add regulator driver for
 UniPhier SoC
In-Reply-To: <1530260533-19415-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1530260533-19415-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1530260533-19415-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20180629110341.GA6556@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 05:22:13PM +0900, Kunihiko Hayashi wrote:

> +++ b/drivers/regulator/uniphier-regulator.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Regulator controller driver for UniPhier SoC
> + * Copyright 2018 Socionext Inc.
> + * Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> + */

Please make the entire header a C++ comment so that it looks intentional
rather than mixing C and C++ like this.

> +static int uniphier_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct uniphier_regulator_priv *priv = rdev_get_drvdata(rdev);
> +	u32 val;
> +
> +	val = readl_relaxed(priv->base + rdev->desc->enable_reg);
> +	val &= ~rdev->desc->enable_mask;
> +	val |= rdev->desc->enable_val;
> +	writel_relaxed(val, priv->base + rdev->desc->enable_reg);
> +
> +	return 0;
> +}

Could you use a MMIO regmap for this driver?  All the operations look
like they're just straight up operations of the sort the standard
helpers support them and it means the driver will be able to take
advantage of any improvements the core makes for free.

Otherwise this looks great, and the above two issues can be fixed as
followup patches so I'll apply.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180629/a76a53c6/attachment.sig>
