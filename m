From: slash.tmp@free.fr (Mason)
Date: Wed, 24 May 2017 11:44:18 +0200
Subject: Asking for guidance in writing IRQ controller driver
In-Reply-To: <d6cca2c6-67cd-39c2-9529-9ee7c9293b78@free.fr>
References: <99c32a84-c064-06c8-799d-a5aa1794ba0d@free.fr>
 <4cf2a2da-a229-8ff4-2d08-6cd2d78fce3f@free.fr>
 <d6cca2c6-67cd-39c2-9529-9ee7c9293b78@free.fr>
Message-ID: <6c78d7eb-24e3-4765-a96c-6a72d6fc992f@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Past ramblings archived at

	https://www.spinics.net/lists/arm-kernel/msg581128.html

Hello IRQ maintainers,

I'd like to ask for your help writing an interrupt controller
driver. So far, level interrupts work, but edge interrupts
apparently don't.

I'll recap the situation with a diagram.

This interrupt controller is really just a big mux:
128 lines in, 24 lines out.
The controller doesn't latch anything, it just routes IRQ
signals from one input line to one (programmable) output line.
The input lines come from devices.
The output lines are connected to GIC SPIs 0-23 (GIC v1 Cortex A9 MP)


----------------------------------------
|                devices               |
----------------------------------------
	|  ...  |  ...  |  ...  |	(x128)
	v	v	v	v
----------------------------------------
|       \       |       /              |
|        \      |      /               | IRQ router
|         \     |     /                |
----------------------------------------
	   |   ...   |			(x24)
	   v         v
----------------------------------------
|               GIC v1                 |
----------------------------------------


A high-level description of my current implementation:

- Define a linear irq domain for 128 interrupts.
- in the .map callback, program input i to
    - output 0 for level high interrupts
    - output 1 for edge rising interrupts


Obviously, I'm missing something, since the driver doesn't quite
work as expected: edge IRQs are not detected.

I have a few random ideas to try, but if someone spots something
wrong, I would be very grateful for a pointer.

I'll paste my WIP code below, for the gory details.

Regards.



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
	writel_relaxed(data->mask, intc->base + data->hwirq * 4);
	spin_unlock_irqrestore(&intc->lock, flags);
}

static void tango_unmask(struct irq_data *data)
{
	unsigned long flags;
	struct tango_intc *intc = data->chip_data;

#if 0
	if (!in_irq() && !in_interrupt()) {
		printk("HWIRQ=%lu mask=%u\n", data->hwirq, data->mask);
		dump_stack();
	}
#endif

	spin_lock_irqsave(&intc->lock, flags);
	__set_bit(data->hwirq, intc->enabled);
	writel_relaxed(BIT(31) | data->mask, intc->base + data->hwirq * 4);
	spin_unlock_irqrestore(&intc->lock, flags);
}

int tango_set_type(struct irq_data *data, unsigned int flow_type)
{
	printk("%s: IRQ=%lu type=%x\n", __func__, data->hwirq, flow_type);
	if (flow_type & IRQ_TYPE_LEVEL_HIGH) {
		data->mask = 0x0;
		return 0;
	}

	if (flow_type & IRQ_TYPE_EDGE_RISING) {
		data->mask = 0x1;
		return 0;
	}

	dump_stack();
	return -ENOSYS;
}


static struct irq_chip tango_chip = {
	.name		= "tango",
	.irq_mask	= tango_mask,
	.irq_unmask	= tango_unmask,
	.irq_set_type	= tango_set_type,
};

static void my_flow_handler(struct irq_desc *desc)
{
	struct irq_data *data = irq_desc_get_irq_data(desc);
	if (data->mask == 0)
		handle_level_irq(desc);
	else if (data->mask == 0)
		handle_edge_irq(desc);
}

static int tango_map(struct irq_domain *dom, unsigned int virq, irq_hw_number_t hw)
{
	struct tango_intc *intc = dom->host_data;
	printk("%s: dom=%p virq=%u hwirq=%lu\n", __func__, dom, virq, hw);
	irq_domain_set_info(dom, virq, hw, &tango_chip, intc, my_flow_handler, NULL, NULL);

	return 0;
}

static void tango_unmap(struct irq_domain *d, unsigned int virq)
{
	printk("%s: dom=%p virq=%u\n", __func__, d, virq);
	dump_stack();
}

struct irq_domain_ops dom_ops =
{
	.map	= tango_map,
	.unmap	= tango_unmap,
	.xlate	= irq_domain_xlate_twocell,
};

static int __init tango_irq_init(struct device_node *node, struct device_node *parent)
{
	int i;
	int virq0, virq1;
	struct irq_domain *irq_dom;
	void __iomem *base;
	struct tango_intc *intc = kzalloc(sizeof(*intc), GFP_KERNEL);

	base = of_iomap(node, 0);
	if (!base)
		panic("%s: of_iomap failed", node->name);

	virq0 = irq_of_parse_and_map(node, 0);
	if (!virq0)
		panic("%s: Failed to map IRQ 0\n", node->name);

	virq1 = irq_of_parse_and_map(node, 1);
	if (!virq1)
		panic("%s: Failed to map IRQ 1\n", node->name);

	irq_dom = irq_domain_add_linear(node, IRQ_MAX, &dom_ops, intc);

	irq_set_chained_handler_and_data(virq0, tango_isr, intc);
	irq_set_chained_handler_and_data(virq1, tango_isr, intc);

	for (i = 125; i < 128; ++i)
		writel(0, base + i*4);

#if 0
	for (i = 0; i < 0x430; i += 4)
	{
		u32 val = readl(base + i);
		if (val) printk("[%p] = %08x\n", base + i, val);
		writel(0, base + i);
		val = readl(base + i);
		if (val) printk("[%p] = %08x\n", base + i, val);
	}
#endif

	spin_lock_init(&intc->lock);
	intc->base = base;
	intc->status = base + 0x420;
	intc->dom = irq_dom;

	return 0;
}
IRQCHIP_DECLARE(tango_intc, "sigma,rev2-intc", tango_irq_init);
