From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 24 Sep 2012 09:05:08 +0200
Subject: [PATCH] ARM: dma-mapping: Fix potential memory leak in
 atomic_pool_init()
In-Reply-To: <1347858583-13338-1-git-send-email-sachin.kamat@linaro.org>
References: <1347858583-13338-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <049301cd9a22$f0b8c960$d22a5c20$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, September 17, 2012 7:10 AM Sachin Kamat wrote:

> When either of __alloc_from_contiguous or __alloc_remap_buffer fails
> to provide a valid pointer, allocated memory is freed up and an error
> is returned. 'pages' was however not freed before returning error.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  arch/arm/mm/dma-mapping.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 546a3e8..477a2d2 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -367,6 +367,8 @@ static int __init atomic_pool_init(void)
>  		       (unsigned)pool->size / 1024);
>  		return 0;
>  	}
> +
> +	kfree(pages);
>  no_pages:
>  	kfree(bitmap);
>  no_bitmap:
> --
> 1.7.4.1

Applied to my fixes-for-3.6 branch. Thanks for spotting this issue!

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
