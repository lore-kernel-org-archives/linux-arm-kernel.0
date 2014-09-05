From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 5 Sep 2014 18:37:41 +0300
Subject: [RFC PATCH v2 2/7] dma-mapping: replace set_arch_dma_coherent_ops
 with arch_setup_dma_ops
In-Reply-To: <1409680587-29818-3-git-send-email-will.deacon@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
 <1409680587-29818-3-git-send-email-will.deacon@arm.com>
Message-ID: <5409D8C5.9010804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 09/02/2014 08:56 PM, Will Deacon wrote:
> set_arch_dma_coherent_ops is called from of_dma_configure in order to
> swizzle the architectural dma-mapping functions over to a cache-coherent
> implementation. This is currently implemented only for ARM.
> 
> In anticipation of re-using this mechanism for IOMMU-backed dma-mapping
> ops too, this patch replaces the function with a broader
> arch_setup_dma_ops callback which is also responsible for setting the
> DMA mask and offset as well as selecting the correct mapping functions.
> 
> A further advantage of this split is that it nicely isolates the
> of-specific code from the dma-mapping code, allowing potential reuse by
> other buses (e.g. PCI) in the future.

I think this patch can introduce a regression if it will be used as is :(

When this code was initially created there ware a lot of discussion about
and finally it was decided to configure all common (for all arches) DMA 
specific parameters for devices in common code, while strictly arch 
specific things using arch specific APIs/callbacks.

The following parameters are common now:
dev->coherent_dma_mask	= mask;
dev->dma_mask		= &dev->coherent_dma_mask;
dev->dma_pfn_offset	= offset;

and they need to be set always, otherwise it will affect on other
DT-based arches.

Links:
- [PATCH v2 0/7] ARM: dma: Support dma-ranges and dma-coherent
http://www.spinics.net/lists/arm-kernel/msg311678.html

- [PATCH 0/7] of: setup dma parameters using dma-ranges and dma-coherent
https://lkml.org/lkml/2014/3/6/186

- [PATCH v2 0/7] of: setup dma parameters using dma-ranges and dma-coherent
https://lkml.org/lkml/2014/4/19/80

- [PATCH v3 0/7] of: setup dma parameters using dma-ranges and dma-coherent
http://thread.gmane.org/gmane.linux.kernel/1690224/focus=319246

> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm/include/asm/dma-mapping.h | 13 ++++++++----
>   drivers/of/platform.c              | 42 ++++++++++----------------------------
>   include/linux/dma-mapping.h        |  8 +++-----
>   3 files changed, 23 insertions(+), 40 deletions(-)
> 

[...]

> +	arch_setup_dma_ops(dev, DMA_BIT_MASK(32), offset, coherent);
>   }
>   
>   /**
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 931b70986272..0f7f7b68b0db 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -129,11 +129,9 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
>   
>   extern u64 dma_get_required_mask(struct device *dev);
>   
> -#ifndef set_arch_dma_coherent_ops
> -static inline int set_arch_dma_coherent_ops(struct device *dev)
> -{
> -	return 0;
> -}
> +#ifndef arch_setup_dma_ops
> +static inline void arch_setup_dma_ops(struct device *dev, u64 mask,
> +				      unsigned long offset, bool coherent) { }
>   #endif
>   
>   static inline unsigned int dma_get_max_seg_size(struct device *dev)
> 

Regards,
-grygorii
