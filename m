From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 21 Sep 2012 07:18:54 -0700
Subject: [PATCH] serial: omap: fix the overrun case
In-Reply-To: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
 (Shubhrajyoti D.'s message of "Fri, 21 Sep 2012 15:52:56 +0530")
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <87a9wjfohd.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> Overrun also causes an internal flag to be set, which disables further
> reception. Before the next frame can
> be received, the MPU must:
> ? Reset the RX FIFO.
> ? clear the internal flag.
>
> In the uart mode a dummy read is needed. Add the same.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> - functional testing on omap4sdp
> - Verified idle and suspend path hits off on beagle.

Tested-by: Kevin Hilman <khilman@ti.com>

This fixes the console hang I was seeing on 3530/Overo.

Thanks,

Kevin

>  drivers/tty/serial/omap-serial.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index a0d4460..bc22a2b 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -334,6 +334,13 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
>  {
>  	unsigned int flag;
> +	unsigned char ch = 0;
> +
> +	if (!(lsr & UART_LSR_BRK_ERROR_BITS))
> +		return;
> +
> +	if (likely(lsr & UART_LSR_DR))
> +		ch = serial_in(up, UART_RX);
>  
>  	up->port.icount.rx++;
>  	flag = TTY_NORMAL;
