From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Nov 2015 09:47:23 +0100
Subject: [PATCH v3 2/7] spi: imx: replace fixed timeout with calculated one
In-Reply-To: <1446388901-6073-3-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1446388901-6073-3-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <20151105084723.GI8526@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 01, 2015 at 03:41:36PM +0100, Anton Bondarenko wrote:
> From: Anton Bondarenko <anton_bondarenko@mentor.com>
> 
> Fixed timeout value can fire while transaction is ongoing. This may happen
> because there are no strict requirements on SPI transaction duration.
> Dynamic timeout value is generated based on SCLK and transaction size.
> 
> There is also 4 * SCLK delay between TX bursts related to CS change.
> 
> Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
> ---
>  drivers/spi/spi-imx.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index bd7b721..9b80c7f 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -57,7 +57,6 @@
>  
>  /* The maximum  bytes that a sdma BD can transfer.*/
>  #define MAX_SDMA_BD_BYTES  (1 << 15)
> -#define IMX_DMA_TIMEOUT (msecs_to_jiffies(3000))
>  struct spi_imx_config {
>  	unsigned int speed_hz;
>  	unsigned int bpw;
> @@ -93,6 +92,7 @@ struct spi_imx_data {
>  	struct clk *clk_per;
>  	struct clk *clk_ipg;
>  	unsigned long spi_clk;
> +	unsigned int spi_bus_clk;
>  
>  	unsigned int count;
>  	void (*tx)(struct spi_imx_data *);
> @@ -314,8 +314,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>  {
>  	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, dma = 0;
>  	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
> -
> -	u32 clk = config->speed_hz, delay;
> +	u32 delay;
>  
>  	/*
>  	 * The hardware seems to have a race condition when changing modes. The
> @@ -327,7 +326,9 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>  	ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
>  
>  	/* set clock speed */
> -	ctrl |= mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz, &clk);
> +	spi_imx->spi_bus_clk = config->speed_hz;
> +	ctrl |= mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz,
> +				  &spi_imx->spi_bus_clk);
>  
>  	/* set chip select to use */
>  	ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
> @@ -367,7 +368,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>  	 * the SPI communication as the device on the other end would consider
>  	 * the change of SCLK polarity as a clock tick already.
>  	 */
> -	delay = (2 * 1000000) / clk;
> +	delay = (2 * USEC_PER_SEC) / spi_imx->spi_bus_clk;
>  	if (likely(delay < 10))	/* SCLK is faster than 100 kHz */
>  		udelay(delay);
>  	else			/* SCLK is _very_ slow */
> @@ -890,12 +891,40 @@ static void spi_imx_dma_tx_callback(void *cookie)
>  	complete(&spi_imx->dma_tx_completion);
>  }
>  
> +static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
> +{
> +	unsigned long coef1 = 1;
> +	unsigned long coef2 = MSEC_PER_SEC;
> +	unsigned long timeout = 0;
> +
> +	/* Swap coeficients to avoid div by 0 */
> +	if (spi_imx->spi_bus_clk < MSEC_PER_SEC) {
> +		coef1 = MSEC_PER_SEC;
> +		coef2 = 1;
> +	}
> +
> +	/* Time with actual data transfer */
> +	timeout += DIV_ROUND_UP(8 * size * coef1,
> +				spi_imx->spi_bus_clk / coef2);
> +
> +	/* Take CS change delay related to HW */
> +	timeout += DIV_ROUND_UP((size - 1) * 4 * coef1,
> +				spi_imx->spi_bus_clk / coef2);
> +
> +	/* Add extra second for scheduler related activities */
> +	timeout += MSEC_PER_SEC;
> +
> +	/* Double calculated timeout */
> +	return msecs_to_jiffies(2 * timeout);
> +}

I think you can simplify this function to:

	timeout = size * 8 / spi_imx->spi_bus_clk;
	timeout += 2;

	return msecs_to_jiffies(timeout * MSEC_PER_SEC);

The rationale is that when size * 8 / spi_imx->spi_bus_clk is 0 then we
can add another second and be fine. No need to calculate this more
accurate, in the end it's important to catch the timeout. If we do this
one or two seconds too late doesn't matter.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
