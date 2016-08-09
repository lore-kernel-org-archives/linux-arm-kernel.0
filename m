From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 9 Aug 2016 18:51:58 +0100
Subject: [PATCH] arm64: suspend: avoid potential TLB conflict
In-Reply-To: <57AA0401.1020809@arm.com>
References: <1470651050-18291-1-git-send-email-mark.rutland@arm.com>
 <57AA0401.1020809@arm.com>
Message-ID: <20160809175157.GC13591@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 05:25:37PM +0100, James Morse wrote:
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

Hmmm... given that, it looks like if we bail out in swsusp_arch_resume()
after the call to create_safe_exec_page(), we may return to userspace
with a corrupted TTBR0.

We probably need to defer the call to create_safe_exec_page() after the
other potential failure sites so as to avoid that.

Looking around it's not clear to me how/where the get_safe_page()
allocations are cleaned up when a failure occurs.

Thanks,
Mark.
