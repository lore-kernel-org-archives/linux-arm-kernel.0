From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 26 Jan 2012 09:09:26 +0100
Subject: [PATCH 8/8 RESEND] ARM: dma-mapping: add support for IOMMU	mapper
In-Reply-To: <20120125125916.GE1068@n2100.arm.linux.org.uk>
References: <1323448798-18184-9-git-send-email-m.szyprowski@samsung.com>
 <1326124161-2220-1-git-send-email-m.szyprowski@samsung.com>
 <20120125125916.GE1068@n2100.arm.linux.org.uk>
Message-ID: <007a01ccdc01$d2028400$76078c00$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, January 25, 2012 1:59 PM Russell King - ARM Linux wrote:

> On Mon, Jan 09, 2012 at 04:49:21PM +0100, Marek Szyprowski wrote:
> > This patch add a complete implementation of DMA-mapping API for
> > devices that have IOMMU support. All DMA-mapping calls are supported.
> >
> > This patch contains some of the code kindly provided by Krishna Reddy
> > <vdumpa@nvidia.com> and Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >
> > ---
> >
> > Hello,
> >
> > This is the corrected version of the previous patch from the "[PATCH 0/8
> > v4] ARM: DMA-mapping framework redesign" thread which can be found here:
> > http://www.spinics.net/lists/linux-mm/msg27382.html
> >
> > Previous version had very nasty bug which causes memory trashing if
> > DMA-mapping managed to allocate pages larger than 4KiB. The problem was
> > in __iommu_alloc_buffer() function which did not check how many pages
> > has been left to allocate.
> 
> This patch seems to be incomplete.
> 
> If the standard DMA API is used (the one which exists in current kernels)
> and NEED_SG_DMA_LENGTH is enabled, then where do we set the DMA length
> in the scatterlist?

Standard DMA API is also updated to work correctly with NEED_SG_DMA_LENGTH,
please notice the following chunk:

-----
@@ -644,6 +659,9 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist 
*sg, int nents,
        int i, j;
 
        for_each_sg(sg, s, nents, i) {
+#ifdef CONFIG_NEED_SG_DMA_LENGTH
+               s->dma_length = s->length;
+#endif
                s->dma_address = ops->map_page(dev, sg_page(s), s->offset,
                                                s->length, dir, attrs);
                if (dma_mapping_error(dev, s->dma_address))
-----
(http://www.spinics.net/lists/arm-kernel/msg154889.html for the reference)

> > diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
> > new file mode 100644
> > index 0000000..6668b41
> > --- /dev/null
> > +++ b/arch/arm/include/asm/dma-iommu.h
> > @@ -0,0 +1,36 @@
> > +#ifndef ASMARM_DMA_IOMMU_H
> > +#define ASMARM_DMA_IOMMU_H
> > +
> > +#ifdef __KERNEL__
> > +
> > +#include <linux/mm_types.h>
> > +#include <linux/scatterlist.h>
> > +#include <linux/dma-debug.h>
> > +#include <linux/kmemcheck.h>
> > +
> > +#include <asm/memory.h>
> 
> I can't see anything in here which needs asm/memory.h - if files which
> include this need it, please include it in there so we can see why it's
> needed.

Ok, I will fix this issue.

> 
> > +
> > +struct dma_iommu_mapping {
> > +	/* iommu specific data */
> > +	struct iommu_domain	*domain;
> > +
> > +	void			*bitmap;
> > +	size_t			bits;
> > +	unsigned int		order;
> > +	dma_addr_t		base;
> > +
> > +	spinlock_t		lock;
> > +	struct kref		kref;
> > +};
> > +
> > +struct dma_iommu_mapping *
> > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
> > +			 int order);
> > +
> > +void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
> > +
> > +int arm_iommu_attach_device(struct device *dev,
> > +					struct dma_iommu_mapping *mapping);
> > +
> > +#endif /* __KERNEL__ */
> > +#endif
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 4845c09..2287b01 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -27,6 +27,9 @@
> >  #include <asm/sizes.h>
> >  #include <asm/mach/arch.h>
> >
> > +#include <linux/iommu.h>
> 
> linux/ includes should be grouped together.

Ok, I will fix this.

> 
> > diff --git a/arch/arm/mm/vmregion.h b/arch/arm/mm/vmregion.h
> > index 15e9f04..6bbc402 100644
> > --- a/arch/arm/mm/vmregion.h
> > +++ b/arch/arm/mm/vmregion.h
> > @@ -17,7 +17,7 @@ struct arm_vmregion {
> >  	struct list_head	vm_list;
> >  	unsigned long		vm_start;
> >  	unsigned long		vm_end;
> > -	struct page		*vm_pages;
> > +	void			*priv;
> 
> I want to think about that - I may wish to export the vm_pages via
> the new dma-mappings file to provide additional information.

For IOMMU case I need to store a page array for each allocated buffer.

I haven't analyzed it yet, but maybe it would be possible to use standard 
vmalloc style entries and avoid creating separate arm_vmregion for coherent 
allocations?

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
