From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 09:41:14 +0000
Subject: [PATCH 3/8] ARM: sirf: move irq driver to drivers/irqchip
In-Reply-To: <CAGsJ_4wUtgEGY9fc_RGq4m+=wzzgS1MxCOCLRm6Xh+-5kVMAdQ@mail.gmail.com>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <1363779679-16880-4-git-send-email-arnd@arndb.de>
 <CAGsJ_4wUtgEGY9fc_RGq4m+=wzzgS1MxCOCLRm6Xh+-5kVMAdQ@mail.gmail.com>
Message-ID: <201303250941.14399.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Barry Song wrote:
> 2013/3/20, Arnd Bergmann <arnd@arndb.de>:

> > +static asmlinkage void __exception_irq_entry sirfsoc_handle_irq(struct
> > pt_regs *regs)
> > +{
> > +	void __iomem *base = sirfsoc_irqdomain->host_data;
> > +	u32 irqstat, irqnr;
> > +
> > +	irqstat = readl_relaxed(base + SIRFSOC_INIT_IRQ_ID);
> > +	irqnr = irq_find_mapping(sirfsoc_irqdomain, irqstat & 0xff);
> > +
> > +	handle_IRQ(irqnr, regs);
> > +}
> > +
> > +static void __init sirfsoc_irq_init(struct device_node *np, struct
> > device_node *parent)
> 
> this function should be changed from void to int.

Right.

> > +{
> > +	void __iomem *base = of_iomap(np, 0);
> > +	if (!base)
> > +		panic("unable to map intc cpu registers\n");
> > +
> > +	sirfsoc_irqdomain = irq_domain_add_linear(np, SIRFSOC_NUM_IRQS,
> > +				 &irq_domain_simple_ops, base);
> 
> this breaks the hwirq and irq mapping. the hwirq 0 is mapped to
> no_irqs, then setup_irq will fail in
> drivers/clocksource/timer-prima2.c.

Hmm, I don't understand yet what is going on there. This should create
a domain with all dynamically allocated interrupt descriptors,
and the hwirq number is just local to the controller then.

Without patch 2 of the series, this would fail, because that interrupt
is not mapped, but as far as I can tell, we correctly instantiate
the domain here, so the irq_of_parse_and_map() in sirfsoc_of_timer_map
should return a valid interrupt number. Can you check what it returns
instead? Does it work if you revert to a legacy domain here?

	Arnd
