From: roy.pledge@nxp.com (Roy Pledge)
Date: Thu, 14 Sep 2017 19:07:50 +0000
Subject: [v4 07/11] soc/fsl/qbman: Rework portal mapping calls for ARM/PPC
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
 <1503607075-28970-8-git-send-email-roy.pledge@nxp.com>
 <20170914140014.taz7qwphfqm66kw7@localhost>
Message-ID: <DB6PR04MB29990A7A076761DDACCC1904866F0@DB6PR04MB2999.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/14/2017 10:00 AM, Catalin Marinas wrote:
> On Thu, Aug 24, 2017 at 04:37:51PM -0400, Roy Pledge wrote:
>> diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
>> index ff8998f..e31c843 100644
>> --- a/drivers/soc/fsl/qbman/bman.c
>> +++ b/drivers/soc/fsl/qbman/bman.c
>> @@ -154,7 +154,7 @@ struct bm_mc {
>>   };
>>   
>>   struct bm_addr {
>> -	void __iomem *ce;	/* cache-enabled */
>> +	void *ce;		/* cache-enabled */
>>   	void __iomem *ci;	/* cache-inhibited */
>>   };
> 
> You dropped __iomem from ce, which is fine since it is now set via
> memremap. However, I haven't seen (at least not in this patch), a change
> to bm_ce_in() which still uses __raw_readl().
> 
> (it may be worth checking this code with sparse, it may warn about this)
Thanks, you're correct I missed this. I will fix this (and the qman 
version) and run sparse.
> 
>> diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
>> index 39b39c8..bb03503 100644
>> --- a/drivers/soc/fsl/qbman/bman_portal.c
>> +++ b/drivers/soc/fsl/qbman/bman_portal.c
>> @@ -91,7 +91,6 @@ static int bman_portal_probe(struct platform_device *pdev)
>>   	struct device_node *node = dev->of_node;
>>   	struct bm_portal_config *pcfg;
>>   	struct resource *addr_phys[2];
>> -	void __iomem *va;
>>   	int irq, cpu;
>>   
>>   	pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
>> @@ -123,23 +122,34 @@ static int bman_portal_probe(struct platform_device *pdev)
>>   	}
>>   	pcfg->irq = irq;
>>   
>> -	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
>> -	if (!va) {
>> -		dev_err(dev, "ioremap::CE failed\n");
>> +	/*
>> +	 * TODO: Ultimately we would like to use a cacheable/non-shareable
>> +	 * (coherent) mapping for the portal on both architectures but that
>> +	 * isn't currently available in the kernel.  Because of HW differences
>> +	 * PPC needs to be mapped cacheable while ARM SoCs will work with non
>> +	 * cacheable mappings
>> +	 */
> 
> This comment mentions "cacheable/non-shareable (coherent)". Was this
> meant for ARM platforms? Because non-shareable is not coherent, nor is
> this combination guaranteed to work with different CPUs and
> interconnects.
My wording is poor I should have been clearer that non-shareable == 
non-coherent.  I will fix this.

We do understand that cacheable/non shareable isn't supported on all 
CPU/interconnect combinations but we have verified with ARM that for the 
CPU/interconnects we have integrated QBMan on our use is OK. The note is 
here to try to explain why the mapping is different right now. Once we 
get the basic QBMan support integrated for ARM we do plan to try to have 
patches integrated that enable the cacheable mapping as it gives a 
significant performance boost.  This is a step 2 as we understand the 
topic is complex and a little controversial so I think treating it as an 
independent change will be easier than mixing it with the less 
interesting changes in this patchset.

> 
>> +#ifdef CONFIG_PPC
>> +	/* PPC requires a cacheable/non-coherent mapping of the portal */
>> +	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
>> +				resource_size(addr_phys[0]), MEMREMAP_WB);
>> +#else
>> +	/* ARM can use a write combine mapping. */
>> +	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
>> +				resource_size(addr_phys[0]), MEMREMAP_WC);
>> +#endif
> 
> Nitpick: you could define something like QBMAN_MAP_ATTR to be different
> between PPC and the rest and just keep a single memremap() call.
I will change this - it will be a little more compact.
> 
> One may complain that "ce" is no longer "cache enabled" but I'm
> personally fine to keep the same name for historical reasons.
Cache Enabled is also how the 'data sheet' for the processor describes 
the region and I think it is useful to keep it aligned so that anyone 
looking at the manual and the code can easily correlate the ter >
>> diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
>> index 81a9a5e..0a1d573 100644
>> --- a/drivers/soc/fsl/qbman/dpaa_sys.h
>> +++ b/drivers/soc/fsl/qbman/dpaa_sys.h
>> @@ -51,12 +51,12 @@
>>   
>>   static inline void dpaa_flush(void *p)
>>   {
>> +	/*
>> +	 * Only PPC needs to flush the cache currently - on ARM the mapping
>> +	 * is non cacheable
>> +	 */
>>   #ifdef CONFIG_PPC
>>   	flush_dcache_range((unsigned long)p, (unsigned long)p+64);
>> -#elif defined(CONFIG_ARM)
>> -	__cpuc_flush_dcache_area(p, 64);
>> -#elif defined(CONFIG_ARM64)
>> -	__flush_dcache_area(p, 64);
>>   #endif
>>   }
> 
> Dropping the private API cache maintenance is fine and the memory is WC
> now for ARM (mapping to Normal NonCacheable). However, do you require
> any barriers here? Normal NC doesn't guarantee any ordering.
The barrier is done in the code where the command is formed. We follow 
this pattern
a) Zero the command cache line (the device never reacts to a 0 command 
verb so a cast out of this will have no effect)
b) Fill in everything in the command except the command verb (byte 0)
c) Execute a memory barrier
d) Set the command verb (byte 0)
e) Flush the command
If a castout happens between d) and e) doesn't matter since it was about 
to be flushed anyway .  Any castout before d) will not cause HW to 
process the command because verb is still 0. The barrier at c) prevents 
reordering so the HW cannot see the verb set before the command is formed.

> 
>> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
>> index cbacdf4..41fe33a 100644
>> --- a/drivers/soc/fsl/qbman/qman_portal.c
>> +++ b/drivers/soc/fsl/qbman/qman_portal.c
>> @@ -224,7 +224,6 @@ static int qman_portal_probe(struct platform_device *pdev)
>>   	struct device_node *node = dev->of_node;
>>   	struct qm_portal_config *pcfg;
>>   	struct resource *addr_phys[2];
>> -	void __iomem *va;
>>   	int irq, cpu, err;
>>   	u32 val;
>>   
>> @@ -262,23 +261,34 @@ static int qman_portal_probe(struct platform_device *pdev)
>>   	}
>>   	pcfg->irq = irq;
>>   
>> -	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
>> -	if (!va) {
>> -		dev_err(dev, "ioremap::CE failed\n");
>> +	/*
>> +	 * TODO: Ultimately we would like to use a cacheable/non-shareable
>> +	 * (coherent) mapping for the portal on both architectures but that
>> +	 * isn't currently available in the kernel.  Because of HW differences
>> +	 * PPC needs to be mapped cacheable while ARM SoCs will work with non
>> +	 * cacheable mappings
>> +	 */
> 
> Same comment as above non non-shareable.
> 
>> +#ifdef CONFIG_PPC
>> +	/* PPC requires a cacheable mapping of the portal */
>> +	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
>> +				resource_size(addr_phys[0]), MEMREMAP_WB);
>> +#else
>> +	/* ARM can use write combine mapping for the cacheable area */
>> +	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
>> +				resource_size(addr_phys[0]), MEMREMAP_WT);
>> +#endif
> 
> Same nitpick: a single memremap() call.
> 
