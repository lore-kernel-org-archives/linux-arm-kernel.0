From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 6 Aug 2018 11:21:21 +0200
Subject: [PATCH RESEND 3/5] spi: imx: Use correct number of bytes per words
In-Reply-To: <20180717143154.28241-4-maxime.chevallier@bootlin.com>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
 <20180717143154.28241-4-maxime.chevallier@bootlin.com>
Message-ID: <20180806092121.s7kuwf3yamrerw24@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 04:31:52PM +0200, Maxime Chevallier wrote:
> The SPI core enforces that we always use the next power-of-two number of
> bytes to store words. As a result, a 24 bits word will be stored in 4
> bytes.
> 
> This commit fixes the spi_imx_bytes_per_word function to return the
> correct number of bytes.
> 
> This also allows to get rid of unnecessary checks in the can_dma
> function, since the SPI core validates that we always have a transfer
> length that is a multiple of the number of bytes per word.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/spi/spi-imx.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index ecafbda5ec94..3ae706dac660 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -202,7 +202,12 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
>  
>  static int spi_imx_bytes_per_word(const int bits_per_word)
>  {
> -	return DIV_ROUND_UP(bits_per_word, BITS_PER_BYTE);
> +	if (bits_per_word <= 8)
> +		return 1;
> +	else if (bits_per_word <= 16)
> +		return 2;
> +	else
> +		return 4;
>  }
>  
>  static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
> @@ -219,9 +224,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>  
>  	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
>  
> -	if (bytes_per_word != 1 && bytes_per_word != 2 && bytes_per_word != 4)
> -		return false;
> -
>  	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
>  		if (!(transfer->len % (i * bytes_per_word)))
>  			break;
> -- 
> 2.11.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
