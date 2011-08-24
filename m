From: ajay.gupta@ti.com (Gupta, Ajay Kumar)
Date: Wed, 24 Aug 2011 21:52:44 +0530
Subject: [PATCH v2] OMAP3EVM: ehci: Fix EHCI support
In-Reply-To: <1314201821.2320.50.camel@bryan-HUTIA>
References: <1314174902-12797-1-git-send-email-bdefaria@adeneo-embedded.com>
	<19F8576C6E063C45BE387C64729E739404EC007BC0@dbde02.ent.ti.com>
	<1314189727.2320.16.camel@bryan-HUTIA>
	<19F8576C6E063C45BE387C64729E739404EC007C71@dbde02.ent.ti.com>
	<1314201821.2320.50.camel@bryan-HUTIA>
Message-ID: <19F8576C6E063C45BE387C64729E739404EC007CB2@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> For the comment what about:
> Set the VAUX2 regulator supply to 1.8V for the HSUSB host interface.
> Tps65950 GPIO2 has to be set to zero in order to enable the EHCI select
> line.

Looks fine.

> 
> I see this patch as a fix for the EHCI support, what would you suggest
> for the patch name?

This is also fine.

Ajay
> 
> Bryan
> > Hi,
> > > TPS65950 GPIO2 is to choose through u131 if we drive the lines to
> the
> > > evm mother board or to the expansion connector p18. Should not it
> be
> > > default to the mother board?
> > It's not enabled by default and that?s why we need to enable it
> through
> > Tps65950 GPIO2.
> >
> > Your patch looks fine but the comment and name needs to be changed as
> > There is no clock which gets enabled using gpio2. All the HSUSB
> clocks
> > Are handled inside driver at drivers/usb/host/ehci-omap.c
> >
> > Ajay
> >
> > > The EHCI port on the mother board works with this patch.
> > >
> > > Bryan
> > >
> > > > Hi,
> > > > > Set the VAUX2 regulator supply to 1.8V for the HSUSB host
> > > interface.
> > > > > Gpio 2 of the TPS65950 has to be set to zero in order to enable
> the
> > > > > HSUBS2 clock.
> > > >
> > > > TPS65950 GPIO2 is not to enable HSUSB2 clock but to enable chip
> u131
> > > > On omap3evm (rev-G) which latches USB, camera and audio lines.
> > > >
> > > > >
> > > > > Signed-off-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
> > > > > ---
> > > > >  arch/arm/mach-omap2/board-omap3evm.c |   25
> > > +++++++++++++++++++++++++
> > > > >  1 files changed, 25 insertions(+), 0 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm/mach-omap2/board-omap3evm.c
> b/arch/arm/mach-
> > > > > omap2/board-omap3evm.c
> > > > > index c452b3f..13a2b71 100644
> > > > > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > > > > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > > > > @@ -377,6 +377,10 @@ static int omap3evm_twl_gpio_setup(struct
> > > device
> > > > > *dev,
> > > > >  	if (r)
> > > > >  		printk(KERN_ERR "failed to get/set lcd_bkl gpio\n");
> > > > >
> > > > > +	/* gpio + 2 == HSUSB2 Clock Enable */
> > > > > +	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
> > > > > +		gpio_request_one(gpio + 2, GPIOF_OUT_INIT_LOW,
> > > > > "EN_HSUSB2_CLK");
> > > > > +
> > > >
> > > > Did you test EHCI port with this change ?
> > > >
> > > > Ajay
> > > > >  	/* gpio + 7 == DVI Enable */
> > > > >  	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
> > > > [...]
> > > > rm-kernel
> >
