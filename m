From: shijie.huang@arm.com (Huang Shijie)
Date: Fri, 25 Dec 2015 01:46:50 +0000
Subject: [PATCH 1/2] tty: amba-pl011: fix earlycon register offsets
In-Reply-To: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
References: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
Message-ID: <20151225014649.GA26561@robwan01-pc.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2015 at 09:49:48AM -0600, Timur Tabi wrote:
> The REG_x macros are indices into a table, not register offsets.  Since
> earlycon does not have access to the vendor data, we can currently only
> support standard ARM PL011 devices.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index f6ad383..06f827a 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2302,10 +2302,10 @@ static struct console amba_console = {
>
>  static void pl011_putc(struct uart_port *port, int c)
>  {
> -     while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
> +     while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>               ;
> -     writeb(c, port->membase + REG_DR);
> -     while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
> +     writeb(c, port->membase + UART01x_DR);
> +     while (readl(port->membase + UART01x_FR) & UART011_FR_BUSY)
We will meet the compiler error, since there is no UART011_FR_BUSY.
Please test it before you send it out :)

thanks
Huang Shijie
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
