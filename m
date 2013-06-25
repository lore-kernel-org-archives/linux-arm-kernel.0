From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Jun 2013 12:37:14 +0100
Subject: [PATCH 3/9] ARM: dma-mapping: convert DMA direction into IOMMU
 protection attributes
In-Reply-To: <20130625131215.d3cea2a5668a3d41dbbeb064@nvidia.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-4-git-send-email-will.deacon@arm.com>
 <20130625131215.d3cea2a5668a3d41dbbeb064@nvidia.com>
Message-ID: <20130625113714.GF31838@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 11:12:15AM +0100, Hiroshi Doyu wrote:
> Hi Will,

Hi Hiroshi,

> On Mon, 10 Jun 2013 20:34:39 +0200
> Will Deacon <will.deacon@arm.com> wrote:
> ...
> > @@ -1636,13 +1636,27 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
> >  {
> >  	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
> >  	dma_addr_t dma_addr;
> > -	int ret, len = PAGE_ALIGN(size + offset);
> > +	int ret, prot, len = PAGE_ALIGN(size + offset);
> >  
> >  	dma_addr = __alloc_iova(mapping, len);
> >  	if (dma_addr == DMA_ERROR_CODE)
> >  		return dma_addr;
> >  
> > -	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, 0);
> > +	switch (dir) {
> > +	case DMA_BIDIRECTIONAL:
> > +		prot = IOMMU_READ | IOMMU_WRITE;
> > +		break;
> > +	case DMA_TO_DEVICE:
> > +		prot = IOMMU_READ;
> > +		break;
> > +	case DMA_FROM_DEVICE:
> > +		prot = IOMMU_WRITE;
> > +		break;
> > +	default:
> > +		prot = 0;
> > +	}
> > +
> > +	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, prot);
> 
> Do we need similar changes for map_sg case as well? They still passes '0' as prot.

Yes, we could use the same trick there (probably worth moving the logic into
a helper function for translating dma_data_direction into IOMMU_* values).

There are also iommu_map calls when allocating DMA buffers, but I think 0 is
the right thing to pass there (i.e. no permission until pages have been
explicitly mapped). Although, to be honest, I don't see why we need to map
the buffer at all when we allocate it.

Will
