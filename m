From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 9 Apr 2010 19:27:51 +0530
Subject: [PATCH] Fix ioremap_cached()/ioremap_wc() for SMP platforms
In-Reply-To: <20100409134723.GC2804@n2100.arm.linux.org.uk>
References: <20100408093852.GC31407@n2100.arm.linux.org.uk>
	<20100409134723.GC2804@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4DAEC1D@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, April 09, 2010 7:17 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] Fix ioremap_cached()/ioremap_wc() for SMP platforms
> 
> Santosh,
> 
> Any chance of checking this please?  This should result in the query
> about the OMAP framebuffer mappings sharedness being resolved.
> 
Oh Yes. I tested this and it does fix the "shared" bit issue of frame buffer
> 
> On Thu, Apr 08, 2010 at 10:38:52AM +0100, Russell King - ARM Linux wrote:
> > Write combining/cached device mappings are not setting the shared bit,
> > which could potentially cause problems on SMP systems since the cache
> > lines won't participate in the cache coherency protocol.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > --
> > This doesn't make it any more legal to use ioremap*() on main system
> > RAM than it was before this change; it does mean that ioremap_wc()
> > regions are correctly marked as shared which happens to agree with
> > the main system RAM mappings.  Strictly to the arch. spec. for ARMv6+,
> > it remains "unpredictable" to use ioremap*() on main system RAM.
> >
> >  arch/arm/mm/mmu.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 9d4da6a..4223d08 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -420,6 +420,10 @@ static void __init build_mem_type_table(void)
> >  		user_pgprot |= L_PTE_SHARED;
> >  		kern_pgprot |= L_PTE_SHARED;
> >  		vecs_pgprot |= L_PTE_SHARED;
> > +		mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
> > +		mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
> > +		mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
> > +		mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
> >  		mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
> >  		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
> >  #endif
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
