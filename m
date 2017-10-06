From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 06 Oct 2017 22:22:09 +0200
Subject: [PATCH 09/16] serial: mvebu-uart: add TX interrupt trigger for
 pulse interrupts
In-Reply-To: <20171006101344.15590-10-miquel.raynal@free-electrons.com>
 (Miquel Raynal's message of "Fri, 6 Oct 2017 12:13:37 +0200")
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
 <20171006101344.15590-10-miquel.raynal@free-electrons.com>
Message-ID: <87r2ugc9hq.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On ven., oct. 06 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> From: Allen Yan <yanwei@marvell.com>
>
> Pulse interrupts (extended UART only) needs a change of state to trigger
> the TX interrupt. In addition to enabling the TX_READY_INT_EN flag,
> produce a FIFO state change from 'empty' to 'not full'. For this, write
> only one data byte in TX start, making the TX FIFO not empty, and wait
> for the TX interrupt to continue the transfer.
>
> Signed-off-by: Allen Yan <yanwei@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> ---
>  drivers/tty/serial/mvebu-uart.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 67f302748b78..46d10209637a 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -165,8 +165,16 @@ static void mvebu_uart_stop_tx(struct uart_port *port)
>  
>  static void mvebu_uart_start_tx(struct uart_port *port)
>  {
> -	unsigned int ctl = readl(port->membase + UART_INTR(port));
> +	unsigned int ctl;
> +	struct circ_buf *xmit = &port->state->xmit;
>  
> +	if (IS_EXTENDED(port) && !uart_circ_empty(xmit)) {
> +		writel(xmit->buf[xmit->tail], port->membase + UART_TSH(port));
> +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +		port->icount.tx++;
> +	}
> +
> +	ctl = readl(port->membase + UART_INTR(port));
>  	ctl |= CTRL_TX_RDY_INT(port);
>  	writel(ctl, port->membase + UART_INTR(port));
>  }
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
