From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Oct 2016 08:48:28 +0100
Subject: [PATCH] arm64: mmu: set the contiguous for kernel mappings when
 appropriate
In-Reply-To: <20161011074419.GA20213@remoulade>
References: <1476123164-10532-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161011074419.GA20213@remoulade>
Message-ID: <20161011074827.GB20213@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 08:44:19AM +0100, Mark Rutland wrote:
> >  {
> > +	pgprot_t prot_cont = __pgprot(pgprot_val(prot) | PTE_CONT);
> > +	bool cont = false;
> >  	pte_t *pte;
> >  
> >  	BUG_ON(pmd_sect(*pmd));
> > @@ -115,7 +118,20 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
> >  
> >  	pte = pte_set_fixmap_offset(pmd, addr);
> >  	do {
> > -		set_pte(pte, pfn_pte(pfn, prot));
> > +		/*
> > +		 * Set the contiguous bit for the subsequent group of PTEs if
> > +		 * its size and alignment are suitable.
> > +		 */
> > +		if (((addr | PFN_PHYS(pfn)) & ~CONT_MASK) == 0)
> > +			cont = allow_block_mappings && end - addr >= CONT_SIZE;
> 
> Given we increment addr by PAGE_SIZE in the loop, isn't this only true for the
> first CONT_SIZE aligned entry, and not its (intended-to-be-contiguous)
> siblings?

Looking again, I'd mis-read the above; it will work as expected.

Sorry for the noise.

Thanks,
Mark.
