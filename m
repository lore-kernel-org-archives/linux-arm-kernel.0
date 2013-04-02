From: marex@denx.de (Marek Vasut)
Date: Wed, 3 Apr 2013 01:24:30 +0200
Subject: [PATCH V2 03/12] spi/mxs: Change flag arguments in txrx functions
 to bit flags
In-Reply-To: <1364905195-24286-3-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
 <1364905195-24286-3-git-send-email-tpiepho@gmail.com>
Message-ID: <201304030124.30625.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Trent Piepho,

> There are three flag arguments to the PIO and DMA txrx functions.  Two
> are passed as pointers to integers, even though they are input only
> and not modified, which makes no sense to do.  The third is passed as
> an integer.
> 
> The compiler must use an argument register or stack variable for each
> flag this way.  By using bitflags in a single flag argument more
> efficient and smaller code is produced since all the flags can fit in
> a single register.  And all the flag arguments get cumbersome,
> especially when more are added for things like GPIO chipselects.
> 
> The "first" flag is never used, so can just be deleted.
> 
> The "last" flag is renamed to DEASSERT_CS, since that's really what it
> does.  The spi_transfer cs_change flag means that CS might be
> de-asserted on a transfer which is not last and not de-assert on the
> last transfer, so it is not which transfer is the last we need to know
> but rather the transfers which after which CS should be de-asserted.
> 
> This also extends the driver to not ignore cs_change when setting the
> DEASSERT_CS nee "last" flag.
> 
> Signed-off-by: Trent Piepho <tpiepho@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/spi/spi-mxs.c |   55
> ++++++++++++++++++++++++++++--------------------- 1 file changed, 31
> insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index 7eb4bc9..3064304 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -58,6 +58,13 @@
> 
>  #define SG_MAXLEN		0xff00
> 
> +/*
> + * Flags for txrx functions.  More efficient that using an argument
> register for + * each one.
> + */
> +#define TXRX_WRITE		1	/* This is a write */
> +#define TXRX_DEASSERT_CS	2	/* De-assert CS at end of txrx */
> +

Use (1 << n) here as these are bitfield flags.

[...]

> @@ -409,10 +418,9 @@ static int mxs_spi_transfer_one(struct spi_master
> *master, if (status)
>  			break;
> 
> -		if (&t->transfer_list == m->transfers.next)
> -			first = 1;
> -		if (&t->transfer_list == m->transfers.prev)
> -			last = 1;
> +		/* De-assert on last transfer, inverted by cs_change flag */
> +		flag = (&t->transfer_list == m->transfers.prev) ^ t->cs_change ?
> +		       TXRX_DEASSERT_CS : 0;

Make this into an if-else block, this really is hard to parse at first glance.

>  		if ((t->rx_buf && t->tx_buf) || (t->rx_dma && t->tx_dma)) {
>  			dev_err(ssp->dev,
>  				"Cannot send and receive simultaneously\n");
[...]
