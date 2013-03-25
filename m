From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 25 Mar 2013 17:56:41 +0800
Subject: [PATCH 3/8] ARM: sirf: move irq driver to drivers/irqchip
In-Reply-To: <201303250941.14399.arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <1363779679-16880-4-git-send-email-arnd@arndb.de>
 <CAGsJ_4wUtgEGY9fc_RGq4m+=wzzgS1MxCOCLRm6Xh+-5kVMAdQ@mail.gmail.com>
 <201303250941.14399.arnd@arndb.de>
Message-ID: <CAGsJ_4yPRE8SBSk5eLH3j3Y9bf9tbhy15i0kEE+83VcPNk80Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/25, Arnd Bergmann <arnd@arndb.de>:
> On Monday 25 March 2013, Barry Song wrote:
>> 2013/3/20, Arnd Bergmann <arnd@arndb.de>:
>
>> > +static asmlinkage void __exception_irq_entry sirfsoc_handle_irq(struct
>> > pt_regs *regs)
>> > +{
>> > +	void __iomem *base = sirfsoc_irqdomain->host_data;
>> > +	u32 irqstat, irqnr;
>> > +
>> > +	irqstat = readl_relaxed(base + SIRFSOC_INIT_IRQ_ID);
>> > +	irqnr = irq_find_mapping(sirfsoc_irqdomain, irqstat & 0xff);
>> > +
>> > +	handle_IRQ(irqnr, regs);
>> > +}
>> > +
>> > +static void __init sirfsoc_irq_init(struct device_node *np, struct
>> > device_node *parent)
>>
>> this function should be changed from void to int.
>
> Right.
>
>> > +{
>> > +	void __iomem *base = of_iomap(np, 0);
>> > +	if (!base)
>> > +		panic("unable to map intc cpu registers\n");
>> > +
>> > +	sirfsoc_irqdomain = irq_domain_add_linear(np, SIRFSOC_NUM_IRQS,
>> > +				 &irq_domain_simple_ops, base);
>>
>> this breaks the hwirq and irq mapping. the hwirq 0 is mapped to
>> no_irqs, then setup_irq will fail in
>> drivers/clocksource/timer-prima2.c.
>
> Hmm, I don't understand yet what is going on there. This should create
> a domain with all dynamically allocated interrupt descriptors,
> and the hwirq number is just local to the controller then.

suppose we think the hardware register flag bit of timer-prima2 is 0,
irq_of_parse_and_map() will return 16 in patch2 for the timer-prima2
which uses the 1st hardware IRQ in the system.

if add nr_irqs=288 in ATLAS6 machine, irq_of_parse_and_map() will
return 288 in patch2. it looks like the first hw irq will always be
mapped to nr_irqs.

>
> Without patch 2 of the series, this would fail, because that interrupt
> is not mapped, but as far as I can tell, we correctly instantiate
> the domain here, so the irq_of_parse_and_map() in sirfsoc_of_timer_map
> should return a valid interrupt number. Can you check what it returns
> instead? Does it work if you revert to a legacy domain here?

actually patch2 can work without patch3 by irq_domain_add legacy. as
you can see, my old timer-marco.c uses irq_of_parse_and_map() instead
of reading interrupts manually.

the irq mapping works with the following changes:
-------------------------------------------------------------------------
-------------------------------------------------------------------------
arch/arm/mach-prima2/common.c:

 DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
        /* Maintainer: Barry Song <baohua.song@csr.com> */
        .map_io         = sirfsoc_map_io,
+       .nr_irqs        = 288,
        .init_irq       = irqchip_init,
        .init_time      = sirfsoc_init_time,
        .init_machine   = sirfsoc_mach_init,

-------------------------------------------------------------------------
-------------------------------------------------------------------------
drivers/irqchip/irq-sirfsoc.c:
index 9a6a925..271f905 100644
--- a/drivers/irqchip/irq-sirfsoc.c
+++ b/drivers/irqchip/irq-sirfsoc.c
@@ -54,13 +54,13 @@ static asmlinkage void __exception_irq_entry
sirfsoc_handle_irq(struct pt_regs *
        handle_IRQ(irqnr, regs);
 }

-static void __init sirfsoc_irq_init(struct device_node *np, struct
device_node *parent)
+static int __init sirfsoc_irq_init(struct device_node *np, struct
device_node *parent)
 {
        void __iomem *base = of_iomap(np, 0);
        if (!base)
                panic("unable to map intc cpu registers\n");

-       sirfsoc_irqdomain = irq_domain_add_linear(np, SIRFSOC_NUM_IRQS,
+       sirfsoc_irqdomain = irq_domain_add_legacy(np, SIRFSOC_NUM_IRQS, 0, 0,
                                 &irq_domain_simple_ops, base);

        sirfsoc_alloc_gc(base, 0, 32);
@@ -73,6 +73,8 @@ static void __init sirfsoc_irq_init(struct
device_node *np, struct device_node *
        writel_relaxed(0, base + SIRFSOC_INT_RISC_MASK1);

        set_handle_irq(sirfsoc_handle_irq);
+
+       return 0;
 }
 IRQCHIP_DECLARE(sirfsoc_intc, "sirf,prima2-intc", sirfsoc_irq_init);

-------------------------------------------------------------------------
-------------------------------------------------------------------------
drivers/pinctrl/pinctrl-sirf.c:
-                bank->domain = irq_domain_add_linear(np,
SIRFSOC_GPIO_BANK_SIZE,
+                bank->domain = irq_domain_add_legacy(np,
SIRFSOC_GPIO_BANK_SIZE,
+                        128 + i * SIRFSOC_GPIO_BANK_SIZE, 0,
                        &sirfsoc_gpio_irq_simple_ops, bank);

@@ -65,13 +74,14 @@ MACHINE_END

-barry
