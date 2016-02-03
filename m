From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 Feb 2016 21:27:58 +0100
Subject: [PATCH v2 06/26] clk: sunxi: Add PLL3 clock
In-Reply-To: <CAGb2v64pj5Ga4-QaF7RpExUSyYntyMU2dQ87TPsm5WbNeAXMOQ@mail.gmail.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-7-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64pj5Ga4-QaF7RpExUSyYntyMU2dQ87TPsm5WbNeAXMOQ@mail.gmail.com>
Message-ID: <20160203202758.GD3327@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 17, 2016 at 12:05:06AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Thu, Jan 14, 2016 at 11:24 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The A10 SoCs and relatives have a PLL controller to drive the PLL3 and
> > PLL7, clocked from a 3MHz oscillator, that drives the display related
> > clocks (GPU, display engine, TCON, etc.)
> >
> > Add a driver for it.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
> >  drivers/clk/sunxi/Makefile                        |  1 +
> >  drivers/clk/sunxi/clk-sun4i-pll3.c                | 90 +++++++++++++++++++++++
> >  3 files changed, 92 insertions(+)
> >  create mode 100644 drivers/clk/sunxi/clk-sun4i-pll3.c
> >
> > diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> > index 5360554a7d3f..bb9fb78dcff8 100644
> > --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> > +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> > @@ -10,6 +10,7 @@ Required properties:
> >         "allwinner,sun4i-a10-pll1-clk" - for the main PLL clock and PLL4
> >         "allwinner,sun6i-a31-pll1-clk" - for the main PLL clock on A31
> >         "allwinner,sun8i-a23-pll1-clk" - for the main PLL clock on A23
> > +       "allwinner,sun4i-a10-pll3-clk" - for the video PLL clock on A10
> >         "allwinner,sun9i-a80-pll4-clk" - for the peripheral PLLs on A80
> >         "allwinner,sun4i-a10-pll5-clk" - for the PLL5 clock
> >         "allwinner,sun4i-a10-pll6-clk" - for the PLL6 clock
> > diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> > index a991cd8ca509..40c32ffd912c 100644
> > --- a/drivers/clk/sunxi/Makefile
> > +++ b/drivers/clk/sunxi/Makefile
> > @@ -11,6 +11,7 @@ obj-y += clk-a20-gmac.o
> >  obj-y += clk-mod0.o
> >  obj-y += clk-simple-gates.o
> >  obj-y += clk-sun4i-display.o
> > +obj-y += clk-sun4i-pll3.o
> >  obj-y += clk-sun8i-mbus.o
> >  obj-y += clk-sun9i-core.o
> >  obj-y += clk-sun9i-mmc.o
> > diff --git a/drivers/clk/sunxi/clk-sun4i-pll3.c b/drivers/clk/sunxi/clk-sun4i-pll3.c
> > new file mode 100644
> > index 000000000000..6c9c2210b6b2
> > --- /dev/null
> > +++ b/drivers/clk/sunxi/clk-sun4i-pll3.c
> > @@ -0,0 +1,90 @@
> > +/*
> > + * Copyright 2015 Maxime Ripard
> > + *
> > + * Maxime Ripard <maxime.ripard@free-electrons.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +
> > +#define SUN4I_A10_PLL3_GATE_BIT        31
> > +#define SUN4I_A10_PLL3_DIV_WIDTH       7
> > +#define SUN4I_A10_PLL3_DIV_SHIFT       0
> > +
> > +static DEFINE_SPINLOCK(sun4i_a10_pll3_lock);
> > +
> > +static void __init sun4i_a10_pll3_setup(struct device_node *node)
> > +{
> > +       const char *clk_name = node->name, *parent;
> > +       struct clk_multiplier *mult;
> > +       struct clk_gate *gate;
> > +       void __iomem *reg;
> > +       struct clk *clk;
> > +       int ret;
> > +
> > +       of_property_read_string(node, "clock-output-names", &clk_name);
> > +       parent = of_clk_get_parent_name(node, 0);
> > +
> > +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> > +       if (IS_ERR(reg)) {
> > +               pr_err("%s: Could not map the clock registers\n", clk_name);
> > +               return;
> > +       }
> > +
> > +       gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> > +       if (!gate)
> > +               return;
> > +
> > +       gate->reg = reg;
> > +       gate->bit_idx = SUN4I_A10_PLL3_GATE_BIT;
> > +       gate->lock = &sun4i_a10_pll3_lock;
> > +
> > +       mult = kzalloc(sizeof(*mult), GFP_KERNEL);
> > +       if (!mult)
> > +               goto err_free_gate;
> > +
> > +       mult->reg = reg;
> > +       mult->shift = SUN4I_A10_PLL3_DIV_SHIFT;
> > +       mult->width = SUN4I_A10_PLL3_DIV_WIDTH;
> > +       mult->lock = &sun4i_a10_pll3_lock;
> > +
> > +       clk = clk_register_composite(NULL, clk_name,
> > +                                    &parent, 1,
> > +                                    NULL, NULL,
> > +                                    &mult->hw, &clk_multiplier_ops,
> > +                                    &gate->hw, &clk_gate_ops,
> > +                                    0);
> > +       if (IS_ERR(clk)) {
> > +               pr_err("%s: Couldn't register the clock\n", clk_name);
> > +               goto err_free_mult;
> > +       }
> > +
> > +       ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
> > +       if (WARN_ON(ret))
> 
> Any particular reason for WARN_ON instead of pr_err like above?

I guess not, I'll change that.

> 
> > +               goto err_clk_unregister;
> > +
> > +       return;
> > +
> > +err_clk_unregister:
> > +       clk_unregister_composite(clk);
> > +err_free_mult:
> > +       kfree(mult);
> > +err_free_gate:
> > +       kfree(gate);
> 
> Clean up after of_io_request_and_map(), otherwise

Ack

> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/c7f23515/attachment.sig>
