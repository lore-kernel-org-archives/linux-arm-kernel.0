From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 12 Nov 2018 18:48:30 +0200
Subject: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
In-Reply-To: <20181031155738.18367-1-tony@atomide.com>
References: <20181031155738.18367-1-tony@atomide.com>
Message-ID: <2099ae8d-ef53-ac6f-a25d-c1e1acc0d5f4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On 2018-10-31 17:57, Tony Lindgren wrote:
> With CONFIG_DMA_API_DEBUG_SG a device may produce the following warning:
> 
> "DMA-API: mapping sg segment longer than device claims to support"
> 
> We default to 64KiB if a DMA engine driver does not initialize dma_parms
> and call dma_set_max_seg_size(). This may be lower that what many MMC
> drivers do with mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count.
> 
> Let's do a sanity check for max_seg_size being higher than what DMA
> supports in mmc_add_host() and lower it as needed.

I tried to address it with:

https://patchwork.kernel.org/patch/9948967/
https://patchwork.kernel.org/patch/9948989/
https://patchwork.kernel.org/patch/9948975/

but it is back in the drawing board for now.

The problem is that with eDMA/SDMA the size limit is not bytes, but the
number of bursts. Different addr_width and burst combination would
result different max_seg_size and I can not guess before the user
provide the  dma_slave_config via dmaengine_slave_config().

I have experimental patches to modify the max_seg_size of the _channel_
proactively in response slave_config and then we should have an API to
query it from the DMA _channel_, not from the DMA device as each channel
can have different limit on the max_seg_size.

> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  drivers/mmc/core/host.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/device.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/idr.h>
>  #include <linux/of.h>
> @@ -415,6 +416,19 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>  
>  EXPORT_SYMBOL(mmc_alloc_host);
>  
> +static void mmc_check_max_seg_size(struct mmc_host *host)
> +{
> +	unsigned int max_seg_size = dma_get_max_seg_size(mmc_dev(host));
> +
> +	if (host->max_seg_size <= max_seg_size)
> +		return;
> +
> +	dev_info(mmc_dev(host), "Lowering max_seg_size for DMA: %u vs %u\n",
> +		 host->max_seg_size, max_seg_size);
> +
> +	host->max_seg_size = max_seg_size;
> +}
> +
>  /**
>   *	mmc_add_host - initialise host hardware
>   *	@host: mmc host
> @@ -430,6 +444,8 @@ int mmc_add_host(struct mmc_host *host)
>  	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
>  		!host->ops->enable_sdio_irq);
>  
> +	mmc_check_max_seg_size(host);
> +
>  	err = device_add(&host->class_dev);
>  	if (err)
>  		return err;
> 

- P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
