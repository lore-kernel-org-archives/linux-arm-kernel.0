From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 29 Oct 2013 04:41:40 +0000
Subject: [PATCH v9 01/18] arm: make SWIOTLB available
In-Reply-To: <alpine.DEB.2.02.1310251206450.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1310251144020.26077@kaball.uk.xensource.com>
 <1382698313-13161-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1310251206450.26077@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1310290441260.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping?

On Fri, 25 Oct 2013, Stefano Stabellini wrote:
> Russell,
> this is the only patch that needs an ack at the moment.
> As you commented on it before and I have already addressed your comments
> few versions ago, unless you have any complaints I am going to add it to
> linux-next and I am thinking of merging it during the next merge window.
> 
> On Fri, 25 Oct 2013, Stefano Stabellini wrote:
> > IOMMU_HELPER is needed because SWIOTLB calls iommu_is_span_boundary,
> > provided by lib/iommu_helper.c.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > CC: will.deacon at arm.com
> > CC: linux at arm.linux.org.uk
> > 
> > 
> > Changes in v8:
> > - use __phys_to_pfn and __pfn_to_phys.
> > 
> > Changes in v7:
> > - dma_mark_clean: empty implementation;
> > - in dma_capable use coherent_dma_mask if dma_mask hasn't been
> >   allocated.
> > 
> > Changes in v6:
> > - check for dev->dma_mask being NULL in dma_capable.
> > 
> > Changes in v5:
> > - implement dma_mark_clean using dmac_flush_range.
> > 
> > Changes in v3:
> > - dma_capable: do not treat dma_mask as a limit;
> > - remove SWIOTLB dependency on NEED_SG_DMA_LENGTH.
> > ---
> >  arch/arm/Kconfig                   |    6 +++++
> >  arch/arm/include/asm/dma-mapping.h |   37 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 43 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 1ad6fb6..b08374f 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1872,6 +1872,12 @@ config CC_STACKPROTECTOR
> >  	  neutralized via a kernel panic.
> >  	  This feature requires gcc version 4.2 or above.
> >  
> > +config SWIOTLB
> > +	def_bool y
> > +
> > +config IOMMU_HELPER
> > +	def_bool SWIOTLB
> > +
> >  config XEN_DOM0
> >  	def_bool y
> >  	depends on XEN
> > diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> > index 5b579b9..01b5a3d 100644
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
> > +	return pfn_to_dma(dev, __phys_to_pfn(paddr)) + offset;
> > +}
> > +
> > +static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
> > +{
> > +	unsigned int offset = dev_addr & ~PAGE_MASK;
> > +	return __pfn_to_phys(dma_to_pfn(dev, dev_addr)) + offset;
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
> > +	if (limit && size > limit)
> > +		return 0;
> > +
> > +	if ((addr | (addr + size - 1)) & ~mask)
> > +		return 0;
> > +
> > +	return 1;
> > +}
> > +
> > +static inline void dma_mark_clean(void *addr, size_t size) { }
> > +
> >  /*
> >   * DMA errors are defined by all-bits-set in the DMA address.
> >   */
> > -- 
> > 1.7.2.5
> > 
> 
