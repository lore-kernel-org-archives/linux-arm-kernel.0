From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 27 Oct 2016 20:02:29 +0200
Subject: [PATCH v6] tty/serial: at91: fix hardware handshake on Atmel
 platforms
In-Reply-To: <20161027160406.25738-1-richard.genoud@gmail.com>
References: <20161027160406.25738-1-richard.genoud@gmail.com>
Message-ID: <20161027180229.5faqrvxa2a4pos7i@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Richard,

On Thu, Oct 27, 2016 at 06:04:06PM +0200, Richard Genoud wrote:
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index fd8aa1f4ba78..168b10cad47b 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2132,11 +2132,29 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  		mode |= ATMEL_US_USMODE_RS485;
>  	} else if (termios->c_cflag & CRTSCTS) {
>  		/* RS232 with hardware handshake (RTS/CTS) */
> -		if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
> -			dev_info(port->dev, "not enabling hardware flow control because DMA is used");
> -			termios->c_cflag &= ~CRTSCTS;
> -		} else {
> +		if (atmel_use_fifo(port) &&
> +		    !mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)) {
> +			/*
> +			 * with ATMEL_US_USMODE_HWHS set, the controller will
> +			 * be able to drive the RTS pin high/low when the RX
> +			 * FIFO is above RXFTHRES/below RXFTHRES2.
> +			 * It will also disable the transmitter when the CTS
> +			 * pin is high.
> +			 * This mode is not activated if CTS pin is a GPIO
> +			 * because in this case, the transmitter is always
> +			 * disabled (there must be an internal pull-up
> +			 * responsible for this behaviour).
> +			 * If the RTS pin is a GPIO, the controller won't be
> +			 * able to drive it according to the FIFO thresholds,
> +			 * but it will be handled by the driver.
> +			 */
>  			mode |= ATMEL_US_USMODE_HWHS;

You use

	!mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)

as indicator that the cts mode of the respective pin is used. Is this
reliable? (It's not if there are machines that don't use CTS, neither as
gpio nor using the hardware function.) Maybe this needs a dt property to
indicate that there is no (hw)handshaking available?

> +		} else {
> +			...
>  		}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
