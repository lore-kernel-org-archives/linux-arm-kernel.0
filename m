From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Jun 2015 08:41:13 +0200
Subject: [PATCH V2 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control
 from set/get_mctrl
In-Reply-To: <1433136067-20644-3-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1433136067-20644-3-git-send-email-bhuvanchandra.dv@toradex.com>
Message-ID: <20150608064113.GX18985@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jun 01, 2015 at 10:51:06AM +0530, Bhuvanchandra DV wrote:
> The LPUART does not provide manual control of RTS/CTS signals,
> those can only be controlled by the hardware directly. Therefore
> manual control of those signals through mctrl can not be provided.
> The current implementation enables/disables the automatic control,
> which is not what mctrl should do, hence remove the incorrect
> implementation.
> 
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 63 +++++------------------------------------
>  1 file changed, 7 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 08ce76f..532cfb7 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -822,64 +822,15 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
>  
>  static unsigned int lpuart_get_mctrl(struct uart_port *port)
>  {
> -	unsigned int temp = 0;
> -	unsigned char reg;
> -
> -	reg = readb(port->membase + UARTMODEM);
> -	if (reg & UARTMODEM_TXCTSE)
> -		temp |= TIOCM_CTS;
> -
> -	if (reg & UARTMODEM_RXRTSE)
> -		temp |= TIOCM_RTS;
> -
> -	return temp;
>From reading the commit log I would expect that you only touch the
set_mctrl function, but not get_mctrl. Assuming your code change is
right, can you mention this in the commit log please? The bits
UARTMODEM_TXCTSE and UARTMODEM_RXRTSE only control the automatic mode?

What is the problem you're fixing here? I'm not sure how such an UART
should be handled, but I imagine that you want to make use of automatic
mode in some cases. Greg?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
