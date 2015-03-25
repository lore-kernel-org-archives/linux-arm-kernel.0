From: ritesh.list@gmail.com (Ritesh Harjani)
Date: Thu, 26 Mar 2015 00:09:37 +0530
Subject: [PATCH v2] ARM: mm: Do not invoke OOM for higher order IOMMU DMA
 allocations
In-Reply-To: <1427095620-20994-1-git-send-email-tfiga@chromium.org>
References: <1427095620-20994-1-git-send-email-tfiga@chromium.org>
Message-ID: <CALk7dXoacMbHKbJZ2UHd0YK9B8rZgATwNpif8cONjGkZj0YTHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, Mar 23, 2015 at 12:57 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> IOMMU should be able to use single pages as well as bigger blocks, so if
> higher order allocations fail, we should not affect state of the system,
> with events such as OOM killer, but rather fall back to order 0
> allocations.
>
> This patch changes the behavior of ARM IOMMU DMA allocator to use
> __GFP_NORETRY, which bypasses OOM invocation, for orders higher than
> zero and, only if that fails, fall back to normal order 0 allocation
> which might invoke OOM killer.

Logical thing to do in IOMMU case :)
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  arch/arm/mm/dma-mapping.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> Changes since v1:
> (https://patchwork.kernel.org/patch/6015921/)
>  - do not clear __GFP_NORETRY, as it might come from the caller,
>  - s/positive order/order higher than 0/.
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 83cd5ac..3f1ac51 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1150,13 +1150,28 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
>         gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>
>         while (count) {
> -               int j, order = __fls(count);
> +               int j, order;
> +
> +               for (order = __fls(count); order > 0; --order) {
> +                       /*
> +                        * We do not want OOM killer to be invoked as long
> +                        * as we can fall back to single pages, so we force
> +                        * __GFP_NORETRY for orders higher than zero.
> +                        */
> +                       pages[i] = alloc_pages(gfp | __GFP_NORETRY, order);
> +                       if (pages[i])
> +                               break;
> +               }
>
> -               pages[i] = alloc_pages(gfp, order);
> -               while (!pages[i] && order)
> -                       pages[i] = alloc_pages(gfp, --order);
> -               if (!pages[i])
> -                       goto error;
> +               if (!pages[i]) {
> +                       /*
> +                        * Fall back to single page allocation.
> +                        * Might invoke OOM killer as last resort.
> +                        */
> +                       pages[i] = alloc_pages(gfp, 0);
I think down the code in this while loop, i & count is being
calculated based on the "order" of allocation in the current
iteration.
Since value of order will be automatically 0 here if (!pages[i]) is
true then, why hard code order to value of 0 here.
Comment clearly says what this code is doing right?

I know it is just a minor thing. Don't know if it is relevant.

> +                       if (!pages[i])
> +                               goto error;
> +               }
>
>                 if (order) {
>                         split_page(pages[i], order);
> --
> 2.2.0.rc0.207.ga3a616c
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


Thanks
Ritesh
