From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 2 May 2014 10:21:57 +0100
Subject: [PATCH] arm64: mm: Create gigabyte kernel logical mappings where
 possible
In-Reply-To: <20140502085119.GA456@arm.com>
References: <1398857782-1525-1-git-send-email-steve.capper@linaro.org>
 <20140502085119.GA456@arm.com>
Message-ID: <20140502092156.GB30999@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 09:51:21AM +0100, Catalin Marinas wrote:
> On Wed, Apr 30, 2014 at 12:36:22PM +0100, Steve Capper wrote:
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 4d29332..867e979 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -234,7 +234,20 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
> >  	pud = pud_offset(pgd, addr);
> >  	do {
> >  		next = pud_addr_end(addr, end);
> > -		alloc_init_pmd(pud, addr, next, phys);
> > +
> > +		/*
> > +		 * For 4K granule only, attempt to put down a 1GB block
> > +		 */
> > +		if ((PAGE_SHIFT == 12) &&
> > +			((addr | next | phys) & ~PUD_MASK) == 0) {
> > +			pud_t old_pud = *pud;
> > +			set_pud(pud, __pud(phys | prot_sect_kernel));
> > +
> > +			if (!pud_none(old_pud))
> > +				flush_tlb_all();
> 
> We could even free the original pmd here. I think a
> memblock_free(pud_pfn(old_pud) << PAGE_SHIFT, PAGE_SIZE) should do
> (untested, and you need to define pud_pfn).

I see what you mean, we will potentially have an unused page in our
swapper_pg_dir array.

I'll have a think, and add some logic to remove the redundant page.

Cheers,
-- 
Steve

> 
> -- 
> Catalin
