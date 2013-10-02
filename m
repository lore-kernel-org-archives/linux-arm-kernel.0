From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 2 Oct 2013 14:25:36 +0200
Subject: [PATCH v2 1/2] serial: mxs-auart: set the FIFO size to DMA
 buffer size
In-Reply-To: <1380715364-8025-2-git-send-email-hector.palacios@digi.com>
References: <1380715364-8025-1-git-send-email-hector.palacios@digi.com>
 <1380715364-8025-2-git-send-email-hector.palacios@digi.com>
Message-ID: <20131002122536.GR2548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Hector,

On Wed, Oct 02, 2013 at 02:02:43PM +0200, Hector Palacios wrote:
> When DMA is enabled (with hardware flow control enabled) the FIFO size
> must be set to the size of the DMA buffer, as this is the size the tty
> subsystem can use.
> 
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> ---
>  drivers/tty/serial/mxs-auart.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index f85b8e6..9f046177 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -40,6 +40,7 @@
>  #include <asm/cacheflush.h>
>  
>  #define MXS_AUART_PORTS 5
> +#define MXS_AUART_FIFO_SIZE		16
>  
>  #define AUART_CTRL0			0x00000000
>  #define AUART_CTRL0_SET			0x00000004
> @@ -549,6 +550,9 @@ static int mxs_auart_dma_init(struct mxs_auart_port *s)
>  	s->flags |= MXS_AUART_DMA_ENABLED;
>  	dev_dbg(s->dev, "enabled the DMA support.");
>  
> +	/* The DMA buffer is now the FIFO the TTY subsystem can use */
> +	s->port.fifosize = UART_XMIT_SIZE;
> +
>  	return 0;
>  
>  err_out:
> @@ -741,6 +745,9 @@ static int mxs_auart_startup(struct uart_port *u)
>  	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
>  			u->membase + AUART_INTR);
>  
> +	/* Reset FIFO size (it could have changed if DMA was enabled) */
> +	u->fifosize = MXS_AUART_FIFO_SIZE;
> +
>  	/*
>  	 * Enable fifo so all four bytes of a DMA word are written to
>  	 * output (otherwise, only the LSB is written, ie. 1 in 4 bytes)
> @@ -1062,7 +1069,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  	s->port.membase = ioremap(r->start, resource_size(r));
>  	s->port.ops = &mxs_auart_ops;
>  	s->port.iotype = UPIO_MEM;
> -	s->port.fifosize = 16;
> +	s->port.fifosize = MXS_AUART_FIFO_SIZE;
>  	s->port.uartclk = clk_get_rate(s->clk);
>  	s->port.type = PORT_IMX;
>  	s->port.dev = s->dev = &pdev->dev;
I don't know if something is surprised when fifosize is changed by
set_termios, but that's how it is. So:

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
