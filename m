From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon, 02 Jul 2018 10:10:35 +0900
Subject: [PATCH 2/2] regulator: uniphier: add regulator driver for
 UniPhier SoC
In-Reply-To: <20180629110341.GA6556@sirena.org.uk>
References: <1530260533-19415-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20180629110341.GA6556@sirena.org.uk>
Message-ID: <20180702101034.23E8.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
Thank you for your comments.

On Fri, 29 Jun 2018 12:03:41 +0100 <broonie@kernel.org> wrote:

> On Fri, Jun 29, 2018 at 05:22:13PM +0900, Kunihiko Hayashi wrote:
> 
> > +++ b/drivers/regulator/uniphier-regulator.c
> > @@ -0,0 +1,251 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Regulator controller driver for UniPhier SoC
> > + * Copyright 2018 Socionext Inc.
> > + * Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > + */
> 
> Please make the entire header a C++ comment so that it looks intentional
> rather than mixing C and C++ like this.

Okay, I'll rewrite it as a C++ comment.

> 
> > +static int uniphier_regulator_enable(struct regulator_dev *rdev)
> > +{
> > +	struct uniphier_regulator_priv *priv = rdev_get_drvdata(rdev);
> > +	u32 val;
> > +
> > +	val = readl_relaxed(priv->base + rdev->desc->enable_reg);
> > +	val &= ~rdev->desc->enable_mask;
> > +	val |= rdev->desc->enable_val;
> > +	writel_relaxed(val, priv->base + rdev->desc->enable_reg);
> > +
> > +	return 0;
> > +}
> 
> Could you use a MMIO regmap for this driver?  All the operations look
> like they're just straight up operations of the sort the standard
> helpers support them and it means the driver will be able to take
> advantage of any improvements the core makes for free.

Indeed. In this case, I can use a MMIO regmap and it's reasonable and
simply to use it.


> Otherwise this looks great, and the above two issues can be fixed as
> followup patches so I'll apply.

And more, as with uniphier_usb3_reset [1], I can reuse soc_data and
use clk_bulk in it. If it's no problem, I'll rewrite like that next.

[1] https://lkml.org/lkml/2018/6/29/183

Thank you,

---
Best Regards,
Kunihiko Hayashi
