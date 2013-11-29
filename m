From: marex@denx.de (Marek Vasut)
Date: Fri, 29 Nov 2013 17:50:22 +0100
Subject: [PATCH 1/3] serial: mxs-auart: implement flush_buffer hook
In-Reply-To: <1385742927-11358-2-git-send-email-hector.palacios@digi.com>
References: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
 <1385742927-11358-2-git-send-email-hector.palacios@digi.com>
Message-ID: <201311291750.22215.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hector,

> Terminate any DMA transfer and verify the TX FIFO is empty.
> 
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> ---
>  drivers/tty/serial/mxs-auart.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c
> b/drivers/tty/serial/mxs-auart.c index 9f0461778fc1..d9bf6e103f65 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -782,6 +782,28 @@ static unsigned int mxs_auart_tx_empty(struct
> uart_port *u) return 0;
>  }
> 
> +/*
> + * Flush the transmit buffer.
> + * Locking: called with port lock held and IRQs disabled.
> + */
> +static void mxs_auart_flush_buffer(struct uart_port *u)
> +{
> +	struct mxs_auart_port *s = to_auart_port(u);
> +	struct dma_chan *channel = s->tx_dma_chan;
> +	unsigned int to;
> +
> +	if (auart_dma_enabled(s)) {
> +		/* Avoid deadlock with the DMA engine callback */
> +		spin_unlock(&s->port.lock);
> +		dmaengine_terminate_all(channel);
> +		spin_lock(&s->port.lock);

Can you not maybe just set some flag here to tell the DMA engine callback things 
are shutting down and to don't do anything funny anymore ?

> +	}
> +	/* Wait for the FIFO to flush */
> +	to = u->timeout;
> +	while (!mxs_auart_tx_empty(u) && to--)
> +		mdelay(1);

Maybe you can put some cond_resched() into the loop to avoid wasting too many 
cycles ?

> +}
> +
>  static void mxs_auart_start_tx(struct uart_port *u)
>  {
>  	struct mxs_auart_port *s = to_auart_port(u);
> @@ -828,6 +850,7 @@ static struct uart_ops mxs_auart_ops = {
>  	.get_mctrl      = mxs_auart_get_mctrl,
>  	.startup	= mxs_auart_startup,
>  	.shutdown       = mxs_auart_shutdown,
> +	.flush_buffer	= mxs_auart_flush_buffer,
>  	.set_termios    = mxs_auart_settermios,
>  	.type	   	= mxs_auart_type,
>  	.release_port   = mxs_auart_release_port,

Best regards,
Marek Vasut
