From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 15 Jul 2011 08:27:58 +0200
Subject: [Linaro-mm-sig] [RFC 2/2] ARM: initial proof-of-concept IOMMU
	mapper for DMA-mapping
In-Reply-To: <CAB-zwWhRQmv8euqN6jeJP=tXTQgGQ3buRJEf=4aPtTOBsh+Z2Q@mail.gmail.com>
References: <CAB-zwWhRQmv8euqN6jeJP=tXTQgGQ3buRJEf=4aPtTOBsh+Z2Q@mail.gmail.com>
Message-ID: <000301cc42b8$569fca30$03df5e90$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, July 14, 2011 8:33 PM Ramirez Luna, Omar wrote:

> > Add initial proof of concept implementation of DMA-mapping API for
> > devices that have IOMMU support. Right now only dma_alloc_coherent,
> > dma_free_coherent and dma_mmap_coherent functions are supported.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> ...
> > diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-
> iommu.h
> > new file mode 100644
> > index 0000000..c246ff3
> > --- /dev/null
> > +++ b/arch/arm/include/asm/dma-iommu.h
> ...
> > +int __init arm_iommu_assign_device(struct device *dev, dma_addr_t base,
> dma_addr_t size);
> 
> __init causes a panic if the iommu is assigned after boot.
> 
> In OMAP3 the iommu driver controls isp and dsp address spaces, it is
> loaded until any of those 2 drivers is needed.

Well, ok. This was just a proof-of-concept/rfc patch, so it was designed only
for our particular case.

> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index f8c6972..b6397c1 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> ...
> > +static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
> > + ? ? ? ? ? dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
> > +{
> > + ? ? ? struct dma_iommu_mapping *mapping = dev->archdata.mapping;
> > + ? ? ? struct page **pages;
> > + ? ? ? void *addr = NULL;
> > + ? ? ? pgprot_t prot;
> > +
> > + ? ? ? if (dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
> > + ? ? ? ? ? ? ? prot = pgprot_writecombine(pgprot_kernel);
> > + ? ? ? else
> > + ? ? ? ? ? ? ? prot = pgprot_dmacoherent(pgprot_kernel);
> > +
> > + ? ? ? arm_iommu_init(dev);
> 
> I found useful to call arm_iommu_init inside arm_iommu_assign_device
> instead. So, then gen_pool is created only once without the
> mapping->pool check, instead of relying on the call to ...alloc_attrs,
> which in my case I never use because I'm implementing
> iommu_map|unmap_sg functions to see how it goes with the dma mapping.

Right, this is still on my todo list, but I wanted to focus on cleanup 
of dma mapping framework and cma first.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
