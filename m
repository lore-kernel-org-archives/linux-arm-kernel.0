From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 8 May 2015 17:03:37 +0200
Subject: [PATCH v4 09/13] arm64: mm: explicitly bootstrap the linear
 mapping
In-Reply-To: <20150508144448.GE12601@e104818-lin.cambridge.arm.com>
References: <1429112064-19952-1-git-send-email-ard.biesheuvel@linaro.org>
 <1429112064-19952-10-git-send-email-ard.biesheuvel@linaro.org>
 <20150507165416.GB11067@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-26A1pawUoeY28mXb1WzhPv4O0Rh433Yj9uBjxFh0MWg@mail.gmail.com>
 <20150508144448.GE12601@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu9RFNpg8nTYzCNc2hE0kE2Cn8HEHebJ0AYXEyT08QC=Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2015 at 16:44, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, May 07, 2015 at 09:21:28PM +0200, Ard Biesheuvel wrote:
>> On 7 May 2015 at 18:54, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Wed, Apr 15, 2015 at 05:34:20PM +0200, Ard Biesheuvel wrote:
>> >> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> >> index ceec4def354b..338eaa7bcbfd 100644
>> >> --- a/arch/arm64/kernel/vmlinux.lds.S
>> >> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> >> @@ -68,6 +68,17 @@ PECOFF_FILE_ALIGNMENT = 0x200;
>> >>  #define ALIGN_DEBUG_RO_MIN(min)              . = ALIGN(min);
>> >>  #endif
>> >>
>> >> +/*
>> >> + * The pgdir region needs to be mappable using a single PMD or PUD sized region,
>> >> + * so it should not cross a 512 MB or 1 GB alignment boundary, respectively
>> >> + * (depending on page size). So align to an upper bound of its size.
>> >> + */
>> >> +#if CONFIG_ARM64_PGTABLE_LEVELS == 2
>> >> +#define PGDIR_ALIGN  (8 * PAGE_SIZE)
>> >> +#else
>> >> +#define PGDIR_ALIGN  (16 * PAGE_SIZE)
>> >> +#endif
>> >
>> > Isn't 8 pages sufficient in both cases? Unless some other patch changes
>> > the idmap and swapper, I can count maximum 7 pages in total.
>>
>> The preceding patch moves the fixmap page tables to this region as well.
>> But the logic is still incorrect -> we only need 16x for 4 levels (7 +
>> 3 == 10), the remaining ones are all <= 8
>
> You should improve the comment here to include the maths, "upper bound
> of its size" is not very clear ;).
>

Yes, you are right, it should read 'power-of-2 upper bound'

>> >> +     static struct bootstrap_pgtables linear_bs_pgtables __pgdir;
>> >> +     const phys_addr_t swapper_phys = __pa(swapper_pg_dir);
>> >> +     unsigned long swapper_virt = __phys_to_virt(swapper_phys) + va_offset;
>> >> +     struct memblock_region *reg;
>> >> +
>> >> +     bootstrap_early_mapping(swapper_virt, &linear_bs_pgtables,
>> >> +                             IS_ENABLED(CONFIG_ARM64_64K_PAGES));
>> >> +
>> >> +     /* now find the memblock that covers swapper_pg_dir, and clip */
>> >> +     for_each_memblock(memory, reg) {
>> >> +             phys_addr_t start = reg->base;
>> >> +             phys_addr_t end = start + reg->size;
>> >> +             unsigned long vstart, vend;
>> >> +
>> >> +             if (start > swapper_phys || end <= swapper_phys)
>> >> +                     continue;
>> >> +
>> >> +#ifdef CONFIG_ARM64_64K_PAGES
>> >> +             /* clip the region to PMD size */
>> >> +             vstart = max(swapper_virt & PMD_MASK,
>> >> +                          round_up(__phys_to_virt(start + va_offset),
>> >> +                                   PAGE_SIZE));
>> >> +             vend = min(round_up(swapper_virt, PMD_SIZE),
>> >> +                        round_down(__phys_to_virt(end + va_offset),
>> >> +                                   PAGE_SIZE));
>> >> +#else
>> >> +             /* clip the region to PUD size */
>> >> +             vstart = max(swapper_virt & PUD_MASK,
>> >> +                          round_up(__phys_to_virt(start + va_offset),
>> >> +                                   PMD_SIZE));
>> >> +             vend = min(round_up(swapper_virt, PUD_SIZE),
>> >> +                        round_down(__phys_to_virt(end + va_offset),
>> >> +                                   PMD_SIZE));
>> >> +#endif
>> >> +
>> >> +             create_mapping(__pa(vstart - va_offset), vstart, vend - vstart,
>> >> +                            PAGE_KERNEL_EXEC);
>> >> +
>> >> +             /*
>> >> +              * Temporarily limit the memblock range. We need to do this as
>> >> +              * create_mapping requires puds, pmds and ptes to be allocated
>> >> +              * from memory addressable from the early linear mapping.
>> >> +              */
>> >> +             memblock_set_current_limit(__pa(vend - va_offset));
>> >> +
>> >> +             return;
>> >> +     }
>> >> +     BUG();
>> >> +}
>> >
>> > I'll probably revisit this function after I see the whole series. But in
>> > the meantime, if the kernel is not loaded in the first memblock (in
>> > address order), isn't there a risk that we allocate memory from the
>> > first memblock which is not mapped yet?
>>
>> memblock allocates top down, so it should only allocate from this
>> region, unless the remaining room is completely reserved.
>
> I don't like to rely on this, it's not guaranteed behaviour.
>

Actually, it is. Allocation is always top-down unless you call
memblock_set_bottom_up(), which is a NOP  unless CONFIG_MOVABLE_NODE
is selected.
That is why the memblock limit only limits at the top afaict

>> I think that is a theoretical problem which exists currently as well,
>> i.e., the boot protocol does not mandate that the 512MB/1GB region
>> containing the kernel contains unreserved room.
>
> That's more of a documentation problem, we can make the requirements
> clearer. Debugging is probably easier as well, it fails to allocate
> memory. But for the other case, not placing the kernel in the first
> memblock has high chances of allocating unmapped memory.
>

The only way we could allocate unmapped memory is if the 512 MB /1 GB
sized/aligned intersection with the memblock covering the kernel is
completely reserved, either by the kernel or by other reservations.
Since UEFI allocates from the top as well, if the kernel is loaded
high and may end up such that there is little room between the start
of the kernel and the beginning of the intersection. Still quite
unlikely imo since it would mean that UEFI using hundreds of megabytes
of memory, and it isn't quite /that/ bad [yet :-)]

> Can we not have another set of level 2,3(,4) page tables pre-allocated
> in swapper for the first block (start of RAM)? It gets hairy, in total
> we would need:
>
> 1) idmap
> 2) swapper
>   2.a) kernel image outside the linear mapping
>   2.b) fixmap
>   2.c) start-of-ram
>   2.d) swapper mapping in the linear mapping
>
> Can we avoid accessing 2.d (swapper in linear mapping) until we finished
> mapping 2.c? Once we mapped the start of RAM and set the memblock limit,
> we can allocate pages to start mapping the rest.
>

I really don't think any of this is necessary tbh
