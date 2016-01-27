From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 27 Jan 2016 10:14:44 +0200
Subject: [PATCH v2] mmc: omap_hsmmc: don't print uninitialized variables
In-Reply-To: <3411189.gO0215GrNM@wuerfel>
References: <3411189.gO0215GrNM@wuerfel>
Message-ID: <56A87C74.2010905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2016 05:26 PM, Arnd Bergmann wrote:
> When DT based probing is used but the DMA request fails, the
> driver will print uninitialized stack data from the rx_req
> and tx_req variables, as indicated by this warning:
> 
> drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
> drivers/mmc/host/omap_hsmmc.c:2162:3: warning: 'rx_req' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
> 
> This removes the DMA request line number from the warning, which
> is the easiest solution and won't hurt us any more as we are
> planning to remove the legacy code path anyway.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> A simpler patch as v1 with the same result, as suggested by Peter Ujfalusi.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b6639ea0bf18..87f0d840a166 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2159,7 +2159,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  						 &rx_req, &pdev->dev, "rx");
>  
>  	if (!host->rx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
> +		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel\n");
>  		ret = -ENXIO;
>  		goto err_irq;
>  	}
> @@ -2169,7 +2169,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  						 &tx_req, &pdev->dev, "tx");
>  
>  	if (!host->tx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
> +		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel\n");
>  		ret = -ENXIO;
>  		goto err_irq;
>  	}
> 


-- 
P?ter
