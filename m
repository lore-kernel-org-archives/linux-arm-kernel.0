From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Nov 2015 17:08:50 +0000
Subject: [PATCH RFT] arm64: kasan: Make KASAN work with 16K pages + 48
 bit VA
In-Reply-To: <56573615.8030604@virtuozzo.com>
References: <1448543686-31869-1-git-send-email-aryabinin@virtuozzo.com>
 <20151126144859.GE32343@leverpostej>
 <56572998.9070102@virtuozzo.com>
 <20151126162117.GH32343@leverpostej>
 <56573615.8030604@virtuozzo.com>
Message-ID: <20151126170850.GI32343@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>>> +		if (!pud_none(*pud))
> >>>> +			clear_pmds(pud, addr, next);
> >>>
> >>> I don't understand this. The KASAN shadow region is PUD_SIZE aligned at
> >>> either end, so KASAN should never own a partial pud entry like this.
> >>>
> >>> Regardless, were this case to occur, surely we'd be clearing pmd entries
> >>> in the active page tables? We didn't copy anything at the pmd level.
> >>>
> >>> That doesn't seem right.
> >>>
> >>
> >> Just take a look at p?d_clear() macroses, under CONFIG_PGTABLE_LEVELS=2 for example.
> >> pgd_clear() and pud_clear() is nops, and pmd_clear() is actually clears pgd.
> > 
> > I see. Thanks for pointing that out.
> > 
> > I detest the weird folding behaviour we have in the p??_* macros. It
> > violates least surprise almost every time.
> > 
> >> I could replace p?d_clear() with set_p?d(p?d, __p?d(0)).
> >> In that case going down to pmds is not needed, set_p?d() macro will do it for us.
> > 
> > I think it would be simpler to rely on the fact that we only use puds
> > with 4 levels of table (and hence the p??_* macros will operate at the
> > levels their names imply).
> > 
> 
> It's not only about puds.
> E.g. if we need to clear PGD with 2-level page tables, than we need to call pmd_clear().

Ah. Yes :(

I will reiterate that I hate the folding behaviour.

> So we should either leave this code as is, or switch to set_pgd/set_pud.

I think set_p?d is preferable.

> > We can verify that at build time with:
> > 
> > BUILD_BUG_ON(CONFIG_PGTABLE_LEVELS != 4 &&
> > 	     (!IS_ALIGNED(KASAN_SHADOW_START, PGDIR_SIZE) ||
> > 	      !IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE)));
> > 
> >>>> +static void copy_pagetables(void)
> >>>> +{
> >>>> +	pgd_t *pgd = tmp_pg_dir + pgd_index(KASAN_SHADOW_START);
> >>>> +
> >>>> +	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(tmp_pg_dir));
> >>>> +
> >>>>  	/*
> >>>> -	 * Remove references to kasan page tables from
> >>>> -	 * swapper_pg_dir. pgd_clear() can't be used
> >>>> -	 * here because it's nop on 2,3-level pagetable setups
> >>>> +	 * If kasan shadow shares PGD with other mappings,
> >>>> +	 * clear_page_tables() will clear puds instead of pgd,
> >>>> +	 * so we need temporary pud table to keep early shadow mapped.
> >>>>  	 */
> >>>> -	for (; start < end; start += PGDIR_SIZE)
> >>>> -		set_pgd(pgd_offset_k(start), __pgd(0));
> >>>> +	if (PGDIR_SIZE > KASAN_SHADOW_END - KASAN_SHADOW_START) {
> >>>> +		pud_t *pud;
> >>>> +		pmd_t *pmd;
> >>>> +		pte_t *pte;
> >>>> +
> >>>> +		memcpy(tmp_pud, pgd_page_vaddr(*pgd), sizeof(tmp_pud));
> >>>> +
> >>>> +		pgd_populate(&init_mm, pgd, tmp_pud);
> >>>> +		pud = pud_offset(pgd, KASAN_SHADOW_START);
> >>>> +		pmd = pmd_offset(pud, KASAN_SHADOW_START);
> >>>> +		pud_populate(&init_mm, pud, pmd);
> >>>> +		pte = pte_offset_kernel(pmd, KASAN_SHADOW_START);
> >>>> +		pmd_populate_kernel(&init_mm, pmd, pte);
> >>>
> >>> I don't understand why we need to do anything below the pud level here.
> >>> We only copy down to the pud level, and we already initialised the
> >>> shared ptes and pmds earlier.
> >>>
> >>> Regardless of this patch, we currently initialise the shared tables
> >>> repeatedly, which is redundant after the first time we initialise them.
> >>> We could improve that.
> >>>
> >>
> >> Sure, just pgd_populate() will work here, because this code is only for 16K+48-bit,
> >> which has 4-level pagetables.
> >> But it wouldn't work if 16k+48-bit would have > 4-level.
> >> Because pgd_populate() in nop in such case, so we need to go down to actually set 'tmp_pud'
> > 
> > I don't follow.
> > 
> > 16K + 48-bit will always require 4 levels given the page table format.
> > We never have more than 4 levels.
> > 
> 
> Oh, it should be '< 4' of course.
> Yes, 16K + 48-bit is always 4-levels, but I tried to not rely on this here.
> 
> But since we can rely on 4-levels here, I'm gonna leave only pgd_populate() and add you BUILD_BUG_ON().

Ok. That sounds good to me.

Thanks,
Mark.
