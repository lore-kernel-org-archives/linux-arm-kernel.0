From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Oct 2009 19:17:15 +0000
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1256582736.5282.161.camel@pc1117.cambridge.arm.com>
References: <20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20091015145753.GC14817@n2100.arm.linux.org.uk>
	<1255620022.10164.74.camel@pc1117.cambridge.arm.com>
	<20091015152852.GD14817@n2100.arm.linux.org.uk>
	<1255622179.10164.92.camel@pc1117.cambridge.arm.com>
	<1256038748.32578.14.camel@pc1117.cambridge.arm.com>
	<20091025144805.GA1774@n2100.arm.linux.org.uk>
	<1256582736.5282.161.camel@pc1117.cambridge.arm.com>
Message-ID: <20091026191715.GB27708@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2009 at 06:45:36PM +0000, Catalin Marinas wrote:
> On Sun, 2009-10-25 at 14:48 +0000, Russell King - ARM Linux wrote:
> > On Tue, Oct 20, 2009 at 12:39:08PM +0100, Catalin Marinas wrote:
> > > diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
> > > index d0d17b6..4e37ab6 100644
> > > --- a/arch/arm/mm/fault-armv.c
> > > +++ b/arch/arm/mm/fault-armv.c
> > > @@ -160,8 +160,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
> > >  	if (mapping) {
> > >  		if (cache_is_vivt())
> > >  			make_coherent(mapping, vma, addr, pfn);
> > > -		else if (vma->vm_flags & VM_EXEC)
> > > -			__flush_icache_all();
> > > +		__flush_icache_all();
> > 
> > BTW, why are you penalising VIVT cached systems as well with this
> > change?  Surely you meant to leave the 'else' still there.
> 
> I removed the else for the case where v6_copy_user_highpage() only does
> flush_dcache_page() and the page was mprotect(RW) temporarily.
> 
> There was another situation in the recent swap/anonymous pages case
> where I replied that there could be a situation where I-cache needs
> unconditional invalidation.

The question still stands.  We've not had I-cache flushing here for VIVT
caches.  We don't have a problem with them here.  Why is it necessary
for them to also flush the I-cache?
