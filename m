From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 4 Feb 2014 09:33:50 -0500
Subject: [RFC/RFT 1/2] ARM: mm: introduce arch hooks for dma address
 translation routines
In-Reply-To: <CAOesGMgmTmAOy4SpZU8oxN=0AihcixX5aU1sM_LNe5TiScMaSw@mail.gmail.com>
References: <1391470107-15927-1-git-send-email-santosh.shilimkar@ti.com>
 <1391470107-15927-2-git-send-email-santosh.shilimkar@ti.com>
 <CAOesGMgmTmAOy4SpZU8oxN=0AihcixX5aU1sM_LNe5TiScMaSw@mail.gmail.com>
Message-ID: <52F0FA4E.3000202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 February 2014 09:18 PM, Olof Johansson wrote:
> Hi,
> 
> 
> On Mon, Feb 3, 2014 at 3:28 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> Currently arch specific DMA address translation routines can be enabled
>> using only defines which makes impossible to use them in with
>> multi-platform builds.
>>
>> Hence, introduce arch specific hooks for DMA address translations
>> routines to be compatible with multi-platform builds:
>> dma_addr_t (*arch_pfn_to_dma)(struct device *dev, unsigned long pfn);
>> unsigned long (*arch_dma_to_pfn)(struct device *dev, dma_addr_t addr);
>> void* (*arch_dma_to_virt)(struct device *dev, dma_addr_t addr);
>> dma_addr_t (*arch_virt_to_dma)(struct device *dev, void *addr);
>>
>> In case if architecture won't use it - DMA address translation routines
>> will fall-back to existing implementation.
>>
>> Also, modify machines omap1, ks8695, iop13xx to use new DMA hooks.
> 
> [...]
> 
>> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
>> index e701a4d..84acc46 100644
>> --- a/arch/arm/include/asm/dma-mapping.h
>> +++ b/arch/arm/include/asm/dma-mapping.h
>> @@ -55,28 +55,16 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
>>   * functions used internally by the DMA-mapping API to provide DMA
>>   * addresses. They must not be used by drivers.
>>   */
>> -#ifndef __arch_pfn_to_dma
>> -static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
>> -{
>> -       return (dma_addr_t)__pfn_to_bus(pfn);
>> -}
>>
>> -static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
>> -{
>> -       return __bus_to_pfn(addr);
>> -}
>> +extern dma_addr_t (*__arch_pfn_to_dma)(struct device *dev, unsigned long pfn);
>> +extern unsigned long (*__arch_dma_to_pfn)(struct device *dev, dma_addr_t addr);
>> +extern void* (*__arch_dma_to_virt)(struct device *dev, dma_addr_t addr);
>> +extern dma_addr_t (*__arch_virt_to_dma)(struct device *dev, void *addr);
> 
> I tend to prefer having these kind of function pointers grouped in a
> struct instead of in the toplevel namespace like this. It allows you
> to use a set_<foo>_ops() interface too instead and reduces
> exposed/exported internals since only the global struct pointer has to
> be exported.
> 
agree

[..]
 
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 5c43ca5..74111bf 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -39,6 +39,35 @@
>>
>>  #include "mm.h"
>>
>> +static inline dma_addr_t __pfn_to_dma(struct device *dev, unsigned long pfn)
>> +{
>> +       return (dma_addr_t)__pfn_to_bus(pfn);
>> +}
>> +
>> +static inline unsigned long __dma_to_pfn(struct device *dev, dma_addr_t addr)
>> +{
>> +       return __bus_to_pfn(addr);
>> +}
>> +
>> +static inline void *__dma_to_virt(struct device *dev, dma_addr_t addr)
>> +{
>> +       return (void *)__bus_to_virt((unsigned long)addr);
>> +}
>> +
>> +static inline dma_addr_t __virt_to_dma(struct device *dev, void *addr)
>> +{
>> +       return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
>> +}
>> +
>> +dma_addr_t (*__arch_pfn_to_dma)(struct device *dev, unsigned long pfn) = __pfn_to_dma;
>> +EXPORT_SYMBOL(__arch_pfn_to_dma);
>> +unsigned long (*__arch_dma_to_pfn)(struct device *dev, dma_addr_t addr) = __dma_to_pfn;
>> +EXPORT_SYMBOL(__arch_dma_to_pfn);
>> +void* (*__arch_dma_to_virt)(struct device *dev, dma_addr_t addr) = __dma_to_virt;
>> +EXPORT_SYMBOL(__arch_dma_to_virt);
>> +dma_addr_t (*__arch_virt_to_dma)(struct device *dev, void *addr) = __virt_to_dma;
>> +EXPORT_SYMBOL(__arch_virt_to_dma);
> 
> Independent on whether someone objects to my preference of exporting a
> struct, these (or that struct pointer) should probably be
> EXPORT_SYMBOL_GPL().
> 
Sure.

Regards,
Santosh
