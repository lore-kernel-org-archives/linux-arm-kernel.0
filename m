From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 23 Mar 2017 20:43:10 +0900
Subject: [PATCH v33 05/14] arm64: mm: allow for unmapping part of kernel
 mapping
In-Reply-To: <58D10209.1090406@arm.com>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <20170315095941.25119-3-takahiro.akashi@linaro.org>
 <58D10209.1090406@arm.com>
Message-ID: <20170323114309.GE17298@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 10:35:53AM +0000, James Morse wrote:
> Hi Akashi,
> 
> On 15/03/17 09:59, AKASHI Takahiro wrote:
> > create_pgd_mapping() is enhanced here so that it will accept
> > PAGE_KERNEL_INVALID protection attribute and unmap a given range of memory.
> > 
> > The feature will be used in a later kdump patch to implement the protection
> > against possible corruption of crash dump kernel memory which is to be set
> > aside from ther other memory on primary kernel.
> 
> Nit: ther- > the

Fix it.

> > Note that, in this implementation, it assumes that all the range of memory
> > to be processed is mapped in page-level since the only current user is
> > kdump where page mappings are also required.
> 
> Using create_pgd_mapping() like this means the mappings will be updated via the
> fixmap which is unnecessary as the page tables will be part of mapped memory. In

This might be a reason that we would go for (un)map_kernel_range()
over create_pgd_mapping() (? not sure)

> the worst case this adds an extra tlbi for every 2MB of crash image when we map
> or unmap it. I don't think this matters.
> 
> This code used to be __init and it is the only user of FIX_PTE, so there won't
> be any existing runtime users. The two arch_kexec_unprotect_crashkres() calls in
> kexec are both protected by the kexec_mutex, and the call in hibernate happens
> after disable_nonboot_cpus(), so these callers can't race with each other.
> 
> This looks safe to me.
> 
> 
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index d28dbcf596b6..cb359a3927ef 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -128,7 +128,10 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
> >  	do {
> >  		pte_t old_pte = *pte;
> >  
> > -		set_pte(pte, pfn_pte(pfn, prot));
> > +		if (pgprot_val(prot))
> > +			set_pte(pte, pfn_pte(pfn, prot));
> > +		else
> > +			pte_clear(null, null, pte);
> 
> Lowercase NULLs? This relies on these values never being used... __set_fixmap()
> in the same file passes &init_mm and the address, can we do the same to be
> consistent?

OK.

Thanks,
-Takahiro AKASHI

> 
> >  		pfn++;
> >  
> >  		/*
> 
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> 
> Thanks,
> 
> James
> 
> 
