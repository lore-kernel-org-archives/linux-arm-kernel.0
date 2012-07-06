From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 6 Jul 2012 23:00:09 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <201207062008.23952.arnd@arndb.de>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <201207051454.24475.arnd@arndb.de> <20120705161600.GA28860@lunn.ch>
 <201207062008.23952.arnd@arndb.de>
Message-ID: <20120706210009.GC11470@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 08:08:23PM +0000, Arnd Bergmann wrote:
> On Thursday 05 July 2012, Andrew Lunn wrote:
> > > I think the latter one needs to be
> > > 
> > > +static int __initdata gpio1_irqs[4] = {
> > > +     IRQ_DOVE_HIGH_GPIO,
> > > +     IRQ_DOVE_HIGH_GPIO,
> > > +     IRQ_DOVE_HIGH_GPIO,
> > > +     IRQ_DOVE_HIGH_GPIO,
> > > +};
> > > 
> > > so we register all four parts to the same primary IRQ. The
> > > same is true for the devicetree representation.
> > 
> > Nope, does not work like that.
> > 
> > It does not matter which IRQ of a GPIO chip fires. It looks at the IRQ
> > cause bits for all lines and fires off the secondary ISR as needed for
> > the whole chip. So in effect, there is a mapping IRQ->GPIO chip, not
> > IRQ->1/4 of GPIO chip. With what you suggest above, you would end up
> > with four chained interrupt handlers, all being handled by the same
> > interrupt handler for one chio, and the last three in the chain would
> > never do anything since the first one does all the work.
> 
> Does it really?
> 
> The handler function I'm looking at is
> 
> 
> static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> {
>         int irqoff;
>         BUG_ON(irq < IRQ_DOVE_GPIO_0_7 || irq > IRQ_DOVE_HIGH_GPIO);
> 
>         irqoff = irq <= IRQ_DOVE_GPIO_16_23 ? irq - IRQ_DOVE_GPIO_0_7 :
>                 3 + irq - IRQ_DOVE_GPIO_24_31;
> 
>         orion_gpio_irq_handler(irqoff << 3);
>         if (irq == IRQ_DOVE_HIGH_GPIO) {
>                 orion_gpio_irq_handler(40);
>                 orion_gpio_irq_handler(48);
>                 orion_gpio_irq_handler(56);
>         }
> }

void orion_gpio_irq_handler(int pinoff)
{
        struct orion_gpio_chip *ochip;
        u32 cause, type;
        int i;

        ochip = orion_gpio_chip_find(pinoff);
        if (ochip == NULL)
                return;

        cause = readl(GPIO_DATA_IN(ochip)) & readl(GPIO_LEVEL_MASK(ochip));
        cause |= readl(GPIO_EDGE_CAUSE(ochip)) & readl(GPIO_EDGE_MASK(ochip));

        for (i = 0; i < ochip->chip.ngpio; i++) {
                int irq;

                irq = ochip->secondary_irq_base + i;

                if (!(cause & (1 << i)))
                        continue;

                type = irqd_get_trigger_type(irq_get_irq_data(irq));
                if ((type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
                        /* Swap polarity (race with GPIO line) */
                        u32 polarity;

                        polarity = readl(GPIO_IN_POL(ochip));
                        polarity ^= 1 << i;
                        writel(polarity, GPIO_IN_POL(ochip));
                }
                generic_handle_irq(irq);
        }
}

orion_gpio_chip_find(pinoff) when called with pinoff 32, 40, 48, or 56
will return the same gpio chip. The loop:

        for (i = 0; i < ochip->chip.ngpio; i++) {

will iterate over all lines of the controller.

> My reading of this is a manual hardwired implementation of a
> primary handler that triggers the secondary handler four times
> when it's called with a specific argument.

Here is your mistake. It not a secondary handler. It is a function
which might trigger a secondary handler, if the status bit requires
that the secondary handler should be called..

> If you want to keep that behavior, this handler cannot be
> generic across all mvebu socs, whereas registering four
> chained handlers for the same primary interrupt would have
> the same effect at a very small runtime overhead without the
> need for any special case.

I would say the current code does redundant stuff.

This code has also been tested on a Dove by Sebastian Hesselbarth and
he did not notice anything strange happening on his system.

   Andrew
