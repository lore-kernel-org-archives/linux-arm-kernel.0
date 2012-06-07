From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Thu, 07 Jun 2012 13:50:03 +0530
Subject: [RESEND PATCH] dma: imx-sdma: buf_tail should be initialize in
 prepare function
In-Reply-To: <1338772644-3344-1-git-send-email-richard.zhao@freescale.com>
References: <1338772644-3344-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1339057203.1927.9.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-06-04 at 09:17 +0800, Richard Zhao wrote:
> This fix audio underrun issue. When SNDRV_PCM_TRIGGER_STOP
> and SNDRV_PCM_TRIGGER_START, it calls prepare again. buf_tail
> should be reset to zero.
> So move buf_tail initialization into prepare function.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/dma/imx-sdma.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index fb4f499..1dc2a4a 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -815,8 +815,6 @@ static int sdma_request_channel(struct sdma_channel *sdmac)
>  
>  	init_completion(&sdmac->done);
>  
> -	sdmac->buf_tail = 0;
> -
>  	return 0;
>  out:
>  
> @@ -927,6 +925,8 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
>  
>  	sdmac->flags = 0;
>  
> +	sdmac->buf_tail = 0;
> +
>  	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
>  			sg_len, channel);
>  
> @@ -1027,6 +1027,8 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
>  
>  	sdmac->status = DMA_IN_PROGRESS;
>  
> +	sdmac->buf_tail = 0;
> +
>  	sdmac->flags |= IMX_DMA_SG_LOOP;
>  	sdmac->direction = direction;
>  	ret = sdma_load_context(sdmac);

Applied, Thanks
-- 
~Vinod
