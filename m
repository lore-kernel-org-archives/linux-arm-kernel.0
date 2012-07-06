From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Jul 2012 20:08:23 +0000
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <20120705161600.GA28860@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <201207051454.24475.arnd@arndb.de> <20120705161600.GA28860@lunn.ch>
Message-ID: <201207062008.23952.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 July 2012, Andrew Lunn wrote:
> > I think the latter one needs to be
> > 
> > +static int __initdata gpio1_irqs[4] = {
> > +     IRQ_DOVE_HIGH_GPIO,
> > +     IRQ_DOVE_HIGH_GPIO,
> > +     IRQ_DOVE_HIGH_GPIO,
> > +     IRQ_DOVE_HIGH_GPIO,
> > +};
> > 
> > so we register all four parts to the same primary IRQ. The
> > same is true for the devicetree representation.
> 
> Nope, does not work like that.
> 
> It does not matter which IRQ of a GPIO chip fires. It looks at the IRQ
> cause bits for all lines and fires off the secondary ISR as needed for
> the whole chip. So in effect, there is a mapping IRQ->GPIO chip, not
> IRQ->1/4 of GPIO chip. With what you suggest above, you would end up
> with four chained interrupt handlers, all being handled by the same
> interrupt handler for one chio, and the last three in the chain would
> never do anything since the first one does all the work.

Does it really?

The handler function I'm looking at is


static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
{
        int irqoff;
        BUG_ON(irq < IRQ_DOVE_GPIO_0_7 || irq > IRQ_DOVE_HIGH_GPIO);

        irqoff = irq <= IRQ_DOVE_GPIO_16_23 ? irq - IRQ_DOVE_GPIO_0_7 :
                3 + irq - IRQ_DOVE_GPIO_24_31;

        orion_gpio_irq_handler(irqoff << 3);
        if (irq == IRQ_DOVE_HIGH_GPIO) {
                orion_gpio_irq_handler(40);
                orion_gpio_irq_handler(48);
                orion_gpio_irq_handler(56);
        }
}

My reading of this is a manual hardwired implementation of a
primary handler that triggers the secondary handler four times
when it's called with a specific argument.

If you want to keep that behavior, this handler cannot be
generic across all mvebu socs, whereas registering four
chained handlers for the same primary interrupt would have
the same effect@a very small runtime overhead without the
need for any special case.

	Arnd
