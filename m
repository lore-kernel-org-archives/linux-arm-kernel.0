From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 29 Jul 2014 22:47:44 +0900
Subject: [PATCH v7 07/11] arm64: mm: Implement 4 levels of translation
 tables
In-Reply-To: <CAGoO6fLT6B_vx+Wtm6bKHD6YkjQcM8f=deD7SDP3BR_uC+1c5w@mail.gmail.com>
References: <CAGoO6fLT6B_vx+Wtm6bKHD6YkjQcM8f=deD7SDP3BR_uC+1c5w@mail.gmail.com>
Message-ID: <ACF42928-55EE-4466-B217-982839BB98C4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 28 08:40:07 PDT 2014, Joel Schopp wrote:

Hi Joel,

> On 07/16/2014 02:09 PM, Catalin Marinas wrote:

[ ... ]

>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 4daf11f5b403..24cbe72c0da9 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -196,12 +196,18 @@ config ARM64_VA_BITS_42
>>  bool "42-bit"
>>  depends on ARM64_64K_PAGES
>> 
>> +config ARM64_VA_BITS_48
>> + bool "48-bit"
>> + depends on !KVM
>> + depends on ARM64_4K_PAGES
>> +
>> endchoice
> Shouldn't we be able to support 48 bit VA with 3 level 64K pages?  If so
> why the dependency on ARM64_4K_PAGES?

Have you reviewed [PATCH 13/11] thread? It supports 3 levels with 64KB page.
In addition, ARM64_VA_BITS_48 depends on only BROKEN.

> More generally it seems like a problem to tie the equate the VA_BITS the
> page table could address with the VA_BITS the hardware could address.
> Even with 4 level 4K page tables that can address 48 bits the hardware
> may only support say 42 bit address space.

I leave comments below.

>> 
>> config ARM64_VA_BITS
>>  int
>>  default 39 if ARM64_VA_BITS_39
>>  default 42 if ARM64_VA_BITS_42
>> + default 48 if ARM64_VA_BITS_48
>> 
>> config ARM64_2_LEVELS
>>  def_bool y if ARM64_64K_PAGES && ARM64_VA_BITS_42
>> @@ -209,6 +215,9 @@ config ARM64_2_LEVELS
>> config ARM64_3_LEVELS
>>  def_bool y if ARM64_4K_PAGES && ARM64_VA_BITS_39
>> 
>> +config ARM64_4_LEVELS
>> + def_bool y if ARM64_4K_PAGES && ARM64_VA_BITS_48
>> +
> It seems like we should also do ARM64_4K_PAGES and ARM64_VA_BITS_42 as a
> valid combination for ARM64_4_LEVELS.  At least if we are assuming the
> VA_BITS correspond to hardware.

I don't understand why VA_BITS should correspond to hardware. For example,
should ARM64_VA_BITS_36 be supported for 36-bit address spaces SoCs?

>> config CPU_BIG_ENDIAN
>>        bool "Build big-endian kernel"
>>        help
>> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
>> index 6bf139188792..cf9afa0366b6 100644
>> --- a/arch/arm64/include/asm/page.h
>> +++ b/arch/arm64/include/asm/page.h
>> @@ -33,19 +33,26 @@
>> 
>> /*
>>  * The idmap and swapper page tables need some space reserved in the kernel
>> - * image. Both require a pgd and a next level table to (section) map the
>> - * kernel. The the swapper also maaps the FDT (see __create_page_tables for
>> + * image. Both require pgd, pud (4 levels only) and pmd tables to (section)
>> + * map the kernel. The swapper also maps the FDT (see __create_page_tables for
>>  * more information).
>>  */
>> +#ifdef CONFIG_ARM64_4_LEVELS
>> +#define SWAPPER_DIR_SIZE (3 * PAGE_SIZE)
>> +#define IDMAP_DIR_SIZE (3 * PAGE_SIZE)
>> +#else
>> #define SWAPPER_DIR_SIZE (2 * PAGE_SIZE)
>> #define IDMAP_DIR_SIZE (2 * PAGE_SIZE)
>> +#endif
>> 
>> #ifndef __ASSEMBLY__
>> 
>> #ifdef CONFIG_ARM64_2_LEVELS
>> #include <asm/pgtable-2level-types.h>
>> -#else
>> +#elif defined(CONFIG_ARM64_3_LEVELS)
>> #include <asm/pgtable-3level-types.h>
>> +#else
>> +#include <asm/pgtable-4level-types.h>
>> #endif
>> 
>> extern void __cpu_clear_user_page(void *p, unsigned long user);
>> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
>> index 48298376e46a..8d745fae4c2d 100644
>> --- a/arch/arm64/include/asm/pgalloc.h
>> +++ b/arch/arm64/include/asm/pgalloc.h
>> @@ -26,6 +26,26 @@
>> 
>> #define check_pgt_cache() do { } while (0)
>> 
>> +#ifdef CONFIG_ARM64_4_LEVELS
>> +
>> +static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>> +{
>> + return (pud_t *)get_zeroed_page(GFP_KERNEL | __GFP_REPEAT);
>> +}
>> +
>> +static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>> +{
>> + BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
>> + free_page((unsigned long)pud);
>> +}
>> +
>> +static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
>> +{
>> + set_pgd(pgd, __pgd(__pa(pud) | PUD_TYPE_TABLE));
>> +}
>> +
>> +#endif  /* CONFIG_ARM64_4_LEVELS */
>> +
>> #ifndef CONFIG_ARM64_2_LEVELS
>> 
>> static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> index c7c603b489b8..fddcc3efa569 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -18,8 +18,10 @@
>> 
>> #ifdef CONFIG_ARM64_2_LEVELS
>> #include <asm/pgtable-2level-hwdef.h>
>> -#else
>> +#elif defined(CONFIG_ARM64_3_LEVELS)
>> #include <asm/pgtable-3level-hwdef.h>
>> +#else
>> +#include <asm/pgtable-4level-hwdef.h>
>> #endif
>> 
>> /*
>> @@ -27,7 +29,7 @@
>>  *
>>  * Level 1 descriptor (PUD).
>>  */
>> -
>> +#define PUD_TYPE_TABLE (_AT(pudval_t, 3) << 0)
>> #define PUD_TABLE_BIT (_AT(pgdval_t, 1) << 1)
>> #define PUD_TYPE_MASK (_AT(pgdval_t, 3) << 0)
>> #define PUD_TYPE_SECT (_AT(pgdval_t, 1) << 0)
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 6d5854972a77..d9b23efdaded 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -35,7 +35,11 @@
>>  * VMALLOC and SPARSEMEM_VMEMMAP ranges.
>>  */
>> #define VMALLOC_START (UL(0xffffffffffffffff) << VA_BITS)
> Here's a good example of where we run into trouble equating page table
> addressable bits with hardware addressable bits.  If VA_BITS is 48 due
> to 4K 4 level page tables but is running on a 42 bit system this will
> end up being out of range.

Is your concern that CPU issues 48-bit address to MMU on 42-bit hardware?
Have you tested this patch series on your hardware?

- Jungseok Lee
