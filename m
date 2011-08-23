From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 10:30:35 +0100
Subject: [PATCH] atmel_serial: RS485: receiving enabled when sending data
In-Reply-To: <4E536536.3030004@evidence.eu.com>
References: <4E492CFF.7040905@pwrnet.de> <20110822211832.GA8023@kroah.com>
	<4E536536.3030004@evidence.eu.com>
Message-ID: <20110823093035.GB19622@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 10:30:46AM +0200, Claudio Scordino wrote:
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index af9b781..5f6c745 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -339,8 +339,9 @@ static void atmel_stop_tx(struct uart_port *port)
>  	/* Disable interrupts */
>  	UART_PUT_IDR(port, atmel_port->tx_done_mask);
>  
> -	if (atmel_port->rs485.flags & SER_RS485_ENABLED)
> -		atmel_start_rx(port);
> +	if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
> +		!(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX))
> +			atmel_start_rx(port);

However, this is incorrect formatting.  The code following the 'if' ends
up being indented by two tabs.

This illustrates why the whole idea that tabs should only be used for
indenting is wrong.  You end up with either what you have above, or:

	if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
		!(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX))
		atmel_start_rx(port);

both of which are dire for readability.  The only sane way to do this is
to ignore that stupid "indentation by tabs only" thing and do it as the
kernel code has _always_ been done over the last 19 years:

	if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
	    !(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX))
		atmel_start_rx(port);

IOW, use spaces to align the wrapped 'if' statement.

> +		if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
> +			!(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX)) {
> +				/* DMA done, stop TX, start RX for RS485 */
> +				atmel_start_rx(port);

And here it makes it look like there's a missing brace.
