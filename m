From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 30 Sep 2015 23:37:14 +0200 (CEST)
Subject: [PATCH v5 1/3] initialize each mbigen device node as a interrupt
 controller.
In-Reply-To: <1443605949-15396-2-git-send-email-majun258@huawei.com>
References: <1443605949-15396-1-git-send-email-majun258@huawei.com>
 <1443605949-15396-2-git-send-email-majun258@huawei.com>
Message-ID: <alpine.DEB.2.11.1509302242220.4500@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Sep 2015, MaJun wrote:

First of all.

[PATCH v5 1/3] initialize each mbigen device node as a interrupt controller

is not a proper subject line, but that's the least of your problems.

> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include "irqchip.h"

Do you really need all these includes?

> +
> +/* Interrupt numbers per mbigen node supported */
> +#define IRQS_PER_MBIGEN_NODE	(128)

Why do you need all these numbers in parentheses? Because you have all
these horrible MACROS?

> +/* Pin0-pin15 total 16 irqs are reserved for each mbigen chip*/
> +#define RESERVED_IRQ_PER_MBIGEN_CHIP (16)
> +
> +#define MBIGEN_INDEX_SHIFT	(12)
> +
> +/*
> + * To calculate the register addr of interrupt, the private index value
> + * also should be included except the hardware pin offset value.
> + *
> + * hwirq[23:12]: index. private index value of interrupt.
> +		Start from 0 for a device.
> + * hwirq[11:0]: pin. hardware pin offset of this interrupt
> + */
> +#define	COMPOSE_MBIGEN_HWIRQ(index, pin)	\
> +		(((index) << MBIGEN_INDEX_SHIFT) | (pin))

Please make that an inline function if@all.

> +
> +/* get the interrupt pin offset from mbigen hwirq */
> +#define	GET_IRQ_PIN_OFFSET(hwirq)	((hwirq) & 0xfff)

Ditto

> +/* get the private index value from mbigen hwirq */
> +#define GET_IRQ_INDEX(hwirq)	(((hwirq) >> MBIGEN_INDEX_SHIFT) & 0xfff)

Ditto

> +
> +/*
> + * In mbigen vector register
> + * bit[21:12]: event id value
> + * bit[11:0]: device id
> + */
> +#define IRQ_EVENT_ID_SHIFT	(12)
> +#define IRQ_EVENT_ID_MASK	(0x3ff)
> +
> +/* register range of mbigen node  */
> +#define MBIGEN_NODE_OFFSET	0x1000
> +
> +/* offset of vector register in mbigen node */
> +#define REG_MBIGEN_VEC_OFFSET	0x200
> +
> +/* offset of clear register in mbigen node.
> + * This register is used to clear the status
> + * of interrupt.
> + */
> +#define REG_MBIGEN_CLEAR_OFFSET	0xa00
> +
> +/*
> + * get the base address of mbigen node
> + * nid: mbigen node number
> + */
> +#define MBIGEN_NODE_ADDR_BASE(nid)	((nid) * MBIGEN_NODE_OFFSET)

That really does not help the readability of the code. Your MACRO is
longer than the actual term.

> +/*

For proper kerneldoc, this wants to be '/**'

> + * struct mbigen_device--Holds the  information of devices connected

I doubt, that '--' is a proper separator. ' - ' Definitely is.

> + * to mbigen chip

Please run that through the kerneldoc machinery.

> + * @domain: irq domain of this mbigen device.
> + * @global_entry: node in a global mbigen device list.
> + * @node: represents the mbigen device node defined in device tree.
> + * @mgn_data: pointer to mbigen_irq_data
> + * @nr_irqs: the total interrupt lines of this device
> + * @base: mapped address of mbigen chip which this mbigen device connected.

Can you please make this a proper table

+ * @domain:		irq domain of this mbigen device.
+ * @global_entry:	node in a global mbigen device list.

....

> +*/
> +struct mbigen_device {
> +	struct irq_domain	*domain;
> +	struct list_head	global_entry;
> +	struct device_node	*node;
> +	struct mbigen_irq_data	*mgn_data;
> +	unsigned int		nr_irqs;
> +	void __iomem		*base;
> +};
> +
> +/*
> + * struct irq_priv_info--structure of irq corresponding information.
> + *
> + * @global_pin_offset: global pin offset of this irq.
> + * @index: private index value of interrupt.(start from 0 for a device)
> + * @nid: id of mbigen node this irq connected.
> + * @local_pin_offset: local pin offset of interrupt within mbigen node.
> + * @reg_offset: Interrupt corresponding register addr offset.
> + */
> +struct irq_priv_info {
> +	unsigned int	global_pin_offset;
> +	unsigned int	index;
> +	unsigned int	nid;
> +	unsigned int	local_pin_offset;
> +	unsigned int	reg_offset;
> +};
> +
> +/*
> + * struct mbigen_irq_data -- private data of each irq
> + *
> + * @info: structure of irq private information.
> + * @dev: mbigen device this irq belong to.
> + * @dev_irq: virq number of this interrupt.
> + * @msi_irq: Corresponding msi irq number of this interrupt.
> + */
> +struct mbigen_irq_data {
> +	struct irq_priv_info	info;
> +	struct mbigen_device	*dev;
> +	unsigned int	dev_irq;
> +	unsigned int	msi_irq;
> +};
> +
> +/*
> + * global mbigen device list including all of the mbigen
> + * devices in this system
> + */
> +static LIST_HEAD(mbigen_device_list);
> +static DEFINE_SPINLOCK(mbigen_device_lock);
> +
> +static inline int get_mbigen_vec_reg_addr(u32 nid, u32 offset)
> +{
> +	return MBIGEN_NODE_ADDR_BASE(nid) + REG_MBIGEN_VEC_OFFSET
> +	    + (offset * 4);
> +}
> +
> +static struct mbigen_irq_data *get_mbigen_irq_data(struct mbigen_device *mgn_dev,
> +						   struct irq_data *d)
> +{
> +	struct irq_priv_info *info;
> +	u32 index;
> +
> +	index = GET_IRQ_INDEX(d->hwirq);
> +	if (index < 0)
> +		return NULL;

And how does index ever become < 0?

> +
> +	info = &mgn_dev->mgn_data[index].info;
> +	info->index = index;
> +	info->global_pin_offset = GET_IRQ_PIN_OFFSET(d->hwirq);
> +	info->nid = info->global_pin_offset / IRQS_PER_MBIGEN_NODE;
> +
> +	info->local_pin_offset = (info->global_pin_offset % IRQS_PER_MBIGEN_NODE)
> +						- RESERVED_IRQ_PER_MBIGEN_CHIP;
> +
> +	info->reg_offset = get_mbigen_vec_reg_addr(info->nid, info->local_pin_offset);

So you fill in a structure with 5 fields and the only information
which is ever used is local_pin_offset.

What's the point of this exercise? 

> +
> +	return &mgn_dev->mgn_data[index];
> +}
> +
> +static int mbigen_set_affinity(struct irq_data *data,
> +				const struct cpumask *mask_val,
> +				bool force)
> +{
> +	struct mbigen_irq_data *mgn_irq_data = irq_data_get_irq_chip_data(data);
> +	struct irq_chip *chip = irq_get_chip(mgn_irq_data->msi_irq);

And that msi_irq information comes from where? Nothing in that code
initializes it.

> +	struct irq_data *parent_d = irq_get_irq_data(mgn_irq_data->msi_irq);

Also WHY are you going through a full lookup of the chip and the irq
data, if that is your parent irq? That's what the domain hierarchy is
for. If you now tell me, that msi_irq is not the same as data->irq,
i.e. the virq number, then you have a lot more things to explain.

irq_chip_set_affinity_parent() is the callback you want for your chip,
not some completely nonsensical hackery.

> +
> +	if (chip && chip->irq_set_affinity)

Why would chip ever be NULL? If your parent interrupt does not have a
chip assigned then your whole setup is hosed.

> +static void mbigen_eoi_irq(struct irq_data *data)
> +{
> +
> +	struct mbigen_irq_data *mgn_irq_data = irq_data_get_irq_chip_data(data);
> +	struct mbigen_device *mgn_dev = mgn_irq_data->dev;

So the only reason for accessing yet another data structure is to get
the base address of that mbi device. You seem to have a strong
interest in making the cache foot print of your code as big as
possible. 

> +	struct irq_chip *chip = irq_get_chip(mgn_irq_data->msi_irq);
> +	struct irq_data *parent_d = irq_get_irq_data(mgn_irq_data->msi_irq);
> +	u32 pin_offset, ofst, mask;
> +
> +	pin_offset = mgn_irq_data->info.local_pin_offset;
> +
> +	ofst = pin_offset / 32 * 4;
> +	mask = 1 << (pin_offset % 32);
> +
> +	writel_relaxed(mask, mgn_dev->base + ofst
> +			+ REG_MBIGEN_CLEAR_OFFSET);
> +
> +	if (chip && chip->irq_eoi)
> +		chip->irq_eoi(parent_d);

So again. Why would chip be NULL and why would chip NOT have an EOI
callback?

> +static int mbigen_domain_xlate(struct irq_domain *d,
> +			       struct device_node *controller,
> +			       const u32 *intspec, unsigned int intsize,
> +			       unsigned long *out_hwirq,
> +			       unsigned int *out_type)
> +{
> +
> +	if (d->of_node != controller)
> +		return -EINVAL;
> +
> +	if (intsize < 2)
> +		return -EINVAL;
> +
> +	/* Compose the hwirq local to mbigen domain
> +	 * intspec[0]: interrut pin offset
> +	 * intspec[1]: index(start from 0)
> +	 */
> +	*out_hwirq = COMPOSE_MBIGEN_HWIRQ(intspec[1], intspec[0]);

So here you use that convoluted MACRO. Why can't you open code it so
we don't have to go up to the top of the file to see what you are
composing?

We use macros and inlines for things which are used over and over, but
not for code obfuscation.

> +static int mbigen_domain_map(struct irq_domain *d, unsigned int irq,
> +				irq_hw_number_t hw)
> +{
> +	struct mbigen_device *mgn_dev = d->host_data;
> +	struct mbigen_irq_data *mgn_irq_data;
> +	struct irq_data *data = irq_get_irq_data(irq);
> +
> +	mgn_irq_data = get_mbigen_irq_data(mgn_dev, data);
> +	if (!mgn_irq_data)
> +		return -EINVAL;

Ah. Here is that useless function actually called and of course the
return value which can never happen checked once more.

> +	mgn_irq_data->dev_irq = irq;

Oh, yet another place where you store the irq number. Darn, it's
already in irq_data. Your data representation is a complete mess.

All you ever need from this is local_pin_offset and the base address
for that calculation in the eoi callback.

> +	pin_offset = mgn_irq_data->info.local_pin_offset;
> +
> +	ofst = pin_offset / 32 * 4;
> +	mask = 1 << (pin_offset % 32);
> +
> +	writel_relaxed(mask, mgn_dev->base + ofst
> +			+ REG_MBIGEN_CLEAR_OFFSET);

Now if you think about it, then you might figure out, that you can
store that information in a way which does not require that math at
all and you can avoid having all these pointless data structures for
it. Hint: Each hierarchy level has it's own irq_data representation
and that is sufficient to store everything.

> +	irq_set_chip_data(irq, mgn_irq_data);
> +	irq_set_chip_and_handler(irq, &mbigen_irq_chip, handle_fasteoi_irq);
> +
> +	set_irq_flags(irq, IRQF_VALID);

And how does that compile against Linus kernel? Not at all.

> +
> +	/* add this mbigen device into a global list*/
> +	spin_lock(&mbigen_device_lock);
> +	list_add(&mgn_dev->global_entry, &mbigen_device_list);
> +	spin_unlock(&mbigen_device_lock);

And that global list is used whatfor? I can't see anything which makes
use of it.

That's a complete disaster and I'm not even thinking about looking at
the next patch in this series.

Can you please explain in a simple ASCII picture how your irq chip
hierarchy looks like and what kind of data you need for each hierarchy
level?

Thanks,

	tglx
