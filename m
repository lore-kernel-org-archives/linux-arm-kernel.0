From: julien.grall@arm.com (Julien Grall)
Date: Mon, 4 Apr 2016 10:14:38 +0100
Subject: [PATCH v4 6/9] irqchip/gic-v3: Parse and export virtual GIC
 information
In-Reply-To: <20160401101308.GB20224@cbox>
References: <1458842023-31853-1-git-send-email-julien.grall@arm.com>
 <1458842023-31853-7-git-send-email-julien.grall@arm.com>
 <20160401101308.GB20224@cbox>
Message-ID: <5702307E.2020304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 01/04/2016 11:13, Christoffer Dall wrote:
> On Thu, Mar 24, 2016 at 05:53:40PM +0000, Julien Grall wrote:
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 50e87e6..b5ed8be 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c

[...]

>> @@ -901,6 +904,39 @@ static int __init gic_validate_dist_version(void __iomem *dist_base)
>>   	return 0;
>>   }
>>
>> +static void __init gic_of_setup_kvm_info(struct device_node *node)
>> +{
>> +	int ret;
>> +	struct resource r;
>> +	u32 gicv_idx;
>> +
>> +	gic_v3_kvm_info.type = GIC_V3;
>> +
>> +	gic_v3_kvm_info.maint_irq = irq_of_parse_and_map(node, 0);
>> +	if (!gic_v3_kvm_info.maint_irq)
>> +		return;
>> +
>> +	if (of_property_read_u32(node, "#redistributor-regions",
>> +				 &gicv_idx))
>> +		gicv_idx = 1;
>> +
>> +	gicv_idx += 3;	/* Also skip GICD, GICC, GICH */
>> +	ret = of_address_to_resource(node, gicv_idx, &r);
>> +	if (!ret) {
>> +		if (!PAGE_ALIGNED(r.start))
>> +			pr_warn("GICV physical address 0x%llx not page aligned\n",
>> +				(unsigned long long)r.start);
>> +		else if (!PAGE_ALIGNED(resource_size(&r)))
>> +			pr_warn("GICV size 0x%llx not a multiple of page size 0x%lx\n",
>> +				(unsigned long long)resource_size(&r),
>> +				PAGE_SIZE);
>> +		else
>
> it seems like you're also checking the above items in the KVM code
> itself, so I still don't understand why we have to do this twice.
>
> My feeling here is that you want to just lookup if you have the proper
> resources to fill in the struct in the GIC driver, and fill in the
> struct with data if the firmware gave you something.
>
> It's then up to KVM to deal with its constraints, such as the resources
> being page-aligned etc.  But I suppose you could also argue that the GIC
> code knows how this hardware resource can or cannot be used and
> therefore should check it.
>
> But in any case, I don't understand why we check it more than one place?

Sorry, I forgot to remove these checks when I re-introduced them in the 
KVM code.

I will remove them in the next version.

Regards,

-- 
Julien Grall
