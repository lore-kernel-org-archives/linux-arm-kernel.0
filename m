From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 06 Jan 2014 11:50:55 +0100
Subject: [PATCH v2] dmaengine: sirf: enable generic dt binding for dma
 channels
In-Reply-To: <1388992371-7908-1-git-send-email-21cnbao@gmail.com>
References: <1388992371-7908-1-git-send-email-21cnbao@gmail.com>
Message-ID: <52CA8A8F.70707@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2014 08:12 AM, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> move to support of_dma_request_slave_channel() and dma_request_slave_channel.
> we add a xlate() to let dma clients be able to find right dma_chan by generic
> "dmas" properties in dts.
> 
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Looks good to me, but ...

[...]
> @@ -81,6 +82,7 @@ struct sirfsoc_dma_regs {
>  
>  struct sirfsoc_dma {
>  	struct dma_device		dma;
> +	dma_cap_mask_t			cap;

... the cap field seems to be unused, ...

>  	struct tasklet_struct		tasklet;
>  	struct sirfsoc_dma_chan		channels[SIRFSOC_DMA_CHANNELS];
>  	void __iomem			*base;
> @@ -640,6 +642,18 @@ bool sirfsoc_dma_filter_id(struct dma_chan *chan, void *chan_id)
>  }
>  EXPORT_SYMBOL(sirfsoc_dma_filter_id);
>  
[...]
>  static int sirfsoc_dma_probe(struct platform_device *op)
>  {
>  	struct device_node *dn = op->dev.of_node;
> @@ -744,11 +758,21 @@ static int sirfsoc_dma_probe(struct platform_device *op)
>  	if (ret)
>  		goto free_irq;
>  
> +	/* Device-tree DMA controller registration */
> +	ret = of_dma_controller_register(dn, of_dma_sirfsoc_xlate, sdma);
> +	if (ret) {
> +		sdma->cap = dma->cap_mask;

... it is initialized here, but never used again.

> +		dev_err(dev, "failed to register DMA controller\n");
> +		goto unreg_dma_dev;
> +	}
> +
>  	pm_runtime_enable(&op->dev);
>  	dev_info(dev, "initialized SIRFSOC DMAC driver\n");
>  
>  	return 0
