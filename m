From: mohun106@gmail.com (Radha Mohan)
Date: Wed, 27 Nov 2013 21:30:53 +0530
Subject: [RFC PATCH 1/2] arm64: Add 48-bit PA support for 4KB page size
In-Reply-To: <20131127111423.GF5402@e106331-lin.cambridge.arm.com>
References: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
 <1385537665-5909-2-git-send-email-mohun106@gmail.com>
 <20131127111423.GF5402@e106331-lin.cambridge.arm.com>
Message-ID: <CAC8NTUUstMH_xAHG_KpMCV-ooZVUAmVqX7AO=tZ1ZK_6Y=-vEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 4:44 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Wed, Nov 27, 2013 at 07:34:24AM +0000, mohun106 at gmail.com wrote:
>> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
>>
>> This patch adds support for 48-bit physical addresses in the ARMv8 based
>> SoCs. The VA_BITS is expanded to 48 enabling access to 128TB of kernel
>> space. The Linux will now be using 4 levels of page tables for address
>> translations for 4KB page size.
>
> Given that this requires an additional level of page table to be
> allocated, it would be nice if this were a compile-time configuration
> option.
>

Having a compile time option increases the number of #ifdefs. Is this
acceptable?

> As you mentioned you'd run LTP tests, what was the additional memory and
> time cost over 3 levels with 40-bit addressing?
>

Additional memory cost will be another page table. Haven't checked the time cost
though. I will get back on the time costs.

> Has this been tested in conjunction with hugepages?
>

This is still under progress.

>>
>> Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
>> ---
>>  arch/arm64/include/asm/memory.h               |    6 +--
>>  arch/arm64/include/asm/page.h                 |    2 +-
>>  arch/arm64/include/asm/pgalloc.h              |   16 ++++++
>>  arch/arm64/include/asm/pgtable-4level-hwdef.h |   57 ++++++++++++++++++++
>>  arch/arm64/include/asm/pgtable-4level-types.h |   71 +++++++++++++++++++++++++
>
> As they're unused after this patch, it feels very odd to leave
> pgtable-3level-*.h lying around...

pgtable-3level-*.h is for 64KB page size.
I can remove pgtable-2level*.h.

>
>>  arch/arm64/include/asm/pgtable-hwdef.h        |    7 ++-
>>  arch/arm64/include/asm/pgtable.h              |   41 +++++++++++++--
>>  arch/arm64/kernel/head.S                      |   33 +++++++++--
>>  arch/arm64/kernel/traps.c                     |    5 ++
>>  arch/arm64/mm/proc.S                          |    2 +-
>>  10 files changed, 220 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 3776217..91e92b4 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -41,11 +41,7 @@
>>   * The module space lives between the addresses given by TASK_SIZE
>>   * and PAGE_OFFSET - it must be within 128MB of the kernel text.
>>   */
>> -#ifdef CONFIG_ARM64_64K_PAGES
>> -#define VA_BITS                        (42)
>> -#else
>> -#define VA_BITS                        (39)
>> -#endif
>> +#define VA_BITS                        (48)
>
> Doesn't this break 64k page support until the next patch?

No, for 64KB also the max width is 48.

>
>>  #define PAGE_OFFSET            (UL(0xffffffffffffffff) << (VA_BITS - 1))
>>  #define MODULES_END            (PAGE_OFFSET)
>>  #define MODULES_VADDR          (MODULES_END - SZ_64M)
>> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
>> index 46bf666..64faf71 100644
>> --- a/arch/arm64/include/asm/page.h
>> +++ b/arch/arm64/include/asm/page.h
>> @@ -36,7 +36,7 @@
>>  #ifdef CONFIG_ARM64_64K_PAGES
>>  #include <asm/pgtable-2level-types.h>
>>  #else
>> -#include <asm/pgtable-3level-types.h>
>> +#include <asm/pgtable-4level-types.h>
>>  #endif
>>
>>  extern void __cpu_clear_user_page(void *p, unsigned long user);
>> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
>> index 9bea6e7..482816c 100644
>> --- a/arch/arm64/include/asm/pgalloc.h
>> +++ b/arch/arm64/include/asm/pgalloc.h
>> @@ -44,6 +44,22 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
>>         set_pud(pud, __pud(__pa(pmd) | PMD_TYPE_TABLE));
>>  }
>>
>> +static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>> +{
>> +       return (pud_t *)get_zeroed_page(GFP_KERNEL | __GFP_REPEAT);
>> +}
>
> This is probably a stupid question, but why do we use __GFP_REPEAT in
> pmd_alloc_one (and here pud_alloc_one), but not pgd_alloc or
> pte_alloc_one?
>
> [...]
>
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> index 755f861..05fadaf 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -19,7 +19,7 @@
>>  #ifdef CONFIG_ARM64_64K_PAGES
>>  #include <asm/pgtable-2level-hwdef.h>
>>  #else
>> -#include <asm/pgtable-3level-hwdef.h>
>> +#include <asm/pgtable-4level-hwdef.h>
>>  #endif
>>
>>  /*
>> @@ -100,9 +100,9 @@
>>  #define PTE_HYP                        PTE_USER
>>
>>  /*
>> - * 40-bit physical address supported.
>> + * 48-bit physical address supported.
>>   */
>> -#define PHYS_MASK_SHIFT                (40)
>> +#define PHYS_MASK_SHIFT                (48)
>
> The 64k page needs to be updated to handle this or it will be broken,
> no?
>
>>  #define PHYS_MASK              ((UL(1) << PHYS_MASK_SHIFT) - 1)
>>
>>  /*
>> @@ -123,6 +123,7 @@
>>  #define TCR_TG0_64K            (UL(1) << 14)
>>  #define TCR_TG1_64K            (UL(1) << 30)
>>  #define TCR_IPS_40BIT          (UL(2) << 32)
>> +#define TCR_IPS_48BIT          (UL(5) << 32)
>>  #define TCR_ASID16             (UL(1) << 36)
>>  #define TCR_TBI0               (UL(1) << 37)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 17bd3af..57efd3d 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -43,12 +43,14 @@
>>  #ifndef __ASSEMBLY__
>>  extern void __pte_error(const char *file, int line, unsigned long val);
>>  extern void __pmd_error(const char *file, int line, unsigned long val);
>> +extern void __pud_error(const char *file, int line, unsigned long val);
>>  extern void __pgd_error(const char *file, int line, unsigned long val);
>>
>>  #define pte_ERROR(pte)         __pte_error(__FILE__, __LINE__, pte_val(pte))
>>  #ifndef CONFIG_ARM64_64K_PAGES
>>  #define pmd_ERROR(pmd)         __pmd_error(__FILE__, __LINE__, pmd_val(pmd))
>>  #endif
>> +#define pud_ERROR(pud)         __pud_error(__FILE__, __LINE__, pud_val(pud))
>>  #define pgd_ERROR(pgd)         __pgd_error(__FILE__, __LINE__, pgd_val(pgd))
>
> Given that these don't seem to be called from assembly, and currently
> are identical other than the "pte", "pmd, or "pgd" string, could we not
> have a single implementation and pass the requisite "pte", "pmd", "pud",
> or "pgd" in as a parameter here?
>
> [...]
>
>> @@ -352,8 +385,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>>  extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
>>
>> -#define SWAPPER_DIR_SIZE       (3 * PAGE_SIZE)
>> -#define IDMAP_DIR_SIZE         (2 * PAGE_SIZE)
>> +#define SWAPPER_DIR_SIZE       (4 * PAGE_SIZE)
>> +#define IDMAP_DIR_SIZE         (3 * PAGE_SIZE)
>>
>>  /*
>>   * Encode and decode a swap entry:
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index 7009387..cc764e5 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -45,8 +45,10 @@
>>  #error KERNEL_RAM_VADDR must start at 0xXXX80000
>>  #endif
>>
>> -#define SWAPPER_DIR_SIZE       (3 * PAGE_SIZE)
>> -#define IDMAP_DIR_SIZE         (2 * PAGE_SIZE)
>> +#define create_page_entry      create_pud_entry
>> +
>> +#define SWAPPER_DIR_SIZE       (4 * PAGE_SIZE)
>> +#define IDMAP_DIR_SIZE         (3 * PAGE_SIZE)
>
> I hadn't realised that SWAPPER_DIR_SIZE and IDMAP_DIR_SIZE were
> duplicated. Could we not moved the definition in pgtable.h before the
> #ifndef __ASSEMBLY__? head.S includes pgtable.h, and page.h defines
> PAGE_SIZE before its #ifndef __ASSEMBLY__.
>
> [...]
>
>> @@ -336,6 +336,11 @@ void __pmd_error(const char *file, int line, unsigned long val)
>>         printk("%s:%d: bad pmd %016lx.\n", file, line, val);
>>  }
>>
>> +void __pud_error(const char *file, int line, unsigned long val)
>> +{
>> +       printk("%s:%d: bad pud %016lx.\n", file, line, val);
>> +}
>
> As mentioned above, I think we can unify the __p*_error functions
> rather than introducing a new one.
>
> Thanks,
> Mark.
