From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 01:28:32 +0100
Subject: [PATCH 4/7] S3C64XX DMA: S3C2410_DMAF_CIRCULAR disable
In-Reply-To: <1253008882-7587-1-git-send-email-jassi.brar@samsung.com>
References: <1253008882-7587-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090916002832.GN13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:01:22PM +0900, Jassi wrote:
> S3C2410_DMAF_CIRCULAR requires that we don't free buffer
> resources after TC-IRQ because we will revisit the buffer.
> During simple long term playback/capture, like movie-play,
> this may block those resources(kmem/dma_pool) unncessarily.
> This is especially a problem since we allocate them in IRQ
> context.
> For now, we disable the option and free buff resources after
> it's TC-IRQ. Also, chan->curr will point to the active buffer
> while chan->next is rendered useless.

This would have been better changing the sound driver and ensuring
it does not allocate as much memory for buffering audio.

The whole point of the circular buffer is it is allocated once and
then used until the end of playback. If what you are saying is right,
and resources are running out then somewhere either the SoC layer is
losing them or between the DMA and the I2S driver we are losing
buffers. This points to a bug in the resource management of one of
them.
 
> Signed-Off-by: Jassi <jassi.brar@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/dma.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
> index 266a107..02bc82b 100644
> --- a/arch/arm/plat-s3c64xx/dma.c
> +++ b/arch/arm/plat-s3c64xx/dma.c
> @@ -375,10 +375,12 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
>  		end->next = buff;
>  		endlli->next_lli = buff->lli_dma;
>  
> +#if 0
>  		if (chan->flags & S3C2410_DMAF_CIRCULAR) {
>  			struct s3c64xx_dma_buff *curr = chan->curr;
>  			lli->next_lli = curr->lli_dma;
>  		}
> +#endif
>  
>  		if (next == chan->curr) {
>  			writel(buff->lli_dma, chan->regs + PL080_CH_LLI);
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
