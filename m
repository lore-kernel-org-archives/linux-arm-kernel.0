From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 26 Jan 2015 14:37:51 +0100
Subject: [PATCH v2 1/9] clk: sunxi: Add support for sun9i a80 usb clocks
 and resets
In-Reply-To: <CAGb2v667DGBPXGdU1jO1x=pxmu3Oue9qxVZmZz5KxqzC_9xxGw@mail.gmail.com>
References: <1422188530-1794-1-git-send-email-wens@csie.org>
 <1422188530-1794-2-git-send-email-wens@csie.org>
 <20150125160253.GG8470@lukather>
 <CAGb2v667DGBPXGdU1jO1x=pxmu3Oue9qxVZmZz5KxqzC_9xxGw@mail.gmail.com>
Message-ID: <20150126133751.GE31568@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 05:25:49PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> 2015?1?25? ??11:05 ? "Maxime Ripard" <maxime.ripard@free-electrons.com> ???
> >
> > Hi,
> >
> > On Sun, Jan 25, 2015 at 08:22:02PM +0800, Chen-Yu Tsai wrote:
> > > The USB controller/phy clocks and reset controls are in a separate
> > > address block, unlike previous SoCs where they were in the clock
> > > controller.
> > >
> > > This patch copies the original gates clk functions used for usb
> > > clocks into a separate file, and renames them to *_usb_*. Also
> > > add a per-gate parent index, so we can set different parents for
> > > each gate.
> > >
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > >  Documentation/devicetree/bindings/clock/sunxi.txt |   2 +
> > >  drivers/clk/sunxi/Makefile                        |   1 +
> > >  drivers/clk/sunxi/clk-usb.c                       | 193 ++++++++++++++++++++++
> > >  3 files changed, 196 insertions(+)
> > >  create mode 100644 drivers/clk/sunxi/clk-usb.c
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> > > index 60b44285250d..3f1dcd879af7 100644
> > > --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> > > +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> > > @@ -66,6 +66,8 @@ Required properties:
> > >       "allwinner,sun4i-a10-usb-clk" - for usb gates + resets on A10 / A20
> > >       "allwinner,sun5i-a13-usb-clk" - for usb gates + resets on A13
> > >       "allwinner,sun6i-a31-usb-clk" - for usb gates + resets on A31
> > > +     "allwinner,sun9i-a80-usb-mod-clk" - for usb gates + resets on A80
> > > +     "allwinner,sun9i-a80-usb-phy-clk" - for usb phy gates + resets on A80
> > >
> > >  Required properties for all clocks:
> > >  - reg : shall be the control register address for the clock.
> > > diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> > > index 3a5292e3fcf8..058f273d6154 100644
> > > --- a/drivers/clk/sunxi/Makefile
> > > +++ b/drivers/clk/sunxi/Makefile
> > > @@ -9,6 +9,7 @@ obj-y += clk-mod0.o
> > >  obj-y += clk-sun8i-mbus.o
> > >  obj-y += clk-sun9i-core.o
> > >  obj-y += clk-sun9i-mmc.o
> > > +obj-y += clk-usb.o
> >
> > Is that supposed to handle the other USB clocks in the future as well?
> 
> I plan to do that. If you compare this and the original USB clk driver,
> you'll notice it's pretty much the same.

Yeah, hence why I asked :)

I'd rather not have two distinct copies of the same code. Could you
move these old clocks first, and then add the A80 clocks?

At least your commit log somewhat induces that this is new code, while
it clearly isn't.

> > >
> > >  obj-$(CONFIG_MFD_SUN6I_PRCM) += \
> > >       clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
> > > diff --git a/drivers/clk/sunxi/clk-usb.c b/drivers/clk/sunxi/clk-usb.c
> > > new file mode 100644
> > > index 000000000000..1a93400353de
> > > --- /dev/null
> > > +++ b/drivers/clk/sunxi/clk-usb.c
> > > @@ -0,0 +1,193 @@
> > > +/*
> > > + * Copyright 2013 Emilio L?pez
> > > + *
> > > + * Emilio L?pez <emilio@elopez.com.ar>
> >
> > Hmmmm, the copyright notice seems weird :)
> 
> The code was pulled from clk-sunxi.c, which only has Emilio's
> copyright. I suppose I could dig up who actually wrote the code.
> I think it was Hans.

Ok. The copyright date should at least be updated.

> > > +     clk_data->clks = kzalloc((qty+1) * sizeof(struct clk *), GFP_KERNEL);
> > > +     if (!clk_data->clks) {
> > > +             kfree(clk_data);
> > > +             return;
> > > +     }
> > > +
> > > +     for_each_set_bit(i, (unsigned long *)&data->clk_mask,
> > > +                      SUNXI_USB_MAX_SIZE) {
> > > +             of_property_read_string_index(node, "clock-output-names",
> > > +                                           j, &clk_name);
> > > +             clk_data->clks[i] = clk_register_gate(NULL, clk_name,
> > > +                                                   clk_parent, 0,
> > > +                                                   reg, i, 0, lock);
> > > +             WARN_ON(IS_ERR(clk_data->clks[i]));
> > > +             clk_register_clkdev(clk_data->clks[i], clk_name, NULL);
> >
> > Do we really need to use clkdev for these clocks?
> 
> Original code. I don't think we do.

The only reason why we should have clkdev is for the protected
clocks. We should move away from that code, and I don't think any of
the USB clocks are in that case anyway.

> > > +     if (IS_ERR(reset_data->clk)) {
> > > +             pr_err("Could not get clock for reset controls\n");
> > > +             kfree(reset_data);
> > > +             return;
> > > +     }
> >
> > Newline, and that block should probably be part of the if block above.
> 
> NULL is not considered an error, but maybe being in the same block
> makes it clear that they are related.

Yeah, maybe it's just me, but it triggered a might-be-uninitialized
warning in my brain while reading it (while the kzalloc above
obviously takes care of it)

It would be more logical to have that inside the if statement.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150126/c660afff/attachment.sig>
