From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Apr 2012 11:58:29 +0000
Subject: [PATCHv8 10/10] ARM: dma-mapping: add support for IOMMU mapper
In-Reply-To: <1334055852-19500-11-git-send-email-m.szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-11-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201204101158.29590.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> +/**
> + * arm_iommu_create_mapping
> + * @bus: pointer to the bus holding the client device (for IOMMU calls)
> + * @base: start address of the valid IO address space
> + * @size: size of the valid IO address space
> + * @order: accuracy of the IO addresses allocations
> + *
> + * Creates a mapping structure which holds information about used/unused
> + * IO address ranges, which is required to perform memory allocation and
> + * mapping with IOMMU aware functions.
> + *
> + * The client device need to be attached to the mapping with
> + * arm_iommu_attach_device function.
> + */
> +struct dma_iommu_mapping *
> +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
> +                        int order)
> +{
> +       unsigned int count = size >> (PAGE_SHIFT + order);
> +       unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> +       struct dma_iommu_mapping *mapping;
> +       int err = -ENOMEM;
> +
> +       if (!count)
> +               return ERR_PTR(-EINVAL);
> +
> +       mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
> +       if (!mapping)
> +               goto err;
> +
> +       mapping->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> +       if (!mapping->bitmap)
> +               goto err2;
> +
> +       mapping->base = base;
> +       mapping->bits = BITS_PER_BYTE * bitmap_size;
> +       mapping->order = order;
> +       spin_lock_init(&mapping->lock);
> +
> +       mapping->domain = iommu_domain_alloc(bus);
> +       if (!mapping->domain)
> +               goto err3;
> +
> +       kref_init(&mapping->kref);
> +       return mapping;
> +err3:
> +       kfree(mapping->bitmap);
> +err2:
> +       kfree(mapping);
> +err:
> +       return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL(arm_iommu_create_mapping);

I don't understand this function, mostly I guess because you have not
provided any users. A few questions here:

* What is ARM specific about it that it is named arm_iommu_create_mapping?
  Isn't this completely generic, at least on the interface side?

* Why is this exported to modules? Which device drivers do you expect
  to call it?

* Why do you pass the bus_type in here? That seems like the completely
  wrong thing to do when all devices are on the same bus type (e.g.
  amba or platform) but are connected to different instances that each
  have their own iommu. I guess this is a question for J?rg, because the
  base iommu interface provides iommu_domain_alloc().

	Arnd
