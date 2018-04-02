From: neelx@redhat.com (Daniel Vacek)
Date: Mon, 2 Apr 2018 10:43:59 +0200
Subject: [PATCH v5 2/5] arm: arm64: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
In-Reply-To: <CAKv+Gu8=6adUTGMna45ZnJhRhqkW_gU5T1WZaVRDOF0S5uEFgQ@mail.gmail.com>
References: <1522636236-12625-1-git-send-email-hejianet@gmail.com>
 <1522636236-12625-3-git-send-email-hejianet@gmail.com>
 <CAKv+Gu8=6adUTGMna45ZnJhRhqkW_gU5T1WZaVRDOF0S5uEFgQ@mail.gmail.com>
Message-ID: <CACjP9X_WTVA8dqdiSmf91VchkGm+qGyGWv7R9MmuCui+uFzunQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2018 at 8:57 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 2 April 2018 at 04:30, Jia He <hejianet@gmail.com> wrote:
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") optimized the loop in memmap_init_zone(). But there is
>> still some room for improvement. E.g. if pfn and pfn+1 are in the same
>> memblock region, we can simply pfn++ instead of doing the binary search
>> in memblock_next_valid_pfn.
>>
>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>> ---
>>  arch/arm/include/asm/page.h   |  1 +
>>  arch/arm/mm/init.c            | 28 ++++++++++++++++++++++------
>>  arch/arm64/include/asm/page.h |  1 +
>>  arch/arm64/mm/init.c          | 28 ++++++++++++++++++++++------
>>  4 files changed, 46 insertions(+), 12 deletions(-)
>>
>
> Could we put this in a shared file somewhere? This is the second patch
> where you put make identical changes to ARM and arm64.

Ard, I was wondering if we can actually have this changed to something
like CONFIG_MEMBLOCK_PFN_VALID and shared instead of it being arm
specific? Is there a reason it's only usable for arm? The rest is
dependent on this, hence I suggested to place it close-by. But
generalizing it all would make it a lot cleaner.

arch/arm/mm/init.c:196:
#ifdef CONFIG_HAVE_ARCH_PFN_VALID
int pfn_valid(unsigned long pfn)
{
        return memblock_is_map_memory(__pfn_to_phys(pfn));
}
EXPORT_SYMBOL(pfn_valid);
#endif

arch/arm64/mm/init.c:287:
#ifdef CONFIG_HAVE_ARCH_PFN_VALID
int pfn_valid(unsigned long pfn)
{
        return memblock_is_map_memory(pfn << PAGE_SHIFT);
}
EXPORT_SYMBOL(pfn_valid);
#endif

--nX

>> diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
>> index 489875c..f38909c 100644
>> --- a/arch/arm/include/asm/page.h
>> +++ b/arch/arm/include/asm/page.h
>> @@ -157,6 +157,7 @@ extern void copy_page(void *to, const void *from);
>>  typedef struct page *pgtable_t;
>>
>>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>> +extern int early_region_idx;
>>  extern int pfn_valid(unsigned long);
>>  extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
>>  #define skip_to_last_invalid_pfn(pfn) (memblock_next_valid_pfn(pfn) - 1)
>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>> index 0fb85ca..06ed190 100644
>> --- a/arch/arm/mm/init.c
>> +++ b/arch/arm/mm/init.c
>> @@ -193,6 +193,8 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
>>  }
>>
>>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>> +int early_region_idx __meminitdata = -1;
>> +
>>  int pfn_valid(unsigned long pfn)
>>  {
>>         return memblock_is_map_memory(__pfn_to_phys(pfn));
>> @@ -203,28 +205,42 @@ EXPORT_SYMBOL(pfn_valid);
>>  unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
>>  {
>>         struct memblock_type *type = &memblock.memory;
>> +       struct memblock_region *regions = type->regions;
>>         unsigned int right = type->cnt;
>>         unsigned int mid, left = 0;
>> +       unsigned long start_pfn, end_pfn;
>>         phys_addr_t addr = PFN_PHYS(++pfn);
>>
>> +       /* fast path, return pfn+1 if next pfn is in the same region */
>> +       if (early_region_idx != -1) {
>> +               start_pfn = PFN_DOWN(regions[early_region_idx].base);
>> +               end_pfn = PFN_DOWN(regions[early_region_idx].base +
>> +                               regions[early_region_idx].size);
>> +
>> +               if (pfn >= start_pfn && pfn < end_pfn)
>> +                       return pfn;
>> +       }
>> +
>> +       /* slow path, do the binary searching */
>>         do {
>>                 mid = (right + left) / 2;
>>
>> -               if (addr < type->regions[mid].base)
>> +               if (addr < regions[mid].base)
>>                         right = mid;
>> -               else if (addr >= (type->regions[mid].base +
>> -                                 type->regions[mid].size))
>> +               else if (addr >= (regions[mid].base + regions[mid].size))
>>                         left = mid + 1;
>>                 else {
>> -                       /* addr is within the region, so pfn is valid */
>> +                       early_region_idx = mid;
>>                         return pfn;
>>                 }
>>         } while (left < right);
>>
>>         if (right == type->cnt)
>>                 return -1UL;
>> -       else
>> -               return PHYS_PFN(type->regions[right].base);
>> +
>> +       early_region_idx = right;
>> +
>> +       return PHYS_PFN(regions[early_region_idx].base);
>>  }
>>  EXPORT_SYMBOL(memblock_next_valid_pfn);
>>  #endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
>> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
>> index e57d3f2..f0d8c8e5 100644
>> --- a/arch/arm64/include/asm/page.h
>> +++ b/arch/arm64/include/asm/page.h
>> @@ -38,6 +38,7 @@ extern void clear_page(void *to);
>>  typedef struct page *pgtable_t;
>>
>>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>> +extern int early_region_idx;
>>  extern int pfn_valid(unsigned long);
>>  extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
>>  #define skip_to_last_invalid_pfn(pfn) (memblock_next_valid_pfn(pfn) - 1)
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 13e43ff..342e4e2 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -285,6 +285,8 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>>  #endif /* CONFIG_NUMA */
>>
>>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>> +int early_region_idx __meminitdata = -1;
>> +
>>  int pfn_valid(unsigned long pfn)
>>  {
>>         return memblock_is_map_memory(pfn << PAGE_SHIFT);
>> @@ -295,28 +297,42 @@ EXPORT_SYMBOL(pfn_valid);
>>  unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
>>  {
>>         struct memblock_type *type = &memblock.memory;
>> +       struct memblock_region *regions = type->regions;
>>         unsigned int right = type->cnt;
>>         unsigned int mid, left = 0;
>> +       unsigned long start_pfn, end_pfn;
>>         phys_addr_t addr = PFN_PHYS(++pfn);
>>
>> +       /* fast path, return pfn+1 if next pfn is in the same region */
>> +       if (early_region_idx != -1) {
>> +               start_pfn = PFN_DOWN(regions[early_region_idx].base);
>> +               end_pfn = PFN_DOWN(regions[early_region_idx].base +
>> +                               regions[early_region_idx].size);
>> +
>> +               if (pfn >= start_pfn && pfn < end_pfn)
>> +                       return pfn;
>> +       }
>> +
>> +       /* slow path, do the binary searching */
>>         do {
>>                 mid = (right + left) / 2;
>>
>> -               if (addr < type->regions[mid].base)
>> +               if (addr < regions[mid].base)
>>                         right = mid;
>> -               else if (addr >= (type->regions[mid].base +
>> -                                 type->regions[mid].size))
>> +               else if (addr >= (regions[mid].base + regions[mid].size))
>>                         left = mid + 1;
>>                 else {
>> -                       /* addr is within the region, so pfn is valid */
>> +                       early_region_idx = mid;
>>                         return pfn;
>>                 }
>>         } while (left < right);
>>
>>         if (right == type->cnt)
>>                 return -1UL;
>> -       else
>> -               return PHYS_PFN(type->regions[right].base);
>> +
>> +       early_region_idx = right;
>> +
>> +       return PHYS_PFN(regions[early_region_idx].base);
>>  }
>>  EXPORT_SYMBOL(memblock_next_valid_pfn);
>>  #endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
>> --
>> 2.7.4
>>
