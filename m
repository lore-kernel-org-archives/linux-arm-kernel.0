From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 4 Apr 2018 08:45:01 +0200
Subject: [PATCH v3 1/6] spi: sun6i: coding style/readability improvements
In-Reply-To: <20180403154449.2443-2-ssuloev@orpaltech.com>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-2-ssuloev@orpaltech.com>
Message-ID: <20180404064501.3sfo67ynkplk4vyx@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 06:44:44PM +0300, Sergey Suloev wrote:
> Minor changes to fulfill the coding style and improve
> the readability of the code.
> 
> Changes in v2:
> 1) Fixed issue with misplacing a piece of code that requires access
> to the transfer structure into sun6i_spi_prepare_message() function
> where the transfer structure is not available.

This shouldn't be in your commit log.

> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> ---
>  drivers/spi/spi-sun6i.c | 97 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 58 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 8533f4e..88ad45e 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -88,8 +88,12 @@
>  #define SUN6I_TXDATA_REG		0x200
>  #define SUN6I_RXDATA_REG		0x300
>  
> +#define SUN6I_SPI_MODE_BITS		(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST)
> +
> +#define SUN6I_SPI_MAX_SPEED_HZ		100000000
> +#define SUN6I_SPI_MIN_SPEED_HZ		3000
> +
>  struct sun6i_spi {
> -	struct spi_master	*master;
>  	void __iomem		*base_addr;
>  	struct clk		*hclk;
>  	struct clk		*mclk;
> @@ -189,6 +193,9 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
>  	else
>  		reg &= ~SUN6I_TFR_CTL_CS_LEVEL;
>  
> +	/* We want to control the chip select manually */
> +	reg |= SUN6I_TFR_CTL_CS_MANUAL;
> +
>  	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
>  }
>  
> @@ -197,6 +204,39 @@ static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
>  	return SUN6I_MAX_XFER_SIZE - 1;
>  }
>  
> +static int sun6i_spi_prepare_message(struct spi_master *master,
> +				     struct spi_message *msg)
> +{
> +	struct spi_device *spi = msg->spi;
> +	struct sun6i_spi *sspi = spi_master_get_devdata(master);
> +	u32 reg;
> +
> +	/*
> +	 * Setup the transfer control register: Chip Select,
> +	 * polarities, etc.
> +	 */
> +	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
> +
> +	if (spi->mode & SPI_CPOL)
> +		reg |= SUN6I_TFR_CTL_CPOL;
> +	else
> +		reg &= ~SUN6I_TFR_CTL_CPOL;
> +
> +	if (spi->mode & SPI_CPHA)
> +		reg |= SUN6I_TFR_CTL_CPHA;
> +	else
> +		reg &= ~SUN6I_TFR_CTL_CPHA;
> +
> +	if (spi->mode & SPI_LSB_FIRST)
> +		reg |= SUN6I_TFR_CTL_FBS;
> +	else
> +		reg &= ~SUN6I_TFR_CTL_FBS;
> +
> +	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
> +
> +	return 0;
> +}
> +

You're doing way more than just "coding style improvements", please
split the patches accordingly.

And slow down between versions, you had 0 review on the v1 and the v2,
and you're at v3 already in just a couple of days.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/9b0cc4db/attachment.sig>
