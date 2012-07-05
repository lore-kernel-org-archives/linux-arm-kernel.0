From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Jul 2012 18:16:00 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <201207051454.24475.arnd@arndb.de>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <20120705130819.GV17534@lunn.ch> <4FF5A15A.8070309@googlemail.com>
 <201207051454.24475.arnd@arndb.de>
Message-ID: <20120705161600.GA28860@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Something completely different I just noticed in the original patch:
> 
> > @@ -90,6 +74,27 @@ static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
> >       }
> >  }
> >  
> > +static int __initdata gpio0_irqs[4] = {
> > +     IRQ_DOVE_GPIO_0_7,
> > +     IRQ_DOVE_GPIO_8_15,
> > +     IRQ_DOVE_GPIO_16_23,
> > +     IRQ_DOVE_GPIO_24_31,
> > +};
> > +
> > +static int __initdata gpio1_irqs[4] = {
> > +     IRQ_DOVE_HIGH_GPIO,
> > +     0,
> > +     0,
> > +     0,
> > +};
> 
> I think the latter one needs to be
> 
> +static int __initdata gpio1_irqs[4] = {
> +     IRQ_DOVE_HIGH_GPIO,
> +     IRQ_DOVE_HIGH_GPIO,
> +     IRQ_DOVE_HIGH_GPIO,
> +     IRQ_DOVE_HIGH_GPIO,
> +};
> 
> so we register all four parts to the same primary IRQ. The
> same is true for the devicetree representation.

Nope, does not work like that.

It does not matter which IRQ of a GPIO chip fires. It looks at the IRQ
cause bits for all lines and fires off the secondary ISR as needed for
the whole chip. So in effect, there is a mapping IRQ->GPIO chip, not
IRQ->1/4 of GPIO chip. With what you suggest above, you would end up
with four chained interrupt handlers, all being handled by the same
interrupt handler for one chio, and the last three in the chain would
never do anything since the first one does all the work.

	  Andrew
