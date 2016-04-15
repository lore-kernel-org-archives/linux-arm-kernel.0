From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 15 Apr 2016 14:52:10 +0200
Subject: [PATCH] tty/serial: atmel: fix hardware handshake selection
In-Reply-To: <1460465500-25396-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1460465500-25396-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5710E3FA.6040203@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/04/2016 14:51, Alexandre Belloni a ?crit :
> Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
> hardware handshake is enabled") actually allowed to enable hardware
> handshaking.
> Before, the CRTSCTS flags was silently ignored.
> 
> As the DMA controller can't drive RTS (as explain in the commit message).
> Ensure that hardware flow control stays disabled when DMA is used and FIFOs
> are not available.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Yes, I agree with the fix:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

We can also add the following tags:

Fixes: 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
hardware handshake is enabled")
Cc: stable <stable@vger.kernel.org> # v4.0+

Bye,

> ---
>  drivers/tty/serial/atmel_serial.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index d9439e6ab719..954941dd8124 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -274,6 +274,13 @@ static bool atmel_use_dma_rx(struct uart_port *port)
>  	return atmel_port->use_dma_rx;
>  }
>  
> +static bool atmel_use_fifo(struct uart_port *port)
> +{
> +	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +
> +	return atmel_port->fifo_size;
> +}
> +
>  static unsigned int atmel_get_lines_status(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> @@ -2090,7 +2097,12 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  		mode |= ATMEL_US_USMODE_RS485;
>  	} else if (termios->c_cflag & CRTSCTS) {
>  		/* RS232 with hardware handshake (RTS/CTS) */
> -		mode |= ATMEL_US_USMODE_HWHS;
> +		if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
> +			dev_info(port->dev, "not enabling hardware flow control because DMA is used");
> +			termios->c_cflag &= ~CRTSCTS;
> +		} else {
> +			mode |= ATMEL_US_USMODE_HWHS;
> +		}
>  	} else {
>  		/* RS232 without hadware handshake */
>  		mode |= ATMEL_US_USMODE_NORMAL;
> 


-- 
Nicolas Ferre
