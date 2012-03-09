From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 Mar 2012 12:00:28 +0100
Subject: [PATCH v2 01/13] dmaengine: imx-dma: merge old dma-v1.c with
 imx-dma.c
In-Reply-To: <1331130825-14947-2-git-send-email-javier.martin@vista-silicon.com>
References: <1331130825-14947-1-git-send-email-javier.martin@vista-silicon.com>
 <1331130825-14947-2-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20120309110028.GB3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 03:33:33PM +0100, Javier Martin wrote:
> It is mainly a simple merge changing the prefix of some
> functions to fit the imx-dma namings.
> 
> As there are no users of the old dma-v1.c api we can safely
> remove this file.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
> @@ -633,11 +1127,8 @@ static int __exit imxdma_remove(struct platform_device *pdev)
>  
>          dma_async_device_unregister(&imxdma->dma_device);
>  
> -	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
> -		struct imxdma_channel *imxdmac = &imxdma->channel[i];
> -
> -		 imx_dma_free(imxdmac->imxdma_channel);
> -	}
> +	for (i = 0; i < MAX_DMA_CHANNELS; i++)
> +		free_irq(MX2x_INT_DMACH0 + i, NULL);

This lacks a test for i.MX1/21/27. The above is correct for i.MX21/27,
but on i.MX1 you have to free MX1_DMA_INT/MX1_DMA_ERR.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
