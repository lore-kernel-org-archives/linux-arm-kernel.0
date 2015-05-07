From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 7 May 2015 21:21:28 +0200
Subject: [PATCH v4 09/13] arm64: mm: explicitly bootstrap the linear
 mapping
In-Reply-To: <20150507165416.GB11067@e104818-lin.cambridge.arm.com>
References: <1429112064-19952-1-git-send-email-ard.biesheuvel@linaro.org>
 <1429112064-19952-10-git-send-email-ard.biesheuvel@linaro.org>
 <20150507165416.GB11067@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu-26A1pawUoeY28mXb1WzhPv4O0Rh433Yj9uBjxFh0MWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2015 at 18:54, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Apr 15, 2015 at 05:34:20PM +0200, Ard Biesheuvel wrote:
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index ceec4def354b..338eaa7bcbfd 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -68,6 +68,17 @@ PECOFF_FILE_ALIGNMENT = 0x200;
>>  #define ALIGN_DEBUG_RO_MIN(min)              . = ALIGN(min);
>>  #endif
>>
>> +/*
>> + * The pgdir region needs to be mappable using a single PMD or PUD sized region,
>> + * so it should not cross a 512 MB or 1 GB alignment boundary, respectively
>> + * (depending on page size). So align to an upper bound of its size.
>> + */
>> +#if CONFIG_ARM64_PGTABLE_LEVELS == 2
>> +#define PGDIR_ALIGN  (8 * PAGE_SIZE)
>> +#else
>> +#define PGDIR_ALIGN  (16 * PAGE_SIZE)
>> +#endif
>
> Isn't 8 pages sufficient in both cases? Unless some other patch changes
> the idmap and swapper, I can count maximum 7 pages in total.
>

The preceding patch moves the fixmap page tables to this region as well.
But the logic is still incorrect -> we only need 16x for 4 levels (7 +
3 == 10), the remaining ones are all <= 8

>> +
>>  SECTIONS
>>  {
>>       /*
>> @@ -160,7 +171,7 @@ SECTIONS
>>
>>       BSS_SECTION(0, 0, 0)
>>
>> -     .pgdir (NOLOAD) : ALIGN(PAGE_SIZE) {
>> +     .pgdir (NOLOAD) : ALIGN(PGDIR_ALIGN) {
>>               idmap_pg_dir = .;
>>               . += IDMAP_DIR_SIZE;
>>               swapper_pg_dir = .;
>> @@ -185,6 +196,11 @@ ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
>>       "ID map text too big or misaligned")
>>
>>  /*
>> + * Check that the chosen PGDIR_ALIGN value if sufficient.
>> + */
>> +ASSERT(SIZEOF(.pgdir) < ALIGNOF(.pgdir), ".pgdir size exceeds its alignment")
>> +
>> +/*
>>   * If padding is applied before .head.text, virt<->phys conversions will fail.
>>   */
>>  ASSERT(_text == (PAGE_OFFSET + TEXT_OFFSET), "HEAD is misaligned")
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index c27ab20a5ba9..93e5a2497f01 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -380,26 +380,68 @@ static void __init bootstrap_early_mapping(unsigned long addr,
>>       }
>>  }
>>
>> +static void __init bootstrap_linear_mapping(unsigned long va_offset)
>> +{
>> +     /*
>> +      * Bootstrap the linear range that covers swapper_pg_dir so that the
>> +      * statically allocated page tables as well as newly allocated ones
>> +      * are accessible via the linear mapping.
>> +      */
>
> Just move the comment outside the function.
>

OK

>> +     static struct bootstrap_pgtables linear_bs_pgtables __pgdir;
>> +     const phys_addr_t swapper_phys = __pa(swapper_pg_dir);
>> +     unsigned long swapper_virt = __phys_to_virt(swapper_phys) + va_offset;
>> +     struct memblock_region *reg;
>> +
>> +     bootstrap_early_mapping(swapper_virt, &linear_bs_pgtables,
>> +                             IS_ENABLED(CONFIG_ARM64_64K_PAGES));
>> +
>> +     /* now find the memblock that covers swapper_pg_dir, and clip */
>> +     for_each_memblock(memory, reg) {
>> +             phys_addr_t start = reg->base;
>> +             phys_addr_t end = start + reg->size;
>> +             unsigned long vstart, vend;
>> +
>> +             if (start > swapper_phys || end <= swapper_phys)
>> +                     continue;
>> +
>> +#ifdef CONFIG_ARM64_64K_PAGES
>> +             /* clip the region to PMD size */
>> +             vstart = max(swapper_virt & PMD_MASK,
>> +                          round_up(__phys_to_virt(start + va_offset),
>> +                                   PAGE_SIZE));
>> +             vend = min(round_up(swapper_virt, PMD_SIZE),
>> +                        round_down(__phys_to_virt(end + va_offset),
>> +                                   PAGE_SIZE));
>> +#else
>> +             /* clip the region to PUD size */
>> +             vstart = max(swapper_virt & PUD_MASK,
>> +                          round_up(__phys_to_virt(start + va_offset),
>> +                                   PMD_SIZE));
>> +             vend = min(round_up(swapper_virt, PUD_SIZE),
>> +                        round_down(__phys_to_virt(end + va_offset),
>> +                                   PMD_SIZE));
>> +#endif
>> +
>> +             create_mapping(__pa(vstart - va_offset), vstart, vend - vstart,
>> +                            PAGE_KERNEL_EXEC);
>> +
>> +             /*
>> +              * Temporarily limit the memblock range. We need to do this as
>> +              * create_mapping requires puds, pmds and ptes to be allocated
>> +              * from memory addressable from the early linear mapping.
>> +              */
>> +             memblock_set_current_limit(__pa(vend - va_offset));
>> +
>> +             return;
>> +     }
>> +     BUG();
>> +}
>
> I'll probably revisit this function after I see the whole series. But in
> the meantime, if the kernel is not loaded in the first memblock (in
> address order), isn't there a risk that we allocate memory from the
> first memblock which is not mapped yet?
>

memblock allocates top down, so it should only allocate from this
region, unless the remaining room is completely reserved. I think that
is a theoretical problem which exists currently as well, i.e., the
boot protocol does not mandate that the 512MB/1GB region containing
the kernel contains unreserved room.

-- 
Ard.
