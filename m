From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 22 Aug 2012 08:30:53 +0300
Subject: [Linaro-mm-sig] [PATCH 2/3] ARM: DMA-Mapping: print warning
 when atomic coherent allocation fails
In-Reply-To: <1345459648-24263-3-git-send-email-m.szyprowski@samsung.com>
References: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
 <1345459648-24263-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120822083053.42efc6162076534250112652@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Aug 2012 12:47:27 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> Print a loud warning when system runs out of memory from atomic coherent
> pool to let users notice the potential problem.
> 
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mm/dma-mapping.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index d1cc9c1..25963ea 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -461,6 +461,9 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
>  		bitmap_set(pool->bitmap, pageno, count);
>  		ptr = pool->vaddr + PAGE_SIZE * pageno;
>  		*ret_page = pool->page + pageno;
> +	} else {
> +		pr_err("Atomic coherent pool too small!\n"
> +		       "Please increase it with  kernel parameter!\n");

It might be a little bit nicer if the current pool size is printed in
the above too. That could be the hint for how much to specify in
"coherent_pool=".
