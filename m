From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 15 Oct 2013 16:45:38 +0100
Subject: [PATCH v8 01/17] arm: make SWIOTLB available
In-Reply-To: <20131010094307.GD3817@mudshark.cambridge.arm.com>
References: <alpine.DEB.2.02.1310092109190.26077@kaball.uk.xensource.com>
 <1381351710-1876-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20131010094307.GD3817@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.02.1310151643230.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Oct 2013, Will Deacon wrote:
> On Wed, Oct 09, 2013 at 09:48:14PM +0100, Stefano Stabellini wrote:
> > IOMMU_HELPER is needed because SWIOTLB calls iommu_is_span_boundary,
> > provided by lib/iommu_helper.c.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > CC: will.deacon at arm.com
> > CC: linux at arm.linux.org.uk
> 
> [...]
> 
> > diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> > index 5b579b9..9aa5384 100644
> > --- a/arch/arm/include/asm/dma-mapping.h
> > +++ b/arch/arm/include/asm/dma-mapping.h
> > @@ -10,6 +10,7 @@
> >  
> >  #include <asm-generic/dma-coherent.h>
> >  #include <asm/memory.h>
> > +#include <asm/cacheflush.h>
> >  
> >  #define DMA_ERROR_CODE	(~0)
> >  extern struct dma_map_ops arm_dma_ops;
> > @@ -86,6 +87,42 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
> >  }
> >  #endif
> >  
> > +static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> > +{
> > +	unsigned int offset = paddr & ~PAGE_MASK;
> > +	return pfn_to_dma(dev, paddr >> PAGE_SHIFT) + offset;
> 
> __phys_to_pfn instead of the explicit shift?
> 
> > +}
> > +
> > +static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
> > +{
> > +	unsigned int offset = dev_addr & ~PAGE_MASK;
> > +	return (dma_to_pfn(dev, dev_addr) << PAGE_SHIFT) + offset;i
> 
> then __pfn_to_phys here.

good point

> > +}
> > +
> > +static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
> > +{
> > +	u64 limit, mask;
> > +	
> > +	if (dev->dma_mask)
> > +		mask = *dev->dma_mask;
> > +	else 
> > +		mask = dev->coherent_dma_mask;
> > +
> > +	if (mask == 0)
> > +		return 0;
> > +
> > +	limit = (mask + 1) & ~mask;
> 
> This looks like homebrew alignment to me. Can you use __ALIGN_KERNEL_MASK or
> one of thoese guys from kernel.h?

It was suggested by Russell here:

http://marc.info/?l=linux-arm-kernel&m=137535542901235&w=2

I don't think that __ALIGN_KERNEL_MASK would be useful in this case.
I could add a comment to explain the purpose of the check though.
