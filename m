From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 1 Mar 2012 11:19:05 +0100
Subject: [PATCH v2 2/2] dmaengine: Add support for multiple descriptors
 for imx-dma.
In-Reply-To: <1330445298-3522-3-git-send-email-javier.martin@vista-silicon.com>
References: <1330445298-3522-1-git-send-email-javier.martin@vista-silicon.com>
 <1330445298-3522-3-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20120301101904.GA3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 05:08:18PM +0100, Javier Martin wrote:
> dmaengine specifies the possibility that several descriptors
> can be queued for transfer. It also indicates that tasklets
> must be used for DMA callbacks.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Have you tested this patch with audio?


> +static int imxdma_xfer_desc(struct imxdma_desc *d)
> +{
> +	struct imxdma_channel *imxdmac = to_imxdma_chan(d->desc.chan);
> +	int ret;
> +
> +	/* Configure and enable */
> +	switch (d->type) {
> +	case IMXDMA_DESC_MEMCPY:
> +		ret = imx_dma_config_channel(imxdmac->imxdma_channel,
> +					  d->config_port, d->config_mem, 0, 0);
> +		if (ret < 0)
> +			return ret;
> +		ret = imx_dma_setup_single(imxdmac->imxdma_channel, d->src,
> +					   d->len, d->dest, d->dmamode);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case IMXDMA_DESC_CYCLIC:
> +		ret = imx_dma_setup_progression_handler(imxdmac->imxdma_channel,
> +							imxdma_progression);
> +		if (ret < 0)
> +			return ret;

You fall through here. Is this intended? If yes, a comment would be good
here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
