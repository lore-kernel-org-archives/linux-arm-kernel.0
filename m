From: peter@hurleysoftware.com (Peter Hurley)
Date: Mon, 17 Aug 2015 11:39:03 -0400
Subject: [PATCH 1/4] serial: xuartps: Fix termios issue for enabling odd
 parity
In-Reply-To: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
References: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
Message-ID: <55D20017.4010008@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2015 03:22 AM, Michal Simek wrote:
> From: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
> 
> Existing set_termios does not handle the option for enabling
> odd parity. This patch fixes it.

NAK. PARODD does not enable parity generation or detection.

Regards,
Peter Hurley

> Signed-off-by: Anirudha Sarangi <anirudh@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 009e0dbc12d2..a3020344ac9d 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -723,7 +723,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
>  	else
>  		cval |= CDNS_UART_MR_STOPMODE_1_BIT; /* 1 STOP bit */
>  
> -	if (termios->c_cflag & PARENB) {
> +	if ((termios->c_cflag & PARENB) || (termios->c_cflag & PARODD)) {
>  		/* Mark or Space parity */
>  		if (termios->c_cflag & CMSPAR) {
>  			if (termios->c_cflag & PARODD)
> 
