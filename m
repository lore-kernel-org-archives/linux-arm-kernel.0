From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Mar 2012 08:32:22 +0000
Subject: [PATCH] serial: PL011: clear pending interrupts
In-Reply-To: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120312083221.GW17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 09:25:50AM +0100, Linus Walleij wrote:
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 6800f5f..ff3fed0 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -224,6 +224,11 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
>  		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
>  	}
>  

What if we really do end up receiving some characters here?

> +	/* RXIS but RXFE? Just clear the interrupt */
> +	if(unlikely(fifotaken == 0))
> +		writew(UART011_RTIS | UART011_RXIS,
> +		       uap->port.membase + UART011_ICR);
