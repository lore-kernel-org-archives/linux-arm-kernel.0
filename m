From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Sep 2012 15:16:31 -0700
Subject: [RFC PATCH 07/13] mmc: omap_hsmmc: dma_request_slave_channel()
 support for DT platforms
In-Reply-To: <1348152226-13588-8-git-send-email-mporter@ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-8-git-send-email-mporter@ti.com>
Message-ID: <20120920221630.GL28835@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matt Porter <mporter@ti.com> [120920 07:43]:
> For platforms with DT populated, use dma_request_slave_channel()
> to acquire the DMA channel. For !DT platforms, we fall back to
> explicitly passing the omap_dma_filter_fn() to dma_request_channel().
> Once all platforms boot from DT, the dma_request_channel() path can
> be dropped.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 3a09f93..c82d0ab 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1923,14 +1923,26 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
> +	if (pdev->dev.of_node)
> +		host->rx_chan =
> +			dma_request_slave_channel(&pdev->dev, "rx");
> +	else
> +		host->rx_chan = dma_request_channel(mask,
> +						    omap_dma_filter_fn,
> +						    &rx_req);
>  	if (!host->rx_chan) {
>  		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
>  		ret = -ENXIO;
>  		goto err_irq;
>  	}
>  
> -	host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
> +	if (pdev->dev.of_node)
> +		host->tx_chan =
> +			dma_request_slave_channel(&pdev->dev, "tx");
> +	else
> +		host->tx_chan = dma_request_channel(mask,
> +						    omap_dma_filter_fn,
> +						    &tx_req);
>  	if (!host->tx_chan) {
>  		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
>  		ret = -ENXIO;
> 

Here to the omap_hsmmc.c driver should not need to care about which
way to request the dma channels.

Regards,

Tony
