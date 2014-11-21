From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 20 Nov 2014 17:02:24 -0800
Subject: [PATCHv5 7/7] arm64: add better page protections to arm64
In-Reply-To: <20141120120400.GA30398@linaro.org>
References: <1416272105-14787-1-git-send-email-lauraa@codeaurora.org>
 <1416272105-14787-8-git-send-email-lauraa@codeaurora.org>
 <20141120120400.GA30398@linaro.org>
Message-ID: <546E8F20.8070202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/20/2014 4:04 AM, Steve Capper wrote:
>
> Hi Laura,
> Some comments inline.
>
>> ---
>> v5:
>>   -Dropped map_io from the alloc_init_* functions
>>   -Fixed a bug in split_pud and cleaned it up per suggestions from Steve
>>   -Aligned _etext up to SECTION_SIZE of DEBUG_ALIGN_RODATA is enabled to ensure
>>    that the section mapping is actually kept and we don't leak any RWX regions
>>   -Dropped some old ioremap code that somehow snuck in from the last rebase
>>   -Fixed create_id_mapping to use the early mapping since efi_idmap_init is
>>    called early
>> ---
>>   arch/arm64/Kconfig.debug            |  23 +++
>>   arch/arm64/include/asm/cacheflush.h |   4 +
>>   arch/arm64/kernel/vmlinux.lds.S     |  20 +++
>>   arch/arm64/mm/init.c                |   1 +
>>   arch/arm64/mm/mm.h                  |   2 +
>>   arch/arm64/mm/mmu.c                 | 289 +++++++++++++++++++++++++++++++-----
>>   6 files changed, 298 insertions(+), 41 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
>> index 0a12933..867fe6f1 100644
>> --- a/arch/arm64/Kconfig.debug
>> +++ b/arch/arm64/Kconfig.debug
>> @@ -54,4 +54,27 @@ config DEBUG_SET_MODULE_RONX
>>             against certain classes of kernel exploits.
>>             If in doubt, say "N".
>>
>> +config DEBUG_RODATA
>> +	bool "Make kernel text and rodata read-only"
>> +	help
>> +	  If this is set, kernel text and rodata will be made read-only. This
>> +	  is to help catch accidental or malicious attempts to change the
>> +	  kernel's executable code. Additionally splits rodata from kernel
>> +	  text so it can be made explicitly non-executable.
>> +
>> +          If in doubt, say Y
>> +
>> +config DEBUG_ALIGN_RODATA
>> +	depends on DEBUG_RODATA && !ARM64_64K_PAGES
>> +	bool "Align linker sections up to SECTION_SIZE"
>> +	help
>> +	  If this option is enabled, sections that may potentially be marked as
>> +	  read only or non-executable will be aligned up to the section size of
>> +	  the kernel. This prevents sections from being split into pages and
>> +	  avoids a potential TLB penalty. The downside is an increase in
>> +	  alignment and potentially wasted space. Turn on this option if
>> +	  performance is more important than memory pressure.
>> +
>> +	  If in doubt, say N
>> +
>>   endmenu
>> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
>> index 689b637..0014207 100644
>> --- a/arch/arm64/include/asm/cacheflush.h
>> +++ b/arch/arm64/include/asm/cacheflush.h
>> @@ -152,4 +152,8 @@ int set_memory_ro(unsigned long addr, int numpages);
>>   int set_memory_rw(unsigned long addr, int numpages);
>>   int set_memory_x(unsigned long addr, int numpages);
>>   int set_memory_nx(unsigned long addr, int numpages);
>> +
>> +#ifdef CONFIG_DEBUG_RODATA
>> +void mark_rodata_ro(void);
>> +#endif
>>   #endif
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 2d7e20a..405820d 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -8,6 +8,7 @@
>>   #include <asm/thread_info.h>
>>   #include <asm/memory.h>
>>   #include <asm/page.h>
>> +#include <asm/pgtable.h>
>>
>>   #include "image.h"
>>
>> @@ -54,6 +55,9 @@ SECTIONS
>>   		_text = .;
>>   		HEAD_TEXT
>>   	}
>> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
>> +	. = ALIGN(1<<SECTION_SHIFT);
>> +#endif
>
> For 64K pages, SECTION_SHIFT will be 29, will that large an alignment
> cause any issues?
>

This option currently depends on !ARM64_64K_PAGES. It's really only
beneficial for 4K pages.

>>   	.text : {			/* Real text segment		*/
...
>> -static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>> +void __ref split_pud(pud_t *old_pud, pmd_t *pmd)
>> +{
>> +	unsigned long addr = pud_pfn(*old_pud) << PAGE_SHIFT;
>> +	pgprot_t prot = __pgprot(pud_val(*old_pud) ^ pud_pfn(*old_pud));
>
> I don't think this is quite right, the page frame number is the PA
> shifted right, so that can't be XOR'ed directly with the pud. The
> following should work though:
> 	pgprot_t prot = __pgprot(pud_val(*old_pud) ^ addr);
>

Right, I'll fix it.

>> +	int i = 0;
>> +
>> +	do {
>> +		set_pmd(pmd, __pmd(addr | prot));
>> +		addr += PMD_SIZE;
>> +	} while (pmd++, i++, i < PTRS_PER_PMD);
>> +}
>> +
>> +static void __ref alloc_init_pmd(pud_t *pud, unsigned long addr,
>>   				  unsigned long end, phys_addr_t phys,
>> -				  int map_io)
>> +				  pgprot_t sect_prot, pgprot_t pte_prot,
>> +				  bool early)
>>   {
>>   	pmd_t *pmd;
>>   	unsigned long next;
>> -	pmdval_t prot_sect;
>> -	pgprot_t prot_pte;
>> -
>> -	if (map_io) {
>> -		prot_sect = PROT_SECT_DEVICE_nGnRE;
>> -		prot_pte = __pgprot(PROT_DEVICE_nGnRE);
>> -	} else {
>> -		prot_sect = PROT_SECT_NORMAL_EXEC;
>> -		prot_pte = PAGE_KERNEL_EXEC;
>> -	}
>>
>>   	/*
>>   	 * Check for initial section mappings in the pgd/pud and remove them.
>>   	 */
>>   	if (pud_none(*pud) || pud_bad(*pud)) {
>> -		pmd = early_alloc(PTRS_PER_PMD * sizeof(pmd_t));
>> +		if (early)
>> +			pmd = early_alloc(PTRS_PER_PMD * sizeof(pmd_t));
>> +		else
>> +			pmd = pmd_alloc_one(&init_mm, addr);
>> +		BUG_ON(!pmd);
>> +		if (pud_sect(*pud)) {
>> +			/*
>> +			 * need to have the 1G of mappings continue to be
>> +			 * present
>> +			 */
>> +			split_pud(pud, pmd);
>> +		}
>>   		pud_populate(&init_mm, pud, pmd);
>> +		flush_tlb_all();
>>   	}
>>
>>   	pmd = pmd_offset(pud, addr);
>> @@ -186,8 +240,8 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>>   		next = pmd_addr_end(addr, end);
>>   		/* try section mapping first */
>>   		if (((addr | next | phys) & ~SECTION_MASK) == 0) {
>> -			pmd_t old_pmd =*pmd;
>> -			set_pmd(pmd, __pmd(phys | prot_sect));
>> +			pmd_t old_pmd = *pmd;
>> +			set_pmd(pmd, __pmd(phys | sect_prot));
>>   			/*
>>   			 * Check for previous table entries created during
>>   			 * boot (__create_page_tables) and flush them.
>> @@ -196,15 +250,39 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>>   				flush_tlb_all();
>>   		} else {
>>   			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
>> -				       prot_pte);
>> +					pte_prot, early);
>>   		}
>>   		phys += next - addr;
>>   	} while (pmd++, addr = next, addr != end);
>>   }
>>
>> -static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
>> -				  unsigned long end, phys_addr_t phys,
>> -				  int map_io)
>> +static inline bool use_1G_block(unsigned long addr, unsigned long next,
>> +			unsigned long phys, pgprot_t sect_prot,
>> +			pgprot_t pte_prot, bool early)
>> +{
>> +	if (!early)
>> +		return false;
>> +
>> +	if (PAGE_SHIFT != 12)
>> +		return false;
>> +
>> +	if (((addr | next | phys) & ~PUD_MASK) != 0)
>> +		return false;
>> +
>> +	/*
>> +	 * The assumption here is that if the memory is anything other
>> +	 * than normal we should not be using a block type
>> +	 */
>> +	return ((sect_prot & PMD_ATTRINDX_MASK) ==
>> +				PMD_ATTRINDX(MT_NORMAL)) &&
>> +			((pte_prot & PTE_ATTRINDX_MASK) ==
>> +				PTE_ATTRINDX(MT_NORMAL));
>
> Do we need this check for memory type?
> A block mapping for device memory is perfectly valid (just unlikely!).
>

I was trying to match the existing behavior of !map_io. I assumed that
check was there for a reason.

Thanks,
Laura


-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
