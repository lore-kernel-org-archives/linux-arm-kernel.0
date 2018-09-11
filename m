From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 11 Sep 2018 11:23:30 +0100
Subject: [PATCH 1/4] arm-nommu: don't define arch_teardown_dma_ops
In-Reply-To: <20180827084711.23407-2-hch@lst.de>
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-2-hch@lst.de>
Message-ID: <8ae006ad-0aff-bab3-2c16-be1696d58b5f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/18 09:47, Christoph Hellwig wrote:
> We can just use the default implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/include/asm/dma-mapping.h | 2 ++
>  arch/arm/mm/dma-mapping-nommu.c    | 4 ----
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 8436f6ade57d..965b7c846ecb 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -100,8 +100,10 @@ static inline unsigned long dma_max_pfn(struct device *dev)
>  extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  			       const struct iommu_ops *iommu, bool coherent);
>  
> +#ifdef CONFIG_MMU
>  #define arch_teardown_dma_ops arch_teardown_dma_ops
>  extern void arch_teardown_dma_ops(struct device *dev);
> +#endif
>  
>  /* do not use this function in a driver */
>  static inline bool is_device_dma_coherent(struct device *dev)
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> index f448a0663b10..aa7aba302e76 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -237,7 +237,3 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  
>  	set_dma_ops(dev, dma_ops);
>  }
> -
> -void arch_teardown_dma_ops(struct device *dev)
> -{
> -}
> 

FWIW:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Thanks
Vladimir
