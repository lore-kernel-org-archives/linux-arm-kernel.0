From: chris@cloudcar.com (Christoffer Dall)
Date: Fri, 1 Feb 2013 11:40:35 -0500
Subject: [PATCH v4] ARM: LPAE: Fix mapping in alloc_init_pte for unaligned
 addresses
In-Reply-To: <20130201163722.GH5151@arm.com>
References: <1359472036-7613-1-git-send-email-r.sricharan@ti.com>
 <20130201162631.GG5151@arm.com>
 <CANOGCgOp=kSatDu8fL7grk+bXLQ2pgKAEvEK6LoG8Ba4mqUH=w@mail.gmail.com>
 <20130201163722.GH5151@arm.com>
Message-ID: <CANOGCgMbzEWpJQE8PH2nS9_wa0DP_14E4=whGgKxWGJ_HpwomQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 1, 2013 at 11:37 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Fri, Feb 01, 2013 at 04:32:54PM +0000, Christoffer Dall wrote:
>> On Fri, Feb 1, 2013 at 11:26 AM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > On Tue, Jan 29, 2013 at 03:07:16PM +0000, R Sricharan wrote:
>> >> With LPAE enabled, alloc_init_section() does not map the
>> >> entire address space for unaligned addresses.
>> >>
>> >> The issue also reproduced with CMA + LPAE. CMA tries to map 16MB
>> >> with page granularity mappings during boot. alloc_init_pte()
>> >> is called and out of 16MB, only 2MB gets mapped and rest remains
>> >> unaccessible.
>> >>
>> >> Because of this OMAP5 boot is broken with CMA + LPAE enabled.
>> >> Fix the issue by ensuring that the entire addresses are
>> >> mapped.
>> >>
>> >> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> >> Cc: Christoffer Dall <chris@cloudcar.com>
>> >> Cc: Russell King <linux@arm.linux.org.uk>
>> >> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> >> Tested-by: Christoffer Dall  <chris@cloudcar.com>
>> >> ---
>> >>  [V2] Moved the loop to alloc_init_pte as per Russell's
>> >>      feedback and changed the subject accordingly.
>> >>      Using PMD_XXX instead of SECTION_XXX to avoid
>> >>      different loop increments with/without LPAE.
>> >>
>> >>  [v3] Removed the dummy variable phys and updated
>> >>       the commit log for CMA case.
>> >>
>> >>  [v4] Resending with updated change log and
>> >>       updating the tags.
>> >>
>> >>  arch/arm/mm/mmu.c |   20 ++++++++++++++++----
>> >>  1 file changed, 16 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> >> index f8388ad..b94c313 100644
>> >> --- a/arch/arm/mm/mmu.c
>> >> +++ b/arch/arm/mm/mmu.c
>> >> @@ -569,11 +569,23 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
>> >>                                 unsigned long end, unsigned long pfn,
>> >>                                 const struct mem_type *type)
>> >>  {
>> >> -     pte_t *pte = early_pte_alloc(pmd, addr, type->prot_l1);
>> >> +     unsigned long next;
>> >> +     pte_t *pte;
>> >> +
>> >>       do {
>> >> -             set_pte_ext(pte, pfn_pte(pfn, __pgprot(type->prot_pte)), 0);
>> >> -             pfn++;
>> >> -     } while (pte++, addr += PAGE_SIZE, addr != end);
>> >> +             if ((end-addr) & PMD_MASK)
>> >> +                     next = (addr + PMD_SIZE) & PMD_MASK;
>> >> +             else
>> >> +                     next = end;
>> >
>> > Can use pmd_addr_end(addr, end) here?
>> >
>> >> +             pte = early_pte_alloc(pmd, addr, type->prot_l1);
>> >> +             do {
>> >> +                     set_pte_ext(pte, pfn_pte(pfn,
>> >> +                                     __pgprot(type->prot_pte)), 0);
>> >> +                     pfn++;
>> >> +             } while (pte++, addr += PAGE_SIZE, addr != next);
>> >> +
>> >> +     } while (pmd++, addr = next, addr != end);
>> >
>> > I would actually keep the loop in alloc_init_section(). There is even a
>> > comment in there saying "no need to loop" but you actually moved the
>> > loop in alloc_init_pte().
>> >
>> > I'm proposing a simpler patch below (only lightly tested on VE/C-A9).
>> > The only difference is that we do more flush_pmd_entry() calls but I'm
>> > not really bothered, it's during boot and you won't notice.
>> >
>> >
>> > diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
>> > index 9c82f98..eaa8ba8 100644
>> > --- a/arch/arm/include/asm/pgtable.h
>> > +++ b/arch/arm/include/asm/pgtable.h
>> > @@ -205,6 +205,11 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
>> >
>> >  #define pte_present_user(pte)  (pte_present(pte) && (pte_val(pte) & L_PTE_USER))
>> >
>> > +#define section_addr_end(addr, end)                                            \
>> > +({     unsigned long __boundary = ((addr) + SECTION_SIZE) & SECTION_MASK;      \
>> > +       (__boundary - 1 < (end) - 1)? __boundary: (end);                        \
>> > +})
>> > +
>> >  #if __LINUX_ARM_ARCH__ < 6
>> >  static inline void __sync_icache_dcache(pte_t pteval)
>> >  {
>> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> > index 9f06102..0d0faed 100644
>> > --- a/arch/arm/mm/mmu.c
>> > +++ b/arch/arm/mm/mmu.c
>> > @@ -581,34 +581,19 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
>> >                                       const struct mem_type *type)
>> >  {
>> >         pmd_t *pmd = pmd_offset(pud, addr);
>> > +       unsigned long next;
>> >
>> > -       /*
>> > -        * Try a section mapping - end, addr and phys must all be aligned
>> > -        * to a section boundary.  Note that PMDs refer to the individual
>> > -        * L1 entries, whereas PGDs refer to a group of L1 entries making
>> > -        * up one logical pointer to an L2 table.
>> > -        */
>> > -       if (type->prot_sect && ((addr | end | phys) & ~SECTION_MASK) == 0) {
>> > -               pmd_t *p = pmd;
>> > -
>> > -#ifndef CONFIG_ARM_LPAE
>> > -               if (addr & SECTION_SIZE)
>> > -                       pmd++;
>> > -#endif
>> > -
>> > -               do {
>> > +       do {
>> > +               next = section_addr_end(addr, end);
>> > +               /* try section mapping first */
>> > +               if (((addr | next | phys) & ~SECTION_MASK) == 0) {
>> >                         *pmd = __pmd(phys | type->prot_sect);
>> > -                       phys += SECTION_SIZE;
>> > -               } while (pmd++, addr += SECTION_SIZE, addr != end);
>> > -
>> > -               flush_pmd_entry(p);
>> > -       } else {
>> > -               /*
>> > -                * No need to loop; pte's aren't interested in the
>> > -                * individual L1 entries.
>> > -                */
>> > -               alloc_init_pte(pmd, addr, end, __phys_to_pfn(phys), type);
>> > -       }
>> > +                       flush_pmd_entry(pmd);
>> > +               } else {
>> > +                       alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys), type);
>>
>> aren't you wasting memory here? The pte doesn't alloc a full page, but
>> the memblock allocator allocates a full page right?
>>
>> I thought this was the rationale behind Russell's previous comments on
>> Santosh's earlier patch version.
>
> You are right, it's allocating more ptes. Than we can use pmd_addr_end.
> I'll go back to the code.
>
don't get me wrong, I strongly prefer keeping that loop in
alloc_init_section, the other way it was weird to read, felt like
shoehorning something, but you may have to keep a pointer around for
unused part of a page for pte or something, not sure what ends up
being nicest.

-Christoffer
