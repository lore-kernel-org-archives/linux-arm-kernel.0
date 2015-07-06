From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 6 Jul 2015 14:33:42 +0200 (CEST)
Subject: [PATCH v3 1/3] IRQ/Gic-V3: Add mbigen driver to support mbigen
 interrupt controller
In-Reply-To: <1436166548-34920-2-git-send-email-majun258@huawei.com>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
 <1436166548-34920-2-git-send-email-majun258@huawei.com>
Message-ID: <alpine.DEB.2.11.1507061248090.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jul 2015, Ma Jun wrote:

> This patch contains the mbigen interrupt controller driver.
> 
> To support Mbigen device, irq-mbigen.c and mbi.h are added.
> 
> As a kind of MSI interrupt controller, the mbigen is used as a child 
> domain of ITS domain just like PCI devices.
> 
> In this patch:
> [1]: Create the Mbigen domain as a child domain of ITS according to the
>      Mbigen device node definition in dts file
> [2]: Parse the interrupts of devices(connected to mbigen chip) node which defined in dts file 
> [3]: other operations of interrupts: mask,unmask,activate..

This is not a proper changelog. We can see which files are added and
modified.

What's missing is a proper description of MBI and how it's connected
to ITS.

Also the patches are in the wrong order. This one uses a function
which does not exist yet plus non existant device tree entries ....

> +config MBIGEN_IRQ_DOMAIN

The config symbol should reflect the functionality

    HISILICON_IRQ_MBIGEN

would be a more descriptive on, right?

> +	bool "Support mbigen interrupt controller"
> +	default y

Why would this be default Y? Nothing needs that stuff except hisilicon
platforms.

> +	depends on ARM_GIC_V3 && ARM_GIC_V3_ITS
> +	help
> +	 Enable the mbigen interrupt controller used on
> +	 Hisillicon platform.

Looks like a typo. Should that be Hisillycon perhaps?

> +/* Irq numbers per mbigen node supported */
> +#define IRQS_PER_MBIGEN_NODE	128
> +/* Max mbigen node number in one chip */
> +#define MG_NR			(10)

That define sucks. You have IRQS_PER_MBIGEN_NODE above so why not
using a descriptive one for this as well?

MBIGEN_NODES_PER_CHIP or something like that?

Also please use a proper name space. XXX_MBIGEN_ / MBIGEN_XXX / MB_XX
... looks just like created by a random generator.

> +/* Max interrupts  Mbigen chip supported */
> +#define MG_NR_IRQS		IRQS_PER_MBIGEN_NODE * (MG_NR + 1)

Why is this NODES per SOC plus 1? That's either wrong or the whole
logic of this define chain is wrong.

> +#define	DEV_SHIFT		(10)
> +#define	COMPOSE_HWIRQ(x, y)	(((x) << DEV_SHIFT) | (y))
> +#define	HWIRQ_OFFSET(x)		((x) & 0x3ff)

Magic hex constants pulled from thin air?

> +#define GET_NODE_NUM(x)		(((x) >> DEV_SHIFT) & 0xff)

Can you please use consistant spacing (tabs) for everything?

> +
> +#define IRQ_EVENT_ID_SHIFT	(12)
> +
> +#define IRQ_EVENT_ID_MASK	(0x3ff << IRQ_EVENT_ID_SHIFT)

More magic constants without explanation.

> +/* mbigen node register range */
> +#define MBIGEN_NODE_OFFSET	0x1000
> +/* vector register offset in mbigen node */
> +#define REG_MBIGEN_VEC_OFFSET	0x200
> +/* interrupt type register offset */
> +#define REG_MBIGEN_TYPE_OFFSET	0x0
> +
> +/* get the vector register addr in mbigne node

mbigne? Is that another variant?

> + * x: mbigen node number
> + * y: the irq pin offset
> + */
> +#define MBIGEN_NODE_ADDR_BASE(x)	((x) * MBIGEN_NODE_OFFSET)
> +
> +#define MBIGEN_VEC_REG_ADDR(x, y)	\
> +	(MBIGEN_NODE_ADDR_BASE(x) + REG_MBIGEN_VEC_OFFSET + ((y) * 4))
> +
> +#define MBIGEN_TYPE_REG_ADDR(x, y)	\
> +	(MBIGEN_NODE_ADDR_BASE(x) + REG_MBIGEN_TYPE_OFFSET + y)

These macros can be implemented cleanly as readable inline functions.

> +/**
> + * strutct mbigen_chip - mbigen chip structure descriptor

Broken kerneldoc comment. Also missing the struct member documentation

> + * usually one subsys(ex.DSA,ALG,PCIE)has one mbigen chip

Please use proper sentences.

> + */
> +struct mbigen_chip {
> +	raw_spinlock_t		lock;
> +	struct list_head	entry;
> +	struct device		*dev;
> +	struct device_node	*node;
> +	void __iomem		*base;
> +	struct irq_domain	*domain;
> +	struct list_head	nodes;
> +};
> +
> +/*
> + * mbigen_node: structure of mbigen node in a mbigen chip
> + * usually, a mbigen chip includes 8 ~ 11 mbigen nodes.
> + * The node number depends on the device number connected
> + * to this mbigen chip.
> + * @nid: the mbigen nod number

More broken comment.

> + */
> +struct mbigen_node {
> +	raw_spinlock_t		lock;
> +	struct list_head	entry;
> +	struct mbigen_chip	*chip;
> +	unsigned int		nid;
> +	struct list_head	nodes;
> +};
> +
> +/* refer to the devices connected to mbigen node */

Completely useless explanation of the data structure

> +struct mbigen_device {
> +	struct list_head	entry;
> +	struct mbigen_node	*mgn_node;
> +	struct device_node	*source;
> +	unsigned int		irq;
> +	unsigned int		nr_irqs;
> +	unsigned int		offset;
> +};
> +
> +/**
> + * struct mbi_desc - Message Based Interrupt (MBI) descriptor
> + *
> + * @dev:	the device owned the MBI
> + * @msg_id:	identifier of the message group
> + * @lines:	max number of interrupts supported by the message register
> + * @irq:	base linux interrupt number of the MBI
> + * @nvec:	number of interrupts controlled by the MBI
> + * @data:	message specific data
> + */
> +struct mbi_desc {
> +	struct device	*dev;
> +	int		msg_id;
> +	unsigned int	lines;

Please align the struct members proper.

> +	unsigned int		irq;
> +	unsigned int		nvec;
> +	void			*data;

Why is this a void pointer if that is message specific data?

> +};
> +
> +static LIST_HEAD(mbigen_chip_list);
> +static DEFINE_SPINLOCK(mbigen_lock);

What is the lock protecting and why does it need to be a spinlock? The
code completely lacks an explanation of the locking rules and the lock
nesting rules.

> +
> +static void mbigen_free_dev(struct mbigen_device *mgn_dev)
> +{
> +	raw_spin_lock(&mgn_dev->mgn_node->lock);
> +	list_del(&mgn_dev->entry);
> +	raw_spin_unlock(&mgn_dev->mgn_node->lock);
> +	kfree(mgn_dev);
> +}
> +
> +static struct mbigen_device *mbigen_create_device(struct mbigen_node *mgn_node,
> +					      struct device_node *node,
> +						  unsigned int virq,
> +					      unsigned int nr_irqs)

Your source formating is based on /dev/random, right?

> +{
> +	struct mbigen_device *mgn_dev;
> +
> +	mgn_dev = kzalloc(sizeof(*mgn_dev), GFP_KERNEL);
> +	if (!mgn_dev)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&mgn_dev->entry);
> +	mgn_dev->mgn_node = mgn_node;
> +	mgn_dev->source = node;
> +	mgn_dev->irq = virq;
> +	mgn_dev->nr_irqs = nr_irqs;
> +
> +	raw_spin_lock(&mgn_node->lock);
> +	list_add(&mgn_dev->entry, &mgn_node->nodes);
> +	raw_spin_unlock(&mgn_node->lock);
> +	return mgn_dev;
> +}
> +
> +static struct mbigen_node *get_mbigen_node(struct mbigen_chip *chip,
> +					unsigned int nid)
> +{
> +	struct mbigen_node *tmp, *mbigen;
> +	bool found = false;
> +
> +	if (nid > MG_NR) {
> +		pr_warn("MBIGEN: Device ID exceeds max number!!\n");
> +		return NULL;
> +	}
> +
> +	list_for_each_entry(mbigen, &chip->nodes, entry) {
> +		if (mbigen->nid == nid) {
> +			found = true;
> +			return mbigen;
> +		}
> +	}

That list walk does not need locking?

> +	/*
> +	 * Stop working if no memory available, even if we could
> +	 * get what we want.
> +	 */
> +	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);

tmp is a pretty useless variable name. Why cant you use mbigen for
that? Just because it makes the code harder to read, right?

> +	if (!tmp)
> +		return NULL;
> +
> +	raw_spin_lock(&chip->lock);

Your lock scopes are completely random. Why do you need to protect the
initialization of tmp?

> +	tmp->chip = chip;
> +	tmp->nid = nid;
> +	raw_spin_lock_init(&tmp->lock);
> +	INIT_LIST_HEAD(&tmp->entry);
> +	INIT_LIST_HEAD(&tmp->nodes);
> +
> +	list_add(&tmp->entry, &chip->nodes);
> +	mbigen = tmp;
> +	raw_spin_unlock(&chip->lock);
> +
> +	return mbigen;
> +}
> +
> +/**
> + * get_mbigen_node_type: get the mbigen node type
> + * @nid: the mbigen node value
> + * return 0: evnent id of interrupt connected to this node can be changed.
> + * return 1: evnent id of interrupt connected to this node cant be changed.
> + */
> +static int get_mbigen_node_type(int nid)
> +{
> +	if (nid > MG_NR) {
> +		pr_warn("MBIGEN: Device ID exceeds max number!\n");
> +		return 1;
> +	}
> +	if ((nid == 0) || (nid == 5) || (nid > 7))
> +		return 0;
> +	else
> +		return 1;

Oh no. We do not hardcode such properties into a driver. That wants to
be in the device tree and set as a property in the node data structure.

> +static int mbigen_write_msg(struct irq_data *d, struct msi_msg *msg)
> +{
> +	struct mbigen_chip *chip = d->domain->host_data;
> +	void __iomem *addr;
> +	u32 nid, val, offset;
> +	int ret = 0;
> +
> +	nid = GET_NODE_NUM(d->hwirq);
> +	ret = get_mbigen_node_type(nid);
> +	if (ret)
> +		return 0;

Care to explain what this does? It seems for some nodes you cannot
write the msi message. So how is that supposed to work? How is that
interrupt controlled (mask/unmask ...) ?

> +	offset = HWIRQ_OFFSET(d->hwirq);
> +
> +	addr = chip->base + MBIGEN_VEC_REG_ADDR(nid, offset);
> +
> +	val = readl_relaxed(addr);
> +
> +	val &= ~IRQ_EVENT_ID_MASK;
> +	val |= (msg->data << IRQ_EVENT_ID_SHIFT);
> +
> +	writel_relaxed(val, addr);
> +	return ret;
> +}
> +
> +/*
> + * Interrupt controller operations
> + */
> +static int mbigen_set_type(struct irq_data *d, unsigned int type)
> +{
> +	struct mbigen_chip *chip = d->domain->host_data;
> +	u32 ofst, mask;
> +	u32 val, nid, hwirq;
> +	void __iomem *addr;
> +
> +	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
> +		return -EINVAL;
> +
> +	nid = GET_NODE_NUM(d->hwirq);
> +	hwirq = HWIRQ_OFFSET(d->hwirq);
> +
> +	ofst = hwirq / 32 * 4;
> +	mask = 1 << (hwirq % 32);
> +
> +	addr = chip->base + MBIGEN_TYPE_REG_ADDR(nid, ofst);
> +	raw_spin_lock(&chip->lock);
> +	val = readl_relaxed(addr);
> +
> +	if (type == IRQ_TYPE_LEVEL_HIGH)
> +		val |= mask;
> +	else if (type == IRQ_TYPE_EDGE_RISING)
> +		val &= ~mask;
> +
> +	writel_relaxed(val, addr);
> +	raw_spin_unlock(&chip->lock);

What is the lock protecting here? The read/write access to a per
interrupt register? Why is the per interrupt descriptor lock not
sufficient and why does the above write_msg not requited locking?

> +	return 0;
> +}
> +
> +static void mbigen_mask_irq(struct irq_data *data)
> +{
> +	irq_chip_mask_parent(data);
> +}
> +
> +static void mbigen_unmask_irq(struct irq_data *data)
> +{
> +	irq_chip_unmask_parent(data);
> +}
> +
> +static int mbigen_set_affinity(struct irq_data *data,
> +			       const struct cpumask *mask,
> +			       bool force)
> +{
> +	int ret;
> +
> +	ret = irq_chip_set_affinity_parent(data, mask, force);
> +	return ret;
> +}
> +
> +static void mbigen_irq_eoi(struct irq_data *d)
> +{
> +	irq_chip_eoi_parent(d);
> +}


What's the purpose of these wrappers? Why is setting the chip
functions to irq_chip_*_parent not sufficient?

> +static struct irq_chip mbigen_irq_chip = {
> +	.name			= "MBIGEN-v2",
> +	.irq_mask		= mbigen_mask_irq,
> +	.irq_unmask		= mbigen_unmask_irq,
> +	.irq_eoi		= mbigen_irq_eoi,
> +	.irq_set_affinity	= mbigen_set_affinity,
> +	.irq_set_type		= mbigen_set_type,
> +};

> +static int mbigen_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +			       unsigned int nr_irqs, void *arg)
> +{
> +	struct mbigen_chip *chip = domain->host_data;
> +	struct of_phandle_args *irq_data = arg;
> +	irq_hw_number_t hwirq;
> +	u32 nid, dev_id, mbi_lines;
> +	struct mbigen_node *mgn_node;
> +	struct mbigen_device *mgn_dev;
> +	msi_alloc_info_t out_arg;
> +	int ret = 0, i;
> +
> +	/* OF style allocation, one interrupt at a time */

-ENOPARSE

> +	WARN_ON(nr_irqs != 1);
> +
> +	dev_id = irq_data->args[0];
> +	nid = irq_data->args[3];
> +	hwirq = COMPOSE_HWIRQ(nid, irq_data->args[2]);
> +
> +	mgn_node = get_mbigen_node(chip, nid);
> +	if (!mgn_node)
> +		return -ENODEV;
> +
> +	mgn_dev = mbigen_create_device(mgn_node, irq_data->np, virq, nr_irqs);
> +	if (!mgn_dev)
> +		return -ENOMEM;

Leaks the node allocation.

> +
> +	mbi_lines = irq_data->args[1];
> +
> +	ret = its_msi_prepare(domain, dev_id, mbi_lines, &out_arg);

This looks wrong. Why do you have an explicit call for this in the
allocation function?

msi_domain_ops.msi_prepare is called from the core code and you should
provide a msi_prepare callback which does the necessary initialization
and invokes the parent domains msi_prepare callback.

> +	if (ret)
> +		return ret;

Leaks the node allocation and the device.

> +
> +	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &out_arg);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < nr_irqs; i++) {

This loop is required because?

> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +						&mbigen_irq_chip, mgn_dev);
> +	}
> +
> +	return ret;

> +/*
> + * Early initialization as an interrupt controller
> + */
> +static int __init mbigen_of_init(struct device_node *node,
> +				 struct device_node *parent_node)
> +{
> +	struct mbigen_chip *chip;
> +	struct irq_domain *parent_domain;
> +	int err;
> +
> +	parent_node = of_parse_phandle(node, "msi-parent", 0);

Huch. parent node is an argument here. So WHY do you need to override
it with some magic parent entry in the mbigen node? Seems your
devicetree design sucks.

> diff --git a/include/linux/mbi.h b/include/linux/mbi.h
> new file mode 100644
> index 0000000..d3b8155
> --- /dev/null
> +++ b/include/linux/mbi.h
> +
> +/* Function to parse and map message interrupts */
> +extern int its_msi_prepare(struct irq_domain *domain, u32 dev_id,
> +		    int nvec, msi_alloc_info_t *info);
> +extern struct irq_domain *get_its_domain(struct device_node *node);

Crap in various aspects

     - these functions should only be visible from drivers/irqchip/

     - the header name is wrong as it does not provide any MBI
       specific functionality

Thanks,

	tglx
