From: majun258@huawei.com (majun (F))
Date: Wed, 8 Jul 2015 12:21:04 +0800
Subject: [PATCH v3 1/3] IRQ/Gic-V3: Add mbigen driver to support mbigen
 interrupt controller
In-Reply-To: <alpine.DEB.2.11.1507061248090.3916@nanos>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
 <1436166548-34920-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1507061248090.3916@nanos>
Message-ID: <559CA530.2090508@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas:

? 2015/7/6 20:33, Thomas Gleixner ??:
> On Mon, 6 Jul 2015, Ma Jun wrote:
> 

>> +/**
>> + * get_mbigen_node_type: get the mbigen node type
>> + * @nid: the mbigen node value
>> + * return 0: evnent id of interrupt connected to this node can be changed.
>> + * return 1: evnent id of interrupt connected to this node cant be changed.
>> + */
>> +static int get_mbigen_node_type(int nid)
>> +{
>> +	if (nid > MG_NR) {
>> +		pr_warn("MBIGEN: Device ID exceeds max number!\n");
>> +		return 1;
>> +	}
>> +	if ((nid == 0) || (nid == 5) || (nid > 7))
>> +		return 0;
>> +	else
>> +		return 1;
> 
> Oh no. We do not hardcode such properties into a driver. That wants to
> be in the device tree and set as a property in the node data structure.
> 
Ok,I will move this to device tree

>> +static int mbigen_write_msg(struct irq_data *d, struct msi_msg *msg)
>> +{
>> +	struct mbigen_chip *chip = d->domain->host_data;
>> +	void __iomem *addr;
>> +	u32 nid, val, offset;
>> +	int ret = 0;
>> +
>> +	nid = GET_NODE_NUM(d->hwirq);
>> +	ret = get_mbigen_node_type(nid);
>> +	if (ret)
>> +		return 0;
> 
> Care to explain what this does? It seems for some nodes you cannot
> write the msi message. So how is that supposed to work? How is that
> interrupt controlled (mask/unmask ...) ?
> 
This function is used to write irq event id into vector register.Depends on
hardware design, write operation is permitted in some mbigen node(nid=0,5,and >7),
For other mbigen node, this register is read only.

But only vector register has this problem. Other registers are ok for read/write.

>> +
>> +	ofst = hwirq / 32 * 4;
>> +	mask = 1 << (hwirq % 32);
>> +
>> +	addr = chip->base + MBIGEN_TYPE_REG_ADDR(nid, ofst);
>> +	raw_spin_lock(&chip->lock);
>> +	val = readl_relaxed(addr);
>> +
>> +	if (type == IRQ_TYPE_LEVEL_HIGH)
>> +		val |= mask;
>> +	else if (type == IRQ_TYPE_EDGE_RISING)
>> +		val &= ~mask;
>> +
>> +	writel_relaxed(val, addr);
>> +	raw_spin_unlock(&chip->lock);
> 
> What is the lock protecting here? The read/write access to a per
> interrupt register? Why is the per interrupt descriptor lock not
> sufficient and why does the above write_msg not requited locking?
> 
yes,lock protecting is not necessary here.

>> +	return 0;
[...]
>> +static int mbigen_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +			       unsigned int nr_irqs, void *arg)
>> +{
>> +	struct mbigen_chip *chip = domain->host_data;
>> +	struct of_phandle_args *irq_data = arg;
>> +	irq_hw_number_t hwirq;
>> +	u32 nid, dev_id, mbi_lines;
>> +	struct mbigen_node *mgn_node;
>> +	struct mbigen_device *mgn_dev;
>> +	msi_alloc_info_t out_arg;
>> +	int ret = 0, i;
>> +
>> +	/* OF style allocation, one interrupt at a time */
> 
> -ENOPARSE
> 
what's this mean? I didn't find this definition in kernel code

>> +	WARN_ON(nr_irqs != 1);
>> +
>> +	dev_id = irq_data->args[0];
>> +	nid = irq_data->args[3];
>> +	hwirq = COMPOSE_HWIRQ(nid, irq_data->args[2]);
>> +
>> +	mgn_node = get_mbigen_node(chip, nid);
>> +	if (!mgn_node)
>> +		return -ENODEV;
>> +
>> +	mgn_dev = mbigen_create_device(mgn_node, irq_data->np, virq, nr_irqs);
>> +	if (!mgn_dev)
>> +		return -ENOMEM;
> 
> Leaks the node allocation.
> 
>> +
>> +	mbi_lines = irq_data->args[1];
>> +
>> +	ret = its_msi_prepare(domain, dev_id, mbi_lines, &out_arg);
> 
> This looks wrong. Why do you have an explicit call for this in the
> allocation function?
> 
> msi_domain_ops.msi_prepare is called from the core code and you should
> provide a msi_prepare callback which does the necessary initialization
> and invokes the parent domains msi_prepare callback.
> 
According to Marc suggestion, I changed the ITS code so I can use its_msi_prepare
function in my code.
So,do you mean i should not call this function directly ?
How about make this code likes below in mbigen driver:

static struct msi_domain_ops mbigen_domain_ops = {

	.msi_prepare	= mbigen_domain_ops_prepare,
};

static int mbigen_domain_ops_prepare(struct irq_domain *domain, struct device *dev,
			       int nvec, msi_alloc_info_t *info)
{
	return its_msi_prepare(domain, dev_id, count, info);
}


>> +	if (ret)
>> +		return ret;
> 
> Leaks the node allocation and the device.
> 
>> +
>> +	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &out_arg);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	for (i = 0; i < nr_irqs; i++) {
> 
> This loop is required because?
> 
Although we know this value is 1, I think use loop seems better

>> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>> +						&mbigen_irq_chip, mgn_dev);
>> +	}
>> +
>> +	return ret;
> 
>> +/*
>> + * Early initialization as an interrupt controller
>> + */
>> +static int __init mbigen_of_init(struct device_node *node,
>> +				 struct device_node *parent_node)
>> +{
>> +	struct mbigen_chip *chip;
>> +	struct irq_domain *parent_domain;
>> +	int err;
>> +
>> +	parent_node = of_parse_phandle(node, "msi-parent", 0);
> 
> Huch. parent node is an argument here. So WHY do you need to override
> it with some magic parent entry in the mbigen node? Seems your
> devicetree design sucks.
Because parent_nod argument point to gic node, but the parent device node of
mbigen is its node.

I didn't find the way how to pass its node into this function as the parent_node,
would you please give me some hint?
Thanks
> 
>> diff --git a/include/linux/mbi.h b/include/linux/mbi.h
>> new file mode 100644
>> index 0000000..d3b8155
>> --- /dev/null
>> +++ b/include/linux/mbi.h
>> +
>> +/* Function to parse and map message interrupts */
>> +extern int its_msi_prepare(struct irq_domain *domain, u32 dev_id,
>> +		    int nvec, msi_alloc_info_t *info);
>> +extern struct irq_domain *get_its_domain(struct device_node *node);
> 
> Crap in various aspects
> 
>      - these functions should only be visible from drivers/irqchip/
> 
>      - the header name is wrong as it does not provide any MBI
>        specific functionality
> 
Maybe I can named this file as 'arm-gic-v3-its.h' and put it in
include/linux/irqchip/

Thanks
