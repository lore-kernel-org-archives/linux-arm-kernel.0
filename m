From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 27 Feb 2018 14:12:55 +0100
Subject: [PATCH] serial: mvebu_uart: fix tx lost characters
In-Reply-To: <3B588D51285A4A4D8D39C94212E0782627008E@SPQCMBX02.exfo.com>
References: <3B588D51285A4A4D8D39C94212E0782627008E@SPQCMBX02.exfo.com>
Message-ID: <20180227141255.177ea751@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

On Thu, 22 Feb 2018 20:30:56 +0000, Gabriel Matni
<gabriel.matni@exfo.com> wrote:

> From: Gabriel Matni <gabriel.matni@exfo.com>
> 
> Fixes missing characters on kernel console at low baud rates (i.e.9600).
> The driver should poll TX_RDY instead of TX_EMPTY to ensure that the
> transmitter holding is ready to receive a new byte. Polling TX_EMPTY isn't
> enough as the hardware buffer can become empty but not yet ready for CPU to
> write the next byte.

I am kind of sceptic with the explanation. My understanding is that:
- TX_EMPTY means the FIFO is empty
- TX_RDY means the FIFO is not full, neither empty, it is a "half
  loaded" state.
Polling TX_RDY instead of TX_EMPTY should work too, but I don't see
why it would fix the loss of character by filling the FIFO when there
are bytes in it rather than when it is fully empty.

> 
> Signed-off-by: Gabriel Matni <gabriel.matni@exfo.com>
> ---
> drivers/tty/serial/mvebu-uart.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index a100e98259d7..f0df0640208e 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -618,7 +618,7 @@ static void wait_for_xmitr(struct uart_port *port)
>    u32 val;
> 
>    readl_poll_timeout_atomic(port->membase + UART_STAT, val,
> -             (val & STAT_TX_EMP), 1, 10000);
> +             (val & STAT_TX_RDY(port)), 1, 10000);

However, this change might have brought one noticeable difference: the
bit polled is a per-port bit while the TX_EMPTY bit looks global. So
maybe you faced the issue because you are using the ports quite
intensively in parallel?

Also it could explain why you only face the issue at slow baudrates:
bytes will remain longer in the FIFO, increasing the probability of
collision.

> }
> 
> static void mvebu_uart_console_putchar(struct uart_port *port, int ch)
> --
> 2.7.4

Thanks,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
