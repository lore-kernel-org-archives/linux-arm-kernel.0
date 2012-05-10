From: minchan@kernel.org (Minchan Kim)
Date: Fri, 11 May 2012 00:14:27 +0900
Subject: [PATCH] drivers: cma: don't fail if migration returns -EAGAIN
In-Reply-To: <1336655975-15729-1-git-send-email-m.szyprowski@samsung.com>
References: <1333462221-3987-1-git-send-email-m.szyprowski@samsung.com>
 <1336655975-15729-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120510151427.GB2394@barrios>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 03:19:35PM +0200, Marek Szyprowski wrote:
> alloc_contig_range() function might return -EAGAIN if migrate_pages() call

migrate_page never return -EAGAIN and I can't find any -EAGAIN return in alloc_contig_range.
Am I seeing different tree? 

> fails for some temporarily locked pages. Such case should not be fatal
> to dma_alloc_from_contiguous(), which should retry allocation like in case
> of -EBUSY error.
> 
> Reported-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/base/dma-contiguous.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 78efb03..e46e2fb 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -346,7 +346,7 @@ struct page *dma_alloc_from_contiguous(struct device *dev, int count,
>  		if (ret == 0) {
>  			bitmap_set(cma->bitmap, pageno, count);
>  			break;
> -		} else if (ret != -EBUSY) {
> +		} else if (ret != -EBUSY && ret != -EAGAIN) {
>  			goto error;
>  		}
>  		pr_debug("%s(): memory range at %p is busy, retrying\n",
> -- 
> 1.7.1.569.g6f426
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>
