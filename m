From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Jun 2016 22:29:37 +0200
Subject: [PATCH v2 11/15] clk: sunxi-ng: Add N-M-factor clock support
In-Reply-To: <20160609094101.426a13c4c61aa6cb11df16fc@free.fr>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160607204154.31967-12-maxime.ripard@free-electrons.com>
 <20160609094101.426a13c4c61aa6cb11df16fc@free.fr>
Message-ID: <20160627202937.GY4000@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 09, 2016 at 09:41:01AM +0200, Jean-Francois Moine wrote:
> On Tue,  7 Jun 2016 22:41:50 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Introduce support for clocks that multiply and divide using linear factors.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > 
> > ---
> > Changes from v1:
> >   - Fixed the maximums for both factors passed to the rational factor
> >     computation.
> > ---
> >  drivers/clk/sunxi-ng/Makefile |   1 +
> >  drivers/clk/sunxi-ng/ccu_nm.c | 114 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/sunxi-ng/ccu_nm.h |  95 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 210 insertions(+)
> >  create mode 100644 drivers/clk/sunxi-ng/ccu_nm.c
> >  create mode 100644 drivers/clk/sunxi-ng/ccu_nm.h
> > 
> > diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> > index a201fad6b11d..5c7ae1ad1082 100644
> > --- a/drivers/clk/sunxi-ng/Makefile
> > +++ b/drivers/clk/sunxi-ng/Makefile
> > @@ -9,4 +9,5 @@ obj-y += ccu_gate.o
> >  obj-y += ccu_mp.o
> >  obj-y += ccu_mux.o
> >  obj-y += ccu_nk.o
> > +obj-y += ccu_nm.o
> >  obj-y += ccu_phase.o
> > diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
> > new file mode 100644
> > index 000000000000..e35ddd8eec8b
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu_nm.c
> > @@ -0,0 +1,114 @@
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
> > +#include "ccu_frac.h"
> > +#include "ccu_gate.h"
> > +#include "ccu_nm.h"
> 	[snip]
> > +static unsigned long ccu_nm_recalc_rate(struct clk_hw *hw,
> > +					unsigned long parent_rate)
> > +{
> > +	struct ccu_nm *nm = hw_to_ccu_nm(hw);
> > +	unsigned long n, m;
> > +	u32 reg;
> > +
> > +	if (ccu_frac_helper_is_enabled(&nm->common, &nm->frac))
> > +		return ccu_frac_helper_read_rate(&nm->common, &nm->frac);
> > +
> > +	reg = readl(nm->common.base + nm->common.reg);
> > +
> > +	n = reg >> nm->n.shift;
> > +	n &= (1 << nm->n.width) - 1;
> > +
> > +	m = reg >> nm->m.shift;
> > +	m &= (1 << nm->m.width) - 1;
> > +
> > +	return parent_rate * (n + 1) / (m + 1);
> 
> In the H3, 'm' is a pre-divider (audio and video PLLs):
> 
> 	return parent_rate / (m + 1) * (n + 1);

That's true, but the "true" N-M clocks exist and are using this
formula (like the Audio PLL on A10's).

If (and when) that causes some rounding issues, we can always add
pre-divider support to N-Clocks that we are going to need anyway for
the older SoCs.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160627/f0177858/attachment.sig>
