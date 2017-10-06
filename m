From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 06 Oct 2017 14:40:47 +0200
Subject: [PATCH 08/16] serial: mvebu-uart: clear state register before IRQ
 request
In-Reply-To: <20171006101344.15590-9-miquel.raynal@free-electrons.com> (Miquel
 Raynal's message of "Fri, 6 Oct 2017 12:13:36 +0200")
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
 <20171006101344.15590-9-miquel.raynal@free-electrons.com>
Message-ID: <878tgofnzk.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On ven., oct. 06 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> From: Allen Yan <yanwei@marvell.com>
>
> When receiving data on RX pin before ->uart_startup() is called, some
> error bits in the state register could be set up (like BRK_DET).
>
> This is harmless when using only the standard UART (error bits are
> read-only), but may procude an endless loop once in the extended UART
                      produce
> RX interrupt handler (error bits must be cleared).
>
> Clear the status register in ->uart_startup() to avoid this situation.
>
> Signed-off-by: Allen Yan <yanwei@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> ---
>  drivers/tty/serial/mvebu-uart.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 81a3d2714fd3..67f302748b78 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -322,6 +322,12 @@ static int mvebu_uart_startup(struct uart_port *port)
>  	writel(CTRL_TXFIFO_RST | CTRL_RXFIFO_RST,
>  	       port->membase + UART_CTRL(port));
>  	udelay(1);
> +
> +	/* Clear the error bits of state register before IRQ request */
> +	ret = readl(port->membase + UART_STAT);
> +	ret |= STAT_BRK_ERR;
> +	writel(ret, port->membase + UART_STAT);
> +
>  	writel(CTRL_BRK_INT, port->membase + UART_CTRL(port));
>  
>  	ctl = readl(port->membase + UART_INTR(port));
> -- 
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
