From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jan 2012 10:51:06 +0000
Subject: [PATCH 3/4] dma: imx-dma: start transfer in issue_pending
In-Reply-To: <1326101570-3716-4-git-send-email-s.hauer@pengutronix.de>
References: <1326101570-3716-1-git-send-email-s.hauer@pengutronix.de>
 <1326101570-3716-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120109105106.GI21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 10:32:49AM +0100, Sascha Hauer wrote:
> The DMA API requires that transfers are started in issue_pending

DMA engine API != DMA API.

> instead of tx_submit. Fix this.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/dma/imx-dma.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
> index 4be55f9..217207b 100644
> --- a/drivers/dma/imx-dma.c
> +++ b/drivers/dma/imx-dma.c
> @@ -186,8 +186,6 @@ static dma_cookie_t imxdma_tx_submit(struct dma_async_tx_descriptor *tx)
>  
>  	cookie = imxdma_assign_cookie(imxdmac);
>  
> -	imx_dma_enable(imxdmac->imxdma_channel);
> -
>  	spin_unlock_irq(&imxdmac->lock);
>  
>  	return cookie;
> @@ -332,9 +330,10 @@ static struct dma_async_tx_descriptor *imxdma_prep_dma_cyclic(
>  
>  static void imxdma_issue_pending(struct dma_chan *chan)
>  {
> -	/*
> -	 * Nothing to do. We only have a single descriptor
> -	 */
> +	struct imxdma_channel *imxdmac = to_imxdma_chan(chan);
> +
> +	if (imxdmac->status == DMA_IN_PROGRESS)
> +		imx_dma_enable(imxdmac->imxdma_channel);
>  }
>  
>  static int __init imxdma_probe(struct platform_device *pdev)
> -- 
> 1.7.7.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
