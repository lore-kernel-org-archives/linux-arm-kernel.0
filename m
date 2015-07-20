From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Jul 2015 17:36:45 +0100
Subject: [PATCH 1/2] arm64: dma-mapping: implement dma_get_sgtable()
In-Reply-To: <65a75c2ea16d0fff8e8ec18a8f42e204c33249ed.1437148528.git.robin.murphy@arm.com>
References: <65a75c2ea16d0fff8e8ec18a8f42e204c33249ed.1437148528.git.robin.murphy@arm.com>
Message-ID: <20150720163645.GM9908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 04:58:21PM +0100, Robin Murphy wrote:
> The default dma_common_get_sgtable() implementation relies on the CPU
> address of the buffer being a regular lowmem address. This is not always
> the case on arm64, since allocations from the various DMA pools may have
> remapped vmalloc addresses, rendering the use of virt_to_page() invalid.
> 
> Fix this by providing our own implementation based on the fact that we
> can safely derive a physical address from the DMA address in both cases.
> 
> CC: Jon Medhurst <tixy@linaro.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index d16a1ce..4b9b600 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -337,10 +337,24 @@ static int __swiotlb_mmap(struct device *dev,
>  	return __dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
>  }
>  
> +int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
> +			  void *cpu_addr, dma_addr_t handle, size_t size,
> +			  struct dma_attrs *attrs)
> +{
> +	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +
> +	if (!ret)
> +		sg_set_page(sgt->sgl, phys_to_page(dma_to_phys(dev, handle)),
> +			    PAGE_ALIGN(size), 0);
> +
> +	return ret;
> +}

Any reason not to do this in dma_common_get_sgtable?

Will
