From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 8 Dec 2009 23:06:24 +0000
Subject: [PATCH] S3C24XX: DMA: Use valid index when accessing array
In-Reply-To: <1260286961-24097-1-git-send-email-ramaxlo@gmail.com>
References: <1260286961-24097-1-git-send-email-ramaxlo@gmail.com>
Message-ID: <20091208230624.GB20364@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2009 at 11:42:41PM +0800, Ramax Lo wrote:
> The DMA_CH_VALID bit used in the channel index should be masked out before
> using it to access the channel array.

ok, applied to s3c24xx-updates.
 
> Signed-off-by: Ramax Lo <ramaxlo@gmail.com>
> ---
>  arch/arm/plat-s3c24xx/dma.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
> index f046f8c..3623b2e 100644
> --- a/arch/arm/plat-s3c24xx/dma.c
> +++ b/arch/arm/plat-s3c24xx/dma.c
> @@ -1403,11 +1403,13 @@ static struct s3c2410_dma_chan *s3c2410_dma_map_channel(int channel)
>  		ord = &dma_order->channels[channel];
>  
>  		for (ch = 0; ch < dma_channels; ch++) {
> +			int tmp;
>  			if (!is_channel_valid(ord->list[ch]))
>  				continue;
>  
> -			if (s3c2410_chans[ord->list[ch]].in_use == 0) {
> -				ch = ord->list[ch] & ~DMA_CH_VALID;
> +			tmp = ord->list[ch] & ~DMA_CH_VALID;
> +			if (s3c2410_chans[tmp].in_use == 0) {
> +				ch = tmp;
>  				goto found;
>  			}
>  		}
> -- 
> 1.5.4.3
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
