From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 11:13:43 +0000
Subject: [PATCH 3/8] ARM: sirf: move irq driver to drivers/irqchip
In-Reply-To: <CAGsJ_4yPRE8SBSk5eLH3j3Y9bf9tbhy15i0kEE+83VcPNk80Cw@mail.gmail.com>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <201303250941.14399.arnd@arndb.de>
 <CAGsJ_4yPRE8SBSk5eLH3j3Y9bf9tbhy15i0kEE+83VcPNk80Cw@mail.gmail.com>
Message-ID: <201303251113.44076.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Barry Song wrote:
> 2013/3/25, Arnd Bergmann <arnd@arndb.de>:
> > On Monday 25 March 2013, Barry Song wrote:
> >> 2013/3/20, Arnd Bergmann <arnd@arndb.de>:
> >> this breaks the hwirq and irq mapping. the hwirq 0 is mapped to
> >> no_irqs, then setup_irq will fail in
> >> drivers/clocksource/timer-prima2.c.
> >
> > Hmm, I don't understand yet what is going on there. This should create
> > a domain with all dynamically allocated interrupt descriptors,
> > and the hwirq number is just local to the controller then.
> 
> suppose we think the hardware register flag bit of timer-prima2 is 0,
> irq_of_parse_and_map() will return 16 in patch2 for the timer-prima2
> which uses the 1st hardware IRQ in the system.
> 
> if add nr_irqs=288 in ATLAS6 machine, irq_of_parse_and_map() will
> return 288 in patch2. it looks like the first hw irq will always be
> mapped to nr_irqs.

right.

> > Without patch 2 of the series, this would fail, because that interrupt
> > is not mapped, but as far as I can tell, we correctly instantiate
> > the domain here, so the irq_of_parse_and_map() in sirfsoc_of_timer_map
> > should return a valid interrupt number. Can you check what it returns
> > instead? Does it work if you revert to a legacy domain here?
> 
> actually patch2 can work without patch3 by irq_domain_add legacy. as
> you can see, my old timer-marco.c uses irq_of_parse_and_map() instead
> of reading interrupts manually.

Yes, irq_of_parse_and_map() should always work.

>         void __iomem *base = of_iomap(np, 0);
>         if (!base)
>                 panic("unable to map intc cpu registers\n");
> 
> -       sirfsoc_irqdomain = irq_domain_add_linear(np, SIRFSOC_NUM_IRQS,
> +       sirfsoc_irqdomain = irq_domain_add_legacy(np, SIRFSOC_NUM_IRQS, 0, 0,
>                                  &irq_domain_simple_ops, base);
> 
>         sirfsoc_alloc_gc(base, 0, 32);
> ...
> drivers/pinctrl/pinctrl-sirf.c:
> -                bank->domain = irq_domain_add_linear(np,
> SIRFSOC_GPIO_BANK_SIZE,
> +                bank->domain = irq_domain_add_legacy(np,
> SIRFSOC_GPIO_BANK_SIZE,
> +                        128 + i * SIRFSOC_GPIO_BANK_SIZE, 0,
>                         &sirfsoc_gpio_irq_simple_ops, bank);

Right, but if we do this, we encode static IRQ numbers into the
irqchip drivers, which should not be necessary if all interrupts
can be mapped dynamically.

This means that the interrupt numbers that Linux reports in
/proc/interrupts will all change, but I don't see anything that
still depends on those, unless you have additional out of tree
patches that rely on hardcoded numbers.

Digging a bit deeper, I found that the generic irqchip implemmentation
does not deal with linear irq domains yet. There was a patch[1] least
year from Rob Herring, but it never got merged. I guess we can move
back to using the legacy domain for drivers/irqchip/irq-sirfsoc.c for
now and hardwire the assumption that its interrupts start at number 0.

	Arnd

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082455.html
