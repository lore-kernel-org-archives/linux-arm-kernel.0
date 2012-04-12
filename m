From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 12 Apr 2012 11:49:23 +0200
Subject: [PATCHv8 10/10] ARM: dma-mapping: add support for IOMMU mapper
In-Reply-To: <201204101158.29590.arnd@arndb.de>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-11-git-send-email-m.szyprowski@samsung.com>
 <201204101158.29590.arnd@arndb.de>
Message-ID: <026f01cd1891$8a2f1b80$9e8d5280$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tuesday, April 10, 2012 1:58 PM Arnd Bergmann wrote:

> On Tuesday 10 April 2012, Marek Szyprowski wrote:
> > +/**
> > + * arm_iommu_create_mapping
> > + * @bus: pointer to the bus holding the client device (for IOMMU calls)
> > + * @base: start address of the valid IO address space
> > + * @size: size of the valid IO address space
> > + * @order: accuracy of the IO addresses allocations
> > + *
> > + * Creates a mapping structure which holds information about used/unused
> > + * IO address ranges, which is required to perform memory allocation and
> > + * mapping with IOMMU aware functions.
> > + *
> > + * The client device need to be attached to the mapping with
> > + * arm_iommu_attach_device function.
> > + */
> > +struct dma_iommu_mapping *
> > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
> > +                        int order)
> > +{
> > +       unsigned int count = size >> (PAGE_SHIFT + order);
> > +       unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> > +       struct dma_iommu_mapping *mapping;
> > +       int err = -ENOMEM;
> > +
> > +       if (!count)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
> > +       if (!mapping)
> > +               goto err;
> > +
> > +       mapping->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > +       if (!mapping->bitmap)
> > +               goto err2;
> > +
> > +       mapping->base = base;
> > +       mapping->bits = BITS_PER_BYTE * bitmap_size;
> > +       mapping->order = order;
> > +       spin_lock_init(&mapping->lock);
> > +
> > +       mapping->domain = iommu_domain_alloc(bus);
> > +       if (!mapping->domain)
> > +               goto err3;
> > +
> > +       kref_init(&mapping->kref);
> > +       return mapping;
> > +err3:
> > +       kfree(mapping->bitmap);
> > +err2:
> > +       kfree(mapping);
> > +err:
> > +       return ERR_PTR(err);
> > +}
> > +EXPORT_SYMBOL(arm_iommu_create_mapping);
> 
> I don't understand this function, mostly I guess because you have not
> provided any users. A few questions here:
> 
> * What is ARM specific about it that it is named arm_iommu_create_mapping?
>   Isn't this completely generic, at least on the interface side?

This function is quite generic. It creates 'struct dma_iommu_mapping' object,
which is stored in the client's device arch data. This object mainly stores
information about io/dma address space: base address, allocation bitmap and
respective iommu domain. Please note that more than one device can be assigned
to the given dma_iommu_mapping to match different hardware topologies.

This function is called by the board/(sub-)platform startup code to initialize
iommu based dma-mapping. For the example usage please refer to 
s5p_create_iommu_mapping() function in arch/arm/mach-exynos/dev-sysmmu.c on 
3.4-rc2-arm-dma-v8-samsung branch in 
git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git

GITWeb shortcut: 
http://git.linaro.org/gitweb?p=people/mszyprowski/linux-dma-mapping.git;a=blob;f=arch/arm/mach-exyno
s/dev-sysmmu.c;h=31f2d6caf0e9949def18abd18af3f9d16737ae19;hb=6025093750d41f88406042e6486e331b806dc87
5#l283

> * Why is this exported to modules? Which device drivers do you expect
>   to call it?

I thought it might be useful to use modules for registering devices, but 
now I see that no platform use such approach. I will drop these exports 
unless someone finds a real use case for them.

> * Why do you pass the bus_type in here? That seems like the completely
>   wrong thing to do when all devices are on the same bus type (e.g.
>   amba or platform) but are connected to different instances that each
>   have their own iommu. I guess this is a question for J?rg, because the
>   base iommu interface provides iommu_domain_alloc().

That's only a consequence of the iommu api. I would also prefer to use client 
device pointer here instead of the bus id, but maybe I don't have enough 
knowledge about desktop IOMMUs. I suspect that there is also a need to assign
one IOMMU driver to the whole bus (like pci bus) and it originates from such
systems. In embedded world we usually have only one iommu driver which 
operates on the platform bus devices. On Samsung Exynos4 we have over a dozen
SYSMMU controllers for various multimedia blocks, but they are all exactly 
the same. We use one iommu ops structure and store a pointer to the real 
iommu controller instance inside arch data of the client struct device.
 
Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
