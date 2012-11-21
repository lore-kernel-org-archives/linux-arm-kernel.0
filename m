From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 21 Nov 2012 14:35:52 -0500
Subject: [PATCH] ARM: Kirkwood: Add SPI_CHPA and SPI_CPOL support to
 spi-orion
In-Reply-To: <20121121192335.GA14868@obsidianresearch.com>
References: <20121121192335.GA14868@obsidianresearch.com>
Message-ID: <20121121193552.GE15800@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 12:23:35PM -0700, Jason Gunthorpe wrote:
> Support these transfer modes from the SPI layer by setting
> the appropriate register bits before doing the transfer.
> 
> This was tested on the Marvell kirkwood SOC that uses this driver.
> 
> Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Signed-off-by: Rolf Manderscheid <rvm@obsidianresearch.com>
> ---
>  drivers/spi/spi-orion.c |   25 ++++++++++++++++++++++++-
>  1 files changed, 24 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index b17c09c..011186d 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -32,8 +32,12 @@
>  #define ORION_SPI_DATA_IN_REG		0x0c
>  #define ORION_SPI_INT_CAUSE_REG		0x10
>  
> +#define ORION_SPI_MODE_CPOL		(1 << 11)
> +#define ORION_SPI_MODE_CPHA		(1 << 12)
>  #define ORION_SPI_IF_8_16_BIT_MODE	(1 << 5)
>  #define ORION_SPI_CLK_PRESCALE_MASK	0x1F
> +#define ORION_SPI_MODE_MASK		(ORION_SPI_MODE_CPOL | \
> +					 ORION_SPI_MODE_CPHA)
>  
>  struct orion_spi {
>  	struct spi_master	*master;
> @@ -123,6 +127,23 @@ static int orion_spi_baudrate_set(struct spi_device *spi, unsigned int speed)
>  	return 0;
>  }
>  
> +static void
> +orion_spi_mode_set(struct spi_device *spi)
> +{
> +	u32 reg;
> +	struct orion_spi *orion_spi;
> +
> +	orion_spi = spi_master_get_devdata(spi->master);
> +
> +	reg = readl(spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
> +	reg &= ~ORION_SPI_MODE_MASK;
> +	if (spi->mode & SPI_CPOL)
> +		reg |= ORION_SPI_MODE_CPOL;
> +	if (spi->mode & SPI_CPHA)
> +		reg |= ORION_SPI_MODE_CPHA;
> +	writel(reg, spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
> +}
> +
>  /*
>   * called only when no transfer is active on the bus
>   */
> @@ -142,6 +163,8 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
>  	if ((t != NULL) && t->bits_per_word)
>  		bits_per_word = t->bits_per_word;
>  
> +	orion_spi_mode_set(spi);
> +
>  	rc = orion_spi_baudrate_set(spi, speed);
>  	if (rc)
>  		return rc;
> @@ -399,7 +422,7 @@ static int __init orion_spi_probe(struct platform_device *pdev)
>  	}
>  
>  	/* we support only mode 0, and no options */
> -	master->mode_bits = 0;
> +	master->mode_bits = SPI_CPHA | SPI_CPOL;

The comment no longer seems valid.  ;-)  Also, you are unconditionally
enabling these modes.  Do all users of this driver support this?

thx,

Jason.

>  
>  	master->setup = orion_spi_setup;
>  	master->transfer_one_message = orion_spi_transfer_one_message;
> -- 
> 1.7.5.4
> 
