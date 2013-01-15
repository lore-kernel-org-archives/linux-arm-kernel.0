From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 15 Jan 2013 16:07:16 +0100
Subject: [Linaro-mm-sig][RFC] ARM: dma-mapping: Add DMA attribute to skip
 iommu mapping
In-Reply-To: <1357639944-12050-1-git-send-email-abhinav.k@samsung.com>
References: <1357639944-12050-1-git-send-email-abhinav.k@samsung.com>
Message-ID: <50F570A4.70606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 1/8/2013 11:12 AM, Abhinav Kochhar wrote:
> Adding a new dma attribute which can be used by the
> platform drivers to avoid creating iommu mappings.
> In some cases the buffers are allocated by display
> controller driver using dma alloc apis but are not
> used for scanout. Though the buffers are allocated
> by display controller but are only used for sharing
> among different devices.
> With this attribute the platform drivers can choose
> not to create iommu mapping at the time of buffer
> allocation and only create the mapping when they
> access this buffer.
>
> Change-Id: I2178b3756170982d814e085ca62474d07b616a21
> Signed-off-by: Abhinav Kochhar <abhinav.k@samsung.com>
> ---
>   arch/arm/mm/dma-mapping.c |    8 +++++---
>   include/linux/dma-attrs.h |    1 +
>   2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c0f0f43..e73003c 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1279,9 +1279,11 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
>   	if (!pages)
>   		return NULL;
>   
> -	*handle = __iommu_create_mapping(dev, pages, size);
> -	if (*handle == DMA_ERROR_CODE)
> -		goto err_buffer;
> +	if (!dma_get_attr(DMA_ATTR_NO_IOMMU_MAPPING, attrs)) {
> +		*handle = __iommu_create_mapping(dev, pages, size);
> +		if (*handle == DMA_ERROR_CODE)
> +			goto err_buffer;
> +	}
>   
>   	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
>   		return pages;
> diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
> index c8e1831..1f04419 100644
> --- a/include/linux/dma-attrs.h
> +++ b/include/linux/dma-attrs.h
> @@ -15,6 +15,7 @@ enum dma_attr {
>   	DMA_ATTR_WEAK_ORDERING,
>   	DMA_ATTR_WRITE_COMBINE,
>   	DMA_ATTR_NON_CONSISTENT,
> +	DMA_ATTR_NO_IOMMU_MAPPING,
>   	DMA_ATTR_NO_KERNEL_MAPPING,
>   	DMA_ATTR_SKIP_CPU_SYNC,
>   	DMA_ATTR_FORCE_CONTIGUOUS,

I'm sorry, but from my perspective this patch and the yet another dma
attribute shows that there is something fishy happening in the exynos-drm
driver. Creating a mapping in DMA address space is the MAIN purpose of
the DMA mapping subsystem, so adding an attribute which skips this
operation already should give you a sign of warning that something is
not used right.

It looks that dma-mapping in the current state is simply not adequate
for this driver. I noticed that DRM drivers are already known for
implementing a lots of common code for their own with slightly changed
behavior, like custom page manager/allocator. It looks that exynos-drm
driver grew to the point where it also needs such features. It already
contains custom code for CPU cache handling, IOMMU and contiguous
memory special cases management. I would advise to drop DMA-mapping
API completely, avoid adding yet another dozen of DMA attributes useful
only for one driver and implement your own memory manager with direct
usage of IOMMU API, alloc_pages() and dma_alloc_pages_from_contiguous().
This way DMA mapping subsystem can be kept simple, robust and easy to
understand without confusing or conflicting parts.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
