From: tpiepho@impinj.com (Trent Piepho)
Date: Mon, 12 Feb 2018 19:31:46 +0000
Subject: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
In-Reply-To: <20180207160002.GA9292@embeddedgus>
References: <20180207160002.GA9292@embeddedgus>
Message-ID: <1518463905.25398.281.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-02-07 at 10:00 -0600, Gustavo A. R. Silva wrote:
> Add suffix ULL to constant 9 in order to give the compiler complete
> information about the proper arithmetic to use. Notice that this
> constant is used in a context that expects an expression of type
> unsigned long long (64 bits, unsigned).
> 
> The expression tfr->len * 9 * 1000000 is currently being evaluated
> using 32-bit arithmetic.
> 
> Addresses-Coverity-ID: 1339619
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/spi/spi-bcm2835aux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index 7428091..a768c23 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -363,7 +363,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
>  	 * chunk getting transferred - in our case the chunk size
>  	 * is 3 bytes, so we approximate this by 9 bits/byte
>  	 */
> -	xfer_time_us = tfr->len * 9 * 1000000;
> +	xfer_time_us = tfr->len * 9ULL * 1000000;
>  	do_div(xfer_time_us, spi_used_hz);
>  
>  	/* run in polling mode for short transfers */
	if (xfer_time_us < BCM2835_AUX_SPI_POLLING_LIMIT_US)

If one looks@the logic as a whole...

tfr->len * 9ULL * 100000 / spi_used_hz < 30

A little algebra can change that into:

tfr->len < spi_used_hz / 300000

So rather than add more 64-bit math, it can be removed entirely.  Both
the length and speed are 32 bits and there's no need to multiply them
into something larger than might need 64 bits.
