From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 22 Sep 2016 15:20:45 +0200
Subject: [PATCHv2 2/3] tty/serial: at91: fix hardware handshake with GPIOs
In-Reply-To: <20160912094733.21501-3-richard.genoud@gmail.com>
References: <20160912094733.21501-1-richard.genoud@gmail.com>
 <20160912094733.21501-3-richard.genoud@gmail.com>
Message-ID: <20160922132045.tbrd5u56qasaf7gn@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 11:47:32AM +0200, Richard Genoud wrote:
> Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
> hardware handshake is enabled") broke the hardware handshake when GPIOs
> where used.

s/where/were/

> Hardware handshake with GPIOs used to work before this commit because
> the CRTSCTS flag (termios->c_cflag) was set, but not the
> ATMEL_US_USMODE_HWHS flag (controller register) ; so hardware handshake
> enabled, but not handled by the controller.
> 
> This commit restores this behaviour.
> 
> NB: -stable is not Cced because it doesn't cleanly apply on 4.1+
> and it will also need previous commit:
> "serial: mctrl_gpio: implement mctrl_gpio_use_rtscts"
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Fixes: 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when hardware handshake is enabled")
> ---
>  drivers/tty/serial/atmel_serial.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 2eaa18ddef61..e9b4fbf88c2d 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2025,6 +2025,7 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
>  static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  			      struct ktermios *old)
>  {
> +	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>  	unsigned long flags;
>  	unsigned int old_mode, mode, imr, quot, baud;
>  
> @@ -2126,8 +2127,12 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  		atmel_uart_writel(port, ATMEL_US_TTGR,
>  				  port->rs485.delay_rts_after_send);
>  		mode |= ATMEL_US_USMODE_RS485;
> -	} else if (termios->c_cflag & CRTSCTS) {
> -		/* RS232 with hardware handshake (RTS/CTS) */
> +	} else if ((termios->c_cflag & CRTSCTS) &&
> +		   !mctrl_gpio_use_rtscts(atmel_port->gpios)) {

IMHO the behaviour of the hw controlled pins shouldn't change when
mctrl_gpio is in use (if possible). But I don't understand the issue so
I guess you need a better changelog.


> +		/*
> +		 * RS232 with hardware handshake (RTS/CTS)
> +		 * handled by the controller.
> +		 */
>  		if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
>  			dev_info(port->dev, "not enabling hardware flow control because DMA is used");
>  			termios->c_cflag &= ~CRTSCTS;
> @@ -2135,7 +2140,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  			mode |= ATMEL_US_USMODE_HWHS;
>  		}
>  	} else {
> -		/* RS232 without hadware handshake */
> +		/* RS232 without hadware handshake or controlled by GPIOs */

When touching this line, please also do s/hadware/hardware/.

>  		mode |= ATMEL_US_USMODE_NORMAL;
>  	}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
