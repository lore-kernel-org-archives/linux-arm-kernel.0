From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Thu, 20 Feb 2014 10:37:58 +0100
Subject: machine_desc->nr_irqs question
Message-ID: <m3vbwaqg3t.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm having problems understanding how is machine_desc->nr_irqs supposed
to work with CONFIG_ARM_GIC.
Assuming CONFIG_SPARSE_IRQ is set. The CPU is, in this case, cns3xxx.

Cns3xxx machine_desc->nr_irqs is set to NR_IRQS_CNS3XXX =
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
