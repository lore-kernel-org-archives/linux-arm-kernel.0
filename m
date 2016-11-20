From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 20 Nov 2016 18:29:02 +0530
Subject: [PATCH] spi: davinci: Allow device tree devices to use DMA
In-Reply-To: <1479530464-12538-1-git-send-email-david@lechnology.com>
References: <1479530464-12538-1-git-send-email-david@lechnology.com>
Message-ID: <79f186b5-ac71-189f-c19f-977670395043@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 19 November 2016 10:11 AM, David Lechner wrote:
> This makes SPI devices specified in a device tree use DMA when the master
> controller has DMA configured.
> 
> Since device tree is supposed to only describe the hardware, adding a
> configuration option to device tree to enable DMA per-device would not be
> acceptable. So, this is the best we can do for now to get SPI devices
> working with DMA when using device tree.
> 
> Unfortunately, this excludes the possibility of using one SPI device with
> DMA and one without on the same master.
> 
> I have tested this on LEGO MINDSTORMS EV3 using the NOR flash. Reading the
> flash memory would fail with -EIO when DMA is not enabled for the device.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  drivers/spi/spi-davinci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index d36c11b..c6cf73a 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -388,6 +388,7 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
>  static int davinci_spi_of_setup(struct spi_device *spi)
>  {
>  	struct davinci_spi_config *spicfg = spi->controller_data;
> +	struct davinci_spi *dspi = spi_master_get_devdata(spi->master);
>  	struct device_node *np = spi->dev.of_node;
>  	u32 prop;
>  
> @@ -400,6 +401,9 @@ static int davinci_spi_of_setup(struct spi_device *spi)
>  		if (!of_property_read_u32(np, "ti,spi-wdelay", &prop))
>  			spicfg->wdelay = (u8)prop;
>  		spi->controller_data = spicfg;
> +		/* Use DMA for device if master supports it */
> +		if (dspi->dma_rx)

This should be

		if (!(IS_ERR(dpsi->dma_rx) || IS_ERR(dspi->dma_tx))

> +			spicfg->io_type = SPI_IO_TYPE_DMA;

Otherwise looks good to me.

Thanks,
Sekhar
