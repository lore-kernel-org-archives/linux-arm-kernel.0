From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 7 Jun 2013 12:22:15 +0200 (CEST)
Subject: [PATCH 2/2] ARM: shmobile: sdhi: remove DMA hardware dependencies
In-Reply-To: <1370008605-3745603-2-git-send-email-arnd@arndb.de>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <1370008605-3745603-2-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.64.1306071214200.11277@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

Unrelated to the original trigger, that prompted you to look at this, I 
don't think this would work:

On Fri, 31 May 2013, Arnd Bergmann wrote:

> The MMC driver should not need to care what the dma engine
> is that it is using, so it must not rely on the argument
> to the filter function to be a 'slave_id' value.
> 
> Passing the slave id in dmaengine_slave_config is not
> portable, and does not work with DT-enabled systems,
> so this turns the filter argument into a void pointer
> that gets set by the platform code and gets passed
> to the dmaengine code as an opaque value.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/board-ag5evm.c          |  4 ++--
>  arch/arm/mach-shmobile/board-ap4evb.c          |  8 ++++----
>  arch/arm/mach-shmobile/board-armadillo800eva.c |  8 ++++----
>  arch/arm/mach-shmobile/board-kzm9g.c           |  8 ++++----
>  arch/arm/mach-shmobile/board-mackerel.c        | 12 ++++++------
>  drivers/mmc/host/sh_mobile_sdhi.c              | 20 +++-----------------
>  drivers/mmc/host/tmio_mmc_dma.c                |  6 ++----
>  include/linux/mfd/tmio.h                       |  2 --
>  include/linux/mmc/sh_mobile_sdhi.h             |  5 +++--
>  9 files changed, 28 insertions(+), 45 deletions(-)

Aren't you forgetting about arch/sh?

> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index efe3386..c4a0aab 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -185,23 +185,9 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>  		if (p->get_cd)
>  			mmc_data->get_cd = sh_mobile_sdhi_get_cd;
>  
> -		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
> -			/*
> -			 * Yes, we have to provide slave IDs twice to TMIO:
> -			 * once as a filter parameter and once for channel
> -			 * configuration as an explicit slave ID
> -			 */
> -			dma_priv->chan_priv_tx = (void *)p->dma_slave_tx;
> -			dma_priv->chan_priv_rx = (void *)p->dma_slave_rx;
> -			/*
> -			 * This is a layering violation: the slave driver
> -			 * should not be aware that the chan_priv_* is the
> -			 * slave id.
> -			 * We should not really need to set the slave id
> -			 * here anyway. -arnd
> -			 */
> -			dma_priv->slave_id_tx = p->dma_slave_tx;
> -			dma_priv->slave_id_rx = p->dma_slave_rx;
> +		if (p->dma_slave_tx && p->dma_slave_rx) {
> +			dma_priv->chan_priv_tx = p->dma_slave_tx;
> +			dma_priv->chan_priv_rx = p->dma_slave_rx;
>  			dma_priv->filter = p->dma_filter;
>  		}
>  	}
> diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
> index 47bdb8f..caad28e 100644
> --- a/drivers/mmc/host/tmio_mmc_dma.c
> +++ b/drivers/mmc/host/tmio_mmc_dma.c
> @@ -290,8 +290,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
>  		if (!host->chan_tx)
>  			return;
>  
> -		if (pdata->dma->chan_priv_tx)
> -			cfg.slave_id = pdata->dma->slave_id_tx;
> +		cfg.slave_id = 0; /* already set */
>  		cfg.direction = DMA_MEM_TO_DEV;
>  		cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->bus_shift);
>  		cfg.src_addr = 0;
> @@ -308,8 +307,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
>  		if (!host->chan_rx)
>  			goto ereqrx;
>  
> -		if (pdata->dma->chan_priv_rx)
> -			cfg.slave_id = pdata->dma->slave_id_rx;
> +		cfg.slave_id = 0;

slave_id is needed for the DMAC driver to configure slave DMA. And this 
_is_ the current mainstreem method (in the non-DT case) to configure slave 
DMA, AFAIK. In the non-DT case the filter function is used to verify, 
whether this slave can be served with this channel, and 
dmaengine_slave_config() is used to actually configure the channel for 
slave DMA.

>  		cfg.direction = DMA_DEV_TO_MEM;
>  		cfg.src_addr = cfg.dst_addr;
>  		cfg.dst_addr = 0;
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index ce35113..0990d8a 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -86,8 +86,6 @@ struct dma_chan;
>  struct tmio_mmc_dma {
>  	void *chan_priv_tx;
>  	void *chan_priv_rx;
> -	int slave_id_tx;
> -	int slave_id_rx;
>  	int alignment_shift;
>  	bool (*filter)(struct dma_chan *chan, void *arg);
>  };
> diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
> index 342f07b..66a7d1c 100644
> --- a/include/linux/mmc/sh_mobile_sdhi.h
> +++ b/include/linux/mmc/sh_mobile_sdhi.h
> @@ -2,6 +2,7 @@
>  #define LINUX_MMC_SH_MOBILE_SDHI_H
>  
>  #include <linux/types.h>
> +#include <linux/dmaengine.h>
>  
>  struct platform_device;
>  
> @@ -18,8 +19,8 @@ struct sh_mobile_sdhi_ops {
>  };
>  
>  struct sh_mobile_sdhi_info {
> -	int dma_slave_tx;
> -	int dma_slave_rx;
> +	void *dma_slave_tx;
> +	void *dma_slave_rx;
>  	dma_filter_fn dma_filter;
>  	unsigned long tmio_flags;
>  	unsigned long tmio_caps;
> -- 
> 1.8.1.2
> 

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
