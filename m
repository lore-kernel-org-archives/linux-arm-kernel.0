From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Sep 2012 15:09:31 -0700
Subject: [RFC PATCH 10/13] spi: omap2-mcspi:
 dma_request_slave_channel() support for DT platforms
In-Reply-To: <1348152226-13588-11-git-send-email-mporter@ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-11-git-send-email-mporter@ti.com>
Message-ID: <20120920220931.GJ28835@atomide.com>
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
>  drivers/spi/spi-omap2-mcspi.c |   68 +++++++++++++++++++++++++++++------------
>  1 file changed, 48 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 9502566..1cf1072 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -104,6 +104,9 @@ struct omap2_mcspi_dma {
>  
>  	struct completion dma_tx_completion;
>  	struct completion dma_rx_completion;
> +
> +	char dma_rx_ch_name[14];
> +	char dma_tx_ch_name[14];
>  };
>  
>  /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
> @@ -798,14 +801,26 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  	sig = mcspi_dma->dma_rx_sync_dev;
> -	mcspi_dma->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> +	if (spi->dev.of_node)
> +		mcspi_dma->dma_rx =
> +			dma_request_slave_channel(&master->dev,
> +						  mcspi_dma->dma_rx_ch_name);
> +	else
> +		mcspi_dma->dma_rx =
> +			dma_request_channel(mask, omap_dma_filter_fn, &sig);
>  	if (!mcspi_dma->dma_rx) {
>  		dev_err(&spi->dev, "no RX DMA engine channel for McSPI\n");
>  		return -EAGAIN;
>  	}
>  

Hmm this does not look nice.. We should be able to somehow not to care about
the configuration at the mcspi driver level.

Regards,

Tony
