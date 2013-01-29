From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 29 Jan 2013 09:49:54 +0200
Subject: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
In-Reply-To: <1359410300-26113-3-git-send-email-arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-3-git-send-email-arnd@arndb.de>
Message-ID: <1359445794.31148.34.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-01-28 at 21:58 +0000, Arnd Bergmann wrote: 
> With the new OF DMA binding, it is possible to completely avoid the
> need for platform_data for configuring a DMA channel. In cases where the
> platform has already been converted, calling dma_request_slave_channel
> should get all the necessary information from the device tree.
> 
> Like the patch that converts the dw_dma controller, this is completely
> untested and is looking for someone to try it out.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: spi-devel-general at lists.sourceforge.net
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Vinod Koul <vinod.koul@linux.intel.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  .../devicetree/bindings/spi/spi_pl022.txt          | 36 ++++++++++++++++++
>  drivers/spi/spi-pl022.c                            | 43 +++++++++++++++++++++-
>  2 files changed, 77 insertions(+), 2 deletions(-)
> 

> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1139,6 +1139,35 @@ err_no_rxchan:
>  	return -ENODEV;
>  }
>  
> +static int pl022_dma_autoprobe(struct pl022 *pl022)
> +{
> +	struct device *dev = &pl022->adev->dev;
> +
> +	/* automatically configure DMA channels from platform, normally using DT */
> +	pl022->dma_rx_channel = dma_request_slave_channel(dev, "rx");
> +	if (!pl022->dma_rx_channel)
> +		goto err_no_rxchan;
> +
> +	pl022->dma_tx_channel = dma_request_slave_channel(dev, "tx");
> +	if (!pl022->dma_tx_channel)
> +		goto err_no_txchan;
> +
> +	pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);

Where this memory will be freed?
In dependence of the answer could you consider to use
devm_kmalloc or __get_free_page?

> +	if (!pl022->dummypage)
> +		goto err_no_dummypage;
> +
> +	return 0;
> +
> +err_no_dummypage:
> +	dma_release_channel(pl022->dma_tx_channel);
> +	pl022->dma_tx_channel = NULL;
> +err_no_txchan:
> +	dma_release_channel(pl022->dma_rx_channel);
> +	pl022->dma_rx_channel = NULL;
> +err_no_rxchan:
> +	return -ENODEV;
> +}
> +		
>  static void terminate_dma(struct pl022 *pl022)
>  {
>  	struct dma_chan *rxchan = pl022->dma_rx_channel;
> @@ -1167,6 +1196,11 @@ static inline int configure_dma(struct pl022 *pl022)
>  	return -ENODEV;
>  }
>  
> +static inline int pl022_dma_autoprobe(struct pl022 *pl022)
> +{
> +	return 0;
> +}
> +
>  static inline int pl022_dma_probe(struct pl022 *pl022)
>  {
>  	return 0;
> @@ -2226,8 +2260,13 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  		goto err_no_irq;
>  	}
>  
> -	/* Get DMA channels */
> -	if (platform_info->enable_dma) {
> +	/* Get DMA channels, try autoconfiguration first */
> +	status = pl022_dma_autoprobe(pl022);
> +
> +	/* If that failed, use channels from platform_info */
> +	if (status == 0)
> +		platform_info->enable_dma = 1;
> +	else if (platform_info->enable_dma) {
>  		status = pl022_dma_probe(pl022);
>  		if (status != 0)
>  			platform_info->enable_dma = 0;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
