From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Dec 2013 17:51:34 +0000
Subject: [PATCHv3 1/2] arm64: Check for NULL device before getting the
 coherent_dma_mask
In-Reply-To: <52A8A55A.9060709@codeaurora.org>
References: <1386711816-20270-1-git-send-email-lauraa@codeaurora.org>
 <1386711816-20270-2-git-send-email-lauraa@codeaurora.org>
 <20131211104239.GD26730@mudshark.cambridge.arm.com>
 <52A8A55A.9060709@codeaurora.org>
Message-ID: <20131211175134.GL26730@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 05:48:10PM +0000, Laura Abbott wrote:
> On 12/11/2013 2:42 AM, Will Deacon wrote:
> > On Tue, Dec 10, 2013 at 09:43:35PM +0000, Laura Abbott wrote:
> >> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> >> index 4bd7579..4134212 100644
> >> --- a/arch/arm64/mm/dma-mapping.c
> >> +++ b/arch/arm64/mm/dma-mapping.c
> >> @@ -33,7 +33,7 @@ static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
> >>   					  dma_addr_t *dma_handle, gfp_t flags,
> >>   					  struct dma_attrs *attrs)
> >>   {
> >> -	if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
> >> +	if (dev && IS_ENABLED(CONFIG_ZONE_DMA32) &&
> >>   	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
> >>   		flags |= GFP_DMA32;
> >>   	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
> >
> > Unless I'm misreading the code, it looks like there are paths through
> > swiotlb_alloc_coherent that will dereference the dev parameter without a
> > NULL check. Are you sure we should allow for NULL devices here?
> >
> 
> The current ARM code allows for NULL devices so that would be a 
> difference in behavior between arm and arm64. We're also relying on this 
> behavior in some code. Where exactly in swiotlb_alloc_coherent does this 
> dereference happen? The only one I see is checked with 'if (hwdev && 
> hwdev->coherent_dma_mask)'

phys_to_dma could, but doesn't. The one I spotted was buried down in:

  map_single -> swiotlb_tbl_map_single -> dma_get_seg_boundary

Will
