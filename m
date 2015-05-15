From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 May 2015 09:41:07 +0200
Subject: [PATCH 5/8] clk: sunxi: mod1 clock support
In-Reply-To: <CAGb2v65RTFcKAYOsgJo0A8jPKRfuSvHyiX-7KG_qvjMy0uBbZQ@mail.gmail.com>
References: <1430565879-28113-1-git-send-email-maxime.ripard@free-electrons.com>
 <1430565879-28113-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65RTFcKAYOsgJo0A8jPKRfuSvHyiX-7KG_qvjMy0uBbZQ@mail.gmail.com>
Message-ID: <20150515074107.GP4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 09:43:19PM +0800, Chen-Yu Tsai wrote:
> On Sat, May 2, 2015 at 7:24 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > From: Emilio L?pez <emilio@elopez.com.ar>
> >
> > The module 1 type of clocks consist of a gate and a mux and are used on
> > the audio blocks to mux and gate the PLL2 outputs for AC97, IIS or
> > SPDIF. This commit adds support for them on the sunxi clock driver.
> >
> > Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi/Makefile       |  1 +
> >  drivers/clk/sunxi/clk-a10-mod1.c | 85 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 86 insertions(+)
> >  create mode 100644 drivers/clk/sunxi/clk-a10-mod1.c
> >
> > diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> > index 6fa845e13067..960eeabc375f 100644
> > --- a/drivers/clk/sunxi/Makefile
> > +++ b/drivers/clk/sunxi/Makefile
> > @@ -5,6 +5,7 @@
> >  obj-y += clk-sunxi.o clk-factors.o
> >  obj-y += clk-a10-codec.o
> >  obj-y += clk-a10-hosc.o
> > +obj-y += clk-a10-mod1.o
> >  obj-y += clk-a10-pll2.o
> >  obj-y += clk-a20-gmac.o
> >  obj-y += clk-mod0.o
> > diff --git a/drivers/clk/sunxi/clk-a10-mod1.c b/drivers/clk/sunxi/clk-a10-mod1.c
> > new file mode 100644
> > index 000000000000..6fc1b7a6de00
> > --- /dev/null
> > +++ b/drivers/clk/sunxi/clk-a10-mod1.c
> > @@ -0,0 +1,85 @@
> > +/*
> > + * Copyright 2013 Emilio L?pez
> > + *
> > + * Emilio L?pez <emilio@elopez.com.ar>
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
> > +#include <linux/clkdev.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +
> > +static DEFINE_SPINLOCK(mod1_lock);
> > +
> > +#define SUN4I_MOD1_ENABLE      31
> > +#define SUN4I_MOD1_MUX         16
> > +#define SUN4I_MOD1_MUX_WIDTH   2
> > +#define SUN4I_MOD1_MAX_PARENTS 4
> > +
> > +static void __init sun4i_mod1_clk_setup(struct device_node *node)
> > +{
> > +       struct clk *clk;
> > +       struct clk_mux *mux;
> > +       struct clk_gate *gate;
> > +       const char *parents[4];
> > +       const char *clk_name = node->name;
> > +       void __iomem *reg;
> > +       int i = 0;
> > +
> > +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> > +       if (IS_ERR(reg))
> > +               return;
> > +
> > +       mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> > +       if (!mux)
> > +               goto err_unmap;
> > +
> > +       gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> > +       if (!gate)
> > +               goto err_free_mux;
> > +
> > +       of_property_read_string(node, "clock-output-names", &clk_name);
> > +       reg = of_iomap(node, 0);
> 
> Is this left over from some change?

Yes :/

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150515/e2024d88/attachment.sig>
