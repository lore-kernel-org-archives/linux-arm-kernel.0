From: greg@kroah.com (Greg KH)
Date: Mon, 22 Aug 2011 14:18:32 -0700
Subject: [PATCH] atmel_serial: RS485: receiving enabled when sending data
In-Reply-To: <4E492CFF.7040905@pwrnet.de>
References: <4E492CFF.7040905@pwrnet.de>
Message-ID: <20110822211832.GA8023@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 04:28:15PM +0200, Bernhard Roth wrote:
> Hello!
> 
> By default the atmel_serial driver in RS485 mode disables receiving
> data until all data in the send buffer has been sent. This flag
> allows to receive data even whilst sending data. This is very useful
> to
> 
> - check if the data has been sent correctly over the RS485 bus
> - assure that no collision happened
> - check for short circuits/termination issues on the RS485 bus
> 
> Usually this functionality is realized by hardware, wether
> controlling the RX-Enable pin of the RS485 transceiver with RTS
> (driver control signal) or pulling it LOW permanently. The present
> atmel_serial driver makes this impossible, thus requiring following
> patch.
> 
> Usage example:
> 
>     struct serial_rs485     rs485;
> 
>     memset(&rs485, 0, sizeof(rs485));
>     rs485.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX;
>     ioctl(fd, TIOCSRS485, &rs485);
> 
> 
> 
> 
> atmel_serial: RS485: receiving enabled when sending data
> 
> By default the atmel_serial driver in RS485 mode disables receiving
> data until
> all data in the send buffer has been sent. This flag allows to receive data
> even whilst sending data.
> 
> Signed-off-by: Bernhard Roth <br@pwrnet.de>
> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
> ---
>  drivers/tty/serial/atmel_serial.c |   17 ++++++++++-------
>  include/linux/serial.h            |    1 +
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c
> b/drivers/tty/serial/atmel_serial.c
> index af9b781..5f6c745 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -339,8 +339,9 @@ static void atmel_stop_tx(struct uart_port *port)
>      /* Disable interrupts */
>      UART_PUT_IDR(port, atmel_port->tx_done_mask);
> 
> -    if (atmel_port->rs485.flags & SER_RS485_ENABLED)
> -        atmel_start_rx(port);
> +    if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
> +        !(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX))
> +            atmel_start_rx(port);

Can you fix your email client to not strip patches of tabs and resend
this so that I can apply it?

thanks,

greg k-h
