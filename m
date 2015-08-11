From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Aug 2015 13:40:43 +0100
Subject: earlycon issues in -next with amba-pl011 updates
In-Reply-To: <55C94247.8020701@hurleysoftware.com>
References: <20150810232312.GB10728@bivouac.eciton.net>
 <55C94247.8020701@hurleysoftware.com>
Message-ID: <20150811124043.GZ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 08:31:03PM -0400, Peter Hurley wrote:
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 2af09ab..fd54991 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2348,13 +2348,10 @@ static struct console amba_console = {
>  
>  static void pl011_putc(struct uart_port *port, int c)
>  {
> -	struct uart_amba_port *uap =
> -	    container_of(port, struct uart_amba_port, port);
> -
> -	while (pl011_readw(uap, REG_FR) & UART01x_FR_TXFF)
> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>  		;
> -	pl011_writeb(uap, c, REG_DR);
> -	while (pl011_readw(uap, REG_FR) & uap->fr_busy)
> +	writeb(c, port->membase + UART01x_DR);
> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
>  		;

These loops are wrong.  Kernel coding style is that loops like this
will use cpu_relax() in them, just like the driver used to.  This
was introduced by:

commit 0d3c673e7881e691991b2a4745bd4f149603baa2
Author: Rob Herring <robh@kernel.org>
Date:   Fri Apr 18 17:19:57 2014 -0500

    tty/serial: pl011: add generic earlycon support

Also, the above readl()s should be readl_relaxed(), we don't need
barriered reads or to hit the L2 cache on those reads in the above code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
