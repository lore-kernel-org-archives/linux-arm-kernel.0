From: vkoul@infradead.org (Vinod Koul)
Date: Thu, 25 Oct 2012 09:48:09 +0530
Subject: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
In-Reply-To: <1351074456-25863-3-git-send-email-b32955@freescale.com>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>
 <1351074456-25863-3-git-send-email-b32955@freescale.com>
Message-ID: <1351138689.5263.68.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-10-24 at 18:27 +0800, Huang Shijie wrote:
> Only we meet the following conditions, we can enable the DMA support for
> auart:
> 
>   (1) We enable the DMA support in the dts file, such as
>       arch/arm/boot/dts/imx28.dtsi.
> 
>   (2) We enable the hardware flow control.
> 
>   (3) We use the mx28, not the mx23. Due to hardware bug(see errata: 2836),
>       we can not add the DMA support to mx23.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

>  
>  #define to_auart_port(u) container_of(u, struct mxs_auart_port, port)

> +
> +static int mxs_auart_dma_tx(struct mxs_auart_port *s, int size)
> +{
> +	struct dma_async_tx_descriptor *desc;
> +	struct scatterlist *sgl = &s->tx_sgl;
> +	struct dma_chan *channel = s->tx_dma_chan;
> +	u32 pio;
> +
> +	/* [1] : send PIO. Note, the first pio word is CTRL1. */
> +	pio = AUART_CTRL1_XFER_COUNT(size);
> +	desc = dmaengine_prep_slave_sg(channel, (struct scatterlist *)&pio,
> +					1, DMA_TRANS_NONE, 0);
this seems like a hack. API expects a scatterlist as argument.
Same thing about direction, NONE doesnt mean anything for dma transfer.
> +	if (!desc) {
> +		dev_err(s->dev, "step 1 error\n");
> +		return -EINVAL;
> +	}
> +
> +	/* [2] : set DMA buffer. */
> +	sg_init_one(sgl, s->tx_dma_buf, size);
> +	dma_map_sg(s->dev, sgl, 1, DMA_TO_DEVICE);
> +	desc = dmaengine_prep_slave_sg(channel, sgl,
> +			1, DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc) {
> +		dev_err(s->dev, "step 2 error\n");
> +		return -EINVAL;
> +	}
> +
> +	/* [3] : submit the DMA */
> +	desc->callback = dma_tx_callback;
> +	desc->callback_param = s;
> +	dmaengine_submit(desc);
> +	dma_async_issue_pending(channel);
> +	return 0;
> +}
> +

>  
> +static bool mxs_auart_dma_filter(struct dma_chan *chan, void *param)
> +{
> +	struct mxs_auart_port *s = param;
> +
> +	if (!mxs_dma_is_apbx(chan))
> +		return false;
> +
> +	if (s->dma_channel == chan->chan_id) {
> +		chan->private = &s->dma_data;
dont use chan->private. You need to dmaengine_slave_config API

> +		return true;
> +	}
> +	return false;
> +}
> +

-- 
Vinod Koul
Intel Corp.
