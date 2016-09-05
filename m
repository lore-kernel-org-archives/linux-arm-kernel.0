From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 05 Sep 2016 12:54:09 +0300
Subject: [PATCHv9 4/6] arm: dma-mapping: add {map,
 unmap}_resource for iommu ops
In-Reply-To: <20160823153136.GH2951@bigcity.dyn.berto.se>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
 <20160810112219.17964-5-niklas.soderlund+renesas@ragnatech.se>
 <20160823153136.GH2951@bigcity.dyn.berto.se>
Message-ID: <1952161.FNa7jUW08f@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Niklas and Russell,

On Tuesday 23 Aug 2016 17:31:36 Niklas S?derlund wrote:
> Hi Russell,
> 
> If you have the time can you please have a look at this patch? This
> series have been out for some time now and Vinod is willing to take it
> through the dmaengine tree but a ACK is needed on this patch from you
> first.

I've reviewed and acked all the patches touching the DMA mapping API (1/6 to 
4/6). Russell, if you can find a bit of time to review this one it would be 
very appreciated.

> On 2016-08-10 13:22:17 +0200, Niklas S?derlund wrote:
> > Add methods to map/unmap device resources addresses for dma_map_ops that
> > are IOMMU aware. This is needed to map a device MMIO register from a
> > physical address.
> > 
> > Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >  arch/arm/mm/dma-mapping.c | 63 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> > 
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index c6834c0..746eb29 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -2014,6 +2014,63 @@ static void arm_iommu_unmap_page(struct device
> > *dev, dma_addr_t handle,> 
> >  	__free_iova(mapping, iova, len);
> >  
> >  }
> > 
> > +/**
> > + * arm_iommu_map_resource - map a device resource for DMA
> > + * @dev: valid struct device pointer
> > + * @phys_addr: physical address of resource
> > + * @size: size of resource to map
> > + * @dir: DMA transfer direction
> > + */
> > +static dma_addr_t arm_iommu_map_resource(struct device *dev,
> > +		phys_addr_t phys_addr, size_t size,
> > +		enum dma_data_direction dir, unsigned long attrs)
> > +{
> > +	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> > +	dma_addr_t dma_addr;
> > +	int ret, prot;
> > +	phys_addr_t addr = phys_addr & PAGE_MASK;
> > +	unsigned int offset = phys_addr & ~PAGE_MASK;
> > +	size_t len = PAGE_ALIGN(size + offset);
> > +
> > +	dma_addr = __alloc_iova(mapping, len);
> > +	if (dma_addr == DMA_ERROR_CODE)
> > +		return dma_addr;
> > +
> > +	prot = __dma_direction_to_prot(dir) | IOMMU_MMIO;
> > +
> > +	ret = iommu_map(mapping->domain, dma_addr, addr, len, prot);
> > +	if (ret < 0)
> > +		goto fail;
> > +
> > +	return dma_addr + offset;
> > +fail:
> > +	__free_iova(mapping, dma_addr, len);
> > +	return DMA_ERROR_CODE;
> > +}
> > +
> > +/**
> > + * arm_iommu_unmap_resource - unmap a device DMA resource
> > + * @dev: valid struct device pointer
> > + * @dma_handle: DMA address to resource
> > + * @size: size of resource to map
> > + * @dir: DMA transfer direction
> > + */
> > +static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t
> > dma_handle, +		size_t size, enum dma_data_direction dir,
> > +		unsigned long attrs)
> > +{
> > +	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> > +	dma_addr_t iova = dma_handle & PAGE_MASK;
> > +	unsigned int offset = dma_handle & ~PAGE_MASK;
> > +	size_t len = PAGE_ALIGN(size + offset);
> > +
> > +	if (!iova)
> > +		return;
> > +
> > +	iommu_unmap(mapping->domain, iova, len);
> > +	__free_iova(mapping, iova, len);
> > +}
> > +
> > 
> >  static void arm_iommu_sync_single_for_cpu(struct device *dev,
> >  
> >  		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> >  
> >  {
> > 
> > @@ -2057,6 +2114,9 @@ struct dma_map_ops iommu_ops = {
> > 
> >  	.unmap_sg		= arm_iommu_unmap_sg,
> >  	.sync_sg_for_cpu	= arm_iommu_sync_sg_for_cpu,
> >  	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
> > 
> > +
> > +	.map_resource		= arm_iommu_map_resource,
> > +	.unmap_resource		= arm_iommu_unmap_resource,
> > 
> >  };
> >  
> >  struct dma_map_ops iommu_coherent_ops = {
> > 
> > @@ -2070,6 +2130,9 @@ struct dma_map_ops iommu_coherent_ops = {
> > 
> >  	.map_sg		= arm_coherent_iommu_map_sg,
> >  	.unmap_sg	= arm_coherent_iommu_unmap_sg,
> > 
> > +
> > +	.map_resource	= arm_iommu_map_resource,
> > +	.unmap_resource	= arm_iommu_unmap_resource,
> > 
> >  };
> >  
> >  /**

-- 
Regards,

Laurent Pinchart
