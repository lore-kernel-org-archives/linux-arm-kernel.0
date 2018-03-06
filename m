From: gabriel.matni@exfo.com (Gabriel Matni)
Date: Tue, 6 Mar 2018 15:47:03 +0000
Subject: [PATCH] serial: mvebu-uart: fix tx lost characters
Message-ID: <3B588D51285A4A4D8D39C94212E078262748ED@SPQCMBX02.exfo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Matni <gabriel.matni@exfo.com>

Fixes missing characters on kernel console at low baud rates (i.e.9600).
The driver should poll TX_RDY or TX_FIFO_EMP instead of TX_EMP to ensure
that the transmitter holding register (THR) is ready to receive a new byte.

TX_EMP tells us when it is possible to send a break sequence via
SND_BRK_SEQ. While this also indicates that both the THR and the TSR are
empty, it does not guarantee that a new byte can be written just yet.

Fixes: 30530791a7a0 ("serial: mvebu-uart: initial support for Armada-3700 serial port")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com> 
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>  
Signed-off-by: Gabriel Matni <gabriel.matni@exfo.com> 
---
drivers/tty/serial/mvebu-uart.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index a100e98259d7..f0df0640208e 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -618,7 +618,7 @@ static void wait_for_xmitr(struct uart_port *port)
   u32 val;

   readl_poll_timeout_atomic(port->membase + UART_STAT, val,
-             (val & STAT_TX_EMP), 1, 10000);
+             (val & STAT_TX_RDY(port)), 1, 10000);
}

static void mvebu_uart_console_putchar(struct uart_port *port, int ch)
--
2.7.4

> -----Original Message-----
> From: Miquel Raynal [mailto:miquel.raynal at bootlin.com]
> Sent: March 5, 2018 4:47 AM
> To: Gabriel Matni <gabriel.matni@exfo.com>
> Cc: linux-arm-kernel at lists.infradead.org; gregkh at linuxfoundation.org;
> Gr?gory Clement <gregory.clement@bootlin.com>; Thomas Petazzoni
> <thomas.petazzoni@bootlin.com>
> Subject: Re: [PATCH] serial: mvebu_uart: fix tx lost characters
> 
> Hi Gabriel,
> 
> On Tue, 27 Feb 2018 21:56:03 +0000, Gabriel Matni
> <gabriel.matni@exfo.com> wrote:
> 
> > Hi Miqu?l,
> >
> > > -----Original Message-----
> > > From: Miquel Raynal [mailto:miquel.raynal at bootlin.com]
> > > Sent: February 27, 2018 8:13 AM
> > > To: Gabriel Matni <gabriel.matni@exfo.com>
> > > Cc: linux-arm-kernel at lists.infradead.org; gregkh at linuxfoundation.org;
> > > Gr?gory Clement <gregory.clement@bootlin.com>; Thomas Petazzoni
> > > <thomas.petazzoni@bootlin.com>
> > > Subject: Re: [PATCH] serial: mvebu_uart: fix tx lost characters
> > >
> > > Hi Gabriel,
> > >
> > > On Thu, 22 Feb 2018 20:30:56 +0000, Gabriel Matni
> > > <gabriel.matni@exfo.com> wrote:
> > >
> > > > From: Gabriel Matni <gabriel.matni@exfo.com>
> > > >
> > > > Fixes missing characters on kernel console at low baud rates (i.e.9600).
> > > > The driver should poll TX_RDY instead of TX_EMPTY to ensure that the
> > > > transmitter holding is ready to receive a new byte. Polling TX_EMPTY
> > > > isn't enough as the hardware buffer can become empty but not yet
> ready
> > > > for CPU to write the next byte.
> > >
> > > I am kind of sceptic with the explanation. My understanding is that:
> > > - TX_EMPTY means the FIFO is empty
> 
> I had a deeper look into the spec : TX_EMPTY != TX_FIFO_EMPTY. I was
> referring to TX_FIFO_EMPTY here so my understanding of your solution was
> wrong.
> 
> > > - TX_RDY means the FIFO is not full, neither empty, it is a "half
> > >   loaded" state.
> > > Polling TX_RDY instead of TX_EMPTY should work too, but I don't see why
> it
> > > would fix the loss of character by filling the FIFO when there are bytes in
> it
> > > rather than when it is fully empty.
> >
> > TX_READY is set whenever the UART Transmitter Holding register is ready
> to
> > receive a new byte. It gets cleared as soon as a new byte is written to the
> > register. If the FIFO is empty or still has room, the ready will be set.
> >
> > TX_EMPTY tells us when it is possible to send a break sequence via
> > SND_BRK_SEQ. While this also indicates that both the THR and the TSR are
> > empty, it does not guarantee that a new byte can be written just yet.
> 
> I do agree with this statement. You are right that polling on TX_EMPTY
> looks wrong and we should definitively poll on TX_READY instead.
> 
> > I am
> > unsure about the FIFO status in this case as I can encounter
> TX_FIFO_EMP=0
> > while TX_EMP=1, which suggests that the FIFO isn't necessarily empty
> when
> > TX_EMP is set.
> 
> That is weird but maybe the TX_FIFO_EMPTY is asserted only when all
> bits have been shifted, which is a 10-bit period after TSR is
> cleared, while TX_EMPTY would not wait for these bits to be actually
> shifted out and would be asserted a bit earlier, as soon as TSR is
> cleared. That is just and idea.
> 
> >
> > Therefore, the driver can either poll TX_FIFO_EMP or TX_READY to know
> > whether it can output a new byte. I personally like TX_READY as it takes
> > advantage of the FIFO.
> 
> True.
> 
> >
> > > >
> > > > Signed-off-by: Gabriel Matni <gabriel.matni@exfo.com>
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Thanks,
> Miqu?l
> 
> --
> Miquel Raynal, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
