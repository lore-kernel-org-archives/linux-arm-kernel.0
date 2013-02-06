From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Feb 2013 15:16:38 +0000
Subject: [PATCH v4] ARM: LPAE: Fix mapping in alloc_init_pte for
 unaligned addresses
In-Reply-To: <511260FC.2090002@ti.com>
References: <1359472036-7613-1-git-send-email-r.sricharan@ti.com>
 <20130201162631.GG5151@arm.com>
 <CANOGCgOp=kSatDu8fL7grk+bXLQ2pgKAEvEK6LoG8Ba4mqUH=w@mail.gmail.com>
 <20130201163722.GH5151@arm.com>
 <CANOGCgMbzEWpJQE8PH2nS9_wa0DP_14E4=whGgKxWGJ_HpwomQ@mail.gmail.com>
 <20130201174246.GJ5151@arm.com> <510F3BA8.8070700@ti.com>
 <510F3CA3.7080604@ti.com> <20130206121523.GD26454@arm.com>
 <511260FC.2090002@ti.com>
Message-ID: <20130206151638.GG26454@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 01:56:12PM +0000, R Sricharan wrote:
> On Wednesday 06 February 2013 05:45 PM, Catalin Marinas wrote:
> > On Mon, Feb 04, 2013 at 04:44:19AM +0000, R Sricharan wrote:
> >>     I did a similar kind of patch in my V1 [1].
> >>      I should be using PMD_MASK instead of SECTION_MASK there, and
> >>     updated it in the next version.
> >>
> >>      [1] https://patchwork.kernel.org/patch/1272991/
> >
> > With regards to your current patch, I really don't think looping over
> > pmd in alloc_init_pte() is the right fix. The alloc_init_pte() function
> > gets a pmd argument and it is supposed to make it point to a pte and
> > populate that pte rather than populate a number of pmds.
> >
> > create_mapping() loops over pgds. alloc_init_pud() loops over puds
> > (well, we don't have any but we have the function for consistency).
> > alloc_init_section() should loop over pmds (we can even change the name
> > to alloc_init_pmd()).
> >
> > Your original patch from August was better as it kept the looping
> > consistent but as you said, it should be using pmd_addr_end(). We can
> > use something simpler like alloc_init_pmd() on arm64 and instead of
> > set_pmd() there just call a separate map_init_section() which for
> > 2-levels it sets both entries. This may address Russell's comment that
> > the resulting code was ugly.
> 
>   Thanks. So just to understand, you mean alloc_init_pmd loops over
>   map_init_section. map_init_section populates either one pmd
>   or calls alloc_init_pte. correct ? . I can send a v5 for this.

alloc_init_pmd() loops over pmd (similar to alloc_init_pud). If
(type->prot_sect && ((addr | next | phys) & ~SECTION_MASK) == 0) you
call a map_init_section (whatever name you think is better) function
which contains the current section code from alloc_init_section().
Something like below (easier than explaining):

static void __init map_init_section(pmd_t *pmd, unsigned long addr,
				    unsigned long end, phys_addr_t phys,
				    const struct mem_type *type)
{
#ifndef CONFIG_ARM_LPAE
	if (addr & SECTION_SIZE)
		pmd++;
#endif

	do {
		*pmd = __pmd(phys | type->prot_sect);
		phys += SECTION_SIZE;
	} while (pmd++, addr += SECTION_SIZE, addr != end);

	flush_pmd_entry(p);
}

Pretty much avoiding the indentation level in alloc_init_section() with
multiple loops.

> > The problem with the classic MMU is that if we have a 1MB range we can
> > end up with just page mappings. The code is currently buggy since if we
> > have create_mapping() for a 1MB range and later create_mapping() for a
> > 4KB in the next MB, the first 1MB is removed.
>
>   Ok, so in that case we will have a BUG_ON(pmd_bad) right?

Yes, you are right, the BUG_ON(pmd_bad) should catch this. The other
scenario (4K mapping followed by 1M) wouldn't be but it's relatively
safe as we don't override any entry.

-- 
Catalin
