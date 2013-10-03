From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Oct 2013 20:17:40 +0200
Subject: [PATCH v3 2/2] serial: mxs-auart: wait for FIFO to flush before
 shutdown
In-Reply-To: <1380785524-20490-3-git-send-email-hector.palacios@digi.com>
References: <1380785524-20490-1-git-send-email-hector.palacios@digi.com>
 <1380785524-20490-3-git-send-email-hector.palacios@digi.com>
Message-ID: <20131003181740.GB10079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

there is only a single concern left and probably only the Freescale guys
can comment here ...
On Thu, Oct 03, 2013 at 09:32:04AM +0200, Hector Palacios wrote:
> The shutdown function was not waiting for the FIFO (which may be the
> real 16 byte FIFO or the DMA buffer, if DMA is enabled) to flush
> before disabling the AUART.
> This lead to many bytes not being transferred (specially at low
> baudrates), as they were still in the DMA buffer when the AUART was
> shutdown.
> This patch also adds the check for the BUSY flag on the tx_empty
> callback.
> 
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> ---
>  drivers/tty/serial/mxs-auart.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 9f046177..30edb91 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -757,9 +757,26 @@ static int mxs_auart_startup(struct uart_port *u)
>  	return 0;
>  }
>  
> +static unsigned int mxs_auart_tx_empty(struct uart_port *u)
> +{
> +	unsigned long stat;
> +
> +	stat = readl(u->membase + AUART_STAT);
> +	if ((stat & (AUART_STAT_BUSY | AUART_STAT_TXFE)) == AUART_STAT_TXFE)
> +		return TIOCSER_TEMT;
Can it happen that both the fifo and the shifter are empty but there are
still some chars pending to be transfered via DMA? If you were checking
if dma is still setup you'd be on the safe side.

Best regards
Uwe

> +
> +	return 0;
> +}
> +
>  static void mxs_auart_shutdown(struct uart_port *u)
>  {
>  	struct mxs_auart_port *s = to_auart_port(u);
> +	unsigned int to;
> +
> +	/* Wait for the FIFO to flush */
> +	to = u->timeout;
> +	while (!mxs_auart_tx_empty(u) && to--)
> +		mdelay(1);
>  
>  	if (auart_dma_enabled(s))
>  		mxs_auart_dma_exit(s);
> @@ -774,14 +791,6 @@ static void mxs_auart_shutdown(struct uart_port *u)
>  	clk_disable_unprepare(s->clk);
>  }
>  
> -static unsigned int mxs_auart_tx_empty(struct uart_port *u)
> -{
> -	if (readl(u->membase + AUART_STAT) & AUART_STAT_TXFE)
> -		return TIOCSER_TEMT;
> -	else
> -		return 0;
> -}
> -
>  static void mxs_auart_start_tx(struct uart_port *u)
>  {
>  	struct mxs_auart_port *s = to_auart_port(u);
> -- 
> 1.8.4
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
