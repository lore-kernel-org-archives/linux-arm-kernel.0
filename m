From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 Feb 2016 21:29:26 +0100
Subject: [PATCH v2 07/26] clk: sunxi: Add TCON channel1 clock
In-Reply-To: <CAGb2v65_jsmiQ6DNCznFuQCcWxqs1N2fYJ-8OiUJ_BR+jf314w@mail.gmail.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-8-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65_jsmiQ6DNCznFuQCcWxqs1N2fYJ-8OiUJ_BR+jf314w@mail.gmail.com>
Message-ID: <20160203202926.GE3327@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 17, 2016 at 12:36:20AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Thu, Jan 14, 2016 at 11:24 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The TCON is a controller generating the timings to output videos signals,
> > acting like both a CRTC and an encoder.
> >
> > It has two channels depending on the output, each channel being driven by
> > its own clock (and own clock controller).
> >
> > Add a driver for the channel 1 clock.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/clock/sunxi.txt |   1 +
> >  drivers/clk/sunxi/Makefile                        |   1 +
> >  drivers/clk/sunxi/clk-sun4i-tcon-ch1.c            | 154 ++++++++++++++++++++++
> >  3 files changed, 156 insertions(+)
> >  create mode 100644 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
> >
> > diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> > index bb9fb78dcff8..fe34fc56e803 100644
> > --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> > +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> > @@ -67,6 +67,7 @@ Required properties:
> >         "allwinner,sun7i-a20-out-clk" - for the external output clocks
> >         "allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
> >         "allwinner,sun4i-a10-tcon-ch0-clk" - for the TCON channel 0 clock on the A10
> > +       "allwinner,sun4i-a10-tcon-ch1-clk" - for the TCON channel 1 clock on the A10
> >         "allwinner,sun4i-a10-usb-clk" - for usb gates + resets on A10 / A20
> >         "allwinner,sun5i-a13-usb-clk" - for usb gates + resets on A13
> >         "allwinner,sun6i-a31-usb-clk" - for usb gates + resets on A31
> > diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> > index 40c32ffd912c..0a20873cd103 100644
> > --- a/drivers/clk/sunxi/Makefile
> > +++ b/drivers/clk/sunxi/Makefile
> > @@ -12,6 +12,7 @@ obj-y += clk-mod0.o
> >  obj-y += clk-simple-gates.o
> >  obj-y += clk-sun4i-display.o
> >  obj-y += clk-sun4i-pll3.o
> > +obj-y += clk-sun4i-tcon-ch1.o
> >  obj-y += clk-sun8i-mbus.o
> >  obj-y += clk-sun9i-core.o
> >  obj-y += clk-sun9i-mmc.o
> > diff --git a/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c b/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
> > new file mode 100644
> > index 000000000000..51ddc38821f7
> > --- /dev/null
> > +++ b/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
> > @@ -0,0 +1,154 @@
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
> > +#define SUN4I_TCON_CH1_SCLK_NAME_LEN   32
> > +
> > +#define SUN4I_A10_TCON_CH1_SCLK2_PARENTS       4
> > +
> > +#define SUN4I_A10_TCON_CH1_SCLK2_GATE_BIT      31
> > +#define SUN4I_A10_TCON_CH1_SCLK2_MUX_MASK      3
> > +#define SUN4I_A10_TCON_CH1_SCLK2_MUX_SHIFT     24
> > +#define SUN4I_A10_TCON_CH1_SCLK2_DIV_WIDTH     4
> > +#define SUN4I_A10_TCON_CH1_SCLK2_DIV_SHIFT     0
> > +
> > +#define SUN4I_A10_TCON_CH1_SCLK1_GATE_BIT      15
> > +#define SUN4I_A10_TCON_CH1_SCLK1_DIV_WIDTH     1
> > +#define SUN4I_A10_TCON_CH1_SCLK1_DIV_SHIFT     11
> > +
> > +static DEFINE_SPINLOCK(sun4i_a10_tcon_ch1_lock);
> > +
> > +static void __init sun4i_a10_tcon_ch1_setup(struct device_node *node)
> > +{
> > +       const char *sclk2_parents[SUN4I_A10_TCON_CH1_SCLK2_PARENTS];
> > +       const char *sclk1_name = node->name;
> > +       const char *sclk2_name;
> > +       struct clk_divider *sclk1_div, *sclk2_div;
> > +       struct clk_gate *sclk1_gate, *sclk2_gate;
> > +       struct clk_mux *sclk2_mux;
> > +       struct clk *sclk1, *sclk2;
> > +       void __iomem *reg;
> > +       int i, ret;
> > +
> > +       of_property_read_string(node, "clock-output-names",
> > +                               &sclk1_name);
> > +
> > +       sclk2_name = kasprintf(GFP_KERNEL, "%s2", sclk1_name);
> > +       if (!sclk2_name)
> > +               return;
> > +
> > +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> > +       if (IS_ERR(reg)) {
> > +               pr_err("%s: Could not map the clock registers\n", sclk2_name);
> > +               return;
> > +       }
> > +
> > +       for (i = 0; i < SUN4I_A10_TCON_CH1_SCLK2_PARENTS; i++)
> > +               sclk2_parents[i] = of_clk_get_parent_name(node, i);
> 
> of_clk_parent_fill?

Indeed

> 
> > +
> > +       sclk2_mux = kzalloc(sizeof(*sclk2_mux), GFP_KERNEL);
> > +       if (!sclk2_mux)
> > +               return;
> > +
> > +       sclk2_mux->reg = reg;
> > +       sclk2_mux->shift = SUN4I_A10_TCON_CH1_SCLK2_MUX_SHIFT;
> > +       sclk2_mux->mask = SUN4I_A10_TCON_CH1_SCLK2_MUX_MASK;
> > +       sclk2_mux->lock = &sun4i_a10_tcon_ch1_lock;
> > +
> > +       sclk2_gate = kzalloc(sizeof(*sclk2_gate), GFP_KERNEL);
> > +       if (!sclk2_gate)
> > +               goto free_sclk2_mux;
> > +
> > +       sclk2_gate->reg = reg;
> > +       sclk2_gate->bit_idx = SUN4I_A10_TCON_CH1_SCLK2_GATE_BIT;
> > +       sclk2_gate->lock = &sun4i_a10_tcon_ch1_lock;
> > +
> > +       sclk2_div = kzalloc(sizeof(*sclk2_div), GFP_KERNEL);
> > +       if (!sclk2_div)
> > +               goto free_sclk2_gate;
> > +
> > +       sclk2_div->reg = reg;
> > +       sclk2_div->shift = SUN4I_A10_TCON_CH1_SCLK2_DIV_SHIFT;
> > +       sclk2_div->width = SUN4I_A10_TCON_CH1_SCLK2_DIV_WIDTH;
> > +       sclk2_div->lock = &sun4i_a10_tcon_ch1_lock;
> > +
> > +       sclk2 = clk_register_composite(NULL, sclk2_name, sclk2_parents,
> > +                                      SUN4I_A10_TCON_CH1_SCLK2_PARENTS,
> > +                                      &sclk2_mux->hw, &clk_mux_ops,                                   &
> 
> > +                                      sclk2_div->hw, &clk_divider_ops,
> 
> Placement of the "&" is very weird.

Hmm, right. I don't know what happened here, but it's obviously wrong :)

> 
> > +                                      &sclk2_gate->hw, &clk_gate_ops,
> > +                                      0);
> > +       if (IS_ERR(sclk2)) {
> > +               pr_err("%s: Couldn't register the clock\n", sclk2_name);
> > +               goto free_sclk2_div;
> > +       }
> > +
> > +       sclk1_div = kzalloc(sizeof(*sclk1_div), GFP_KERNEL);
> > +       if (!sclk1_div)
> > +               goto free_sclk2;
> > +
> > +       sclk1_div->reg = reg;
> > +       sclk1_div->shift = SUN4I_A10_TCON_CH1_SCLK1_DIV_SHIFT;
> > +       sclk1_div->width = SUN4I_A10_TCON_CH1_SCLK1_DIV_WIDTH;
> > +       sclk1_div->lock = &sun4i_a10_tcon_ch1_lock;
> > +
> > +       sclk1_gate = kzalloc(sizeof(*sclk1_gate), GFP_KERNEL);
> > +       if (!sclk1_gate)
> > +               goto free_sclk1_mux;
> > +
> > +       sclk1_gate->reg = reg;
> > +       sclk1_gate->bit_idx = SUN4I_A10_TCON_CH1_SCLK1_GATE_BIT;
> > +       sclk1_gate->lock = &sun4i_a10_tcon_ch1_lock;
> > +
> > +       sclk1 = clk_register_composite(NULL, sclk1_name, &sclk2_name, 1,
> > +                                      NULL, NULL,
> > +                                      &sclk1_div->hw, &clk_divider_ops,
> > +                                      &sclk1_gate->hw, &clk_gate_ops,
> > +                                      0);
> > +       if (IS_ERR(sclk1)) {
> > +               pr_err("%s: Couldn't register the clock\n", sclk1_name);
> > +               goto free_sclk1_gate;
> > +       }
> > +
> > +       ret = of_clk_add_provider(node, of_clk_src_simple_get, sclk1);
> > +       if (WARN_ON(ret))
> > +               goto free_sclk1;
> > +
> > +       return;
> > +
> > +free_sclk1:
> > +       clk_unregister_composite(sclk1);
> > +free_sclk1_gate:
> > +       kfree(sclk1_gate);
> > +free_sclk1_mux:
> > +       kfree(sclk1_div);
> > +free_sclk2:
> > +       clk_unregister(sclk2);
> > +free_sclk2_div:
> > +       kfree(sclk2_div);
> > +free_sclk2_gate:
> > +       kfree(sclk2_gate);
> > +free_sclk2_mux:
> > +       kfree(sclk2_mux);
> 
> Cleanup after of_io_request_and_map?

Indeed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/a23789f0/attachment-0001.sig>
