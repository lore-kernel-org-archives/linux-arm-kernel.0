From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 13:48:09 +0100
Subject: For the problem when using swiotlb
In-Reply-To: <20141121093509.GA19783@e104818-lin.cambridge.arm.com>
References: <5469E26B.2010905@huawei.com> <2522857.bNQToYpBNt@wuerfel>
 <20141121093509.GA19783@e104818-lin.cambridge.arm.com>
Message-ID: <5029442.vhLMp7Ns7F@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 09:35:10 Catalin Marinas wrote:
> On Thu, Nov 20, 2014 at 07:40:00AM +0000, Arnd Bergmann wrote:
> > On Thursday 20 November 2014 10:57:53 Ding Tianhong wrote:
> 
> But this wouldn't help Ding's case, here the driver needs to set the
> wider DMA mask.
> 
> Anyway, back to your point, to make sure I understand what you meant (I
> can send a proper patch with log afterwards):

Thanks for putting this into code!

> @@ -88,11 +89,24 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
>  {
>  	if (!dev->dma_mask || !dma_supported(dev, mask))
>  		return -EIO;
> +	/* if asking for bigger dma mask, limit it to the bus dma ranges */
> +	if (mask > *dev->dma_mask)
> +		mask &= of_dma_get_range_mask(dev);
>  	*dev->dma_mask = mask;
>  
>  	return 0;
>  }

As you commented later, the dma_supported check indeed needs to happen
after the masking.

> +static inline int dma_set_coherent_mask(struct device *dev, u64 mask)
> +{
> +	if (!dma_supported(dev, mask))
> +		return -EIO;
> +	if (mask > dev->coherent_dma_mask)
> +		mask &= of_dma_get_range_mask(dev);
> +	dev->coherent_dma_mask = mask;
> +	return 0;
> +}

There is an interesting side problem here: the dma mask points to
coherent_dma_mask for all devices probed from DT, so this breaks
if we have any driver that sets them to different values. It is a
preexisting problem them.

>  EXPORT_SYMBOL_GPL(of_dma_get_range);
>  
> +u64 of_dma_get_range_mask(struct device *dev)
> +{
> +	u64 dma_addr, paddr, size;
> +
> +	/* no dma mask limiting if no of_node or no dma-ranges property */
> +	if (!dev->of_node ||
> +	    of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size) < 0)
> +		return DMA_BIT_MASK(64);

If no dma-ranges are present, we should assume that the bus only supports
32-bit DMA, or we could make it architecture specific. It would probably
be best for arm64 to require a dma-ranges property for doing any DMA
at all, but we can't do that on arm32 any more now.

> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 3b64d0bf5bba..50d1ac4739e6 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -200,6 +200,10 @@ static void of_dma_configure(struct device *dev)
>  	/* DMA ranges found. Calculate and set dma_pfn_offset */
>  	dev->dma_pfn_offset = PFN_DOWN(paddr - dma_addr);
>  	dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
> +
> +	/* limit the coherent_dma_mask to the dma-ranges size property */

I would change the comment to clarify that we are actually changing
the dma_mask here as well.

> +	if (size < (1ULL << 32))
> +		dev->coherent_dma_mask = DMA_BIT_MASK(ilog2(size));
>  }
>  


As you mentioned in another mail in this thread, we wouldn't be
able to suuport this case on arm64.

	Arnd
