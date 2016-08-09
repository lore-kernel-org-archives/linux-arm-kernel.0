From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 9 Aug 2016 17:49:53 +0100
Subject: [PATCH] arm64: suspend: avoid potential TLB conflict
In-Reply-To: <57AA0401.1020809@arm.com>
References: <1470651050-18291-1-git-send-email-mark.rutland@arm.com>
 <57AA0401.1020809@arm.com>
Message-ID: <20160809164953.GA13591@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 05:25:37PM +0100, James Morse wrote:
> Hi Mark,
> 
> ~s/suspend/hibernate/ in the subject?

Ah, yes. I'll fix that up.

> >  /*
> > @@ -217,12 +218,16 @@ static int create_safe_exec_page(void *src_start, size_t length,
> >  	set_pte(pte, __pte(virt_to_phys((void *)dst) |
> >  			 pgprot_val(PAGE_KERNEL_EXEC)));
> >  
> > -	/* Load our new page tables */
> > -	asm volatile("msr	ttbr0_el1, %0;"
> > -		     "isb;"
> > -		     "tlbi	vmalle1is;"
> > -		     "dsb	ish;"
> > -		     "isb" : : "r"(virt_to_phys(pgd)));
> > +	/*
> > +	 * Load our new page tables. TTBR0 currently points to the zero page,
> 
> fe12c00d21bb ("PM / hibernate: Introduce test_resume mode for hibernation") came
> in with the merge window, this does a suspend followed by a resume with the user
> page tables still loaded in ttbr0_el1.
> 
> So now we need to call cpu_set_reserved_ttbr0() in here to make this true/safe.

Thanks for the heads-up!

>From a quick look, that sounds like the right thing to do.

> > +	 * and the TLBs should be free of global entries, but may contain stale
> > +	 * ASID-tagged entries (e.g. from the EFI runtime services). A strict
> > +	 * BBM approach requires that we destroy these before installing
> > +	 * overlapping global mappings.
> > +	 */
> > +	local_flush_tlb_all();
> > +	write_sysreg(virt_to_phys(pgd), ttbr0_el1);
> > +	isb();
> >  
> >  	*phys_dst_addr = virt_to_phys((void *)dst);
> 
> and it even looks better!
> 
> If you think they're useful:
> Tested-by: James Morse <james.morse@arm.com>
> Acked-by: James Morse <james.morse@arm.com>

Cheers!

I assume those apply with the addition of cpu_set_reserved_ttbr0(),
which I'll fold into v2 along with them.

Thanks,
Mark.
