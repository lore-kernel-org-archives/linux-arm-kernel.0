From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 3 Feb 2010 22:58:55 +0100
Subject: [PATCH 06/13] ARM: LPC32XX: Core architecture files
In-Reply-To: <20100203204056.GD20113@pengutronix.de>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-7-git-send-email-wellsk40@gmail.com>
	<20100203155558.GH11354@pengutronix.de>
	<083DF309106F364B939360100EC290F805C8B78790@eu1rdcrdc1wx030.exi.nxp.com>
	<20100203204056.GD20113@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805C8B787EB@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > +   case IRQ_TYPE_EDGE_FALLING:
> > > > +           /* Falling edge sensitive */
> > > > +           reg = readl(ctrl + INTC_POLAR);
> > > > +           reg &= ~mask;
> > > > +           writel(reg, (ctrl + INTC_POLAR));
> > > > +           reg = readl(ctrl + INTC_ACT_TYPE);
> > > > +           reg |= mask;
> > > > +           writel(reg, (ctrl + INTC_ACT_TYPE));
> > > > +           set_irq_handler(irq, handle_edge_irq);
> > > > +           break;
> > > did you test that you really need handle_edge_irq?  Sane irq
> controllers
> > > can (and should) use handle_level_irq for both level and edge
> sensitive
> > > irqs.  You only need handle_edge_irq if your controller doesn't
> remember
> > > edge transitions while the irq is masked.
> >
> > This is supported and intended. It's important for slow moving external
> > GPIO events where you can't clear the active level state or pulse
> > duration (ie, switches).
> I didn't understand your answer here.  What is supported and intended?
> This has something to do with your controller, not with slow external
> things.
> 

The controller supports level and edge sensitive modes. There are cases
when using external events that you want an edge based interrupt. For
example, an event connected to a monetary switch will stay asserted
(level-wise) as long as the switch is closed. The interrupt controller
latches the event and can clear the latch, but the latch would never
clear if the interrupt was level sensitive. In cases like this, you just
want to handle the edges. This has been tested.

> > > Does this work without NO_HZ?  I though you need to setup a periodic
> > > mode with CONFIG_HZ irqs per second first?
> >
> > This is handled in the clockevents handler. It will setup the driver
> > for the next event in the set_next_event callback. I believe the
> > current CONFIG_HZ rate is set to 100.
> Hmmm:
> 
> 	~/gsrc/linux-2.6/arch/arm/mach-lpc32xx$ grep HZ *
> 	~/gsrc/linux-2.6/arch/arm/mach-lpc32xx$
> 

CONFIG_HZ is defined in the phy3250_defconfig file in arch/arms/configs.
It's actually used in the clock events driver and passes the next tick delta
to the timer driver callback. The timer driver itself doesn't know the tick
rate or even the value of HZ - it's in the higher layers. Note this timer
driver also works fine with NO_HZ. Sorry about the confusion on this.
