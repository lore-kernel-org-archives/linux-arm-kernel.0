From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 00:56:31 +0100
Subject: [PATCH 3/7] S3C64XX DMA: Debugged alloc's with GFP_KERNEL flag in
	Intr context.
In-Reply-To: <1253008880-7555-1-git-send-email-jassi.brar@samsung.com>
References: <1253008880-7555-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915235631.GF13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:01:20PM +0900, Jassi wrote:
> s3c2410_dma_enqueue makes call to kzalloc and dma_pool_alloc with GFP_KERNEL
> flag set, this can be an issue for drivers, like I2S, which call s3c2410_dma_enqueue
> from dma-bufferdone callback.
> Changed the flag GFP_KERNEL to GFP_ATOMIC.

applied to next-s3c64xx-fixes, with some edits to the description.
 
> Signed-Off-by: Jassi <jassi.brar@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/dma.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
> index b26d2a2..266a107 100644
> --- a/arch/arm/plat-s3c64xx/dma.c
> +++ b/arch/arm/plat-s3c64xx/dma.c
> @@ -345,13 +345,13 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
>  	if (!chan)
>  		return -EINVAL;
>  
> -	buff = kzalloc(sizeof(struct s3c64xx_dma_buff), GFP_KERNEL);
> +	buff = kzalloc(sizeof(struct s3c64xx_dma_buff), GFP_ATOMIC);
>  	if (!buff) {
>  		printk(KERN_ERR "%s: no memory for buffer\n", __func__);
>  		return -ENOMEM;
>  	}
>  
> -	lli = dma_pool_alloc(dma_pool, GFP_KERNEL, &buff->lli_dma);
> +	lli = dma_pool_alloc(dma_pool, GFP_ATOMIC, &buff->lli_dma);
>  	if (!lli) {
>  		printk(KERN_ERR "%s: no memory for lli\n", __func__);
>  		ret = -ENOMEM;
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
