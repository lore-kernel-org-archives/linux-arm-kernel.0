From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 11 May 2012 11:08:39 +0530
Subject: [PATCH] dma: imx-sdma: keep the callbacks invoked in the tasklet
In-Reply-To: <1335608142-22580-1-git-send-email-b32955@freescale.com>
References: <1335608142-22580-1-git-send-email-b32955@freescale.com>
Message-ID: <1336714719.15424.1533.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-04-28 at 18:15 +0800, Huang Shijie wrote:
> The current code keeps the callbacks invoked from interrupt context, this
> does not conform to the Documentation/dmaengine.txt.
> 
> So add tasklet support to fix this issue.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
Applied Thanks
> ---
>  drivers/dma/imx-sdma.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index a894482..c492079 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -271,6 +271,7 @@ struct sdma_channel {
>  	enum dma_status			status;
>  	unsigned int			chn_count;
>  	unsigned int			chn_real_count;
> +	struct tasklet_struct		tasklet;
>  };
>  
>  #define IMX_DMA_SG_LOOP		BIT(0)
> @@ -534,8 +535,10 @@ static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
>  		sdmac->desc.callback(sdmac->desc.callback_param);
>  }
>  
> -static void mxc_sdma_handle_channel(struct sdma_channel *sdmac)
> +static void sdma_tasklet(unsigned long data)
>  {
> +	struct sdma_channel *sdmac = (struct sdma_channel *) data;
> +
>  	complete(&sdmac->done);
>  
>  	/* not interested in channel 0 interrupts */
> @@ -560,7 +563,7 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
>  		int channel = fls(stat) - 1;
>  		struct sdma_channel *sdmac = &sdma->channel[channel];
>  
> -		mxc_sdma_handle_channel(sdmac);
> +		tasklet_schedule(&sdmac->tasklet);
>  
>  		__clear_bit(channel, &stat);
>  	}
> @@ -1361,6 +1364,8 @@ static int __init sdma_probe(struct platform_device *pdev)
>  		dma_cookie_init(&sdmac->chan);
>  		sdmac->channel = i;
>  
> +		tasklet_init(&sdmac->tasklet, sdma_tasklet,
> +			     (unsigned long) sdmac);
>  		/*
>  		 * Add the channel to the DMAC list. Do not add channel 0 though
>  		 * because we need it internally in the SDMA driver. This also means


-- 
~Vinod
