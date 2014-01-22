From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Jan 2014 16:10:11 +0000
Subject: [PATCH 11/11] arm: dma-mapping: Add support to extend DMA IOMMU
 mappings
In-Reply-To: <1389876263-25759-12-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-12-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20140122161010.GH14108@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 12:44:23PM +0000, Andreas Herrmann wrote:
> Instead of using just one bitmap to keep track of IO virtual addresses
> (handed out for IOMMU use) introduce a list of iova_ranges (each
> having its own bitmap). This allows us to extend existing mappings
> when running out of iova space for a mapping.
> 
> If there is not enough space in the mapping to service an IO virtual
> address allocation request, __alloc_iova() tries to extend the mapping
> -- by allocating another bitmap -- and makes another allocation
> attempt using the freshly allocated bitmap.
> 
> This allows arm iommu drivers to start with a decent initial size when
> an dma_iommu_mapping is created and still to avoid running out of IO
> virtual addresses for the mapping.
> 
> Tests were done on Calxeda ECX-2000 with smmu for sata and xgmac.
> I've used SZ_512K both for initial mapping size and grow_size.

Aha, I thought grow_size was the *maximum* size, rather than the incremental
size. In which case, you probably want to pick the maximum supported IOMMU
page size that satisfies a fixed limit on the bitmap size.

> +static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
> +{
> +	struct dma_iommu_iova_range *iovar;
> +	unsigned int count = mapping->grow_size >> (PAGE_SHIFT + mapping->order);
> +	unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> +
> +	if (!mapping->grow_size ||
> +		(mapping->size + mapping->grow_size) >= mapping->max_size)
> +		return -EINVAL;
> +
> +	iovar = kzalloc(sizeof(struct dma_iommu_iova_range), GFP_ATOMIC);
> +	if (!iovar)
> +		return -ENOMEM;
> +
> +	iovar->bitmap = kzalloc(bitmap_size, GFP_ATOMIC);

Do these allocation really need to be atomic? I worry that's going to have
severe restrictions on our ability to allocate large address spaces.

Will
