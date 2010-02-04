From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 4 Feb 2010 09:17:45 +0100
Subject: [PATCH 06/13] ARM: LPC32XX: Core architecture files
In-Reply-To: <083DF309106F364B939360100EC290F805C8B787EB@eu1rdcrdc1wx030.exi.nxp.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-7-git-send-email-wellsk40@gmail.com>
	<20100203155558.GH11354@pengutronix.de>
	<083DF309106F364B939360100EC290F805C8B78790@eu1rdcrdc1wx030.exi.nxp.com>
	<20100203204056.GD20113@pengutronix.de>
	<083DF309106F364B939360100EC290F805C8B787EB@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20100204081744.GA5380@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Feb 03, 2010 at 10:58:55PM +0100, Kevin Wells wrote:
> > > > > +   case IRQ_TYPE_EDGE_FALLING:
> > > > > +           /* Falling edge sensitive */
> > > > > +           reg = readl(ctrl + INTC_POLAR);
> > > > > +           reg &= ~mask;
> > > > > +           writel(reg, (ctrl + INTC_POLAR));
> > > > > +           reg = readl(ctrl + INTC_ACT_TYPE);
> > > > > +           reg |= mask;
> > > > > +           writel(reg, (ctrl + INTC_ACT_TYPE));
> > > > > +           set_irq_handler(irq, handle_edge_irq);
> > > > > +           break;
> > > > did you test that you really need handle_edge_irq?  Sane irq
> > controllers
> > > > can (and should) use handle_level_irq for both level and edge
> > sensitive
> > > > irqs.  You only need handle_edge_irq if your controller doesn't
> > remember
> > > > edge transitions while the irq is masked.
> > >
> > > This is supported and intended. It's important for slow moving external
> > > GPIO events where you can't clear the active level state or pulse
> > > duration (ie, switches).
> > I didn't understand your answer here.  What is supported and intended?
> > This has something to do with your controller, not with slow external
> > things.
> > 
> 
> The controller supports level and edge sensitive modes. There are cases
> when using external events that you want an edge based interrupt. For
> example, an event connected to a monetary switch will stay asserted
> (level-wise) as long as the switch is closed. The interrupt controller
> latches the event and can clear the latch, but the latch would never
> clear if the interrupt was level sensitive. In cases like this, you just
> want to handle the edges. This has been tested.
Oh yes.  Of course.  I'll retry to make my point more explicit using some
code.

Did you verify the following is broken? :

	static int lpc32xx_set_irq_type(unsigned int irq, unsigned int type)
	{
		unsigned int reg, ctrl, mask;

		get_controller(irq, &ctrl, &mask);

		switch (type) {
		case IRQ_TYPE_EDGE_RISING:
			/* Rising edge sensitive */
			__set_irq_type(ctrl, mask, mask, mask);
			/*
			 * don't set irq_handler to handle_edge_irq here
		         * as handle_level_irq can handle edge sensitive
		         * irqs just fine.  Of course the controller
		         * needs to be setup for edge irqs to get any
		         * difference to IRQ_TYPE_LEVEL_HIGH.
			 * See
			 * http://mid.gmane.org/20091007102836.GA27860 at flint.arm.linux.org.uk
			 * for some details
			 */
			break;

		case IRQ_TYPE_EDGE_FALLING:
			/* Falling edge sensitive */
			__set_irq_type(ctrl, mask, 0, mask);
			/* don't set irq_handler to handle_edge_irq here */
			break;

		case IRQ_TYPE_LEVEL_LOW:
			/* Low level sensitive */
			__set_irq_type(ctrl, mask, 0, 0);
			...

	}

	...

	void __init lpc32xx_init_irq(void)
	{
		...
		for (i = 0; i < NR_IRQS; i++) {
			set_irq_flags(i, IRQF_VALID);
			set_irq_chip(i, &lpc32xx_irq_chip);
			/*
			 * use handle_level_irq for edge and level
 			 * triggered irqs
			 */
			set_irq_handler(irq, handle_level_irq);
		}
		...
	}
	

> > > > Does this work without NO_HZ?  I though you need to setup a periodic
> > > > mode with CONFIG_HZ irqs per second first?
> > >
> > > This is handled in the clockevents handler. It will setup the driver
> > > for the next event in the set_next_event callback. I believe the
> > > current CONFIG_HZ rate is set to 100.
> > Hmmm:
> > 
> > 	~/gsrc/linux-2.6/arch/arm/mach-lpc32xx$ grep HZ *
> > 	~/gsrc/linux-2.6/arch/arm/mach-lpc32xx$
> > 
> 
> CONFIG_HZ is defined in the phy3250_defconfig file in arch/arms/configs.
> It's actually used in the clock events driver and passes the next tick delta
> to the timer driver callback. The timer driver itself doesn't know the tick
> rate or even the value of HZ - it's in the higher layers. Note this timer
> driver also works fine with NO_HZ. Sorry about the confusion on this.
Probably it's really just me who is confused, but I wondered if this
works *without* NO_HZ as I thought the timer init function is supposed
to set up a HZ tick.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
