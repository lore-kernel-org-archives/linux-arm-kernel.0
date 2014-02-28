From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 28 Feb 2014 12:00:12 +0100
Subject: [ARM] CNS3xxx: 3 regressions identified in v3.14-rc4+
Message-ID: <m3eh2nqz7n.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Linux version 3.14.0-rc4+ (current tip, no extra patches), CPU is Cavium
Econa CNS3420, board is Gateworks Laguna GW2388-4 (masqueraded as
CNS3420VB).


Issue #1 ###################################################

kernel BUG at mm/vmalloc.c:1132!
PC is at vm_area_add_early+0x20/0x84
LR is at add_static_vm_early+0xc/0x60

The problem is cns3xxx_pcie_init() (device_initcall) calls the "early"
iotable_init(). I'll attach the patch.


Issue #2 ###################################################

PCI hangs system completely while trying to access any PCI MMIO region
(plain IO not tested).

The guilty commit is 928bea964827d7824b548c1f8e06eccbbc4d0d7d:

    PCI: Delay enabling bridges until they're needed

    We currently enable PCI bridges after scanning a bus and assigning
    resources.  This is often done in arch code.

    This patch changes this so we don't enable a bridge until necessary, i.e.,
    until we enable a PCI device behind the bridge.  We do this in the generic
    pci_enable_device() path, so this also removes the arch-specific code to
    enable bridges.

Reverting changes in arch/arm/kernel/bios32.c, drivers/pci/bus.c and
include/linux/pci.h (= essentially adding pci_enable_bridges(bus) in
ARM's pci_common_init_dev()) makes it work again.

Options?


Issue #3 ###################################################

NR_IRQS:16 nr_irqs:96 96

WARNING: at drivers/irqchip/irq-gic.c:952 gic_init_bases+0xe4/0x2b8()
Cannot allocate irq_descs @ IRQ16, assuming pre-allocated
Backtrace:
gic_init_bases    from cns3xxx_init_irq+0x24/0x34
cns3xxx_init_irq  from init_IRQ+0x24/0x2c
init_IRQ          from start_kernel+0x1a8/0x338
start_kernel      from 0x2000806c

I'm having problems understanding how is machine_desc->nr_irqs supposed
to work with CONFIG_ARM_GIC and CONFIG_SPARSE_IRQ set.

machine_desc->nr_irqs is set to NR_IRQS_CNS3XXX =
IRQ_TC11MP_GIC_START + 64 = 32 + 64 = 96.

At start, machine_desc->nr_irqs are pre-allocated via
start_kernel() -> early_irq_init().

Then, gic_init(0, 29, ...) ->  gic_init_bases(0, 29, ...) tries this
(and fails):

	/*
	 * For primary GICs, skip over SGIs.
	 * For secondary GICs, skip over PPIs, too.
	 */
	irq_start = (effectively) 16;

	irq_base = irq_alloc_descs(irq_start, 16, gic_irqs, numa_node_id());
	if (IS_ERR_VALUE(irq_base)) {
		WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
		     irq_start);

Does this mean machine_desc->nr_irqs is to be kept at 16
(NR_IRQS_LEGACY) or less, so it doesn't conflict with gic_init()?

Or perhaps gic_init() shouldn't warn about this?

-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
