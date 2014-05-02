From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 2 May 2014 11:05:16 -0400
Subject: [PATCH v3 5/7] ARM: dma: Use dma_pfn_offset for dma address
 translation
In-Reply-To: <20140502145852.GC3693@n2100.arm.linux.org.uk>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <1398353407-2345-6-git-send-email-santosh.shilimkar@ti.com>
 <20140502145852.GC3693@n2100.arm.linux.org.uk>
Message-ID: <5363B42C.4010404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 May 2014 10:58 AM, Russell King - ARM Linux wrote:
> On Thu, Apr 24, 2014 at 11:30:05AM -0400, Santosh Shilimkar wrote:
>> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
>> index e701a4d..424fda9 100644
>> --- a/arch/arm/include/asm/dma-mapping.h
>> +++ b/arch/arm/include/asm/dma-mapping.h
>> @@ -58,22 +58,35 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
>>  #ifndef __arch_pfn_to_dma
>>  static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
>>  {
>> -	return (dma_addr_t)__pfn_to_bus(pfn);
>> +	if (!dev)
>> +		return (dma_addr_t)__pfn_to_bus(pfn);
>> +	else
>> +		return (dma_addr_t)__pfn_to_bus(pfn - dev->dma_pfn_offset);
> 
> I really don't trust gcc to do this right, so I think it would be better
> to make life easier on the compiler:
> 
> 	if (dev)
> 		pfn -= dev->dma_pfn_offset;
> 	return (dma_addr_t)__pfn_to_bus(pfn);
> 
This looks better. Will udpate with above.

>>  static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
>>  {
>> -	return __bus_to_pfn(addr);
>> +	if (!dev)
>> +		return __bus_to_pfn(addr);
>> +	else
>> +		return __bus_to_pfn(addr) + dev->dma_pfn_offset;
> 
> and:
> 
> 	unsigned long pfn = __bus_to_pfn(addr);
> 
> 	if (dev)
> 		pfn += dev->dma_pfn_offset;
> 
> 	return pfn;
> 
Ok..

>>  }
>>  
>>  static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
>>  {
>> -	return (void *)__bus_to_virt((unsigned long)addr);
>> +	if (!dev)
>> +		return (void *)__bus_to_virt((unsigned long)addr);
>> +	else
>> +		return (void *)__bus_to_virt(__pfn_to_bus(dma_to_pfn(dev, addr)));
> 
> This is quite horrendous.  There's easier ways to do this...  I assume
> you haven't looked at the assembler resulting from this at all with
> stuff like the p2v patching enabled?
> 
I haven't. Will check.

>>  }
>>  
>>  static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
>>  {
>> -	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
>> +	if (!dev)
>> +		return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
>> +	else
>> +		return pfn_to_dma(dev,
>> +				__bus_to_pfn(__virt_to_bus((unsigned long)(addr))));
> 
> Same here.
> 
ok.

Thanks !!

Regards,
Santosh
