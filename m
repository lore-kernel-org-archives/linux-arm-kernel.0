From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Oct 2014 11:05:18 +0200
Subject: [PATCH 2/5] clk: sunxi: Add support for A80 basic bus clocks
In-Reply-To: <CAGb2v65mwuUQt5W_nXmvnBQMdpAqVLz65j_6va8MTgp4XvJe7w@mail.gmail.com>
References: <1413106825-5777-1-git-send-email-wens@csie.org>
 <1413106825-5777-3-git-send-email-wens@csie.org>
 <20141016083103.GG19438@lukather>
 <CAGb2v65iKVuZYMiu2+PT-wMZ327Jeh24KtG03K47p4ZifKoRfA@mail.gmail.com>
 <20141017135125.GQ19438@lukather>
 <CAGb2v65mwuUQt5W_nXmvnBQMdpAqVLz65j_6va8MTgp4XvJe7w@mail.gmail.com>
Message-ID: <20141020090518.GT19438@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 18, 2014 at 09:35:21PM +0800, Chen-Yu Tsai wrote:
> On Fri, Oct 17, 2014 at 9:51 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Thu, Oct 16, 2014 at 08:35:49PM +0800, Chen-Yu Tsai wrote:
> >> On Thu, Oct 16, 2014 at 4:31 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > On Sun, Oct 12, 2014 at 05:40:22PM +0800, Chen-Yu Tsai wrote:
> >> >> The A80 SoC has 12 PLL clocks, 3 AHB clocks, 2 APB clocks, and a
> >> >> new "GT" bus, which I assume is some kind of data bus connecting
> >> >> the processor cores, memory and various busses. Also there is a
> >> >> bus clock for a ARM CCI400 module.
> >> >>
> >> >> As far as I can tell, the GT bus and CCI400 bus clock must be
> >> >> protected.
> >> >>
> >> >> This patch adds driver support for peripheral related PLLs and
> >> >> bus clocks on the A80. The GT and CCI400 clocks are added as well
> >> >> as these 2 along with the PLLs they are clocked from must not be
> >> >> disabled.
> >> >>
> >> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> >> ---
> >> >>  Documentation/devicetree/bindings/clock/sunxi.txt |   5 +
> >> >>  drivers/clk/sunxi/Makefile                        |   1 +
> >> >>  drivers/clk/sunxi/clk-sun9i-core.c                | 272 ++++++++++++++++++++++
> >> >>  3 files changed, 278 insertions(+)
> >> >>  create mode 100644 drivers/clk/sunxi/clk-sun9i-core.c
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> >> >> index ed116df..7f1c486 100644
> >> >> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> >> >> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> >> >> @@ -10,14 +10,17 @@ Required properties:
> >> >>       "allwinner,sun4i-a10-pll1-clk" - for the main PLL clock and PLL4
> >> >>       "allwinner,sun6i-a31-pll1-clk" - for the main PLL clock on A31
> >> >>       "allwinner,sun8i-a23-pll1-clk" - for the main PLL clock on A23
> >> >> +     "allwinner,sun9i-a80-pll4-clk" - for the peripheral PLLs on A80
> >> >>       "allwinner,sun4i-a10-pll5-clk" - for the PLL5 clock
> >> >>       "allwinner,sun4i-a10-pll6-clk" - for the PLL6 clock
> >> >>       "allwinner,sun6i-a31-pll6-clk" - for the PLL6 clock on A31
> >> >> +     "allwinner,sun9i-a80-gt-clk" - for the GT bus clock on A80
> >> >>       "allwinner,sun4i-a10-cpu-clk" - for the CPU multiplexer clock
> >> >>       "allwinner,sun4i-a10-axi-clk" - for the AXI clock
> >> >>       "allwinner,sun8i-a23-axi-clk" - for the AXI clock on A23
> >> >>       "allwinner,sun4i-a10-axi-gates-clk" - for the AXI gates
> >> >>       "allwinner,sun4i-a10-ahb-clk" - for the AHB clock
> >> >> +     "allwinner,sun9i-a80-ahb-clk" - for the AHB bus clocks on A80
> >> >>       "allwinner,sun4i-a10-ahb-gates-clk" - for the AHB gates on A10
> >> >>       "allwinner,sun5i-a13-ahb-gates-clk" - for the AHB gates on A13
> >> >>       "allwinner,sun5i-a10s-ahb-gates-clk" - for the AHB gates on A10s
> >> >> @@ -29,6 +32,7 @@ Required properties:
> >> >>       "allwinner,sun4i-a10-apb0-clk" - for the APB0 clock
> >> >>       "allwinner,sun6i-a31-apb0-clk" - for the APB0 clock on A31
> >> >>       "allwinner,sun8i-a23-apb0-clk" - for the APB0 clock on A23
> >> >> +     "allwinner,sun9i-a80-apb0-clk" - for the APB0 bus clock on A80
> >> >>       "allwinner,sun4i-a10-apb0-gates-clk" - for the APB0 gates on A10
> >> >>       "allwinner,sun5i-a13-apb0-gates-clk" - for the APB0 gates on A13
> >> >>       "allwinner,sun5i-a10s-apb0-gates-clk" - for the APB0 gates on A10s
> >> >> @@ -36,6 +40,7 @@ Required properties:
> >> >>       "allwinner,sun7i-a20-apb0-gates-clk" - for the APB0 gates on A20
> >> >>       "allwinner,sun8i-a23-apb0-gates-clk" - for the APB0 gates on A23
> >> >>       "allwinner,sun4i-a10-apb1-clk" - for the APB1 clock
> >> >> +     "allwinner,sun9i-a80-apb1-clk" - for the APB1 bus clock on A80
> >> >>       "allwinner,sun4i-a10-apb1-mux-clk" - for the APB1 clock muxing
> >> >>       "allwinner,sun4i-a10-apb1-gates-clk" - for the APB1 gates on A10
> >> >>       "allwinner,sun5i-a13-apb1-gates-clk" - for the APB1 gates on A13
> >> >> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> >> >> index 7ddc2b5..a66953c 100644
> >> >> --- a/drivers/clk/sunxi/Makefile
> >> >> +++ b/drivers/clk/sunxi/Makefile
> >> >> @@ -7,6 +7,7 @@ obj-y += clk-a10-hosc.o
> >> >>  obj-y += clk-a20-gmac.o
> >> >>  obj-y += clk-mod0.o
> >> >>  obj-y += clk-sun8i-mbus.o
> >> >> +obj-y += clk-sun9i-core.o
> >> >>
> >> >>  obj-$(CONFIG_MFD_SUN6I_PRCM) += \
> >> >>       clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
> >> >> diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
> >> >> new file mode 100644
> >> >> index 0000000..ba5f091
> >> >> --- /dev/null
> >> >> +++ b/drivers/clk/sunxi/clk-sun9i-core.c
> >> >> @@ -0,0 +1,272 @@
> >> >> +/*
> >> >> + * Copyright 2014 Chen-Yu Tsai
> >> >> + *
> >> >> + * Chen-Yu Tsai <wens@csie.org>
> >> >> + *
> >> >> + * This program is free software; you can redistribute it and/or modify
> >> >> + * it under the terms of the GNU General Public License as published by
> >> >> + * the Free Software Foundation; either version 2 of the License, or
> >> >> + * (at your option) any later version.
> >> >> + *
> >> >> + * This program is distributed in the hope that it will be useful,
> >> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> >> + * GNU General Public License for more details.
> >> >> + */
> >> >> +
> >> >> +#include <linux/clk-provider.h>
> >> >> +#include <linux/clkdev.h>
> >> >> +#include <linux/of.h>
> >> >> +#include <linux/of_address.h>
> >> >> +#include <linux/log2.h>
> >> >> +
> >> >> +#include "clk-factors.h"
> >> >> +
> >> >> +
> >> >> +/**
> >> >> + * sun9i_a80_get_pll4_factors() - calculates n, p, m factors for PLL1
> >> >> + * PLL4 rate is calculated as follows
> >> >> + * rate = (parent_rate * n >> p) / (m + 1);
> >> >> + * parent_rate is always 24Mhz
> >> >> + *
> >> >> + * p and m are named div1 and div2 in Allwinner's SDK
> >> >> + */
> >> >> +
> >> >> +static void sun9i_a80_get_pll4_factors(u32 *freq, u32 parent_rate,
> >> >> +                                    u8 *n, u8 *k, u8 *m, u8 *p)
> >> >> +{
> >> >> +     int div;
> >> >> +
> >> >> +     /* Normalize value to a 6M multiple */
> >> >> +     div = *freq / 6000000;
> >> >> +
> >> >> +     /* divs above 256 cannot be odd */
> >> >> +     if (div > 256)
> >> >> +             div &= ~0x1;
> >> >> +
> >> >> +     /* divs above 512 must be a multiple of 4 */
> >> >> +     if (div > 512)
> >> >> +             div &= ~0x3;
> >> >
> >> > round_up / round_down looks more readable.
> >>
> >> OK.
> >>
> >> >> +
> >> >> +     *freq = 6000000 * div;
> >> >
> >> > and here as well
> >>
> >> This won't look pretty with round_up/round_down i think.
> >> This function is supposed to return the actual closest supported
> >> frequency, so it depends on the calculated/rounded divider from
> >> the previous section.
> >
> > Well, if I understood your code correctly, you want to round the
> > frequency to 6MHz multiple if div < 256, 12MHz if div < 512 and 24MHz
> > otherwise right?
> >
> > I'm confident it can be made prettier.
> 
> I seem to have responded incorrectly.
> 
> What I meant to say is that i can replace the bitmasking with
> ROUND_UP/ROUND_DOWN, but the conditionals will still be there.
> 
> Is that what you had in mind?

Oh, my bad.

Yes, it's definitely something like that I had in mind :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141020/e4789ad9/attachment.sig>
