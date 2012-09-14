From: vkoul@infradead.org (Vinod Koul)
Date: Fri, 14 Sep 2012 08:36:39 +0530
Subject: [PATCH] mxs/dma: Enlarge the CCW descriptor area to 4 pages
In-Reply-To: <1346731465-6301-1-git-send-email-marex@denx.de>
References: <1346731465-6301-1-git-send-email-marex@denx.de>
Message-ID: <1347591999.1943.13.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-04 at 06:04 +0200, Marek Vasut wrote:
> In case of a large SPI flash, the amount of DMA descriptors
> available to the DMA driver is not large enough anymore. For
> example 8MB SPI flash now needs 129 descriptors to be transfered
> in one long read. There are currently 53 descriptors available in
> one PAGE_SIZE-big block. Enlarge the allocated descriptor area to
> four PAGE_SIZE blocks to fulfill such requirements.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
Applied thanks
> ---
>  drivers/dma/mxs-dma.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index 7f41b25..e269325 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -101,7 +101,8 @@ struct mxs_dma_ccw {
>  	u32		pio_words[MXS_PIO_WORDS];
>  };
>  
> -#define NUM_CCW	(int)(PAGE_SIZE / sizeof(struct mxs_dma_ccw))
> +#define CCW_BLOCK_SIZE	(4 * PAGE_SIZE)
> +#define NUM_CCW	(int)(CCW_BLOCK_SIZE / sizeof(struct mxs_dma_ccw))
>  
>  struct mxs_dma_chan {
>  	struct mxs_dma_engine		*mxs_dma;
> @@ -354,14 +355,15 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
>  
>  	mxs_chan->chan_irq = data->chan_irq;
>  
> -	mxs_chan->ccw = dma_alloc_coherent(mxs_dma->dma_device.dev, PAGE_SIZE,
> -				&mxs_chan->ccw_phys, GFP_KERNEL);
> +	mxs_chan->ccw = dma_alloc_coherent(mxs_dma->dma_device.dev,
> +				CCW_BLOCK_SIZE, &mxs_chan->ccw_phys,
> +				GFP_KERNEL);
>  	if (!mxs_chan->ccw) {
>  		ret = -ENOMEM;
>  		goto err_alloc;
>  	}
>  
> -	memset(mxs_chan->ccw, 0, PAGE_SIZE);
> +	memset(mxs_chan->ccw, 0, CCW_BLOCK_SIZE);
>  
>  	if (mxs_chan->chan_irq != NO_IRQ) {
>  		ret = request_irq(mxs_chan->chan_irq, mxs_dma_int_handler,
> @@ -387,7 +389,7 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
>  err_clk:
>  	free_irq(mxs_chan->chan_irq, mxs_dma);
>  err_irq:
> -	dma_free_coherent(mxs_dma->dma_device.dev, PAGE_SIZE,
> +	dma_free_coherent(mxs_dma->dma_device.dev, CCW_BLOCK_SIZE,
>  			mxs_chan->ccw, mxs_chan->ccw_phys);
>  err_alloc:
>  	return ret;
> @@ -402,7 +404,7 @@ static void mxs_dma_free_chan_resources(struct dma_chan *chan)
>  
>  	free_irq(mxs_chan->chan_irq, mxs_dma);
>  
> -	dma_free_coherent(mxs_dma->dma_device.dev, PAGE_SIZE,
> +	dma_free_coherent(mxs_dma->dma_device.dev, CCW_BLOCK_SIZE,
>  			mxs_chan->ccw, mxs_chan->ccw_phys);
>  
>  	clk_disable_unprepare(mxs_dma->clk);
