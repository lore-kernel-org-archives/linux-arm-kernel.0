From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Dec 2014 22:09:19 +0100
Subject: [PATCHv2 2/3] sunxi:drivers:input:ps2 Added sunxi A10/A20 ps2
 driver
In-Reply-To: <CAEzqOZu9TWmYyBOP8t+b7mepqdbKjhf-3P-uNJS_Od05XiBLZw@mail.gmail.com>
References: <1417907719-26775-1-git-send-email-VishnuPatekar0510@gmail.com>
 <1417907719-26775-3-git-send-email-VishnuPatekar0510@gmail.com>
 <20141208224137.GO8739@lukather>
 <CAEzqOZu9TWmYyBOP8t+b7mepqdbKjhf-3P-uNJS_Od05XiBLZw@mail.gmail.com>
Message-ID: <20141211210919.GI8739@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Remember to reply to all the recipients.

On Tue, Dec 09, 2014 at 04:40:36PM +0530, Vishnu Patekar wrote:
> > > Signed-off-by: vishnupatekar <VishnuPatekar0510@gmail.com>
> > > ---
> > >  drivers/input/serio/Kconfig     |   10 ++
> > >  drivers/input/serio/Makefile    |    1 +
> > >  drivers/input/serio/sunxi-ps2.c |  364
> > +++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 375 insertions(+)
> > >  create mode 100644 drivers/input/serio/sunxi-ps2.c
> > >
> > > diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> > > index bc2d474..3a7599c 100644
> > > --- a/drivers/input/serio/Kconfig
> > > +++ b/drivers/input/serio/Kconfig
> > > @@ -281,4 +281,14 @@ config HYPERV_KEYBOARD
> > >         To compile this driver as a module, choose M here: the module
> > will
> > >         be called hyperv_keyboard.
> > >
> > > +config SERIO_SUNXI_PS2
> > > +     tristate "Allwinner Sun4i-A10/Sun7i-A20 PS/2 controller"
> >
> > Allwinner A10 is enough
> >
> Okie, Should I change the config option as well, like SERIO_SUN4I_PS2 ?

Yep.

> > > +     /*Set Clock Divider Register*/
> > > +     clk_scdf = DIV_ROUND_UP(src_clk, PS2_SAMPLE_CLK) - 1;
> > > +     clk_pcdf = DIV_ROUND_UP(PS2_SAMPLE_CLK, PS2_SCLK) - 1;
> >
> > So this is actually a rounding down?
> >
> > Why not just using src_clk / PS2_SAMPLE_CLK directly?
> >
> > > +     rval = (clk_scdf<<8) | clk_pcdf;
> >
> > Spaces between the operators. Remember, run checkpatch.
> >
> Okie.
> 
> checkpatch could  not catch this!!

Well, then it should have :)

> > > +     writel(rval, drvdata->reg_base + PS2_REG_CLKDR);
> > > +
> > > +     /*Set Global Control Register*/
> > > +     rval = PS2_GCTL_RESET | PS2_GCTL_INTEN | PS2_GCTL_MASTER
> > > +             | PS2_GCTL_BUSEN;
> > > +     writel(rval, drvdata->reg_base + PS2_REG_GCTL);
> >
> > You seem to be reading/writing from the same registers than in your
> > interrupt handler, don't you need some locking in here?
> >
>
> Interrupt is getting enabled only after writing to GCTL register.
>
> do you think still we need to locking mechanism here?

Not really, you don't know the state of the device before your driver
is probed, and the interrupts are enabled as soon as request_irq. So
you can very well have the device running with the interrupts running
before this function is called.

Plus you might get spurious interrupts.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141211/68395019/attachment.sig>
