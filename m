From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 22 May 2016 21:20:58 +0200
Subject: [PATCH 05/16] clk: sunxi-ng: Add mux clock support
In-Reply-To: <CAGb2v66FShuDB_YH37x+VymjrpD+Q9OA2D=b3=MyaLkfFySvmQ@mail.gmail.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66FShuDB_YH37x+VymjrpD+Q9OA2D=b3=MyaLkfFySvmQ@mail.gmail.com>
Message-ID: <20160522192058.GY27618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, May 22, 2016 at 12:18:26AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, May 9, 2016 at 4:01 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Some clocks in the Allwinner SoCs clocks unit are just muxes.
> >
> > However, those muxes might also be found in some other complicated clocks
> > that would benefit from the code in there to deal with "advanced" features,
> > like pre-dividers.
> >
> > Introduce a set of helpers to reduce the code duplication in such cases.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi-ng/Makefile  |   1 +
> >  drivers/clk/sunxi-ng/ccu_mux.c | 187 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/sunxi-ng/ccu_mux.h |  80 +++++++++++++++++-
> >  3 files changed, 264 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/clk/sunxi-ng/ccu_mux.c
> >
> > diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> > index fc01127b3b45..aa5c411ff8ea 100644
> > --- a/drivers/clk/sunxi-ng/Makefile
> > +++ b/drivers/clk/sunxi-ng/Makefile
> > @@ -3,3 +3,4 @@ obj-y += ccu_reset.o
> >
> >  obj-y += ccu_fixed_factor.o
> >  obj-y += ccu_gate.o
> > +obj-y += ccu_mux.o
> > diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
> > new file mode 100644
> > index 000000000000..cb54a8931de3
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> > @@ -0,0 +1,187 @@
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
> > +#include "ccu_gate.h"
> > +#include "ccu_mux.h"
> > +
> > +void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
> > +                                            struct ccu_mux_internal *cm,
> > +                                            int parent_index,
> > +                                            unsigned long *parent_rate)
> > +{
> > +       u8 prediv = 1;
> > +       u32 reg;
> > +
> > +       if (!((common->features & CCU_FEATURE_FIXED_PREDIV) ||
> > +             (common->features & CCU_FEATURE_VARIABLE_PREDIV)))
> > +               return;
> > +
> > +       reg = readl(common->base + common->reg);
> > +       if (parent_index < 0) {
> > +               parent_index = reg >> cm->shift;
> > +               parent_index &= (1 << cm->width) - 1;
> > +       }
> > +
> > +       if (common->features & CCU_FEATURE_FIXED_PREDIV)
> > +               if (parent_index == cm->fixed_prediv.index)
> > +                       prediv = cm->fixed_prediv.div;
> > +
> > +       if (common->features & CCU_FEATURE_VARIABLE_PREDIV)
> > +               if (parent_index == cm->variable_prediv.index) {
> > +                       u8 div;
> > +
> > +                       div = reg >> cm->variable_prediv.shift;
> > +                       div &= (1 << cm->variable_prediv.width) - 1;
> > +                       prediv = div + 1;
> > +               }
> > +
> > +       *parent_rate = *parent_rate / prediv;
> > +}
> > +
> > +int ccu_mux_helper_determine_rate(struct ccu_common *common,
> > +                                 struct ccu_mux_internal *cm,
> > +                                 struct clk_rate_request *req,
> > +                                 unsigned long (*round)(struct ccu_mux_internal *,
> > +                                                        unsigned long,
> > +                                                        unsigned long,
> > +                                                        void *),
> > +                                 void *data)
> > +{
> > +       unsigned long best_parent_rate = 0, best_rate = 0;
> > +       struct clk_hw *best_parent, *hw = &common->hw;
> > +       unsigned int i;
> > +
> > +       for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
> > +               unsigned long tmp_rate, parent_rate;
> > +               struct clk_hw *parent;
> > +
> > +               parent = clk_hw_get_parent_by_index(hw, i);
> > +               if (!parent)
> > +                       continue;
> > +
> > +               parent_rate = clk_hw_get_rate(parent);
> 
> Using clk-mux.c as a reference, you should honor CLK_SET_RATE_PARENT here.
> 
> > +               ccu_mux_helper_adjust_parent_for_prediv(common, cm, i,
> > +                                                       &parent_rate);
> 
> ccu_mux_helper_adjust_parent_for_prediv can modify parent_rate. You
> should probably save a copy...
> 
> > +
> > +               tmp_rate = round(cm, clk_hw_get_rate(parent), req->rate, data);
> > +               if (tmp_rate == req->rate) {
> > +                       best_parent = parent;
> > +                       best_parent_rate = parent_rate;
> 
> ... to assign to best_parent_rate. The returned best_parent_rate is used
> to change the parent clock rate. This happens if CLK_SET_RATE_PARENT is set.
> The CCF doesn't know about our predivs, so you should pass back the original
> rate, not the one after the prediv.
>
> I suppose you didn't run into problems as CLK_SET_RATE_PARENT was not used
> anywhere?

Probably, yes. You do have a good point, but I'm a bit unconfident
merging some code that hasn't been tested, and will probably end up
broken anyway. This is always something that we can add later.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160522/43ff552c/attachment.sig>
