From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 18 Apr 2011 15:33:53 +0200
Subject: [PATCH 06/10] clk: Add support for a generic clock multiplexer
In-Reply-To: <20110418131527.GF31131@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-7-git-send-email-s.hauer@pengutronix.de>
	<20110418131527.GF31131@pengutronix.de>
Message-ID: <20110418133353.GL14770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 03:15:27PM +0200, Uwe Kleine-K?nig wrote:
> On Fri, Apr 15, 2011 at 09:08:11PM +0200, Sascha Hauer wrote:
> > This patch adds support for a common type of clock multiplexer.
> > The multiplexer is described with register, shift and width and
> > an array of clocks which correspond to the bit value.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> > ---
> >  drivers/clk/Kconfig       |    3 +
> >  drivers/clk/Makefile      |    1 +
> >  drivers/clk/clk-divider.c |    2 +-
> >  drivers/clk/clk-mux.c     |   92 +++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/clk.h       |   28 ++++++++++++++
> >  5 files changed, 125 insertions(+), 1 deletions(-)
> >  create mode 100644 drivers/clk/clk-mux.c
> > 
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 76bb4c9..710d73d 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -8,3 +8,6 @@ config USE_COMMON_STRUCT_CLK
> >  
> >  config USE_COMMON_CLK_DIVIDER
> >  	bool
> > +
> > +config USE_COMMON_CLK_MUX
> > +	bool
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index 723d884..195a434 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -2,3 +2,4 @@
> >  obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
> >  obj-$(CONFIG_USE_COMMON_STRUCT_CLK) += clk.o
> >  obj-$(CONFIG_USE_COMMON_CLK_DIVIDER) += clk-divider.o
> > +obj-$(CONFIG_USE_COMMON_CLK_MUX) += clk-mux.o
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index 2de94df..e3f5b7a 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Copyright (C) 2011 Sascha Hauer <s.hauer@pengutronix.de>
> > + * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
> This should go into an earlier patch.

Indeed, already fixed.

> > +
> > +static int clk_mux_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +	struct clk_mux *mux = to_clk_mux(clk);
> > +	u32 val;
> > +	int i;
> > +	unsigned long flags = 0;
> = 0 isn't needed. (Or does gcc wail without it?)

At least my gcc is not smart engough for this. flags may be used unitialized.

> 
> > +
> > +	for (i = 0; i < mux->num_clks; i++)
> > +		if (mux->clks[i] == parent)
> > +			break;
> > +
> > +	if (i == mux->num_clks)
> > +		return -EINVAL;
> > +
> > +	if (mux->lock)
> > +		spin_lock_irqsave(mux->lock, flags);
> > +
> > +	val = readl(mux->reg);
> > +	val &= ~(((1 << mux->width) - 1) << mux->shift);
> > +	val |= i << mux->shift;
> > +	writel(val, mux->reg);
> > +
> > +	if (mux->lock)
> > +		spin_unlock_irqrestore(mux->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static long clk_mux_round_rate(struct clk *clk, unsigned long rate)
> > +{
> > +	struct clk *parent = clk_get_parent(clk);
> > +
> > +	if (IS_ERR(parent))
> > +		return PTR_ERR(parent);
> > +
> > +	return clk_get_rate(parent);
> > +}
> > +
> > +static int clk_mux_set_rate(struct clk *clk, unsigned long desired)
> > +{
> > +	struct clk *parent = clk_get_parent(clk);
> > +
> > +	if (IS_ERR(parent))
> > +		return PTR_ERR(parent);
> > +
> > +	if (desired != clk_get_rate(parent))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> Isn't not implementing set_rate good enough? Ditto for .round_rate.

Yes, I removed these.

> >  
> > +/**
> > + * clock multiplexer
> > + *
> > + * @clk		clock source
> > + * @reg		the register this multiplexer can be configured with
> > + * @shift	the shift to the start bit of this multiplexer
> > + * @width	the width in bits of this multiplexer
> > + * @num_clks	number of parent clocks
> > + * @lock	register lock
> > + * @clks	array of possible parents for this multiplexer. Can contain
> > + *		holes with NULL in it for invalid register settings
> NULL is a valid clk, isn't it?

You're right. I think for invalid mux settings we should ERR_PTR(-EINVAL)
or similar to the array.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
