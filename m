From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 13 Apr 2015 17:15:42 +0200
Subject: [PATCH v3 04/11] arm64: use fixmap region for permanent FDT
 mapping
In-Reply-To: <20150413150203.GF4076@leverpostej>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
 <1428674035-26603-5-git-send-email-ard.biesheuvel@linaro.org>
 <20150413150203.GF4076@leverpostej>
Message-ID: <CAKv+Gu8AmPU0iPYHsvG6Lbyi+ho_DBD1PG+8sOLYkTiHjF-ZtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 April 2015 at 17:02, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
>> -The device tree blob (dtb) must be placed on an 8-byte boundary within
>> -the first 512 megabytes from the start of the kernel image and must not
>> -cross a 2-megabyte boundary. This is to allow the kernel to map the
>> -blob using a single section mapping in the initial page tables.
>> +The device tree blob (dtb) must be placed on an 8-byte boundary and must
>> +not exceed 2 megabytes in size.
>>
>> +NOTE: versions prior to v4.2 also require that the dtb be placed within
>> +512 MB of the 2 MB aligned boundary right below the kernel Image.
>
> This reads a little odd (it sounds like you could load the DTB 512M
> below the boundary too).
>
> How about:
>
> NOTE: versions prior to v4.2 also require that the DTB be placed within
> the 512 MB region starting at text_offset bytes below the kernel Image.
>

OK

> [...]
>
>>  enum fixed_addresses {
>>       FIX_HOLE,
>> +
>> +     /*
>> +      * Reserve 4 MB of virtual space for the FDT at the top of the fixmap
>> +      * region. Keep this at the top so it remains 2 MB aligned.
>> +      */
>> +#define FIX_FDT_SIZE         SZ_4M
>> +     FIX_FDT_END,
>> +     FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
>> +
>>       FIX_EARLYCON_MEM_BASE,
>>       FIX_TEXT_POKE0,
>>       __end_of_permanent_fixed_addresses,
>
> [...]
>
>> +     /*
>> +      * Before passing the dt_virt pointer to early_init_dt_scan(), we have
>> +      * to ensure that the FDT size as reported in the FDT itself does not
>> +      * exceed the window we just mapped for it.
>> +      */
>> +     if (!dt_virt ||
>> +         fdt_check_header(dt_virt) != 0 ||
>> +         (dt_phys & (SZ_2M - 1)) + fdt_totalsize(dt_virt) > FIX_FDT_SIZE ||
>> +         !early_init_dt_scan(dt_virt)) {
>
> Doesn't this allow a DTB > 2M (violating the boot protocol's 2M
> restriction)?
>

Yes it does, and I was wondering what to do about it. We could be
pedantic, and fail here with no user visible feedback about what went
wrong, or we could be lax here, and add a warning later (similar to
the x1/x2/x3 check) that the boot protocol was violated if the FDT
exceeds 2 MB but otherwise proceed normally.

> Perhaps we want a MAX_FDT_SIZE, and have FIX_FDT_SIZE be MAX_FDT_SIZE +
> 2M. Then we can check that the DTB <= MAX_FDT_SIZE, and we know we will
> always be able to map it.
>
> Otherwise we could get intermittent failures for DTBs larger than 2MB,
> depending on where they're loaded. Always failing those for now would
> give us a consistent early warning that we need to bump MAX_FDT_SIZE.
>

Consistent, early, but emitted before we even have a console ...

> [...]
>
>> +void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
>> +{
>> +     const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
>> +     phys_addr_t dt_phys_base = dt_phys & ~(SZ_2M - 1);
>
> Do we definitely retain the high bits here? I don't have the C integer
> promotion rules paged into my head, but the definition in
> include/linux/sizes.h makes me suspicious, given it should have an int
> type:
>
> #define SZ_2M                           0x00200000
>

I will use round_down() instead

>> +     u64 pfn = dt_phys_base >> PAGE_SHIFT;
>> +     u64 pfn_end = pfn + (FIX_FDT_SIZE >> PAGE_SHIFT);
>> +     pgprot_t prot = PAGE_KERNEL | PTE_RDONLY;
>> +
>> +     /*
>> +      * Make sure that the FDT region can be mapped without the need to
>> +      * allocate additional translation table pages, or perform physical
>> +      * to virtual address translations via the linear mapping.
>> +      *
>> +      * On 4k pages, we'll use section mappings for the region so we
>> +      * only have to be in the same PUD as the rest of the fixmap.
>> +      * On 64k pages, we need to be in the same PMD as well, as the region
>> +      * will be mapped using PTEs.
>> +      */
>
> It would be nice to have the last two statements swapped (with
> appropriate wording fixups) to match the order of the if branches.
>

ok

> Otherwise this looks good to me.
>

thanks.

-- 
Ard.

>> +     BUILD_BUG_ON(dt_virt_base & (SZ_2M - 1));
>> +
>> +     if (IS_ENABLED(CONFIG_ARM64_64K_PAGES)) {
>> +             pte_t *pte;
>> +
>> +             BUILD_BUG_ON(__fix_to_virt(FIX_FDT_END) >> PMD_SHIFT !=
>> +                          __fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT);
>> +
>> +             /* map the FDT using 64k pages */
>> +             pte = fixmap_pte(dt_virt_base);
>> +             do {
>> +                     set_pte(pte++, pfn_pte(pfn++, prot));
>> +             } while (pfn < pfn_end);
>> +     } else {
>> +             pmd_t *pmd;
>> +
>> +             BUILD_BUG_ON(__fix_to_virt(FIX_FDT_END) >> PUD_SHIFT !=
>> +                          __fix_to_virt(FIX_BTMAP_BEGIN) >> PUD_SHIFT);
>> +
>> +             /* map the FDT using 2 MB sections */
>> +             pmd = fixmap_pmd(dt_virt_base);
>> +             do {
>> +                     set_pmd(pmd++, pfn_pmd(pfn, mk_sect_prot(prot)));
>> +                     pfn += PMD_SIZE >> PAGE_SHIFT;
>> +             } while (pfn < pfn_end);
>> +     }
>> +
>> +     return (void *)(dt_virt_base + dt_phys - dt_phys_base);
>> +}
>> --
>> 1.8.3.2
>>
