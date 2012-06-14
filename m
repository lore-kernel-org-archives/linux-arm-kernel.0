From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 14 Jun 2012 11:18:58 +0200
Subject: [PATCH 1/9] ARM: Kirkwood: Add interrupt controller support for
 DT boards
In-Reply-To: <201206140812.34399.arnd@arndb.de>
References: <1339324322-29388-2-git-send-email-andrew@lunn.ch>
 <201206140812.34399.arnd@arndb.de>
Message-ID: <20120614091858.GD4799@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 08:12:34AM +0000, Arnd Bergmann wrote:
> On Sunday 10 June 2012, Andrew Lunn wrote:
> > +static int __init kirkwood_add_irq_domain(struct device_node *np,
> > +                                         struct device_node *interrupt_parent)
> > +{
> > +       kirkwood_init_irq();
> > +       irq_domain_add_legacy(np, 64, 0, 0, &irq_domain_simple_ops, NULL);
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id kirkwood_irq_match[] = {
> > +       { .compatible = "marvell,orion-intc",
> > +         .data = kirkwood_add_irq_domain, },
> > +       {},
> > +};
> > +
> > +static void __init kirkwood_dt_init_irq(void)
> > +{
> > +       of_irq_init(kirkwood_irq_match);
> > +}
> > +
> 
> I think if you compute the number of interrupts in the domain from the number of
> registers that are described in the device tree, call orion_irq_init()
> based on those registers, and use irq domains for the gpio stuff as Rob suggested,
> this init_irq function can become completely generic to all orion platforms.

I'm reworking the GPIO stuff at the moment, moving it to use IRQ
domains for its interrupts. That code will be generic to all Orion
platforms. I'm modeling the code on the AT91 GPIO handler, since that
has a similar structure, one hardware interrupt for a number of GPIO
lines, which is in software demultiplexed and triggers secondary level
interrupts. The major difference is that AT91 has one hardware
interrupt for a GPIO chip with 32 lines, where as Orion has 4 hardware
interrupt lines, so maybe four interrupt domains, for one GPIO chip
with 32 lines.

Non-GPIO interrupts are more of a problem. Underneath it uses the
generic-chip interrupt code. The patchset to add _domain versions of
these calls is stalled. So i think for the moment, we need to stay
with the domain bolted on top, until generic-chip gets domain
support. I would also expect that generic-chip also gets a common DT
binding which any SoC can use.

My aim at the moment is to get something which works well enough that
we can add DT support to other drivers. Without interrupts, we are not
going to get very far. We can later rip it out what i create now and
replace it once generic-chip becomes domain and DT aware, and there
should be no effect on other drivers.

       Andrew
