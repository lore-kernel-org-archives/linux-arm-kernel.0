From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 14 Oct 2010 13:27:35 +0200
Subject: [PATCH] serial/imx: check that the buffer is non-empty before
	sending it out
In-Reply-To: <1286960637-11600-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20101008091640.GD29673@pengutronix.de>
	<1286960637-11600-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20101014112735.GK10432@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 11:03:57AM +0200, Uwe Kleine-K?nig wrote:
> From: Volker Ernst <volker.ernst@txtr.com>
> 
> The .start_tx callback (imx_start_tx here) isn't only called when the
> buffer is non-empty.  E.g. after resume or when handshaking is enabled
> and the other side starts to signal being ready.
> 
> So check for an empty puffer already before sending the first character.
> This prevents sending out stale (or uninitialised) data.
> 
> Signed-off-by: Volker Ernst <volker.ernst@txtr.com>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Andy Green <andy@warmcat.com>
> [ukl: reword commit log, put check in while condition]
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> as I didn't sent a patch, here comes my current version.  Don't know if
> it makes it easier to test for you ...
> 
> I faked Daniel's SoB as Andrew said he did, compressed the changelog a
> bit and put the check in the while condition as I suggested.

FWIW, that looks good to me. Thanks for finishing the work :)


Daniel


>  drivers/serial/imx.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
> index 66ecc7a..dfcf4b1 100644
> --- a/drivers/serial/imx.c
> +++ b/drivers/serial/imx.c
> @@ -327,14 +327,13 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
>  {
>  	struct circ_buf *xmit = &sport->port.state->xmit;
>  
> -	while (!(readl(sport->port.membase + UTS) & UTS_TXFULL)) {
> +	while (!uart_circ_empty(xmit) &&
> +			!(readl(sport->port.membase + UTS) & UTS_TXFULL)) {
>  		/* send xmit->buf[xmit->tail]
>  		 * out the port here */
>  		writel(xmit->buf[xmit->tail], sport->port.membase + URTX0);
>  		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>  		sport->port.icount.tx++;
> -		if (uart_circ_empty(xmit))
> -			break;
>  	}
>  
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> -- 
> 1.7.2.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
