From: balbi@ti.com (Felipe Balbi)
Date: Fri, 21 Sep 2012 19:01:00 +0300
Subject: [PATCH v2] serial: omap: fix the reciever line error case
In-Reply-To: <1348238239-18510-1-git-send-email-shubhrajyoti@ti.com>
References: <1348238239-18510-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120921160059.GA9886@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 08:07:19PM +0530, Shubhrajyoti D wrote:
> This patch does the following
> - In case of errors if there least one data character in the RX FIFO
> read it otherwise it may stall the receiver.
> 
> This is recommended in the interrupt reset method in the table 23-246 of
> the omap4 TRM.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> - Tested on omap4sdp.
> - pm tested hitting off in idle and suspend.
> - v2 changes update the changelogs.
> - Also remove the dummy check as FE , PE , BI and OE are the only
> receiver errors.
> 
>  drivers/tty/serial/omap-serial.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index a0d4460..4fea16b 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -334,6 +334,10 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
>  {
>  	unsigned int flag;
> +	unsigned char ch = 0;
> +
> +	if (likely(lsr & UART_LSR_DR))
> +		ch = serial_in(up, UART_RX);
>  
>  	up->port.icount.rx++;
>  	flag = TTY_NORMAL;
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120921/716d4245/attachment.sig>
