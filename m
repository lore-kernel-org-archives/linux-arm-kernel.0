From: toshi.kani@hpe.com (Kani, Toshi)
Date: Thu, 8 Mar 2018 19:30:23 +0000
Subject: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
In-Reply-To: <20180308180446.GF14918@arm.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
 <20180307183227.17983-2-toshi.kani@hpe.com>
 <20180308180446.GF14918@arm.com>
Message-ID: <1520540118.2693.103.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-03-08 at 18:04 +0000, Will Deacon wrote:
 :
> > diff --git a/lib/ioremap.c b/lib/ioremap.c
> > index b808a390e4c3..54e5bbaa3200 100644
> > --- a/lib/ioremap.c
> > +++ b/lib/ioremap.c
> > @@ -91,7 +91,8 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
> >  
> >  		if (ioremap_pmd_enabled() &&
> >  		    ((next - addr) == PMD_SIZE) &&
> > -		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
> > +		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
> > +		    pmd_free_pte_page(pmd)) {
> 
> I find it a bit weird that we're postponing this to the subsequent map. If
> we want to address the break-before-make issue that was causing a panic on
> arm64, then I think it would be better to do this on the unmap path to avoid
> duplicating TLB invalidation.

Hi Will,

Yes, I started looking into doing it the unmap path, but found the
following issues:

 - The iounmap() path is shared with vunmap().  Since vmap() only
supports pte mappings, making vunmap() to free pte pages is an overhead
for regular vmap users as they do not need pte pages freed up.
 - Checking to see if all entries in a pte page are cleared in the unmap
path is racy, and serializing this check is expensive.
 - The unmap path calls free_vmap_area_noflush() to do lazy TLB purges.
Clearing a pud/pmd entry before the lazy TLB purges needs extra TLB
purge.

Hence, I decided to postpone and do it in the ioremap path when a
pud/pmd mapping is set.  The "break" on arm64 happens when you update a
pmd entry without purging it.  So, the unmap path is not broken.  I
understand that arm64 may need extra TLB purge in pmd_free_pte_page(),
but it limits this overhead only when it sets up a pud/pmd mapping.

Thanks,
-Toshi
