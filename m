From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Dec 2017 11:03:14 +0000
Subject: [PATCH v3 14/19] KVM: arm/arm64: Move HYP IO VAs to the "idmap"
 range
In-Reply-To: <20171220131624.xvewngmlrv5niwzb@capper-debian.cambridge.arm.com>
References: <20171218173926.16911-1-marc.zyngier@arm.com>
 <20171218173926.16911-15-marc.zyngier@arm.com>
 <20171220131624.xvewngmlrv5niwzb@capper-debian.cambridge.arm.com>
Message-ID: <86h8sdrbt9.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Wed, 20 Dec 2017 13:16:24 +0000,
Steve Capper wrote:
> 
> Hi Marc,
> 
> On Mon, Dec 18, 2017 at 05:39:21PM +0000, Marc Zyngier wrote:
> > We so far mapped our HYP IO (which is essencially the GICv2 control
> > registers) using the same method as for memory. It recently appeared
> > that is a bit unsafe:
> > 
> > we compute the HYP VA using the kern_hyp_va helper, but that helper
> > is only designed to deal with kernel VAs coming from the linear map,
> > and not from the vmalloc region... This could in turn cause some bad
> > aliasing between the two, amplified by the new VA randomisation.
> > 
> > A solution is to come up with our very own basic VA allocator for
> > MMIO. Since half of the HYP address space only contains a single
> > page (the idmap), we have plenty to borrow from. Let's use the idmap
> > as a base, and allocate downwards from it. GICv2 now lives on the
> > other side of the great VA barrier.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  virt/kvm/arm/mmu.c | 40 ++++++++++++++++++++++++++++------------
> >  1 file changed, 28 insertions(+), 12 deletions(-)
> > 
> > diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> > index 6192d45d1e1a..0597c9846f1a 100644
> > --- a/virt/kvm/arm/mmu.c
> > +++ b/virt/kvm/arm/mmu.c
> 
> [...]
> 
> > @@ -721,7 +728,8 @@ int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
> >  			   void __iomem **kaddr,
> >  			   void __iomem **haddr)
> >  {
> > -	unsigned long start, end;
> > +	pgd_t *pgd = hyp_pgd;
> > +	unsigned long base;
> >  	int ret;
> >  
> >  	*kaddr = ioremap(phys_addr, size);
> > @@ -733,19 +741,26 @@ int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
> >  		return 0;
> >  	}
> >  
> > +	mutex_lock(&io_map_lock);
> > +
> > +	base = io_map_base - size;
> > +	base &= ~(size - 1);
> > +
> 
> Is it worth checking to see if we have "escaped" from our half of the
> HYP region?
> 
> So something like?
> 
> if (base ^ io_map_base & BIT(VA_BITS - 1))
>     allocationFailed...

Ah, cool trick. It took me a minute to grasp it (I blame the
turkey...), but that's definitely neat and a nice sanity check.

I'll add that to v4.

Thanks,

	M.
