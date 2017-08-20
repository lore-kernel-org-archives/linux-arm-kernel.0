From: slash.tmp@free.fr (Mason)
Date: Sun, 20 Aug 2017 19:22:00 +0200
Subject: [PATCH v6] irqchip: Add support for tango interrupt router
In-Reply-To: <ee9e4a52-9b21-d57f-1ae8-c7297d4386a6@arm.com>
References: <657580dd-0cfe-e377-e425-0deabf6d20c3@free.fr>
 <20170606175219.34ef62b9@free-electrons.com>
 <d8a4d8ad-a9f3-07eb-9e2a-a4bbec01961e@free.fr>
 <dfb86360-2247-65bb-602b-5c21029709fd@free.fr>
 <c0bd235a-9035-2002-31eb-e68710b076fd@free.fr>
 <24f34220-a017-f4e0-b72e-d1fdb014c0e1@free.fr>
 <9f384711-eef0-5117-b89c-9d2dc16e5ae5@free.fr>
 <afcc2b79-61ff-b54d-eac1-ea7f3ee6b6b2@free.fr>
 <e4a201b1-64e7-32a1-9cad-e632eeb156f6@free.fr>
 <473118cd-20dc-3534-d0d8-88799e3d2c3b@free.fr>
 <eea0ba7d-15d2-fb20-7c23-b2d3c4a7cfa7@free.fr>
 <ee9e4a52-9b21-d57f-1ae8-c7297d4386a6@arm.com>
Message-ID: <21670cea-beaf-8a41-84fb-f3c892527b0e@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2017 14:47, Marc Zyngier wrote:

> On 01/08/17 17:56, Mason wrote:
>
>> +/*
>> + * This controller maps IRQ_MAX input lines to SPI_MAX output lines.
>> + * The output lines are routed to GIC SPI 0 to 23.
>> + * This driver muxes LEVEL_HIGH IRQs onto output line 0,
>> + * and gives every EDGE_RISING IRQ a dedicated output line.
>> + */
>> +#define IRQ_MAX		128
>> +#define SPI_MAX		24
>> +#define LEVEL_SPI	0
>> +#define IRQ_ENABLE	BIT(31)
>> +#define STATUS		0x420
>> +
>> +struct tango_intc {
>> +	void __iomem *base;
>> +	struct irq_domain *dom;
>> +	u8 spi_to_tango_irq[SPI_MAX];
>> +	u8 tango_irq_to_spi[IRQ_MAX];
>> +	DECLARE_BITMAP(enabled_level, IRQ_MAX);
>> +	DECLARE_BITMAP(enabled_edge, IRQ_MAX);
>> +	spinlock_t lock;
>> +};
>> +
>> +static struct tango_intc *tango_intc;
>> +
>> +static void tango_level_isr(struct irq_desc *desc)
>> +{
>> +	uint pos, virq;
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	struct tango_intc *intc = irq_desc_get_handler_data(desc);
>> +	DECLARE_BITMAP(status, IRQ_MAX);
>> +
>> +	chained_irq_enter(chip, desc);
>> +
>> +	spin_lock(&intc->lock);
>> +	memcpy_fromio(status, intc->base + STATUS, IRQ_MAX / BITS_PER_BYTE);
> 
> No. Please don't. Nothing guarantees that your bus can deal with those.
> We have readl_relaxed, which is what should be used.

Is that because readl_relaxed() handles endianness, while
memcpy_fromio() does not?

How do I fill a DECLARE_BITMAP using readl_relaxed() ?

> Also, you do know which inputs are level, right? So why do you need to
> read the whole register array all the time?

AFAIR, interrupts are scattered all over the map, so there's
at least one interrupt per word. I'll double-check.


>> +	bitmap_and(status, status, intc->enabled_level, IRQ_MAX);
>> +	spin_unlock(&intc->lock);
>> +
>> +	for_each_set_bit(pos, status, IRQ_MAX) {
>> +		virq = irq_find_mapping(intc->dom, pos);
>> +		generic_handle_irq(virq);
> 
> Please check for virq==0, just in case you get a spurious interrupt.

AFAICT, generic_handle_irq() would handle virq==0
gracefully(?)


>> +static void tango_edge_isr(struct irq_desc *desc)
>> +{
>> +	uint virq;
>> +	struct irq_data *data = irq_desc_get_irq_data(desc);
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	struct tango_intc *intc = irq_desc_get_handler_data(desc);
>> +	int tango_irq = intc->spi_to_tango_irq[data->hwirq - 32];
>> +
>> +	chained_irq_enter(chip, desc);
>> +	virq = irq_find_mapping(intc->dom, tango_irq);
>> +	generic_handle_irq(virq);
>> +	chained_irq_exit(chip, desc);
> 
> If you have a 1:1 mapping between an edge input and its output, why do
> you with a chained interrupt handler? This should be a hierarchical
> setup for these 23 interrupts.

I don't understand what you are suggesting.

I should not call chained_irq_enter/chained_irq_exit
in tango_edge_isr()?


>> +static int tango_set_type(struct irq_data *data, uint flow_type)
>> +{
>> +	return 0;
> 
> What does this mean? Either you can do a set-type (and you do it), or
> you cannot, and you fail. At least you check that what you're asked to
> do matches the configuration.

IIRC, __irq_set_trigger() barfed when I did it differently.

(FWIW, this HW block only routes interrupt signals, it doesn't
latch anything.)


>> +static int tango_alloc(struct irq_domain *dom, uint virq, uint n, void *arg)
>> +{
>> +	int spi;
>> +	struct irq_fwspec *fwspec = arg;
>> +	struct tango_intc *intc = dom->host_data;
>> +	u32 hwirq = fwspec->param[0], trigger = fwspec->param[1];
>> +
>> +	if (trigger & IRQ_TYPE_EDGE_FALLING || trigger & IRQ_TYPE_LEVEL_LOW)
>> +		return -EINVAL;
>> +
>> +	if (trigger & IRQ_TYPE_LEVEL_HIGH)
>> +		intc->tango_irq_to_spi[hwirq] = LEVEL_SPI;
>> +
>> +	if (trigger & IRQ_TYPE_EDGE_RISING) {
>> +		for (spi = 1; spi < SPI_MAX; ++spi) {
>> +			if (intc->spi_to_tango_irq[spi] == 0) {
>> +				intc->tango_irq_to_spi[hwirq] = spi;
>> +				intc->spi_to_tango_irq[spi] = hwirq;
>> +				break;
>> +			}
>> +		}
>> +		if (spi == SPI_MAX)
>> +			return -ENOSPC;
>> +	}
> 
> What's wrong with having a bitmap allocation, just like on other drivers?

I don't understand what you are suggesting.

The mapping is set up at run-time, I need to record it
somewhere.


>> +static int __init tango_irq_init(struct device_node *node, struct device_node *parent)
>> +{
>> +	int spi, virq;
>> +	struct tango_intc *intc;
>> +
>> +	intc = kzalloc(sizeof(*intc), GFP_KERNEL);
>> +	if (!intc)
>> +		panic("%s: Failed to kalloc\n", node->name);
>> +
>> +	virq = map_irq(parent, LEVEL_SPI, IRQ_TYPE_LEVEL_HIGH);
>> +	if (!virq)
>> +		panic("%s: Failed to map IRQ %d\n", node->name, LEVEL_SPI);
>> +
>> +	irq_set_chained_handler_and_data(virq, tango_level_isr, intc);
>> +
>> +	for (spi = 1; spi < SPI_MAX; ++spi) {
>> +		virq = map_irq(parent, spi, IRQ_TYPE_EDGE_RISING);
>> +		if (!virq)
>> +			panic("%s: Failed to map IRQ %d\n", node->name, spi);
>> +
>> +		irq_set_chained_handler_and_data(virq, tango_edge_isr, intc);
>> +	}
> 
> Calling panic? For a secondary interrupt controller? Don't. We call
> panic when we know for sure that the system is in such a state that
> we're better off killing it altogether than keeping it running (to avoid
> corruption, for example). panic is not a substitute for proper error
> handling.

I handled the setup like irq-tango.c did.

What is the point in bringing up a system where
interrupts do not work? Nothing will work.


>> +	tango_intc = intc;
>> +	register_syscore_ops(&tango_syscore_ops);
>> +
>> +	spin_lock_init(&intc->lock);
>> +	intc->base = of_iomap(node, 0);
>> +	intc->dom = irq_domain_add_linear(node, IRQ_MAX, &dom_ops, intc);
>> +	if (!intc->base || !intc->dom)
>> +		panic("%s: Failed to setup IRQ controller\n", node->name);
>> +
>> +	return 0;
>> +}
>> +IRQCHIP_DECLARE(tango_intc, "sigma,smp8759-intc", tango_irq_init);
> 
> Overall, this edge business feels wrong. If you want to mux a single
> output for all level interrupts, fine by me. But edge interrupts that
> have a 1:1 mapping with the underlying SPI must be represented as a
> hierarchy.

I don't understand what you mean by "feels wrong".

There are 128 inputs, and only 24 outputs.
Therefore, I must map some inputs to the same output.
Thomas explained that edge interrupts *cannot* be shared.
So edge interrupts must receive a dedicated output line.
Did I write anything wrong so far?

Therefore, I figured that I must
A) map every edge interrupt to a different output
B) map at least some level interrupts to the same output

Are you saying that I could do things differently?

Do you mean I should have defined two separate domains,
one for level interrupts, one for edge interrupts?

For level interrupts:
irq_domain_add_linear(node, IRQ_MAX, &dom_ops, intc);

For edge interrupts:
irq_domain_add_hierarchy(...)

Eventually, irq_domain_create_hierarchy() calls
irq_domain_create_linear() anyway.

So maybe you are suggesting a single hierarchical
domain. I will test tomorrow. What differences will
it make? Better performance?

Regards.
