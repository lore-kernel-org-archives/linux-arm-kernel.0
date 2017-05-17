From: slash.tmp@free.fr (Mason)
Date: Wed, 17 May 2017 18:54:36 +0200
Subject: Asking for guidance in writing IRQ controller driver
In-Reply-To: <4cf2a2da-a229-8ff4-2d08-6cd2d78fce3f@free.fr>
References: <99c32a84-c064-06c8-799d-a5aa1794ba0d@free.fr>
 <4cf2a2da-a229-8ff4-2d08-6cd2d78fce3f@free.fr>
Message-ID: <d6cca2c6-67cd-39c2-9529-9ee7c9293b78@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/2017 13:43, Mason wrote:

> It seems clear that I'll need to define an irq_domain.
> 
> I have used irq_domain_create_linear() in the past.
> 
> But I also see other people use irq_domain_create_hierarchy()
> which calls irq_domain_create_linear() but also sets
> domain->parent
> 
> But now I'm left wondering how the code that doesn't set
> domain->parent works... How does the irq framework know
> how to "tie" this new domain into the mix... Probably by
> walking the DT? So setting the parent is not required then?

I have written some code to manage level interrupts.
(Copied below for illustration purposes)

I have some lingering doubts. I would appreciate it if someone
could shed some light.

1) Is it correct to call irq_domain_set_info() in the .map callback?

2) Passing handle_level_irq to irq_domain_set_info() means this
domain can only handle level interrupts, right?

3) If I need to handle also edge interrupts, would I need a separate
domain?

4) How does the core decide which domain to pass to the .map callback?
Is that the role of the .select callback?

5) If I need to route edge and level interrupts, do I need to use
2 separate output lines to the GIC? Or maybe even 4 output lines
(edge rising/falling, level high/low) ?

6) What is the symmetric irq_domain_set_info() to call in .unmap ?





#include <linux/of_irq.h>
#include <linux/of_address.h>
#include <linux/irqchip.h>
#include <linux/irqchip/chained_irq.h>

#define IRQ_MAX 128

struct tango_intc {
	DECLARE_BITMAP(enabled, IRQ_MAX);
	spinlock_t lock;
	void __iomem *base;
	void __iomem *status;
	struct irq_domain *dom;
};

static void tango_isr(struct irq_desc *desc)
{
	unsigned int pos, virq;
	struct irq_chip *chip = irq_desc_get_chip(desc);
	struct tango_intc *intc = irq_desc_get_handler_data(desc);
	DECLARE_BITMAP(status, IRQ_MAX);

	chained_irq_enter(chip, desc);

	memcpy_fromio(status, intc->status, IRQ_MAX / BITS_PER_BYTE);
	bitmap_and(status, status, intc->enabled, IRQ_MAX);
	for_each_set_bit(pos, status, IRQ_MAX) {
		virq = irq_find_mapping(intc->dom, pos);
		generic_handle_irq(virq);
	}

	chained_irq_exit(chip, desc);
}

static void tango_mask(struct irq_data *data)
{
	unsigned long flags;
	struct tango_intc *intc = data->chip_data;

	spin_lock_irqsave(&intc->lock, flags);
	__clear_bit(data->hwirq, intc->enabled);
	writel_relaxed(0, intc->base + data->hwirq * 4);
	spin_unlock_irqrestore(&intc->lock, flags);
}

static void tango_unmask(struct irq_data *data)
{
	unsigned long flags;
	struct tango_intc *intc = data->chip_data;

	spin_lock_irqsave(&intc->lock, flags);
	__set_bit(data->hwirq, intc->enabled);
	writel_relaxed(BIT(31), intc->base + data->hwirq * 4);
	spin_unlock_irqrestore(&intc->lock, flags);
}

static struct irq_chip tango_chip = {
	.name		= "tango",
	.irq_mask	= tango_mask,
	.irq_unmask	= tango_unmask,
	//.irq_set_type
};

static int tango_map(struct irq_domain *dom, unsigned int virq, irq_hw_number_t hw)
{
	struct tango_intc *intc = dom->host_data;
	printk("%s: dom=%p virq=%u hwirq=%lu\n", __func__, dom, virq, hw);
	//dump_stack();
	/*** GROS DOUTE ICI ***/
	irq_domain_set_info(dom, virq, hw, &tango_chip, intc,
			handle_level_irq, NULL, NULL);

	return 0;
}

static void tango_unmap(struct irq_domain *d, unsigned int virq)
{
	printk("%s: dom=%p virq=%u\n", __func__, d, virq);
	dump_stack();
}

struct irq_domain_ops dom_ops =
{
	.map = tango_map,
	.unmap = tango_unmap,
};

static int __init tango_irq_init(struct device_node *node, struct device_node *parent)
{
	int i;
	int virq;
	struct irq_domain *irq_dom;
	void __iomem *base;
	struct tango_intc *intc = kzalloc(sizeof(*intc), GFP_KERNEL);

	base = of_iomap(node, 0);
	if (!base)
		panic("%s: of_iomap failed", node->name);

	virq = irq_of_parse_and_map(node, 0);
	if (!virq)
		panic("%s: Failed to map IRQ\n", node->name);

	irq_dom = irq_domain_add_linear(node, IRQ_MAX, &dom_ops, intc);

	irq_set_chained_handler_and_data(virq, tango_isr, intc);

	spin_lock_init(&intc->lock);
	intc->base = base;
	intc->status = base + 0x420;
	intc->dom = irq_dom;

	return 0;
}
IRQCHIP_DECLARE(tango_intc, "sigma,rev2-intc", tango_irq_init);
