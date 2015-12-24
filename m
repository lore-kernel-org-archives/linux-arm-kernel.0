From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Dec 2015 16:47:24 +0000
Subject: [PATCH 1/2] tty: amba-pl011: fix earlycon register offsets
In-Reply-To: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
References: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
Message-ID: <20151224164723.GK8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2015 at 09:49:48AM -0600, Timur Tabi wrote:
> The REG_x macros are indices into a table, not register offsets.  Since
> earlycon does not have access to the vendor data, we can currently only
> support standard ARM PL011 devices.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Please credit me with the change; this was obviously a change I made
when I posted the updated patches, which Greg had failed to take
instead of the original set.  Thanks.

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
> -	while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>  		;
> -	writeb(c, port->membase + REG_DR);
> -	while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
> +	writeb(c, port->membase + UART01x_DR);
> +	while (readl(port->membase + UART01x_FR) & UART011_FR_BUSY)
>  		;
>  }
>  
> -- 
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
