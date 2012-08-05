From: cyril@ti.com (Cyril Chemparathy)
Date: Sun, 5 Aug 2012 10:05:11 -0400
Subject: [PATCH 03/22] ARM: LPAE: use phys_addr_t on virt <--> phys
 conversion
In-Reply-To: <alpine.LFD.2.02.1208040222110.5231@xanadu.home>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-4-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1208040222110.5231@xanadu.home>
Message-ID: <501E7D97.7070007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/4/2012 2:24 AM, Nicolas Pitre wrote:
> On Tue, 31 Jul 2012, Cyril Chemparathy wrote:
>
>> This patch fixes up the types used when converting back and forth between
>> physical and virtual addresses.
>>
>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>
> Did you verify that this didn't introduce any compilation warning when
> compiling for non LPAE?  If so and there were no warnings then...
>

Yes.  This series has been tested on vanilla ARMv7 Cortex-A8 non-LPAE 
hardware as well.

> Acked-by: Nicolas Pitre <nico@linaro.org>
>
>
>> ---
>>   arch/arm/include/asm/memory.h |   17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
>> index 01c710d..4a0108f 100644
>> --- a/arch/arm/include/asm/memory.h
>> +++ b/arch/arm/include/asm/memory.h
>> @@ -157,22 +157,27 @@ extern unsigned long __pv_phys_offset;
>>
>>   extern unsigned long __pv_offset;
>>
>> -static inline unsigned long __virt_to_phys(unsigned long x)
>> +static inline phys_addr_t __virt_to_phys(unsigned long x)
>>   {
>>   	unsigned long t;
>>   	early_patch_imm8(x, t, "add", __pv_offset);
>>   	return t;
>>   }
>>
>> -static inline unsigned long __phys_to_virt(unsigned long x)
>> +static inline unsigned long __phys_to_virt(phys_addr_t x)
>>   {
>>   	unsigned long t;
>>   	early_patch_imm8(x, t, "sub", __pv_offset);
>>   	return t;
>>   }
>>   #else
>> -#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
>> -#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
>> +
>> +#define __virt_to_phys(x)		\
>> +	((phys_addr_t)(x) - PAGE_OFFSET + PHYS_OFFSET)
>> +
>> +#define __phys_to_virt(x)		\
>> +	((unsigned long)((phys_addr_t)(x) - PHYS_OFFSET + PAGE_OFFSET))
>> +
>>   #endif
>>   #endif
>>
>> @@ -207,14 +212,14 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
>>
>>   static inline void *phys_to_virt(phys_addr_t x)
>>   {
>> -	return (void *)(__phys_to_virt((unsigned long)(x)));
>> +	return (void *)__phys_to_virt(x);
>>   }
>>
>>   /*
>>    * Drivers should NOT use these either.
>>    */
>>   #define __pa(x)			__virt_to_phys((unsigned long)(x))
>> -#define __va(x)			((void *)__phys_to_virt((unsigned long)(x)))
>> +#define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
>>   #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
>>
>>   /*
>> --
>> 1.7.9.5
>>

-- 
Thanks
- Cyril
