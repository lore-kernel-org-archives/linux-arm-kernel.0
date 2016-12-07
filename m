From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 6 Dec 2016 18:24:35 -0800
Subject: [PATCH 3/3] ARM: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <a50d7d1b-643f-cf17-b38f-475916c971c1@redhat.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <20161206195312.22354-1-f.fainelli@gmail.com>
 <20161206195312.22354-4-f.fainelli@gmail.com>
 <a50d7d1b-643f-cf17-b38f-475916c971c1@redhat.com>
Message-ID: <22eb9bb0-f1dc-7923-b7f5-e278c19b374c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2016 06:00 PM, Laura Abbott wrote:
>> @@ -261,6 +261,16 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>>  	((((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT) + \
>>  	 PHYS_PFN_OFFSET)
>>  
>> +#define __pa_symbol_nodebug(x)	((x) - (unsigned long)KERNEL_START)
> 
> On arm64 the kernel image lives in a separate linear offset. arm doesn't
> do anything like that so __phys_addr_symbol should just be the regular
> __virt_to_phys

Yep, which is what I have queued locally now too, thanks!


>> +static inline bool __virt_addr_valid(unsigned long x)
>> +{
>> +	if (x < PAGE_OFFSET)
>> +		return false;
>> +	if (arm_lowmem_limit && is_vmalloc_or_module_addr((void *)x))
>> +		return false;
>> +	if (x >= FIXADDR_START && x < FIXADDR_END)
>> +		return false;
>> +	return true;
>> +}
> 
> I'd rather see this return true for only the linear range and
> reject everything else. asm/memory.h already has
> 
> #define virt_addr_valid(kaddr)  (((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory) \
>                                         && pfn_valid(virt_to_pfn(kaddr)))
> 
> So we can make the check x >= PAGE_OFFSET && x < high_memory

OK that's simpler indeed. I did the check this way because we have early
callers of __pa() from drivers/of/fdt.c, in particular MIN_MEMBLOCK_ADDR
there, and we also have pcpu_dfl_fc_alloc which uses DMA_MAX_ADDR (which
is 0xffff_ffff on my platform).

>> +static inline bool __phys_addr_valid(unsigned long x)
>> +{
>> +	/* This is bounds checking against the kernel image only.
>> +	 * __pa_symbol should only be used on kernel symbol addresses.
>> +	 */
>> +	if (x < (unsigned long)KERNEL_START ||
>> +	    x > (unsigned long)KERNEL_END)
>> +		return false;
>> +
>> +	return true;
>> +}
> 
> This is a confusing name for this function, it's not checking if
> a physical address is valid, it's checking if a virtual address
> corresponding to a kernel symbol is valid.

I have removed it and just moved the check within VIRTUAL_BUG_ON().

Thanks!
-- 
Florian
