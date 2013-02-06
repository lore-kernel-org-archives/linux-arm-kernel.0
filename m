From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Feb 2013 12:15:23 +0000
Subject: [PATCH v4] ARM: LPAE: Fix mapping in alloc_init_pte for
 unaligned addresses
In-Reply-To: <510F3CA3.7080604@ti.com>
References: <1359472036-7613-1-git-send-email-r.sricharan@ti.com>
 <20130201162631.GG5151@arm.com>
 <CANOGCgOp=kSatDu8fL7grk+bXLQ2pgKAEvEK6LoG8Ba4mqUH=w@mail.gmail.com>
 <20130201163722.GH5151@arm.com>
 <CANOGCgMbzEWpJQE8PH2nS9_wa0DP_14E4=whGgKxWGJ_HpwomQ@mail.gmail.com>
 <20130201174246.GJ5151@arm.com> <510F3BA8.8070700@ti.com>
 <510F3CA3.7080604@ti.com>
Message-ID: <20130206121523.GD26454@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 04:44:19AM +0000, R Sricharan wrote:
> On Monday 04 February 2013 10:10 AM, R Sricharan wrote:
> >> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> >> index 9f06102..47154f3 100644
> >> --- a/arch/arm/mm/mmu.c
> >> +++ b/arch/arm/mm/mmu.c
> >> @@ -581,34 +581,36 @@ static void __init alloc_init_section(pud_t
> >> *pud, unsigned long addr,
> >>                         const struct mem_type *type)
> >>   {
> >>       pmd_t *pmd = pmd_offset(pud, addr);
> >> +    unsigned long next;
> >>
> >> -    /*
> >> -     * Try a section mapping - end, addr and phys must all be aligned
> >> -     * to a section boundary.  Note that PMDs refer to the individual
> >> -     * L1 entries, whereas PGDs refer to a group of L1 entries making
> >> -     * up one logical pointer to an L2 table.
> >> -     */
> >> -    if (type->prot_sect && ((addr | end | phys) & ~SECTION_MASK) == 0) {
> >> -        pmd_t *p = pmd;
> >> +    do {
> >> +        next = pmd_addr_end(addr, end);
> >> +
> >> +        /*
> >> +         * Try a section mapping - next, addr and phys must all be
> >> +         * aligned to a section boundary.  Note that PMDs refer to the
> >> +         * individual L1 entries, whereas PGDs refer to a group of L1
> >> +         * entries making up one logical pointer to an L2 table.
> >> +         */
> >> +        if (((addr | next | phys) & ~SECTION_MASK) == 0) {
> >> +            pmd_t *p = pmd;
> >>
> >     There is a  need to do page mappings even when all the addresses
> >     are aligned. This was added with CMA, which required the initial
> >     mappings to be set with 2 level tables.
> >
>     Sorry, i wanted to ask type->prot_sect is removed here and is that
>    intentional?

No, I just forgot about it.

>    I did a similar kind of patch in my V1 [1].
>     I should be using PMD_MASK instead of SECTION_MASK there, and
>    updated it in the next version.
> 
>     [1] https://patchwork.kernel.org/patch/1272991/

With regards to your current patch, I really don't think looping over
pmd in alloc_init_pte() is the right fix. The alloc_init_pte() function
gets a pmd argument and it is supposed to make it point to a pte and
populate that pte rather than populate a number of pmds.

create_mapping() loops over pgds. alloc_init_pud() loops over puds
(well, we don't have any but we have the function for consistency).
alloc_init_section() should loop over pmds (we can even change the name
to alloc_init_pmd()).

Your original patch from August was better as it kept the looping
consistent but as you said, it should be using pmd_addr_end(). We can
use something simpler like alloc_init_pmd() on arm64 and instead of
set_pmd() there just call a separate map_init_section() which for
2-levels it sets both entries. This may address Russell's comment that
the resulting code was ugly.

The problem with the classic MMU is that if we have a 1MB range we can
end up with just page mappings. The code is currently buggy since if we
have create_mapping() for a 1MB range and later create_mapping() for a
4KB in the next MB, the first 1MB is removed.

-- 
Catalin
