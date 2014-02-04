From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 4 Feb 2014 18:00:03 +0000
Subject: [PATCH] arm64: Align CMA sizes to PAGE_SIZE
In-Reply-To: <1391214234-23526-1-git-send-email-lauraa@codeaurora.org>
References: <1391214234-23526-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140204180003.GO30676@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 01, 2014 at 12:23:54AM +0000, Laura Abbott wrote:
> dma_alloc_from_contiguous takes number of pages for a size.
> Align up the dma size passed in to page size to avoid truncation
> and allocation failures on sizes less than PAGE_SIZE.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm64/mm/dma-mapping.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 864b256..be2696e 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -44,6 +44,8 @@ static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
>  		flags |= GFP_DMA32;
>  	if (IS_ENABLED(CONFIG_CMA)) {
>  		unsigned long pfn;
> +
> +		size = PAGE_ALIGN(size);
>  		pfn = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
>  							get_order(size));

The patch looks ok, but it doesn't apply. In my kernel (3.14-rc1),
dma_alloc_from_contiguous returns a struct page.

Thanks.

-- 
Catalin
