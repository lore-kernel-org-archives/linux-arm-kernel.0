From: tn@semihalf.com (Tomasz Nowicki)
Date: Fri, 12 Feb 2016 11:10:59 +0100
Subject: [PATCH V3 06/10] irqchip, GICv3, ITS: Refator ITS dt init code to
 prepare for ACPI.
In-Reply-To: <56BB1548.5050402@arm.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <1453209083-3358-7-git-send-email-tn@semihalf.com> <56BB1548.5050402@arm.com>
Message-ID: <56BDAFB3.6090807@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.02.2016 11:47, Marc Zyngier wrote:
> On 19/01/16 13:11, Tomasz Nowicki wrote:
>> Similarly to GICv3 core, we need to extract common code before adding
>> ACPI support. No functional changes.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c   | 82 +++++++++++++++++++++++---------------
>>   drivers/irqchip/irq-gic-v3.c       |  6 +--
>>   include/linux/irqchip/arm-gic-v3.h |  2 +-
>>   3 files changed, 52 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c

[..]

>> -static int __init its_probe(struct device_node *node,
>> -			    struct irq_domain *parent)
>> +static int __init its_probe_one(phys_addr_t phys_base, unsigned long size,
>> +				struct irq_domain *parent,
>> +				bool is_msi_controller,
>
> I really question the fact that you are keeping this msi_controller
> thing. Let's face it: if this is not an MSI controller, then the whole
> thing is absolutely pointless.
>
> So I'd rather you simplify the whole in a separate patch, and just don't
> bother initializing the ITS if it cannot be used for MSIs.
>
>> +				struct fwnode_handle *handler)
>>   {
>> -	struct resource res;
>>   	struct its_node *its;
>>   	void __iomem *its_base;
>>   	struct irq_domain *inner_domain;
>> @@ -1435,33 +1436,26 @@ static int __init its_probe(struct device_node *node,
>>   	u64 baser, tmp;
>>   	int err;
>>
>> -	err = of_address_to_resource(node, 0, &res);
>> -	if (err) {
>> -		pr_warn("%s: no regs?\n", node->full_name);
>> -		return -ENXIO;
>> -	}
>> -
>> -	its_base = ioremap(res.start, resource_size(&res));
>> +	its_base = ioremap(phys_base, size);
>>   	if (!its_base) {
>> -		pr_warn("%s: unable to map registers\n", node->full_name);
>> +		pr_warn("Unable to map ITS registers\n");
>
> There is some value in at least displaying the base address - think of
> people writing their DT or ACPI tables. Please do not blindly remove
> debugging information which is often useful on a system with multiple ITS.

Yes, base address is helpful with multi ITS.

>
>>   		return -ENOMEM;
>>   	}
>>
>>   	val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
>>   	if (val != 0x30 && val != 0x40) {
>> -		pr_warn("%s: no ITS detected, giving up\n", node->full_name);
>> +		pr_warn("No ITS detected, giving up\n");
>>   		err = -ENODEV;
>>   		goto out_unmap;
>>   	}
>>
>>   	err = its_force_quiescent(its_base);
>>   	if (err) {
>> -		pr_warn("%s: failed to quiesce, giving up\n",
>> -			node->full_name);
>> +		pr_warn("Failed to quiesce, giving up\n");
>>   		goto out_unmap;
>>   	}
>>
>> -	pr_info("ITS: %s\n", node->full_name);
>> +	pr_info("ITS at 0x%lx\n", (long)phys_base);
>>
>>   	its = kzalloc(sizeof(*its), GFP_KERNEL);
>>   	if (!its) {
>> @@ -1473,7 +1467,7 @@ static int __init its_probe(struct device_node *node,
>>   	INIT_LIST_HEAD(&its->entry);
>>   	INIT_LIST_HEAD(&its->its_device_list);
>>   	its->base = its_base;
>> -	its->phys_base = res.start;
>> +	its->phys_base = phys_base;
>>   	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
>>
>>   	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
>> @@ -1485,7 +1479,7 @@ static int __init its_probe(struct device_node *node,
>>
>>   	its_enable_quirks(its);
>>
>> -	err = its_alloc_tables(node->full_name, its);
>> +	err = its_alloc_tables(its);
>>   	if (err)
>>   		goto out_free_cmd;
>>
>> @@ -1521,7 +1515,7 @@ static int __init its_probe(struct device_node *node,
>>   	writeq_relaxed(0, its->base + GITS_CWRITER);
>>   	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
>>
>> -	if (of_property_read_bool(node, "msi-controller")) {
>> +	if (is_msi_controller) {
>>   		struct msi_domain_info *info;
>>
>>   		info = kzalloc(sizeof(*info), GFP_KERNEL);
>> @@ -1530,7 +1524,8 @@ static int __init its_probe(struct device_node *node,
>>   			goto out_free_tables;
>>   		}
>>
>> -		inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
>> +		inner_domain = irq_domain_create_tree(handler, &its_domain_ops,
>> +						      its);
>>   		if (!inner_domain) {
>>   			err = -ENOMEM;
>>   			kfree(info);
>> @@ -1558,10 +1553,28 @@ out_free_its:
>>   	kfree(its);
>>   out_unmap:
>>   	iounmap(its_base);
>> -	pr_err("ITS: failed probing %s (%d)\n", node->full_name, err);
>> +	pr_err("ITS at 0x%lx: failed probing (%d)\n", (long)phys_base, err);
>>   	return err;
>>   }
>>
>> +static int __init
>> +its_of_probe(struct device_node *node, struct irq_domain *parent)
>> +{
>> +	struct resource res;
>> +	bool is_msi_controller = false;
>> +
>> +	if (of_address_to_resource(node, 0, &res)) {
>> +		pr_warn("%s: no regs?\n", node->full_name);
>> +		return -ENXIO;
>> +	}
>> +
>> +	if (of_property_read_bool(node, "msi-controller"))
>> +		is_msi_controller = true;
>
> This is where you should return early, with a message saying that this
> ITS is being ignored if it doesn't have the msi-controller property.

Agree, will do.

Thanks,
Tomasz
