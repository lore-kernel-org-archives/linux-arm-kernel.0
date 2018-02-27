From: gabriel.matni@exfo.com (Gabriel Matni)
Date: Tue, 27 Feb 2018 21:56:03 +0000
Subject: [PATCH] serial: mvebu_uart: fix tx lost characters
In-Reply-To: <20180227141255.177ea751@xps13>
References: <3B588D51285A4A4D8D39C94212E0782627008E@SPQCMBX02.exfo.com>
 <20180227141255.177ea751@xps13>
Message-ID: <3B588D51285A4A4D8D39C94212E07826271B70@SPQCMBX02.exfo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miqu?l,

> -----Original Message-----
> From: Miquel Raynal [mailto:miquel.raynal at bootlin.com]
> Sent: February 27, 2018 8:13 AM
> To: Gabriel Matni <gabriel.matni@exfo.com>
> Cc: linux-arm-kernel at lists.infradead.org; gregkh at linuxfoundation.org;
> Gr?gory Clement <gregory.clement@bootlin.com>; Thomas Petazzoni
> <thomas.petazzoni@bootlin.com>
> Subject: Re: [PATCH] serial: mvebu_uart: fix tx lost characters
> 
> Hi Gabriel,
> 
> On Thu, 22 Feb 2018 20:30:56 +0000, Gabriel Matni
> <gabriel.matni@exfo.com> wrote:
> 
> > From: Gabriel Matni <gabriel.matni@exfo.com>
> >
> > Fixes missing characters on kernel console at low baud rates (i.e.9600).
> > The driver should poll TX_RDY instead of TX_EMPTY to ensure that the
> > transmitter holding is ready to receive a new byte. Polling TX_EMPTY
> > isn't enough as the hardware buffer can become empty but not yet ready
> > for CPU to write the next byte.
> 
> I am kind of sceptic with the explanation. My understanding is that:
> - TX_EMPTY means the FIFO is empty
> - TX_RDY means the FIFO is not full, neither empty, it is a "half
>   loaded" state.
> Polling TX_RDY instead of TX_EMPTY should work too, but I don't see why it
> would fix the loss of character by filling the FIFO when there are bytes in it
> rather than when it is fully empty.

TX_READY is set whenever the UART Transmitter Holding register is ready to
receive a new byte. It gets cleared as soon as a new byte is written to the
register. If the FIFO is empty or still has room, the ready will be set.

TX_EMPTY tells us when it is possible to send a break sequence via
SND_BRK_SEQ. While this also indicates that both the THR and the TSR are
empty, it does not guarantee that a new byte can be written just yet. I am
unsure about the FIFO status in this case as I can encounter TX_FIFO_EMP=0
while TX_EMP=1, which suggests that the FIFO isn't necessarily empty when
TX_EMP is set.

Therefore, the driver can either poll TX_FIFO_EMP or TX_READY to know
whether it can output a new byte. I personally like TX_READY as it takes
advantage of the FIFO.

> >
> > Signed-off-by: Gabriel Matni <gabriel.matni@exfo.com>
> > ---
> > drivers/tty/serial/mvebu-uart.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/mvebu-uart.c
> > b/drivers/tty/serial/mvebu-uart.c index a100e98259d7..f0df0640208e
> > 100644
> > --- a/drivers/tty/serial/mvebu-uart.c
> > +++ b/drivers/tty/serial/mvebu-uart.c
> > @@ -618,7 +618,7 @@ static void wait_for_xmitr(struct uart_port *port)
> >    u32 val;
> >
> >    readl_poll_timeout_atomic(port->membase + UART_STAT, val,
> > -             (val & STAT_TX_EMP), 1, 10000);
> > +             (val & STAT_TX_RDY(port)), 1, 10000);
> 
> However, this change might have brought one noticeable difference: the bit
> polled is a per-port bit while the TX_EMPTY bit looks global. So maybe you
> faced the issue because you are using the ports quite intensively in parallel?
> 
> Also it could explain why you only face the issue at slow baudrates:
> bytes will remain longer in the FIFO, increasing the probability of collision.
> 

In both cases, they are per-port bits, however since UARTS are not
identical (normal vs extended), the driver implementation treats them
differently.  For instance, STAT_TX_EMP maps to bit 6 of the status
register regardless of the UART, however TX_RDY(port) maps to SR bit 5 on
UART1 and SR bit 15 on UART2.

> > }
> >
> > static void mvebu_uart_console_putchar(struct uart_port *port, int ch)
> > --
> > 2.7.4
> 
> Thanks,
> Miqu?l
> 
> --
> Miquel Raynal, Bootlin (formerly Free Electrons) Embedded Linux and Kernel
> engineering https://bootlin.com

Regards,
Gabriel
