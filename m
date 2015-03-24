From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 24 Mar 2015 10:02:32 +0100
Subject: [PATCH v2] ARM: mm: Do not invoke OOM for higher order IOMMU DMA
 allocations
In-Reply-To: <1427095620-20994-1-git-send-email-tfiga@chromium.org>
References: <1427095620-20994-1-git-send-email-tfiga@chromium.org>
Message-ID: <55112828.3010806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-03-23 08:27, Tomasz Figa wrote:
> IOMMU should be able to use single pages as well as bigger blocks, so if
> higher order allocations fail, we should not affect state of the system,
> with events such as OOM killer, but rather fall back to order 0
> allocations.
>
> This patch changes the behavior of ARM IOMMU DMA allocator to use
> __GFP_NORETRY, which bypasses OOM invocation, for orders higher than
> zero and, only if that fails, fall back to normal order 0 allocation
> which might invoke OOM killer.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm/mm/dma-mapping.c | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
>
> Changes since v1:
> (https://patchwork.kernel.org/patch/6015921/)
>   - do not clear __GFP_NORETRY, as it might come from the caller,
>   - s/positive order/order higher than 0/.
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 83cd5ac..3f1ac51 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1150,13 +1150,28 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
>   	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>   
>   	while (count) {
> -		int j, order = __fls(count);
> +		int j, order;
> +
> +		for (order = __fls(count); order > 0; --order) {
> +			/*
> +			 * We do not want OOM killer to be invoked as long
> +			 * as we can fall back to single pages, so we force
> +			 * __GFP_NORETRY for orders higher than zero.
> +			 */
> +			pages[i] = alloc_pages(gfp | __GFP_NORETRY, order);
> +			if (pages[i])
> +				break;
> +		}
>   
> -		pages[i] = alloc_pages(gfp, order);
> -		while (!pages[i] && order)
> -			pages[i] = alloc_pages(gfp, --order);
> -		if (!pages[i])
> -			goto error;
> +		if (!pages[i]) {
> +			/*
> +			 * Fall back to single page allocation.
> +			 * Might invoke OOM killer as last resort.
> +			 */
> +			pages[i] = alloc_pages(gfp, 0);
> +			if (!pages[i])
> +				goto error;
> +		}
>   
>   		if (order) {
>   			split_page(pages[i], order);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
