From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Mar 2010 14:45:57 +0100
Subject: [PATCH] serial: fix possible imx deadlock
In-Reply-To: <80k4tehryt.fsf@merkur.tec.linutronix.de>
References: <80k4tehryt.fsf@merkur.tec.linutronix.de>
Message-ID: <20100315134556.GX19843@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 10:08:58AM +0100, John Ogness wrote:
> This patch fixes a possible deadlock situation with the port and timer
> locks. The calling paths for the deadlock situation are:
> 
> 1. imx_set_termios() -> LOCK(port.lock)
>       -> del_timer_sync() -> LOCK(timer.base.lock)
> 
> 2. run_timer_softirq() -> LOCK(timer.base.lock)
>       -> imx_timeout() -> LOCK(port.lock)
> 
> This patch is against 2.6.34-rc1.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/serial/imx.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> diff -Naurp a/drivers/serial/imx.c b/drivers/serial/imx.c
> --- a/drivers/serial/imx.c	2010-03-08 19:45:44.000000000 +0100
> +++ b/drivers/serial/imx.c	2010-03-15 09:52:39.855261060 +0100
> @@ -836,6 +836,12 @@ imx_set_termios(struct uart_port *port, 
>  	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
>  	quot = uart_get_divisor(port, baud);
>  
> +	/*
> +	 * Stop our timer. This is done with the port unlocked
> +	 * to avoid possible deadlock against the timer function.
> +	 */
> +	del_timer_sync(&sport->timer);
> +

Is this call needed here anyway? Only few drivers have it. Does anyone
have more insights on this?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
