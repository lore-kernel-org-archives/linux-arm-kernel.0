From: julia@diku.dk (Julia Lawall)
Date: Wed, 16 Mar 2011 10:15:35 +0100 (CET)
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <20110316083326.GF13316@pengutronix.de>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
	<1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
	<20110315090656.GC13316@pengutronix.de>
	<Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
	<20110315094946.GD13316@pengutronix.de>
	<Pine.LNX.4.64.1103151113420.8560@pc-004.diku.dk>
	<20110316083326.GF13316@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1103161015100.20452@pc-004.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'll see if I can incorporate the use of gpio_request_one in my rule.

julia


On Wed, 16 Mar 2011, Uwe Kleine-K?nig wrote:

> [added some people to Cc:]
> 
> Hello Julia,
> 
> On Tue, Mar 15, 2011 at 11:19:53AM +0100, Julia Lawall wrote:
> > On Tue, 15 Mar 2011, Uwe Kleine-K?nig wrote:
> > 
> > > On Tue, Mar 15, 2011 at 10:41:37AM +0100, Julia Lawall wrote:
> > > > I tried the following
> > > > 
> > > > @@
> > > > expression E1,E2;
> > > > @@
> > > > 
> > > >       gpio_direction_output(E1,E2);
> > > >       ...
> > > > -     gpio_set_value(E1,E2);
> > > > 
> > > > and found occurrences in 15 files.  In some cases there seems to be some 
> > > > delay before the call to gpio_set_value.  Does that have any impacton 
> > > > whether it is needed?
> > > gpio_direction_output(E1,E2) implies gpio_set_value(E1,E2), so unless
> > > there is a gpio_set_value(E1,!E2) before gpio_set_value(E1,E2) is a
> > > noop.
> > > 
> > > I still don't know how to work with coccinelle, so if you point me to a
> > > concrete location I can be more specific.
> > 
> > OK.  I have changed the semantic patch to the following:
> > 
> > @@
> > expression E1,E2,E3;
> > @@
> > 
> >       gpio_direction_output(E1,E2);
> >       ... when != gpio_set_value(E1,E3)
> > -     gpio_set_value(E1,E2);
> > 
> > Now it doesn't do all the cases where there is an earlier set ofr some 
> > other value.  The patch I obtain is below.  This only concerns 5 files.  
> > I haven't checked the result at all.
> Thanks. So here comes the check.
> 
> > diff -u -p a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> > --- a/arch/arm/mach-mx5/board-mx51_babbage.c 2011-02-19 08:28:51.000000000 +0100
> > +++ b/arch/arm/mach-mx5/board-mx51_babbage.c 2011-03-15 11:17:03.000000000 +0100
> > @@ -218,7 +218,6 @@ static inline void babbage_usbhub_reset(
> >  
> >  	/* USB HUB RESET - De-assert USB HUB RESET_N */
> >  	msleep(1);
> > -	gpio_set_value(BABBAGE_USB_HUB_RESET, 0);
> >  	msleep(1);
> >  	gpio_set_value(BABBAGE_USB_HUB_RESET, 1);
> >  }
> This function is a bit confusing:
> 
> 	/* Bring USB hub out of reset */
> 	ret = gpio_request(BABBAGE_USB_HUB_RESET, "GPIO1_7");
> 	if (ret) {
> 		...
> 		return;
> 	}
> 	gpio_direction_output(BABBAGE_USB_HUB_RESET, 0);
> 	/* USB HUB RESET - De-assert USB HUB RESET_N */
> 	msleep(1);
> 	gpio_set_value(BABBAGE_USB_HUB_RESET, 0);
> 	msleep(1);
> 	gpio_set_value(BABBAGE_USB_HUB_RESET, 1);
> 
> IMHO the comments are misleading.  I'd suggest:
> 
> 	ret = gpio_request_one(BABBAGE_USB_HUB_RESET,
> 			GPIOF_DIR_OUT | GPIOF_INIT_LOW, "USB hub reset#");
> 	if (ret) {
> 		pr_err("failed to request gpio for USB hub reset#: %d\n", ret);
> 		return;
> 	}
> 	msleep(2);
> 	gpio_set_value(BABBAGE_USB_HUB_RESET, 1);
> 
> Fabio?
> 
> > @@ -234,7 +233,6 @@ static inline void babbage_fec_reset(voi
> >  		return;
> >  	}
> >  	gpio_direction_output(BABBAGE_FEC_PHY_RESET, 0);
> > -	gpio_set_value(BABBAGE_FEC_PHY_RESET, 0);
> >  	msleep(1);
> >  	gpio_set_value(BABBAGE_FEC_PHY_RESET, 1);
> >  }
> should use
> 	gpio_request_one(BABBAGE_FEC_PHY_RESET,
> 		GPIOF_DIR_OUT | GPIOF_INIT_LOW, "fec-phy-reset");
> 
> > diff -u -p a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
> > --- a/arch/arm/mach-mx5/board-mx53_evk.c 2011-03-14 17:19:13.000000000 +0100
> > +++ b/arch/arm/mach-mx5/board-mx53_evk.c 2011-03-15 11:17:03.000000000 +0100
> > @@ -88,7 +88,6 @@ static inline void mx53_evk_fec_reset(vo
> >  		return;
> >  	}
> >  	gpio_direction_output(SMD_FEC_PHY_RST, 0);
> > -	gpio_set_value(SMD_FEC_PHY_RST, 0);
> >  	msleep(1);
> >  	gpio_set_value(SMD_FEC_PHY_RST, 1);
> >  }
> ditto
> 
> > diff -u -p a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> > --- a/arch/arm/mach-omap2/board-omap3evm.c 2011-03-14 17:19:13.000000000 +0100
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c 2011-03-15 11:17:04.000000000 +0100
> > @@ -860,7 +860,6 @@ static void __init omap3_evm_init(void)
> >  		omap_mux_init_gpio(61, OMAP_PIN_INPUT_PULLUP);
> >  		gpio_request(OMAP3_EVM_EHCI_SELECT, "select EHCI port");
> >  		gpio_direction_output(OMAP3_EVM_EHCI_SELECT, 0);
> > -		gpio_set_value(OMAP3_EVM_EHCI_SELECT, 0);
> >  
> >  		/* setup EHCI phy reset config */
> >  		omap_mux_init_gpio(21, OMAP_PIN_INPUT_PULLUP);
> ditto
> 
> > diff -u -p a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> > --- a/arch/arm/mach-omap2/board-omap4panda.c 2011-03-14 17:19:13.000000000 +0100
> > +++ b/arch/arm/mach-omap2/board-omap4panda.c 2011-03-15 11:17:04.000000000 +0100
> > @@ -129,7 +129,6 @@ static void __init omap4_ehci_init(void)
> >  	}
> >  	gpio_export(GPIO_HUB_POWER, 0);
> >  	gpio_direction_output(GPIO_HUB_POWER, 0);
> > -	gpio_set_value(GPIO_HUB_POWER, 0);
> Should use gpio_request_one, too. And IMHO gpio_export should only be
> called after the direction is set (which is an obsolete comment when
> gpio_request_one is used).
>   
> >  	/* reset phy+hub */
> >  	ret = gpio_request(GPIO_HUB_NRESET, "hub_nreset");
> > @@ -139,7 +138,6 @@ static void __init omap4_ehci_init(void)
> >  	}
> >  	gpio_export(GPIO_HUB_NRESET, 0);
> >  	gpio_direction_output(GPIO_HUB_NRESET, 0);
> > -	gpio_set_value(GPIO_HUB_NRESET, 0);
> >  	gpio_set_value(GPIO_HUB_NRESET, 1);
> >  
> >  	usbhs_init(&usbhs_bdata);
> ditto
> 
> > diff -u -p a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
> > --- a/arch/arm/mach-pxa/am300epd.c 2010-03-18 09:06:45.000000000 +0100
> > +++ b/arch/arm/mach-pxa/am300epd.c 2011-03-15 11:17:04.000000000 +0100
> > @@ -150,8 +150,6 @@ static int am300_init_gpio_regs(struct b
> >  		gpio_direction_output(i, 0);
> >  
> >  	/* go into command mode */
> > -	gpio_set_value(CFG_GPIO_PIN, 1);
> > -	gpio_set_value(RST_GPIO_PIN, 0);
> >  	msleep(10);
> >  	gpio_set_value(RST_GPIO_PIN, 1);
> >  	msleep(10);
> This can probably make use of gpio_request_array.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
