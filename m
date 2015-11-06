From: peter@hurleysoftware.com (Peter Hurley)
Date: Thu, 5 Nov 2015 20:52:08 -0500
Subject: [PATCH] tty: amba-pl011: add options to earlycon for 32-bit reg
 access
In-Reply-To: <1446770267-26749-1-git-send-email-timur@codeaurora.org>
References: <1446770267-26749-1-git-send-email-timur@codeaurora.org>
Message-ID: <563C07C8.9060506@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2015 07:37 PM, Timur Tabi wrote:
> Add the "sbsa32" command-line option to earlycon to specify that the
> pl011 registers should be accessed with 32-bit accessors only.  This is
> SBSA platforms
> 
> Similarly, also add the "zte" option for the ZTE UART.  It's functionally
> similar to the standard PL011, but some registers are at different
> offsets.
> 
> Normal console uses the "access_32b" field of the vendor data structure
> to determine whether the registers needs 32-bit accessors.  Early console
> is used before the vendor data is available, so we need a different
> mechanism to choose the accessor.
> 
> Example:
> 
> 	earlycon=pl011,0x3ced1000,sbsa32

Perhaps I wasn't clear enough in my previous comments regarding this
approach; I see no benefit to re-using the pl011 earlycon definition.
Just define a completely new earlycon for sbsa32 (and zte):

EARLYCON_DECLARE(sbsa32, sbsa32_early_console_setup);

Example:
	earlycon=sbsa32,0x3ced1000


Regards,
Peter Hurley


> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
> 
> This patch applies on top of Russell's 12-part amba-pl011.c patchset.
> 
>  drivers/tty/serial/amba-pl011.c | 46 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 373b152..58eda89 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2301,10 +2301,10 @@ static struct console amba_console = {
>  
>  static void pl011_putc(struct uart_port *port, int c)
>  {
> -	while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>  		;
> -	writeb(c, port->membase + REG_DR);
> -	while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
> +	writeb(c, port->membase + UART01x_DR);
> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
>  		;
>  }
>  
> @@ -2315,13 +2315,51 @@ static void pl011_early_write(struct console *con, const char *s, unsigned n)
>  	uart_console_write(&dev->port, s, n, pl011_putc);
>  }
>  
> +static void pl011_putc_sbsa32(struct uart_port *port, int c)
> +{
> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
> +		cpu_relax();
> +	writel(c, port->membase + UART01x_DR);
> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
> +		cpu_relax();
> +}
> +
> +static void pl011_early_write_sbsa32(struct console *con, const char *s, unsigned n)
> +{
> +	struct earlycon_device *dev = con->data;
> +
> +	uart_console_write(&dev->port, s, n, pl011_putc_sbsa32);
> +}
> +
> +static void pl011_putc_zte(struct uart_port *port, int c)
> +{
> +	while (readl(port->membase + ZX_UART011_FR) & UART01x_FR_TXFF)
> +		cpu_relax();
> +	writel(c, port->membase + ZX_UART011_DR);
> +	while (readl(port->membase + ZX_UART011_FR) & UART01x_FR_BUSY)
> +		cpu_relax();
> +}
> +
> +static void pl011_early_write_zte(struct console *con, const char *s, unsigned n)
> +{
> +	struct earlycon_device *dev = con->data;
> +
> +	uart_console_write(&dev->port, s, n, pl011_putc_zte);
> +}
> +
>  static int __init pl011_early_console_setup(struct earlycon_device *device,
>  					    const char *opt)
>  {
>  	if (!device->port.membase)
>  		return -ENODEV;
>  
> -	device->con->write = pl011_early_write;
> +	if (strcmp(device->options, "sbsa32") == 0)
> +		device->con->write = pl011_early_write_sbsa32;
> +	else if (strcmp(device->options, "zte") == 0)
> +		device->con->write = pl011_early_write_zte;
> +	else
> +		device->con->write = pl011_early_write;
> +
>  	return 0;
>  }
>  EARLYCON_DECLARE(pl011, pl011_early_console_setup);
> 
