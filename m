From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Dec 2013 10:42:39 +0000
Subject: [PATCHv3 1/2] arm64: Check for NULL device before getting the
 coherent_dma_mask
In-Reply-To: <1386711816-20270-2-git-send-email-lauraa@codeaurora.org>
References: <1386711816-20270-1-git-send-email-lauraa@codeaurora.org>
 <1386711816-20270-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <20131211104239.GD26730@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 09:43:35PM +0000, Laura Abbott wrote:
> The device passed in to dma_alloc may be NULL. Check for this before
> trying to get the coherent_dma_mask.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm64/mm/dma-mapping.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 4bd7579..4134212 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -33,7 +33,7 @@ static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
>  					  dma_addr_t *dma_handle, gfp_t flags,
>  					  struct dma_attrs *attrs)
>  {
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
> +	if (dev && IS_ENABLED(CONFIG_ZONE_DMA32) &&
>  	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
>  		flags |= GFP_DMA32;
>  	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);

Unless I'm misreading the code, it looks like there are paths through
swiotlb_alloc_coherent that will dereference the dev parameter without a
NULL check. Are you sure we should allow for NULL devices here?

Will
