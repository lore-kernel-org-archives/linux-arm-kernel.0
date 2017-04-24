From: sstabellini@kernel.org (Stefano Stabellini)
Date: Mon, 24 Apr 2017 12:16:50 -0700 (PDT)
Subject: [PATCH 1/2] xen/arm, arm64: fix xen_dma_ops after 815dd18
 "Consolidate get_dma_ops..."
In-Reply-To: <alpine.DEB.2.10.1704191023120.31486@sstabellini-ThinkPad-X260>
References: <1492117462-19886-1-git-send-email-sstabellini@kernel.org>
 <20170418142126.GE27592@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.10.1704191023120.31486@sstabellini-ThinkPad-X260>
Message-ID: <alpine.DEB.2.10.1704241214100.16723@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Given the outstanding regression we need to fix as soon as possible,
I'll queue these patches on the xentip tree for 4.12.

Please shout if you disagree.

Thank you.

- Stefano


On Wed, 19 Apr 2017, Stefano Stabellini wrote:
> Hello Russell,
> 
> Can I have your acked-by on the following fix (original patch is
> 1492117462-19886-1-git-send-email-sstabellini at kernel.org)?
> 
> Thanks,
> 
> Stefano
> 
> 
> On Tue, 18 Apr 2017, Catalin Marinas wrote:
> > On Thu, Apr 13, 2017 at 02:04:21PM -0700, Stefano Stabellini wrote:
> > > The following commit:
> > > 
> > >   commit 815dd18788fe0d41899f51b91d0560279cf16b0d
> > >   Author: Bart Van Assche <bart.vanassche@sandisk.com>
> > >   Date:   Fri Jan 20 13:04:04 2017 -0800
> > > 
> > >       treewide: Consolidate get_dma_ops() implementations
> > > 
> > > rearranges get_dma_ops in a way that xen_dma_ops are not returned when
> > > running on Xen anymore, dev->dma_ops is returned instead (see
> > > arch/arm/include/asm/dma-mapping.h:get_arch_dma_ops and
> > > include/linux/dma-mapping.h:get_dma_ops).
> > > 
> > > Fix the problem by storing dev->dma_ops in dev_archdata, and setting
> > > dev->dma_ops to xen_dma_ops. This way, xen_dma_ops is returned naturally
> > > by get_dma_ops. The Xen code can retrieve the original dev->dma_ops from
> > > dev_archdata when needed. It also allows us to remove __generic_dma_ops
> > > from common headers.
> > > 
> > > Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> > > Tested-by: Julien Grall <julien.grall@arm.com>
> > > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > > CC: linux at armlinux.org.uk
> > > CC: catalin.marinas at arm.com
> > > CC: will.deacon at arm.com
> > > CC: boris.ostrovsky at oracle.com
> > > CC: jgross at suse.com
> > > CC: Julien Grall <julien.grall@arm.com>
> > 
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > 
> > > diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
> > > index 220ba20..36ec9c8 100644
> > > --- a/arch/arm/include/asm/device.h
> > > +++ b/arch/arm/include/asm/device.h
> > > @@ -16,6 +16,9 @@ struct dev_archdata {
> > >  #ifdef CONFIG_ARM_DMA_USE_IOMMU
> > >  	struct dma_iommu_mapping	*mapping;
> > >  #endif
> > > +#ifdef CONFIG_XEN
> > > +	const struct dma_map_ops *dev_dma_ops;
> > > +#endif
> > >  	bool dma_coherent;
> > >  };
> > >  
> > > diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> > > index 7166569..680d3f3 100644
> > > --- a/arch/arm/include/asm/dma-mapping.h
> > > +++ b/arch/arm/include/asm/dma-mapping.h
> > > @@ -16,19 +16,9 @@
> > >  extern const struct dma_map_ops arm_dma_ops;
> > >  extern const struct dma_map_ops arm_coherent_dma_ops;
> > >  
> > > -static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
> > > -{
> > > -	if (dev && dev->dma_ops)
> > > -		return dev->dma_ops;
> > > -	return &arm_dma_ops;
> > > -}
> > > -
> > >  static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
> > >  {
> > > -	if (xen_initial_domain())
> > > -		return xen_dma_ops;
> > > -	else
> > > -		return __generic_dma_ops(NULL);
> > > +	return &arm_dma_ops;
> > >  }
> > >  
> > >  #define HAVE_ARCH_DMA_SUPPORTED 1
> > > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > > index 63eabb0..a614459 100644
> > > --- a/arch/arm/mm/dma-mapping.c
> > > +++ b/arch/arm/mm/dma-mapping.c
> > > @@ -2396,6 +2396,13 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> > >  		dma_ops = arm_get_dma_map_ops(coherent);
> > >  
> > >  	set_dma_ops(dev, dma_ops);
> > > +
> > > +#ifdef CONFIG_XEN
> > > +	if (xen_initial_domain()) {
> > > +		dev->archdata.dev_dma_ops = dev->dma_ops;
> > > +		dev->dma_ops = xen_dma_ops;
> > > +	}
> > > +#endif
> > >  }
> > >  
> > >  void arch_teardown_dma_ops(struct device *dev)
> > > diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
> > > index 73d5bab..5a5fa47 100644
> > > --- a/arch/arm64/include/asm/device.h
> > > +++ b/arch/arm64/include/asm/device.h
> > > @@ -20,6 +20,9 @@ struct dev_archdata {
> > >  #ifdef CONFIG_IOMMU_API
> > >  	void *iommu;			/* private IOMMU data */
> > >  #endif
> > > +#ifdef CONFIG_XEN
> > > +	const struct dma_map_ops *dev_dma_ops;
> > > +#endif
> > >  	bool dma_coherent;
> > >  };
> > >  
> > > diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> > > index 505756c..5392dbe 100644
> > > --- a/arch/arm64/include/asm/dma-mapping.h
> > > +++ b/arch/arm64/include/asm/dma-mapping.h
> > > @@ -27,11 +27,8 @@
> > >  #define DMA_ERROR_CODE	(~(dma_addr_t)0)
> > >  extern const struct dma_map_ops dummy_dma_ops;
> > >  
> > > -static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
> > > +static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
> > >  {
> > > -	if (dev && dev->dma_ops)
> > > -		return dev->dma_ops;
> > > -
> > >  	/*
> > >  	 * We expect no ISA devices, and all other DMA masters are expected to
> > >  	 * have someone call arch_setup_dma_ops at device creation time.
> > > @@ -39,14 +36,6 @@ static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
> > >  	return &dummy_dma_ops;
> > >  }
> > >  
> > > -static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
> > > -{
> > > -	if (xen_initial_domain())
> > > -		return xen_dma_ops;
> > > -	else
> > > -		return __generic_dma_ops(NULL);
> > > -}
> > > -
> > >  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> > >  			const struct iommu_ops *iommu, bool coherent);
> > >  #define arch_setup_dma_ops	arch_setup_dma_ops
> > > diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> > > index 81cdb2e..7f8b37e 100644
> > > --- a/arch/arm64/mm/dma-mapping.c
> > > +++ b/arch/arm64/mm/dma-mapping.c
> > > @@ -977,4 +977,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> > >  
> > >  	dev->archdata.dma_coherent = coherent;
> > >  	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
> > > +
> > > +#ifdef CONFIG_XEN
> > > +	if (xen_initial_domain()) {
> > > +		dev->archdata.dev_dma_ops = dev->dma_ops;
> > > +		dev->dma_ops = xen_dma_ops;
> > > +	}
> > > +#endif
> > >  }
> > > diff --git a/include/xen/arm/page-coherent.h b/include/xen/arm/page-coherent.h
> > > index 95ce6ac..b0a2bfc 100644
> > > --- a/include/xen/arm/page-coherent.h
> > > +++ b/include/xen/arm/page-coherent.h
> > > @@ -2,8 +2,16 @@
> > >  #define _ASM_ARM_XEN_PAGE_COHERENT_H
> > >  
> > >  #include <asm/page.h>
> > > +#include <asm/dma-mapping.h>
> > >  #include <linux/dma-mapping.h>
> > >  
> > > +static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
> > > +{
> > > +	if (dev && dev->archdata.dev_dma_ops)
> > > +		return dev->archdata.dev_dma_ops;
> > > +	return get_arch_dma_ops(NULL);
> > > +}
> > > +
> > >  void __xen_dma_map_page(struct device *hwdev, struct page *page,
> > >  	     dma_addr_t dev_addr, unsigned long offset, size_t size,
> > >  	     enum dma_data_direction dir, unsigned long attrs);
> 
