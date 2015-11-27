From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Nov 2015 21:46:37 +0100
Subject: [RFC] ARM64: simplify dma_get_ops
In-Reply-To: <20151127165719.GD25499@e104818-lin.cambridge.arm.com>
References: <4270550.cGd11OgA5n@wuerfel> <7483659.O8uXXLFCFD@wuerfel>
 <20151127165719.GD25499@e104818-lin.cambridge.arm.com>
Message-ID: <7450408.Z6bvbAd5fD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 November 2015 16:57:21 Catalin Marinas wrote:
> On Tue, Nov 17, 2015 at 01:50:24PM +0100, Arnd Bergmann wrote:
> > On Tuesday 17 November 2015 12:22:51 Catalin Marinas wrote:
> > > 
> > The size variable here is the mask that of_dma_configure() computes,
> > though it is not a "default": it is whatever the parent bus can support,
> > independent of additional restrictions that may be present in the
> > device and that are set by the driver.
> > 
> > Checking against that is what I meant above, see below for a prototype
> > that I have not even compile-tested and that might be missing some corner
> > cases.
> > 
> > We actually have the option of swapping out the dev->dma_ops in set_mask
> > so we don't have to go through the swiotlb code for devices that don't
> > need it.
> 
> We could indeed have a lighter implementation that only does cache
> maintenance but I guess this assumes that the device supports all the
> physical address space. Swiotlb detects the masks and doesn't bounce the
> buffer unless necessary, so the overhead shouldn't be that large.

Right, that part is certainly optional.

> > --- a/arch/arm64/mm/dma-mapping.c
> > +++ b/arch/arm64/mm/dma-mapping.c
> > @@ -341,6 +341,31 @@ static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
> >  	return ret;
> >  }
> >  
> > +static int __swiotlb_set_dma_mask(struct device *dev, u64 mask)
> > +{
> > +	/* device is not DMA capable */
> > +	if (!dev->dma_mask)
> > +		return -EIO;
> > +
> > +	/* mask is below swiotlb bounce buffer, so fail */
> > +	if (!swiotlb_dma_supported(dev, mask))
> > +		return -EIO;
> > +
> > +	/*
> > +	 * because of the swiotlb, we can return success for
> > +	 * larger masks, but need to ensure that bounce buffers
> > +	 * are used above parent_dma_mask, so set that as
> > +	 * the effective mask.
> > +	 */
> > +	if (mask > dev->dev_archdata.parent_dma_mask)
> > +		mask = dev->dev_archdata.parent_dma_mask;
> 
> Is there any check for parent_dma_mask being supported by swiotlb? If
> not, should we move the mask setting above?

I think swiotlb assumes that the bus can always handle all of RAM,
as that is typically the case on x86: you can have PCI devices that
don't support 64-bit DMA, but the PCI host bridge always does, and
there are practically never any DMA masters outside of PCI.

powerpc has a 'max_direct_dma_addr' variable in dev_archdata, and we
should probably use the same name rather than parent_dma_mask (but
note the difference when an offset is involved). On powerpc, we assume
that the device driver knows what memory the bus supports, which works
because there are fewer SoC vendors reusing the same parts in different
ways. The max_direct_dma_addr there appears to only be used for PCI
devices.

	Arnd
