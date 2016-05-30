From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 May 2016 09:57:30 +0200
Subject: [PATCH 14/16] clk: sunxi-ng: Add N-K-M-P factor clock
In-Reply-To: <CAGb2v66b7jXrAs0rBrcHWskQQPqrhRVzY6OmCSoGZg2tfDJrDA@mail.gmail.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-15-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66b7jXrAs0rBrcHWskQQPqrhRVzY6OmCSoGZg2tfDJrDA@mail.gmail.com>
Message-ID: <20160530075730.GB4247@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Mon, May 23, 2016 at 10:36:04PM +0800, Chen-Yu Tsai wrote:
> On Mon, May 9, 2016 at 4:01 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Introduce support for clocks that use a combination of two linear
> > multipliers (N and K factors), one linear divider (M) and one power of two
> > divider (P).
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi-ng/Makefile   |   1 +
> >  drivers/clk/sunxi-ng/ccu_nkmp.c | 157 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/sunxi-ng/ccu_nkmp.h |  43 +++++++++++
> >  3 files changed, 201 insertions(+)
> >  create mode 100644 drivers/clk/sunxi-ng/ccu_nkmp.c
> >  create mode 100644 drivers/clk/sunxi-ng/ccu_nkmp.h
> >
> > diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> > index 2bb8bc22e907..c794f57b6fb1 100644
> > --- a/drivers/clk/sunxi-ng/Makefile
> > +++ b/drivers/clk/sunxi-ng/Makefile
> > @@ -9,6 +9,7 @@ obj-y += ccu_mp.o
> >  obj-y += ccu_mux.o
> >  obj-y += ccu_nk.o
> >  obj-y += ccu_nkm.o
> > +obj-y += ccu_nkmp.o
> >  obj-y += ccu_nm.o
> >  obj-y += ccu_p.o
> >  obj-y += ccu_phase.o
> > diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
> > new file mode 100644
> > index 000000000000..b7da00773cd6
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
> > @@ -0,0 +1,157 @@
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
> > +#include <linux/rational.h>
> > +
> > +#include "ccu_gate.h"
> > +#include "ccu_nkmp.h"
> > +
> > +void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
> > +                       unsigned long max_n, unsigned long max_k,
> > +                       unsigned long max_m, unsigned long max_p,
> > +                       unsigned long *n, unsigned long *k,
> > +                       unsigned long *m, unsigned long *p)
> 
> We definitely should just pass struct ccu_nkmp* here.

Ok

> > +{
> > +       unsigned long best_rate = 0;
> > +       unsigned long best_n = 0, best_k = 0, best_m = 0, best_p = 0;
> > +       unsigned long _n, _k, _m, _p;
> > +
> > +       for (_k = 1; _k <= max_k; _k++) {
> > +               for (_p = 0; _p <= max_p; _p++) {
> > +                       unsigned long tmp_rate;
> > +
> > +                       rational_best_approximation(rate / _k, parent << _p,
> 
> I think you mean "parent >> _p" ?

Indeed :/

> In general we might lose some precision if parent is too small or _p is
> too large. But the only place we see this type of clock is the CPU PLL,
> and parent (24 MHz) are divisible by all the possible values of P.
> 
> This brings up another issue: P does not go all the way up to (1 << width - 1).
> A register value of 3, or P = 8 is not valid, and it's not restricted in
> the driver. This is not true for all the SoCs though.
> 
> The manual also says P should only be used when rate < 288 MHz. Moving
> P to the outer loop, and maybe adding a short circuit exit when the rate
> matches exactly would help.

This is already something that was already reported by
Jean-Francois. Apart from the P limitation this is the current logic
used in the clock driver. We should probably fix that, but without any
user (ie, cpufreq), it's just wild guesses in the middle of a massive
and very intrusive changes.

So I don't really want to actually try to figure that out for now (and
this is exactly why I don't want to convert the SoCs with a good
support for now, since we'll pretty much uncover a whole lot of bugs
that would turn into regressions).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/4a242ac9/attachment.sig>
