From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Apr 2013 17:31:56 +0200
Subject: [PATCH] mmc: mmci: Allow MMCI to request channels with
 information acquired from DT
In-Reply-To: <20130417150437.GA3137@gmail.com>
References: <1366205534-25079-1-git-send-email-lee.jones@linaro.org>
 <201304171550.56037.arnd@arndb.de> <20130417150437.GA3137@gmail.com>
Message-ID: <201304171731.56292.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 April 2013, Lee Jones wrote:
> > This looks unnecessarily complex.
> 
> That thought did cross my mind.
> 
> > Why not just do dma_request_slave_channel_compat() unconditionally here?
> 
> So how about something like this instead, as it keeps the current
> semantics, and only differs in the case of DT.

Yes, looks better.

> @@ -298,14 +298,16 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>   * no custom DMA interfaces are supported.
>   */
>  #ifdef CONFIG_DMA_ENGINE
> -static void mmci_dma_setup(struct mmci_host *host)
> +static void mmci_dma_setup(struct amba_device *dev,
> +			   struct mmci_host *host)
>  {
> +	struct device_node *np = dev->dev.of_node;
>  	struct mmci_platform_data *plat = host->plat;
>  	const char *rxname, *txname;
>  	dma_cap_mask_t mask;
>  
> -	if (!plat || !plat->dma_filter) {
> -		dev_info(mmc_dev(host->mmc), "no DMA platform data\n");
> +	if (!(plat && plat->dma_filter) && !np) {
> +		dev_info(mmc_dev(host->mmc), "no DMA platform data or DT\n");
>  		return;
>  	}

I think you can further simplify this, given that in the DT case we always
allocate a zeroed mmci_platform_data for host->plat, so !plat cannot happen
when we get here.

> @@ -321,19 +323,21 @@ static void mmci_dma_setup(struct mmci_host *host)
>  	 * attempt to use it bidirectionally, however if it is
>  	 * is specified but cannot be located, DMA will be disabled.
>  	 */
> -	if (plat->dma_rx_param) {
> -		host->dma_rx_channel = dma_request_channel(mask,
> -							   plat->dma_filter,
> -							   plat->dma_rx_param);
> +	if ((plat && plat->dma_rx_param) || np) {
> +		host->dma_rx_channel = dma_request_slave_channel_compat(mask,
> +					(plat) ? plat->dma_filter : NULL,
> +					(plat) ? plat->dma_rx_param : NULL,
> +					&dev->dev, "rx");
>  		/* E.g if no DMA hardware is present */
>  		if (!host->dma_rx_channel)
>  			dev_err(mmc_dev(host->mmc), "no RX DMA channel\n");

And based on that, you can unconditionally pass plat->dma_filter and
plat->dma_rx_param here. In case of DT, they will be NULL, and they
will not be used either.

	Arnd
