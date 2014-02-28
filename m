From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 12:31:45 +0100
Subject: [ARM] CNS3xxx: 3 regressions identified in v3.14-rc4+
In-Reply-To: <m3eh2nqz7n.fsf@t19.piap.pl>
References: <m3eh2nqz7n.fsf@t19.piap.pl>
Message-ID: <10801013.Hh6CjhvAyx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 February 2014 12:00:12 Krzysztof Ha?asa wrote:
> 
> PCI hangs system completely while trying to access any PCI MMIO region
> (plain IO not tested).
> 
> The guilty commit is 928bea964827d7824b548c1f8e06eccbbc4d0d7d:
> 
>     PCI: Delay enabling bridges until they're needed
> 
>     We currently enable PCI bridges after scanning a bus and assigning
>     resources.  This is often done in arch code.
> 
>     This patch changes this so we don't enable a bridge until necessary, i.e.,
>     until we enable a PCI device behind the bridge.  We do this in the generic
>     pci_enable_device() path, so this also removes the arch-specific code to
>     enable bridges.
> 
> Reverting changes in arch/arm/kernel/bios32.c, drivers/pci/bus.c and
> include/linux/pci.h (= essentially adding pci_enable_bridges(bus) in
> ARM's pci_common_init_dev()) makes it work again.
> 
> Options?

Hmm, this was in 3.12 already, right?

Can you try adding the code in a host specific callback such as
hw->add_bus?

> Issue #3 ###################################################
> 
> NR_IRQS:16 nr_irqs:96 96
> 
> WARNING: at drivers/irqchip/irq-gic.c:952 gic_init_bases+0xe4/0x2b8()
> Cannot allocate irq_descs @ IRQ16, assuming pre-allocated
> Backtrace:
> gic_init_bases    from cns3xxx_init_irq+0x24/0x34
> cns3xxx_init_irq  from init_IRQ+0x24/0x2c
> init_IRQ          from start_kernel+0x1a8/0x338
> start_kernel      from 0x2000806c
> 
> I'm having problems understanding how is machine_desc->nr_irqs supposed
> to work with CONFIG_ARM_GIC and CONFIG_SPARSE_IRQ set.
> 
> machine_desc->nr_irqs is set to NR_IRQS_CNS3XXX =
> IRQ_TC11MP_GIC_START + 64 = 32 + 64 = 96.
> 
> At start, machine_desc->nr_irqs are pre-allocated via
> start_kernel() -> early_irq_init().
> 
> Then, gic_init(0, 29, ...) ->  gic_init_bases(0, 29, ...) tries this
> (and fails):
> 
>         /*
>          * For primary GICs, skip over SGIs.
>          * For secondary GICs, skip over PPIs, too.
>          */
>         irq_start = (effectively) 16;
> 
>         irq_base = irq_alloc_descs(irq_start, 16, gic_irqs, numa_node_id());
>         if (IS_ERR_VALUE(irq_base)) {
>                 WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
>                      irq_start);
> 
> Does this mean machine_desc->nr_irqs is to be kept at 16
> (NR_IRQS_LEGACY) or less, so it doesn't conflict with gic_init()?
> 
> Or perhaps gic_init() shouldn't warn about this?

I think the problem is that both the board file and the gic code try to
set up legacy interrupts. Try just removing the 'nr_irqs=' line.

	Arnd
