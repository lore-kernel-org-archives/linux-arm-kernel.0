From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 6 May 2014 17:57:38 +0200
Subject: [PATCH] spi: atmel: fix incorrect comparison
In-Reply-To: <1399391081-16095-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1399391081-16095-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <53690672.8050708@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2014 17:44, Alexandre Belloni :
> Found using smatch:
> drivers/spi/spi-atmel.c:878 atmel_spi_pump_pio_data() warn: unsigned
> 'as->current_remaining_bytes' is never less than zero.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Yes as the variable is declared as unsigned:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
>  drivers/spi/spi-atmel.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 079e6b1b0cdb..39417fd8462f 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -874,8 +874,9 @@ atmel_spi_pump_pio_data(struct atmel_spi *as, struct spi_transfer *xfer)
>  		spi_readl(as, RDR);
>  	}
>  	if (xfer->bits_per_word > 8) {
> -		as->current_remaining_bytes -= 2;
> -		if (as->current_remaining_bytes < 0)
> +		if (as->current_remaining_bytes > 2)
> +			as->current_remaining_bytes -= 2;
> +		else
>  			as->current_remaining_bytes = 0;
>  	} else {
>  		as->current_remaining_bytes--;
> 


-- 
Nicolas Ferre
