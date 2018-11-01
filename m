From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 1 Nov 2018 12:03:44 -0700
Subject: [PATCH] ARM64: dma: move swiotlb helpers under CONFIG_IOMMU_DMA
In-Reply-To: <20181101185340.32664-1-olof@lixom.net>
References: <20181101185340.32664-1-olof@lixom.net>
Message-ID: <5b524dcf-f78c-25af-6a70-9c85aa8e4a42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/1/18 11:53 AM, Olof Johansson wrote:
> Fixes the following tinyconfig warnings:
> arch/arm64/mm/dma-mapping.c:174:12: warning: '__swiotlb_mmap_pfn' defined but not used [-Wunused-function]
> arch/arm64/mm/dma-mapping.c:163:12: warning: '__swiotlb_get_sgtable_page' defined but not used [-Wunused-function]
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Christoph sent an alternative solution here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-October/609480.html

> ---
>  arch/arm64/mm/dma-mapping.c | 58 ++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 3a703e5d4e32..62356c64e180 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -160,35 +160,6 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
>  	__dma_unmap_area(phys_to_virt(paddr), size, dir);
>  }
>  
> -static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
> -				      struct page *page, size_t size)
> -{
> -	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> -
> -	if (!ret)
> -		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> -
> -	return ret;
> -}
> -
> -static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
> -			      unsigned long pfn, size_t size)
> -{
> -	int ret = -ENXIO;
> -	unsigned long nr_vma_pages = vma_pages(vma);
> -	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long off = vma->vm_pgoff;
> -
> -	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
> -		ret = remap_pfn_range(vma, vma->vm_start,
> -				      pfn + off,
> -				      vma->vm_end - vma->vm_start,
> -				      vma->vm_page_prot);
> -	}
> -
> -	return ret;
> -}
> -
>  static int __init atomic_pool_init(void)
>  {
>  	pgprot_t prot = __pgprot(PROT_NORMAL_NC);
> @@ -358,6 +329,35 @@ arch_initcall(arm64_dma_init);
>  #include <linux/platform_device.h>
>  #include <linux/amba/bus.h>
>  
> +static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
> +				      struct page *page, size_t size)
> +{
> +	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +
> +	if (!ret)
> +		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> +
> +	return ret;
> +}
> +
> +static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
> +			      unsigned long pfn, size_t size)
> +{
> +	int ret = -ENXIO;
> +	unsigned long nr_vma_pages = vma_pages(vma);
> +	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	unsigned long off = vma->vm_pgoff;
> +
> +	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
> +		ret = remap_pfn_range(vma, vma->vm_start,
> +				      pfn + off,
> +				      vma->vm_end - vma->vm_start,
> +				      vma->vm_page_prot);
> +	}
> +
> +	return ret;
> +}
> +
>  /* Thankfully, all cache ops are by VA so we can ignore phys here */
>  static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
>  {
> 


-- 
Florian
