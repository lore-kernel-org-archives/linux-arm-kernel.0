From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 16 Feb 2016 15:02:21 +0000
Subject: [PATCH] ARM64: dma-mapping: fix IOMMU-based dma_mmap_atts()
 implementation
In-Reply-To: <1455632065-14620-1-git-send-email-m.szyprowski@samsung.com>
References: <1455632065-14620-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <56C339FD.6040907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 16/02/16 14:14, Marek Szyprowski wrote:
> IOMMU-based DMA-mapping implementation doesn't support
> dma_declare_coherent() based regions, so there is no point to call
> dma_mmap_from_coherent() from __iommu_mmap_atts(). This patch removes
> useless code.

I'm not sure that's the case - AFAICS a device could still have its own 
local memory despite being behind an IOMMU relative to the rest of the 
system. If it uses dma_declare_coherent() for that, the .alloc and .free 
callbacks here might be bypassed by dma_{alloc,free}_attrs() 
short-circuiting into dma_{alloc,release}_from_coherent(), but in the 
case of dma_mmap_attrs() it hits the .mmap callback first and only falls 
back to the from_coherent check in dma_common_mmap() if that isn't 
implemented.

Maybe the right thing to do would be to move this check (with its 
associated guards) out from dma_common_mmap() up to dma_mmap_attrs() to 
be consistent with alloc/free; so that it doesn't need to be 
reimplemented all over arch/{arm,arm64,mips} at all?

Robin.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm64/mm/dma-mapping.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 331c4ca..573b1e6 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -636,14 +636,9 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>   			      struct dma_attrs *attrs)
>   {
>   	struct vm_struct *area;
> -	int ret;
>
>   	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
>   					     is_device_dma_coherent(dev));
> -
> -	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
> -		return ret;
> -
>   	area = find_vm_area(cpu_addr);
>   	if (WARN_ON(!area || !area->pages))
>   		return -ENXIO;
>
