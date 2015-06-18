From: yong.wu@mediatek.com (Yong Wu)
Date: Thu, 18 Jun 2015 23:00:50 +0800
Subject: [PATCH v2 3/4] arm64: Add IOMMU dma_ops
In-Reply-To: <4e298538ccedbe6f593d8edc40eb3a08ad9e4df5.1434036796.git.robin.murphy@arm.com>
References: <cover.1434036796.git.robin.murphy@arm.com>
 <4e298538ccedbe6f593d8edc40eb3a08ad9e4df5.1434036796.git.robin.murphy@arm.com>
Message-ID: <1434639650.26953.13.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-06-11 at 16:54 +0100, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
> 
> Whilst proliferating per-device private IOMMU data via dev->archdata is
> less than ideal, it will do the job for now, especially since we can't
> easily handle the kind of problematic system topologies in the current
> IOMMU API anyway.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/include/asm/device.h      |   3 +
>  arch/arm64/include/asm/dma-mapping.h |  14 ++
>  arch/arm64/mm/dma-mapping.c          | 342 +++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h            |   4 +-
>  4 files changed, 361 insertions(+), 2 deletions(-)
[snip]
> +static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
> +			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +			      struct dma_attrs *attrs)
> +{
> +	struct vm_struct *area;
> +	int ret;
> +
> +	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
> +					     is_device_dma_coherent(dev));
> +
> +	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
> +		return ret;
> +
> +	area = find_vm_area(cpu_addr);
> +	if (WARN_ON(!area || area->pages))
Is it:    if (WARN_ON(!area || !area->pages))
> +		return -ENXIO;
> +
> +	return iommu_dma_mmap(area->pages, size, vma);
> +}
[snip]
>  #endif	/* __KERNEL__ */
>  #endif	/* __DMA_IOMMU_H */
