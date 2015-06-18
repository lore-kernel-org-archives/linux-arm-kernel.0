From: yong.wu@mediatek.com (Yong Wu)
Date: Thu, 18 Jun 2015 23:00:25 +0800
Subject: [PATCH v2 2/4] iommu: Implement common IOMMU ops for DMA mapping
In-Reply-To: <bf63d80c36533aa4dcc401b5a4b312ba00237e1c.1434036796.git.robin.murphy@arm.com>
References: <cover.1434036796.git.robin.murphy@arm.com>
 <bf63d80c36533aa4dcc401b5a4b312ba00237e1c.1434036796.git.robin.murphy@arm.com>
Message-ID: <1434639625.26953.12.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,
    while our drm test, we meet a problem while dma-mmap.

 On Thu, 2015-06-11 at 16:54 +0100, Robin Murphy wrote:
> Taking inspiration from the existing arch/arm code, break out some
> generic functions to interface the DMA-API to the IOMMU-API. This will
> do the bulk of the heavy lifting for IOMMU-backed dma-mapping.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/Kconfig     |   7 +
>  drivers/iommu/Makefile    |   1 +
>  drivers/iommu/dma-iommu.c | 560 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h |  94 ++++++++
>  4 files changed, 662 insertions(+)
>  create mode 100644 drivers/iommu/dma-iommu.c
>  create mode 100644 include/linux/dma-iommu.h
> 
[snip]
> +/**
> + * iommu_dma_mmap - Map a buffer into provided user VMA
> + * @pages: Array representing buffer from iommu_dma_alloc()
> + * @size: Size of buffer in bytes
> + * @vma: VMA describing requested userspace mapping
> + *
> + * Maps the pages of the buffer in @pages into @vma. The caller is responsible
> + * for verifying the correct size and protection of @vma beforehand.
> + */
> +
> +int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
> +{
> +	unsigned long uaddr = vma->vm_start;
> +	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	int ret = -ENXIO;
> +
> +	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
Is it :  for (i = 0; i < count && uaddr < vma->vm_end; i++)

> +		ret = vm_insert_page(vma, uaddr, pages[i]);
> +		if (ret)
> +			break;
> +		uaddr += PAGE_SIZE;
> +	}
> +	return ret;
> +}
> +
