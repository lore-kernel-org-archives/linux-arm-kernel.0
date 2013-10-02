From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 2 Oct 2013 09:44:36 +0200
Subject: [PATCH] serial: mxs-auart: wait for DMA buffer to flush before
 shutdown
In-Reply-To: <524BCBC4.5050708@digi.com>
References: <1380644315-31581-1-git-send-email-hector.palacios@digi.com>
 <20131001194800.GL2548@pengutronix.de> <524BCBC4.5050708@digi.com>
Message-ID: <20131002074436.GM2548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Oct 02, 2013 at 09:31:16AM +0200, Hector Palacios wrote:
> On 10/01/2013 09:48 PM, Uwe Kleine-K?nig wrote:
> >On Tue, Oct 01, 2013 at 06:18:35PM +0200, Hector Palacios wrote:
> >>The shutdown function was not waiting for the DMA buffer to flush
> >>before disabling the AUART. This lead to many bytes not being
> >>transferred (specially at low baudrates), as they were still in the
> >>DMA buffer when the AUART was shutdown.
> >>This patch also adds the check for the BUSY flag.
> >>
> >>Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> >>
> >>[...]
> >>---
> >>  drivers/tty/serial/mxs-auart.c | 16 +++++++++++++++-
> >>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> >>index f85b8e6..0d8b2ca 100644
> >>--- a/drivers/tty/serial/mxs-auart.c
> >>+++ b/drivers/tty/serial/mxs-auart.c
> >>@@ -750,12 +750,26 @@ static int mxs_auart_startup(struct uart_port *u)
> >>  	return 0;
> >>  }
> >>
> >>+static unsigned int mxs_auart_tx_empty(struct uart_port *u);
> >>+
> >>  static void mxs_auart_shutdown(struct uart_port *u)
> >>  {
> >>  	struct mxs_auart_port *s = to_auart_port(u);
> >>+	unsigned int to;
> >>+
> >>+	if (auart_dma_enabled(s)) {
> >>+		/* Wait enough time to flush DMA buffer completely */
> >>+		to = u->timeout * UART_XMIT_SIZE / u->fifosize;
> >u->timeout is the time needed to send one char, right? UART_XMIT_SIZE is
> >the size of the circular buffer, fifosize is the size of the fifo. I
> >don't get what you get by dividing by the fifosize. I would have
> >expected something like:
> >
> >	u->timeout * min(UART_XMIT_SIZE, u->fifosize)
> >
> >Can you explain, maybe in a comment along the code for the next person
> >not understanding?
> 
> u->timeout is *not* the time needed to send one char but the time
> needed to flush the complete port fifo (see uart_update_timeout() in
> serial_core.c where it is set).
Ah, right. (BTW, uart_update_timeout should better round up instead of
round down, i.e.
-	port->timeout = (HZ * bits) / baud + HZ/50;
+	port->timeout = DIV_ROUND_UP(HZ * bits, baud) + HZ/50;
)

> UART_XMIT_SIZE is the number of bytes in the DMA buffer, so I divide
> the max number of bytes in the FIFO by the FIFO size and multiply by
> the FIFO timeout.
ditto here, better round up. Although I think using a completion could
shorten the timeout considerably because there are often less than
UART_XMIT_SIZE chars in the buffer?!

> >I wonder if the individual driver is the right place this must be fixed
> >in or if there should be (or even exists) some help form the serial
> >framework?!
> 
> Good question, the issue should exit in other DMA drivers as well.
Added Jiri and lakml to Cc:. Maybe someone can say something about that
topic?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
