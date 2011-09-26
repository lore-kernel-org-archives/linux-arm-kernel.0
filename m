From: robherring2@gmail.com (Rob Herring)
Date: Mon, 26 Sep 2011 15:49:11 -0500
Subject: [PATCH 3/3] ARM: gic: add OF based initialization
In-Reply-To: <20110926195704.GD9194@gallagher>
References: <1316550244-3655-1-git-send-email-robherring2@gmail.com>
	<1316550244-3655-4-git-send-email-robherring2@gmail.com>
	<20110926195704.GD9194@gallagher>
Message-ID: <4E80E547.2080004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2011 02:57 PM, Jamie Iles wrote:
> Hi Rob,
> 
> On Tue, Sep 20, 2011 at 03:24:04PM -0500, Rob Herring wrote:
> [...]
>> +int __init gic_of_init(struct device_node *node, struct device_node *parent)
>> +{
>> +	void __iomem *cpu_base;
>> +	void __iomem *dist_base;
>> +	int irq;
>> +	struct irq_domain *domain = &gic_data[gic_cnt].domain;
>> +
>> +	if (WARN_ON(!node))
>> +		return -ENODEV;
>> +
>> +	dist_base = of_iomap(node, 0);
>> +	WARN(!dist_base, "unable to map gic dist registers\n");
>> +
>> +	cpu_base = of_iomap(node, 1);
>> +	WARN(!cpu_base, "unable to map gic cpu registers\n");
>> +
>> +	domain->nr_irq = gic_irq_count(dist_base);
>> +	/* subtract off SGIs. Also subtract off PPIs for secondary GICs */
>> +	if (parent)
>> +		domain->nr_irq -= 32;
>> +	else
>> +		domain->nr_irq -= 16;
>> +
>> +	domain->irq_base = irq_alloc_descs(-1, 16, domain->nr_irq, numa_node_id());
> 
> The way I understand irq_alloc_descs() (probably not very well) is that 
> having the irq parameter < 0 and the from parameter 16 means that it 
> needs to find domain->nr_irq descs starting from at least 16.  But if 
> the base is greater than 16, does this still work with the gic entry 
> macros as they are?

No, but that would only happen if a platform calls irq_alloc_descs prior
to this code. The root controller must be initialized first (for other
reasons as well). There are no calls to irq_alloc_descs in arch/arm.

With the MULTI_IRQ GIC support Marc Z is working on, we could make the
GIC irq mapping be completely dynamic. Although, there's probably not
much reason to do so for the root controller.

Rob
