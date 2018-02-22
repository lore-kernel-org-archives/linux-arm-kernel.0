From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 22 Feb 2018 17:51:15 +0000
Subject: [PATCH] arm64: Revert L1_CACHE_SHIFT back to 6 (64-byte cache
 line size)
In-Reply-To: <20180222160638.16162-1-catalin.marinas@arm.com>
References: <20180222160638.16162-1-catalin.marinas@arm.com>
Message-ID: <486469c2-cc8a-d76b-6ad4-47347de627f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/02/18 16:06, Catalin Marinas wrote:
[...]
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index a96ec0181818..36deb34dd956 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -33,6 +33,7 @@
>   #include <asm/cacheflush.h>
>   
>   static int swiotlb __ro_after_init;
> +DEFINE_STATIC_KEY_FALSE(swiotlb_noncoherent_bounce);
>   
>   static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
>   				 bool coherent)
> @@ -882,6 +883,20 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   			const struct iommu_ops *iommu, bool coherent)
>   {
> +	/*
> +	 * Enable swiotlb for buffer bouncing if ARCH_DMA_MINALIGN < CWG.
> +	 * dma_capable() forces the actual bounce if the device is
> +	 * non-coherent.
> +	 */
> +	if (WARN_TAINT_ONCE(!coherent && ARCH_DMA_MINALIGN < cache_line_size(),
> +			    TAINT_CPU_OUT_OF_SPEC,
> +			    "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
> +			    ARCH_DMA_MINALIGN, cache_line_size())) {
> +		static_branch_enable(&swiotlb_noncoherent_bounce);
> +		swiotlb = 1;

I think it's possible (if a little contrived) for the first non-coherent 
device to only appear after loading a module from userspace, wherein 
this would fall foul of __ro_after_init. That said, it would be nice to 
keep the logic in arm64_dma_init() consistent with its mirror in 
mem_init() (i.e. add the GWC check there as below), at which point the 
aforementioned problem no longer applies anyway.

Robin.

> +		iommu = NULL;
> +	}
> +
>   	if (!dev->dma_ops)
>   		dev->dma_ops = &arm64_swiotlb_dma_ops;
>   
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9f3c47acf8ff..664acf177799 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -586,7 +586,8 @@ static void __init free_unused_memmap(void)
>   void __init mem_init(void)
>   {
>   	if (swiotlb_force == SWIOTLB_FORCE ||
> -	    max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT))
> +	    max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT) ||
> +	    ARCH_DMA_MINALIGN < cache_line_size())
>   		swiotlb_init(1);
>   	else
>   		swiotlb_force = SWIOTLB_NO_FORCE;
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
