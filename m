From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Fri, 24 Apr 2015 12:12:00 -0400
Subject: [PATCH v2] xen: Add __GFP_DMA flag when xen_swiotlb_init gets
 free pages on ARM
In-Reply-To: <alpine.DEB.2.02.1504241526490.2640@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1504241015220.2640@kaball.uk.xensource.com>
 <20150424132749.GA9192@l.oracle.com>
 <alpine.DEB.2.02.1504241526490.2640@kaball.uk.xensource.com>
Message-ID: <20150424161200.GB8117@konrad-lan.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 24, 2015 at 03:31:53PM +0100, Stefano Stabellini wrote:
> On Fri, 24 Apr 2015, Konrad Rzeszutek Wilk wrote:
> > On Fri, Apr 24, 2015 at 10:16:40AM +0100, Stefano Stabellini wrote:
> > > Make sure that xen_swiotlb_init allocates buffers that are DMA capable
> > > when at least one memblock is available below 4G. Otherwise we assume
> > > that all devices on the SoC can cope with >4G addresses. We do this on
> > > ARM and ARM64, where dom0 is mapped 1:1, so pfn == mfn in this case.
> > > 
> > > No functional changes on x86.
> > > 
> > > From: Chen Baozi <baozich@gmail.com>
> > > 
> > > Signed-off-by: Chen Baozi <baozich@gmail.com>
> > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > Tested-by: Chen Baozi <baozich@gmail.com>
> > 
> > Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> Thanks! We are still early in the release cycle, should I add it to
> xentip/stable/for-linus-4.1?

Sure!
> 
> 
> > > diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
> > > index 2f7e6ff..0b579b2 100644
> > > --- a/arch/arm/include/asm/xen/page.h
> > > +++ b/arch/arm/include/asm/xen/page.h
> > > @@ -110,5 +110,6 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
> > >  bool xen_arch_need_swiotlb(struct device *dev,
> > >  			   unsigned long pfn,
> > >  			   unsigned long mfn);
> > > +unsigned long xen_get_swiotlb_free_pages(unsigned int order);
> > >  
> > >  #endif /* _ASM_ARM_XEN_PAGE_H */
> > > diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> > > index 793551d..4983250 100644
> > > --- a/arch/arm/xen/mm.c
> > > +++ b/arch/arm/xen/mm.c
> > > @@ -4,6 +4,7 @@
> > >  #include <linux/gfp.h>
> > >  #include <linux/highmem.h>
> > >  #include <linux/export.h>
> > > +#include <linux/memblock.h>
> > >  #include <linux/of_address.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/types.h>
> > > @@ -21,6 +22,20 @@
> > >  #include <asm/xen/hypercall.h>
> > >  #include <asm/xen/interface.h>
> > >  
> > > +unsigned long xen_get_swiotlb_free_pages(unsigned int order)
> > > +{
> > > +	struct memblock_region *reg;
> > > +	gfp_t flags = __GFP_NOWARN;
> > > +
> > > +	for_each_memblock(memory, reg) {
> > > +		if (reg->base < (phys_addr_t)0xffffffff) {
> > > +			flags |= __GFP_DMA;
> > > +			break;
> > > +		}
> > > +	}
> > > +	return __get_free_pages(flags, order);
> > > +}
> > > +
> > >  enum dma_cache_op {
> > >         DMA_UNMAP,
> > >         DMA_MAP,
> > > diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
> > > index 358dcd3..c44a5d5 100644
> > > --- a/arch/x86/include/asm/xen/page.h
> > > +++ b/arch/x86/include/asm/xen/page.h
> > > @@ -269,4 +269,9 @@ static inline bool xen_arch_need_swiotlb(struct device *dev,
> > >  	return false;
> > >  }
> > >  
> > > +static inline unsigned long xen_get_swiotlb_free_pages(unsigned int order)
> > > +{
> > > +	return __get_free_pages(__GFP_NOWARN, order);
> > > +}
> > > +
> > >  #endif /* _ASM_X86_XEN_PAGE_H */
> > > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > > index 810ad41..4c54932 100644
> > > --- a/drivers/xen/swiotlb-xen.c
> > > +++ b/drivers/xen/swiotlb-xen.c
> > > @@ -235,7 +235,7 @@ retry:
> > >  #define SLABS_PER_PAGE (1 << (PAGE_SHIFT - IO_TLB_SHIFT))
> > >  #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
> > >  		while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
> > > -			xen_io_tlb_start = (void *)__get_free_pages(__GFP_NOWARN, order);
> > > +			xen_io_tlb_start = (void *)xen_get_swiotlb_free_pages(order);
> > >  			if (xen_io_tlb_start)
> > >  				break;
> > >  			order--;
> > 
