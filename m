From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 07 May 2015 19:26:08 +0300
Subject: [PATCH 4/5] dmaengine: hsu: Fix memory leak when stopping a
 running transfer
In-Reply-To: <1427456155-28990-5-git-send-email-peter.ujfalusi@ti.com>
References: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
 <1427456155-28990-5-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1431015968.28073.15.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-03-27 at 13:35 +0200, Peter Ujfalusi wrote:
> The vd->node is removed from the lists when the transfer started so the
> vchan_get_all_descriptors() will not find it. This results memory leak.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/hsu/hsu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
> index 683ba9b62795..d1864bda008f 100644
> --- a/drivers/dma/hsu/hsu.c
> +++ b/drivers/dma/hsu/hsu.c
> @@ -387,7 +387,10 @@ static int hsu_dma_terminate_all(struct dma_chan *chan)
>  	spin_lock_irqsave(&hsuc->vchan.lock, flags);
>  
>  	hsu_dma_stop_channel(hsuc);
> -	hsuc->desc = NULL;
> +	if (hsuc->desc) {
> +		hsu_dma_desc_free(&hsuc->desc->vchan);

By the way, it should be 'vdesc);' at the end.

> +		hsuc->desc = NULL;
> +	}
>  
>  	vchan_get_all_descriptors(&hsuc->vchan, &head);
>  	spin_unlock_irqrestore(&hsuc->vchan.lock, flags);


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
