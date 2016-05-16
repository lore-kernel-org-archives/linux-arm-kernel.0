From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 23:08:03 +0200
Subject: [PATCH 03/16] clk: sunxi-ng: Add fixed factor clock support
In-Reply-To: <CAGb2v65LcXnMj7B-0q2MYESM9vGd9k-yChjvFdX--EivSYdVJg@mail.gmail.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-4-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65LcXnMj7B-0q2MYESM9vGd9k-yChjvFdX--EivSYdVJg@mail.gmail.com>
Message-ID: <20160516210803.GM27618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 06:05:20PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, May 9, 2016 at 4:01 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Some clocks in the Allwinner SoCs clock units are direct, fixed,
> > multipliers or dividers from their parent.
> >
> > Add support for such clocks.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi-ng/Makefile           |  2 ++
> >  drivers/clk/sunxi-ng/ccu_fixed_factor.c | 42 +++++++++++++++++++++++++++
> >  drivers/clk/sunxi-ng/ccu_fixed_factor.h | 50 +++++++++++++++++++++++++++++++++
> >  3 files changed, 94 insertions(+)
> >  create mode 100644 drivers/clk/sunxi-ng/ccu_fixed_factor.c
> >  create mode 100644 drivers/clk/sunxi-ng/ccu_fixed_factor.h
> >
> > diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> > index bd3461b0f38c..d76276736765 100644
> > --- a/drivers/clk/sunxi-ng/Makefile
> > +++ b/drivers/clk/sunxi-ng/Makefile
> > @@ -1,2 +1,4 @@
> >  obj-y += ccu_common.o
> >  obj-y += ccu_reset.o
> > +
> > +obj-y += ccu_fixed_factor.o
> > diff --git a/drivers/clk/sunxi-ng/ccu_fixed_factor.c b/drivers/clk/sunxi-ng/ccu_fixed_factor.c
> > new file mode 100644
> > index 000000000000..75df8a854db5
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu_fixed_factor.c
> > @@ -0,0 +1,42 @@
> > +/*
> > + * Copyright (C) 2016 Maxime Ripard
> > + * Maxime Ripard <maxime.ripard@free-electrons.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +
> > +#include "ccu_fixed_factor.h"
> > +
> > +static unsigned long ccu_fixed_factor_recalc_rate(struct clk_hw *hw,
> > +                                                 unsigned long parent_rate)
> > +{
> > +       struct ccu_fixed_factor *fix = hw_to_ccu_fixed_factor(hw);
> > +
> > +       return parent_rate * fix->mult / fix->div;
> 
> do_div (from include/asm-generic/div64.h) is better, since this is an
> 64 bit value.

unsigned long is 32 bits, but that's true.

> 
> > +}
> > +
> > +static long ccu_fixed_factor_round_rate(struct clk_hw *hw,
> > +                                       unsigned long rate,
> > +                                       unsigned long *parent_rate)
> > +{
> > +       struct ccu_fixed_factor *fix = hw_to_ccu_fixed_factor(hw);
> > +
> > +       return *parent_rate / fix->div * fix->mult;
> 
> Why is this the other way around? With integer math it shouldn't be
> interchangeable. (Though it seems clk_fixed_factor does the same...)

I'm guessing this is so that it doesn't trip over UINT_MAX, but it
doesn't really apply in our case. I'll make it consistant.

> 
> Also, clk_fixed_factor handles CLK_SET_RATE_PARENT. Do we need to do the
> same here?

Indeed, I'll add it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160516/4b467868/attachment.sig>
