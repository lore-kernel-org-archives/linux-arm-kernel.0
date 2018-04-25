From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Apr 2018 11:29:38 +0200
Subject: [PATCH 3/4] ARM: dma-mapping: Implement arch_iommu_detach_device()
In-Reply-To: <20180425091815.16264-3-thierry.reding@gmail.com>
References: <20180425091815.16264-1-thierry.reding@gmail.com>
 <20180425091815.16264-3-thierry.reding@gmail.com>
Message-ID: <20180425092938.GA21182@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 11:18:14AM +0200, Thierry Reding wrote:
[...]
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 8c398fedbbb6..1957938d8c9c 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2366,6 +2366,21 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
>  	arm_iommu_release_mapping(mapping);
>  }
>  
> +void arch_iommu_detach_device(struct device *dev)
> +{
> +	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> +	const struct dma_map_ops *dma_ops;
> +
> +	if (!mapping)
> +		return;
> +
> +	arm_iommu_release_mapping(mapping);
> +	arm_iommu_detach_device(dev);
> +
> +	dma_ops = arm_get_dma_map_ops(dev->archdata.dma_coherent);
> +	set_dma_ops(dev, dma_ops);
> +}

Oh, the irony! This doesn't actually build and I failed to notice
because I forgot to enable ARM_DMA_USE_IOMMU...

Sorry about that, but I think we can use this as basis to discuss
whether the API is good and I'll make sure to properly test the next
revision before sending it out.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180425/ee6a8fdb/attachment.sig>
