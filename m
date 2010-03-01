From: kevin.wells@nxp.com (Kevin Wells)
Date: Mon, 1 Mar 2010 18:57:10 +0100
Subject: [PATCH 04/13] ARM: LPC32XX: GPIO, timer, and IRQ drivers
In-Reply-To: <20100227204243.GB5760@pengutronix.de>
References: <1267228430-27193-1-git-send-email-wellsk40@gmail.com>
	<1267228430-27193-5-git-send-email-wellsk40@gmail.com>
	<20100227204243.GB5760@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805CCF92938@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

> > +
> > +	/* Activation type, edge or level */
> > +	reg = __raw_readl(LPC32XX_INTC_ACT_TYPE(ctrl));
> > +	if (use_edge) {
> > +		reg |= mask;
> > +		set_irq_handler(irq, handle_edge_irq);
> > +	} else {
> > +		reg &= ~mask;
> > +		set_irq_handler(irq, handle_level_irq);
> > +	}
> So you really need handle_edge_irq?  If so you should report this to
> your hardware department and ask for a better irq logic next time.
> 

Thanks for your time in helping to improve this port. I'm really
embarrassed to say I missed this. The complete correct changes are below
with the level based handler used for all sources.
This is fixed it in my baseline. Thanks for catching this.

@@ -242,13 +242,11 @@ static void __lpc32xx_set_irq_type(unsigned int irq, int use_high_level,
 
        /* Activation type, edge or level */
        reg = __raw_readl(LPC32XX_INTC_ACT_TYPE(ctrl));
-       if (use_edge) {
+       if (use_edge)
                reg |= mask;
-               set_irq_handler(irq, handle_edge_irq);
-       } else {
+       else
                reg &= ~mask;
-               set_irq_handler(irq, handle_level_irq);
-       }
+       __raw_writel(reg, LPC32XX_INTC_ACT_TYPE(ctrl));
 
        /* Use same polarity for the wake events */
        if (lpc32xx_events[irq].mask != 0) {

Kevin

> 
> Best regards
> Uwe
> 
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
