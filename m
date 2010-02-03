From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Feb 2010 21:40:56 +0100
Subject: [PATCH 06/13] ARM: LPC32XX: Core architecture files
In-Reply-To: <083DF309106F364B939360100EC290F805C8B78790@eu1rdcrdc1wx030.exi.nxp.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-7-git-send-email-wellsk40@gmail.com>
	<20100203155558.GH11354@pengutronix.de>
	<083DF309106F364B939360100EC290F805C8B78790@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20100203204056.GD20113@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Feb 03, 2010 at 07:43:59PM +0100, Kevin Wells wrote:
> > > +
> > > +static void __set_gpio_dir_p012(struct lpc32xx_gpio_chip *group,
> > > +   unsigned pin, int input)
> > > +{
> > > +   if (input)
> > > +           writel(1 << pin, group->gpio_grp->dir_clr);
> > readl/writel are used to "perform PCI memory accesses via an ioremap
> > region" and "are defined to perform little endian accesses".  I think
> > most archs use __raw_readl/__raw_writel here.
> 
> There seems to be a lot of intermixing elsewhere in arch/arm where
> readl()/writel() is used instead of the __raw() functions. I actually
> switched to the non-__raw functions previously. Are the __raw variants
> the correct way to go then?
I think __raw_... is the right variant.  But I'm sure there are people
thinking different.
 
> > > +   case IRQ_TYPE_EDGE_FALLING:
> > > +           /* Falling edge sensitive */
> > > +           reg = readl(ctrl + INTC_POLAR);
> > > +           reg &= ~mask;
> > > +           writel(reg, (ctrl + INTC_POLAR));
> > > +           reg = readl(ctrl + INTC_ACT_TYPE);
> > > +           reg |= mask;
> > > +           writel(reg, (ctrl + INTC_ACT_TYPE));
> > > +           set_irq_handler(irq, handle_edge_irq);
> > > +           break;
> > did you test that you really need handle_edge_irq?  Sane irq controllers
> > can (and should) use handle_level_irq for both level and edge sensitive
> > irqs.  You only need handle_edge_irq if your controller doesn't remember
> > edge transitions while the irq is masked.
> 
> This is supported and intended. It's important for slow moving external
> GPIO events where you can't clear the active level state or pulse
> duration (ie, switches).
I didn't understand your answer here.  What is supported and intended?
This has something to do with your controller, not with slow external
things.
 
> > > +   /* mask all interrupts except SUBIRQA and SUBFIQ */
> > Why don't you mask all irqs?
> >
> > > +   writel((1 << IRQ_SUB1IRQ) | (1 << IRQ_SUB2IRQ) |
> > > +                   (1 << IRQ_SUB1FIQ) | (1 << IRQ_SUB2FIQ),
> > > +           (io_p2v(MIC_BASE) + INTC_MASK));
> > I wonder you want s/SUBIRQA/SUBIRQ/ ?
> 
> Interrupt banks SIC1 and SIC2 will work, but won't signal events to the
> MIC if they are masked. These are globally unmasked and never changed.
> The MIC is the only device that can generate an ARM IRQ or FIQ.
See my other mail about a chained handler.
 
> > > +   lpc32xx_clkevt.cpumask = cpumask_of(0);
> > > +   clockevents_register_device(&lpc32xx_clkevt);
> > > +
> > > +   /* Use timer1 as clock source. */
> > > +   writel(TIMER_CNTR_TCR_RESET, TIMER_TCR(TIMER1_IOBASE));
> > > +   writel(0, TIMER_PR(TIMER1_IOBASE));
> > > +   writel(0, TIMER_MCR(TIMER1_IOBASE));
> > > +   writel(TIMER_CNTR_TCR_EN, TIMER_TCR(TIMER1_IOBASE));
> > > +   lpc32xx_clksrc.mult = clocksource_hz2mult(clkrate,
> > > +           lpc32xx_clksrc.shift);
> > > +   clocksource_register(&lpc32xx_clksrc);
> > > +}
> > > +
> > > +struct sys_timer lpc32xx_timer = {
> > > +   .init           = &lpc32xx_timer_init,
> > > +};
> > Does this work without NO_HZ?  I though you need to setup a periodic
> > mode with CONFIG_HZ irqs per second first?
> 
> This is handled in the clockevents handler. It will setup the driver
> for the next event in the set_next_event callback. I believe the
> current CONFIG_HZ rate is set to 100.
Hmmm:

	~/gsrc/linux-2.6/arch/arm/mach-lpc32xx$ grep HZ *
	~/gsrc/linux-2.6/arch/arm/mach-lpc32xx$ 

Best regards
Uwe
-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
