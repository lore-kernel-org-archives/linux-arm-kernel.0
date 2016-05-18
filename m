From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 18 May 2016 14:07:57 +0300
Subject: [RFC PATCH 2/3] mmc: host: omap_hsmmc: Enable ADMA2
In-Reply-To: <1463561115-31798-3-git-send-email-kishon@ti.com>
References: <1463561115-31798-1-git-send-email-kishon@ti.com>
 <1463561115-31798-3-git-send-email-kishon@ti.com>
Message-ID: <5a9e0163-1fbb-e0a6-95ff-0b720ba5c110@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/16 11:45, Kishon Vijay Abraham I wrote:

> +static int omap_hsmmc_dma_init(struct omap_hsmmc_host *host)
> +{
> +	dma_cap_mask_t mask;
> +	unsigned int tx_req, rx_req;
> +	struct resource *res;
> +	struct platform_device *pdev = to_platform_device(host->dev);
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	if (!pdev->dev.of_node) {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> +		if (!res) {
> +			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> +			return -ENXIO;
> +		}
> +		tx_req = res->start;
> +
> +		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> +		if (!res) {
> +			dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> +			return -ENXIO;
> +		}
> +		rx_req = res->start;
> +	}
> +
> +	host->rx_chan =
> +		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> +						 &rx_req, &pdev->dev, "rx");
> +
> +	if (!host->rx_chan) {
> +		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel\n");
> +		return -ENXIO;
> +	}
> +
> +	host->tx_chan =
> +		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> +						 &tx_req, &pdev->dev, "tx");
> +
> +	if (!host->tx_chan) {
> +		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel\n");
> +		return -ENXIO;

upstream moved to use dma_request_chan() so this part needs to be changed.

> +	}
> +
> +	return 0;
> +}
> +
> +static void omap_hsmmc_dma_exit(struct omap_hsmmc_host *host)
> +{
> +	if (host->tx_chan)
> +		dma_release_channel(host->tx_chan);
> +	if (host->rx_chan)
> +		dma_release_channel(host->rx_chan);
> +}
> +
>  static int omap_hsmmc_probe(struct platform_device *pdev)
>  {
>  	struct omap_hsmmc_platform_data *pdata = pdev->dev.platform_data;
> @@ -2000,8 +2219,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int ret, irq;
>  	const struct of_device_id *match;
> -	dma_cap_mask_t mask;
> -	unsigned tx_req, rx_req;
>  	const struct omap_mmc_of_data *data;
>  	void __iomem *base;
>  
> @@ -2114,7 +2331,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  	mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
>  	mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
>  	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
> -	mmc->max_seg_size = mmc->max_req_size;
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)
> +		mmc->max_seg_size = ADMA_MAX_LEN;
> +	else
> +		mmc->max_seg_size = mmc->max_req_size;
>  
>  	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>  		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
> @@ -2130,46 +2350,12 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  
>  	omap_hsmmc_conf_bus_power(host);
>  
> -	if (!pdev->dev.of_node) {
> -		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> -		if (!res) {
> -			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> -			ret = -ENXIO;
> -			goto err_irq;
> -		}
> -		tx_req = res->start;
> -
> -		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> -		if (!res) {
> -			dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> -			ret = -ENXIO;
> -			goto err_irq;
> -		}
> -		rx_req = res->start;
> -	}
> -
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -
> -	host->rx_chan =
> -		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> -						 &rx_req, &pdev->dev, "rx");
> -
> -	if (!host->rx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel\n");
> -		ret = -ENXIO;
> -		goto err_irq;
> -	}
> -
> -	host->tx_chan =
> -		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> -						 &tx_req, &pdev->dev, "tx");
> -
> -	if (!host->tx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel\n");
> -		ret = -ENXIO;
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)
> +		ret = omap_hsmmc_adma_init(host);
> +	else
> +		ret = omap_hsmmc_dma_init(host);
> +	if (ret)
>  		goto err_irq;
> -	}
>  
>  	/* Request IRQ for MMC operations */
>  	ret = devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
> @@ -2225,11 +2411,11 @@ err_slot_name:
>  	mmc_remove_host(mmc);
>  err_irq:
>  	device_init_wakeup(&pdev->dev, false);
> -	if (host->tx_chan)
> -		dma_release_channel(host->tx_chan);
> -	if (host->rx_chan)
> -		dma_release_channel(host->rx_chan);
>  	pm_runtime_dont_use_autosuspend(host->dev);
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)
> +		omap_hsmmc_adma_exit(host);
> +	else
> +		omap_hsmmc_dma_exit(host);
>  	pm_runtime_put_sync(host->dev);
>  	pm_runtime_disable(host->dev);
>  	if (host->dbclk)
> @@ -2248,8 +2434,10 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
>  	pm_runtime_get_sync(host->dev);
>  	mmc_remove_host(host->mmc);
>  
> -	dma_release_channel(host->tx_chan);
> -	dma_release_channel(host->rx_chan);
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)
> +		omap_hsmmc_adma_exit(host);
> +	else
> +		omap_hsmmc_dma_exit(host);
>  
>  	pm_runtime_dont_use_autosuspend(host->dev);
>  	pm_runtime_put_sync(host->dev);
> diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
> index 8e981be..e26013d 100644
> --- a/include/linux/platform_data/hsmmc-omap.h
> +++ b/include/linux/platform_data/hsmmc-omap.h
> @@ -27,6 +27,7 @@
>  #define OMAP_HSMMC_SUPPORTS_DUAL_VOLT		BIT(0)
>  #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
>  #define OMAP_HSMMC_SWAKEUP_MISSING		BIT(2)
> +#define OMAP_HSMMC_USE_ADMA			BIT(3)
>  
>  struct omap_hsmmc_dev_attr {
>  	u8 flags;
> 


-- 
P?ter
