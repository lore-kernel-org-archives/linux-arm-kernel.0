From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 8 Jan 2017 10:09:46 +0300
Subject: [PATCH] arm64: do not set dma masks that device connection can't
 handle
In-Reply-To: <1483713911-2079-1-git-send-email-nikita.yoush@cogentembedded.com>
References: <9a03c05d-ad4c-0547-d1fe-01edb8b082d6@cogentembedded.com>
 <1483713911-2079-1-git-send-email-nikita.yoush@cogentembedded.com>
Message-ID: <d60c54cd-ca62-4c56-7545-17e15f80b797@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 1/6/2017 5:45 PM, Nikita Yushchenko wrote:

> It is possible that device is capable of 64-bit DMA addresses, and
> device driver tries to set wide DMA mask, but bridge or bus used to
> connect device to the system can't handle wide addresses.
>
> With swiotlb, memory above 4G still can be used by drivers for streaming
> DMA, but *dev->mask and dev->dma_coherent_mask must still keep values
> that hardware handles physically.
>
> This patch enforces that. Based on original version by
> Arnd Bergmann <arnd@arndb.de>, extended with coherent mask hadnling.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> CC: Arnd Bergmann <arnd@arndb.de>
[...]
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 290a84f..09c7900 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -352,6 +352,31 @@ static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
>  	return 1;
>  }
>
> +static int __swiotlb_set_dma_mask(struct device *dev, u64 mask)
> +{
> +	/* device is not DMA capable */
> +	if (!dev->dma_mask)
> +		return -EIO;
> +
> +	/* mask is below swiotlb bounce buffer, so fail */
> +	if (!swiotlb_dma_supported(dev, mask))
> +		return -EIO;
> +
> +	/*
> +	 * because of the swiotlb, we can return success for
> +	 * larger masks, but need to ensure that bounce buffers
> +	 * are used above parent_dma_mask, so set that as
> +	 * the effective mask.
> +	 */
> +	if (mask > dev->archdata.parent_dma_mask)
> +		mask = dev->archdata.parent_dma_mask;
> +
> +

    One empty line is enough...

> +	*dev->dma_mask = mask;
> +
> +	return 0;
> +}
> +
>  static struct dma_map_ops swiotlb_dma_ops = {
>  	.alloc = __dma_alloc,
>  	.free = __dma_free,
[...]
> @@ -957,6 +997,18 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	if (!dev->archdata.dma_ops)
>  		dev->archdata.dma_ops = &swiotlb_dma_ops;
>
> +	/*
> +	 * we don't yet support buses that have a non-zero mapping.
> +	 *  Let's hope we won't need it
> +	 */
> +	WARN_ON(dma_base != 0);
> +
> +	/*
> +	 * Whatever the parent bus can set. A device must not set
> +	 * a DMA mask larger than this.
> +	 */
> +	dev->archdata.parent_dma_mask = size;

    Not 'size - 1'?

> +
>  	dev->archdata.dma_coherent = coherent;
>  	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
>  }

MBR, Sergei
