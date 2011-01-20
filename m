From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 20 Jan 2011 18:43:13 +0800
Subject: [PATCH 6/6] dmaengine: imx-sdma: avoid stopping channel in the
	middle of a BD transfer
In-Reply-To: <1295473840-17295-7-git-send-email-shawn.guo@freescale.com>
References: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
	<1295473840-17295-7-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110120104312.GA18834@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 05:50:40AM +0800, Shawn Guo wrote:
> When STOP register bit gets set, SDMA hardware will immediately stop
> the channel once the current burst other than buffer descriptor
> transfer is done.
> 
> * Change sdma_disable_channel() to only set STOP register bit after
>   polling the current BD done, so that the current BD transfer
>   corruption could be avoided.
> 
> * Increment buf_tail in mxc_sdma_handle_channel_normal() as well as
>   sdma_handle_channel_loop(), since buf_tail now is used in
>   sdma_disable_channel() which could be called in both sg and cyclic
>   cases.
> 
> * Return DMA_SUCCESS other than DMA_ERROR in sdma_disable_channel().
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  drivers/dma/imx-sdma.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index fa63ace..ae87287 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -481,6 +481,8 @@ static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
>  	else
>  		sdmac->status = DMA_SUCCESS;
>  
> +	sdmac->buf_tail++;
> +
>  	if (sdmac->desc.callback)
>  		sdmac->desc.callback(sdmac->desc.callback_param);
>  	sdmac->last_completed = sdmac->desc.cookie;
> @@ -655,9 +657,14 @@ static void sdma_disable_channel(struct sdma_channel *sdmac)
>  {
>  	struct sdma_engine *sdma = sdmac->sdma;
>  	int channel = sdmac->channel;
> +	struct sdma_buffer_descriptor *bd = &sdmac->bd[sdmac->buf_tail];
> +
> +	while (bd->mode.status & BD_DONE)
> +		cpu_relax();
>  
>  	__raw_writel(1 << channel, sdma->regs + SDMA_H_STATSTOP);
> -	sdmac->status = DMA_ERROR;
> +
> +	sdmac->status = DMA_SUCCESS;
>  }

Sorry. The patch lost the change as below.  Will pick it up in v2.

@@ -658,11 +658,15 @@ static void sdma_disable_channel(struct sdma_channel *sdmac)
        struct sdma_engine *sdma = sdmac->sdma;
        int channel = sdmac->channel;
        struct sdma_buffer_descriptor *bd = &sdmac->bd[sdmac->buf_tail];
+       u32 stat = __raw_readl(sdma->regs + SDMA_H_STATSTOP);

-       while (bd->mode.status & BD_DONE)
-               cpu_relax();
+       /* stop the channel if it's running */
+       if (stat & (1 << channel)) {
+               while (bd->mode.status & BD_DONE)
+                       cpu_relax();

-       __raw_writel(1 << channel, sdma->regs + SDMA_H_STATSTOP);
+               __raw_writel(1 << channel, sdma->regs + SDMA_H_STATSTOP);
+       }

        sdmac->status = DMA_SUCCESS;
 }

>  
>  static int sdma_config_channel(struct sdma_channel *sdmac)
> -- 
> 1.7.1
> 

-- 
Regards,
Shawn
