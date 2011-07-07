From: vkoul@infradead.org (Vinod Koul)
Date: Thu, 07 Jul 2011 08:03:45 +0530
Subject: [PATCH 3/3] dmaengine: at_hdmac: add slave config operation
In-Reply-To: <1151852b20789636633095406a180335364f4afb.1309259835.git.nicolas.ferre@atmel.com>
References: <fb4657207f9eb34784c10333e11c48b5638542ed.1309259835.git.nicolas.ferre@atmel.com>
	<1151852b20789636633095406a180335364f4afb.1309259835.git.nicolas.ferre@atmel.com>
Message-ID: <1310006025.20150.29.camel@psiaudioba-mobl1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-06-28 at 13:17 +0200, Nicolas Ferre wrote:
> Only change source/destination peripheral register access width.
How about a little more explainable change log

> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/dma/at_hdmac.c |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 7096adb..9cb8044 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -954,6 +954,35 @@ static int atc_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>  		clear_bit(ATC_IS_PAUSED, &atchan->status);
>  
>  		spin_unlock_irqrestore(&atchan->lock, flags);
> +	} else if (cmd == DMA_SLAVE_CONFIG) {
> +		struct dma_slave_config *dmaengine_cfg = (void *)arg;
> +		struct at_dma_slave	*atslave = chan->private;
This API was created to remove chan->private, so this doesn't make sense
at all. If your intent is to have a channels internal data, then you
should consider embedding dma_chan into this structure (the way other
dma drivers do) rather than using private field.
> +		enum dma_slave_buswidth sdma_width;
> +		enum at_dma_slave_width	atdma_width;
> +
> +		/* only modify transfer size width */
> +		if (!atslave)
> +			return -ENXIO;
> +
> +		if (dmaengine_cfg->direction == DMA_FROM_DEVICE)
> +			sdma_width = dmaengine_cfg->src_addr_width;
> +		else
> +			sdma_width = dmaengine_cfg->dst_addr_width;
> +
> +		switch (sdma_width) {
> +		case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +			atdma_width = AT_DMA_SLAVE_WIDTH_8BIT;
> +			break;
> +		case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +			atdma_width = AT_DMA_SLAVE_WIDTH_16BIT;
> +			break;
> +		case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +			atdma_width = AT_DMA_SLAVE_WIDTH_32BIT;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		atslave->reg_width = atdma_width;
>  	} else if (cmd == DMA_TERMINATE_ALL) {
>  		struct at_desc	*desc, *_desc;
>  		/*

-- 
~Vinod Koul
Intel Corp.
