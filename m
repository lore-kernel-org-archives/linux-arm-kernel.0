From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Nov 2015 16:57:21 +0000
Subject: [RFC] ARM64: simplify dma_get_ops
In-Reply-To: <7483659.O8uXXLFCFD@wuerfel>
References: <4270550.cGd11OgA5n@wuerfel> <5118146.8KqrJiJrDe@wuerfel>
 <20151117122250.GH6556@e104818-lin.cambridge.arm.com>
 <7483659.O8uXXLFCFD@wuerfel>
Message-ID: <20151127165719.GD25499@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(sorry for the delay, I got distracted by other things)

On Tue, Nov 17, 2015 at 01:50:24PM +0100, Arnd Bergmann wrote:
> On Tuesday 17 November 2015 12:22:51 Catalin Marinas wrote:
> > 
> > > On a related note, we should also urgently fix the
> > > arch_setup_dma_ops() function to no longer ignore the base and size
> > > arguments. For dma_base, we can simply WARN_ON(dma_base != 0), so we
> > > can implement support for that whenever we need it,
> > 
> > I think we should, at least until we implement support for
> > dev->dma_pfn_offset. I'm not sure about iommu though, maybe there are
> > working configurations with dma_base != 0.
> 
> I think we can assume for now that all IOMMUs are similar to the
> ARM SMMU and don't need this.
> 
> > > but for the size we need to prevent drivers from calling
> > > dma_set_mask() with an argument larger than the size we pass in here,
> > > unless the size is also larger than max_pfn.
> > 
> > We have a default mask set up in of_dma_configure() based on size and
> > dma_base. Can we check the new mask against the default one?
> 
> The size variable here is the mask that of_dma_configure() computes,
> though it is not a "default": it is whatever the parent bus can support,
> independent of additional restrictions that may be present in the
> device and that are set by the driver.
> 
> Checking against that is what I meant above, see below for a prototype
> that I have not even compile-tested and that might be missing some corner
> cases.
> 
> We actually have the option of swapping out the dev->dma_ops in set_mask
> so we don't have to go through the swiotlb code for devices that don't
> need it.

We could indeed have a lighter implementation that only does cache
maintenance but I guess this assumes that the device supports all the
physical address space. Swiotlb detects the masks and doesn't bounce the
buffer unless necessary, so the overhead shouldn't be that large.

> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -341,6 +341,31 @@ static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
>  	return ret;
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
> +	if (mask > dev->dev_archdata.parent_dma_mask)
> +		mask = dev->dev_archdata.parent_dma_mask;

Is there any check for parent_dma_mask being supported by swiotlb? If
not, should we move the mask setting above?

-- 
Catalin
