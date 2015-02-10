From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 10 Feb 2015 12:39:11 +0800
Subject: [RFC PATCH v2 2/3] arm64: add IOMMU dma_ops
In-Reply-To: <058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy@arm.com>
References: <cover.1423226542.git.robin.murphy@arm.com>
 <058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy@arm.com>
Message-ID: <1423543151.18280.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-02-06 at 14:55 +0000, Robin Murphy wrote
<...>
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 6932bb5..c1b271f 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -62,13 +62,30 @@ static inline bool is_device_dma_coherent(struct device *dev)
>  
>  #include <asm-generic/dma-mapping-common.h>
>  
> +#ifdef CONFIG_IOMMU_DMA
> +static inline struct iommu_dma_domain *get_dma_domain(struct device *dev)
> +{
> +	return dev->archdata.dma_domain;
> +}
> +
> +static inline void set_dma_domain(struct device *dev,
> +				  struct iommu_dma_domain *dma_domain)
> +{
> +	dev->archdata.dma_domain = dma_domain;
> +}
> +#endif
> +
>  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
> +	if (WARN_ON(dev && get_dma_domain(dev)))
> +		return DMA_ERROR_CODE;
>  	return (dma_addr_t)paddr;
>  }


Hi Robin, 

Build fail if CONFIG_IOMMU_DMA is not enabled.

In file included from ../include/linux/dma-mapping.h:82:0,
                 from ../arch/arm64/kernel/asm-offsets.c:23:
../arch/arm64/include/asm/dma-mapping.h: In function 'phys_to_dma':
../arch/arm64/include/asm/dma-mapping.h:81:2: error: implicit declaration of function 'get_dma_domain' [-Werror=implicit-function-declaration]
  if (WARN_ON(dev && get_dma_domain(dev)))
  ^

Joe.C
