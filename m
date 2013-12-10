From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 10 Dec 2013 13:06:39 -0800
Subject: [PATCHv2 2/2] arm64: Enable CMA
In-Reply-To: <1386705132-7127-3-git-send-email-lauraa@codeaurora.org>
References: <1386705132-7127-1-git-send-email-lauraa@codeaurora.org>
 <1386705132-7127-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <52A7825F.50306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 11:52 AM, Laura Abbott wrote:

>
> @@ -36,14 +37,33 @@ static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
>   	if (dev && IS_ENABLED(CONFIG_ZONE_DMA32) &&
>   	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
>   		flags |= GFP_DMA32;
> -	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
> +	if (IS_ENABLED(CONFIG_DMA_CMA)) {
> +		struct page *page;
> +
> +		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
> +							get_order(size));
> +		if (!page)
> +			return NULL;
> +
> +		return page_address(page);
> +	} else {
> +		return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
> +	}
>   }

Whoops I manged to send out the incorrect version here where I never set 
the dma_handle. Let me resend again...


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
