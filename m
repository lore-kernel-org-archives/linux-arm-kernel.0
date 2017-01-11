From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jan 2017 22:11:32 +0100
Subject: [PATCH 2/2] arm64: avoid increasing DMA masks above what hardware
 supports
In-Reply-To: <1484159512-28515-3-git-send-email-nikita.yoush@cogentembedded.com>
References: <dca35acf-1adf-aa85-7a0b-d0c6ec702fa1@arm.com>
 <1484159512-28515-1-git-send-email-nikita.yoush@cogentembedded.com>
 <1484159512-28515-3-git-send-email-nikita.yoush@cogentembedded.com>
Message-ID: <2489599.dXme8sRkvp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 11, 2017 9:31:52 PM CET Nikita Yushchenko wrote:
> @@ -959,6 +990,15 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>         if (!dev->archdata.dma_ops)
>                 dev->archdata.dma_ops = &swiotlb_dma_ops;
>  
> +       /*
> +        * Whatever the parent bus can set. A device must not set
> +        * a DMA mask larger than this.
> +        */
> +       if (enforce_range)
> +               dev->archdata.parent_dma_mask = size - 1;
> +       else
> +               dev->archdata.parent_dma_mask = DMA_BIT_MASK(64);
> +
>         dev->archdata.dma_coherent = coherent;
>         __iommu_setup_dma_ops(dev, dma_base, size, iommu);
> 

Could we just pass the mask instead of the size here?

	Arnd
