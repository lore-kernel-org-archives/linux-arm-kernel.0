From: toshi.kani@hpe.com (Kani, Toshi)
Date: Tue, 15 May 2018 16:34:24 +0000
Subject: [PATCH 2/3] x86/mm: add TLB purge to free pmd/pte page interfaces
In-Reply-To: <20180515140549.GE18595@8bytes.org>
References: <20180430175925.2657-1-toshi.kani@hpe.com>
 <20180430175925.2657-3-toshi.kani@hpe.com>
 <20180515140549.GE18595@8bytes.org>
Message-ID: <1526401993.2693.605.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-05-15 at 16:05 +0200, Joerg Roedel wrote:
> On Mon, Apr 30, 2018 at 11:59:24AM -0600, Toshi Kani wrote:
> >  int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> >  {
> > -	pmd_t *pmd;
> > +	pmd_t *pmd, *pmd_sv;
> > +	pte_t *pte;
> >  	int i;
> >  
> >  	if (pud_none(*pud))
> >  		return 1;
> >  
> >  	pmd = (pmd_t *)pud_page_vaddr(*pud);
> > +	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
> 
> So you need to allocate a page to free a page? It is better to put the
> pages into a list with a list_head on the stack.

The code should have checked if pmd_sv is NULL...  I will update the
patch.

For performance, I do not think this page alloc is a problem.  Unlike
pmd_free_pte_page(), pud_free_pmd_page() covers an extremely rare case. 
  Since pud requires 1GB-alignment, pud and pmd/pte mappings do not
share the same ranges within the vmalloc space.  I had to instrument the
kernel to force them share the same ranges in order to test this patch.

> I am still on favour of just reverting the broken commit and do a
> correct and working fix for the/a merge window.

I will reorder the patch series, and change patch 3/3 to 1/3 so that we
can take it first to fix the BUG_ON on PAE.  This revert will disable
2MB ioremap on PAE in some cases, but I do not think it's important on
PAE anyway.

I do not think revert on x86/64 is necessary and I am more worried about
disabling 2MB ioremap in some cases, which can be seen as degradation. 
Patch 2/3 fixes a possible page-directory cache issue that I cannot hit
even though I put ioremap/iounmap with various sizes into a tight loop
for a day.

Thanks,
-Toshi
