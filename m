From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Aug 2012 17:07:29 +0100
Subject: [PATCH v2 06/31] arm64: MMU fault handling and page table
 management
In-Reply-To: <201208151347.01169.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-7-git-send-email-catalin.marinas@arm.com>
 <201208151347.01169.arnd@arndb.de>
Message-ID: <20120817160729.GJ24389@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 02:47:00PM +0100, Arnd Bergmann wrote:
> On Tuesday 14 August 2012, Catalin Marinas wrote:
> > +pgd_t *pgd_alloc(struct mm_struct *mm)
> > +{
> > +	pgd_t *new_pgd;
> > +
> > +	new_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, PGD_ORDER);
> > +	if (!new_pgd)
> > +		return NULL;
> > +
> > +	memset(new_pgd, 0, PAGE_SIZE << PGD_ORDER);
> > +
> > +	return new_pgd;
> > +}
> > +
> > +void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> > +{
> > +	free_pages((unsigned long)pgd, PGD_ORDER);
> > +}
>  
> According to the documentation, you should only need 8kb for the pgd on
> a 64kb page system. Is it required that you use up a full page here?

Not with the current virtual memory layout with 39-bit address space for
kernel. With 64K pages we can increase the address space to 42-bit while
still using 2-level page table, in which case a full page is used.

But for now I'll keep the same virtual memory layout and add a check on
(PTRS_PER_PGD * sizeof(pgd_t)), the compiler will choose the right path.

-- 
Catalin
