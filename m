From: labbott@redhat.com (Laura Abbott)
Date: Mon, 21 Nov 2016 09:40:06 -0800
Subject: [PATCHv3 5/6] arm64: Use __pa_symbol for kernel symbols
In-Reply-To: <20161118143543.GC1197@leverpostej>
References: <1479431816-5028-1-git-send-email-labbott@redhat.com>
 <1479431816-5028-6-git-send-email-labbott@redhat.com>
 <20161118143543.GC1197@leverpostej>
Message-ID: <92635df6-9a58-02cf-3230-1a84c28370d1@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2016 06:35 AM, Mark Rutland wrote:
> Hi Laura,
> 
> On Thu, Nov 17, 2016 at 05:16:55PM -0800, Laura Abbott wrote:
>>
>> __pa_symbol is technically the marco that should be used for kernel
>> symbols. Switch to this as a pre-requisite for DEBUG_VIRTUAL which
>> will do bounds checking.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> v3: Conversion of more sites besides just _end. Addition of __lm_sym_addr
>> macro to take care of the _va(__pa_symbol(..)) idiom.
>>
>> Note that a copy of __pa_symbol was added to avoid a mess of headers
>> since the #ifndef __pa_symbol case is defined in linux/mm.h
> 
> I think we also need to fix up virt_to_phys(__cpu_soft_restart) in
> arch/arm64/kernel/cpu-reset.h. Otherwise, this looks complete for uses
> falling under arch/arm64/.
> 
> I also think it's worth mentioning in the commit message that this patch
> adds and __lm_sym_addr() and uses it in some places so that low-level
> helpers can use virt_to_phys() or __pa() consistently.
> 
> The PSCI change doesn't conflict with patches [1] that'll go via
> arm-soc, so I'm happy for that PSCI change to go via the arm64 tree,
> though it may be worth splitting into its own patch just in case
> something unexpected crops up.
> 
> With those fixed up:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/466522.html
> 
> Otherwise, I just have a few nits below.
> 
>> @@ -271,7 +271,7 @@ static inline void __kvm_flush_dcache_pud(pud_t pud)
>>  	kvm_flush_dcache_to_poc(page_address(page), PUD_SIZE);
>>  }
>>  
>> -#define kvm_virt_to_phys(x)		__virt_to_phys((unsigned long)(x))
>> +#define kvm_virt_to_phys(x)		__pa_symbol((unsigned long)(x))
> 
> Nit: we can drop the unsigned long cast given __pa_symbol() contains
> one.
> 
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index ffbb9a5..c2041a3 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -52,7 +52,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
>>   * for zero-mapped memory areas etc..
>>   */
>>  extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>> -#define ZERO_PAGE(vaddr)	pfn_to_page(PHYS_PFN(__pa(empty_zero_page)))
>> +#define ZERO_PAGE(vaddr)	pfn_to_page(PHYS_PFN(__pa_symbol(empty_zero_page)))
> 
> Nit: I think we can also simplify this to:
> 
> 	phys_to_page(__pa_symbol(empty_zero_page))
> 
> ... since phys_to_page(p) is (pfn_to_page(__phys_to_pfn(p)))
> ... and __phys_to_pfn(p) is PHYS_PFN(p)
> 
>> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
>> index 6f2ac4f..af8967a 100644
>> --- a/arch/arm64/kernel/insn.c
>> +++ b/arch/arm64/kernel/insn.c
>> @@ -97,7 +97,7 @@ static void __kprobes *patch_map(void *addr, int fixmap)
>>  	if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
>>  		page = vmalloc_to_page(addr);
>>  	else if (!module)
>> -		page = pfn_to_page(PHYS_PFN(__pa(addr)));
>> +		page = pfn_to_page(PHYS_PFN(__pa_symbol(addr)));
> 
> Nit: likewise, we can use phys_to_page() here.
> 
>> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
>> index a2c2478..791e87a 100644
>> --- a/arch/arm64/kernel/vdso.c
>> +++ b/arch/arm64/kernel/vdso.c
>> @@ -140,11 +140,11 @@ static int __init vdso_init(void)
>>  		return -ENOMEM;
>>  
>>  	/* Grab the vDSO data page. */
>> -	vdso_pagelist[0] = pfn_to_page(PHYS_PFN(__pa(vdso_data)));
>> +	vdso_pagelist[0] = pfn_to_page(PHYS_PFN(__pa_symbol(vdso_data)));
> 
> Nit: phys_to_page() again.
> 
>>  
>>  	/* Grab the vDSO code pages. */
>>  	for (i = 0; i < vdso_pages; i++)
>> -		vdso_pagelist[i + 1] = pfn_to_page(PHYS_PFN(__pa(&vdso_start)) + i);
>> +		vdso_pagelist[i + 1] = pfn_to_page(PHYS_PFN(__pa_symbol(&vdso_start)) + i);
> 
> Nit: phys_to_page() again.

I think it makes sense to keep this one as is. It's offsetting
by pfn number and trying force phys_to_page would make it more
difficult to read.

> 
> Thanks,
> Mark.
> 

Thanks,
Laura
