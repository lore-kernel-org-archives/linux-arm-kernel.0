From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 Oct 2010 10:46:10 +0200
Subject: [PATCH] ARM: imx serial driver: fix resume
In-Reply-To: <20101012183239.GG7159@buzzloop.caiaq.de>
References: <1286384236-4241-1-git-send-email-daniel@caiaq.de>
	<20101012175658.GQ29673@pengutronix.de>
	<20101012183239.GG7159@buzzloop.caiaq.de>
Message-ID: <20101013084610.GA21498@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 12, 2010 at 08:32:39PM +0200, Daniel Mack wrote:
> On Tue, Oct 12, 2010 at 07:56:58PM +0200, Uwe Kleine-K?nig wrote:
> > On Wed, Oct 06, 2010 at 06:57:16PM +0200, Daniel Mack wrote:
> > > From: Volker Ernst <volker.ernst@txtr.com>
> > > 
> > > I just came across a bug in the IMX31 serial driver which is still
> > > present in the newest kernels and which prevents successful
> > > resume-operation for the IMX31 serial ports.
> > > 
> > > What happens is that in "drivers/serial/imx.c" on resume function
> > > "serial_imx_resume" gets called. This function in turn calls
> > > "uart_resume_port" (in the generic serial driver "serial_core.c"),
> > > which in turn calls "imx_start_tx" in "imx.c" (in case the SIO-port
> > > was really suspended) which in turn calls "imx_transmit_buffer".
> > > 
> > > However calling "imx_transmit_buffer" with an empty TX-fifo (as is
> > > usually the case) will result in the serial port starting to transmit
> > > (actually the old [already sent] tx-buffer), as there is no check if
> > > the tx-buffer is empty before starting to feed tx-fifo-data to the
> > > serial port hardware.
> > > 
> > > Signed-off-by: Volker Ernst <volker.ernst@txtr.com>
> > > Cc: Daniel Mack <daniel@caiaq.de>
> > > Cc: Andy Green <andy@warmcat.com>
> > > ---
> > > 
> > > Volker did all the work on this, he just doesn't want to push his great
> > > contributions upstream, so I do it for him :)
> > > 
> > > 
> > >  drivers/serial/imx.c |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
> > > index 66ecc7a..0170119 100644
> > > --- a/drivers/serial/imx.c
> > > +++ b/drivers/serial/imx.c
> > > @@ -328,13 +328,13 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
> > >  	struct circ_buf *xmit = &sport->port.state->xmit;
> > >  
> > >  	while (!(readl(sport->port.membase + UTS) & UTS_TXFULL)) {
> > > +		if (uart_circ_empty(xmit))
> > > +			break;
> > >  		/* send xmit->buf[xmit->tail]
> > >  		 * out the port here */
> > >  		writel(xmit->buf[xmit->tail], sport->port.membase + URTX0);
> > >  		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> > >  		sport->port.icount.tx++;
> > > -		if (uart_circ_empty(xmit))
> > > -			break;
> > >  	}
> > >  
> > >  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > I needed that patch now, too, though in a different situation.  I havn't
> > investigated the details yet, but I think the problem is that
> > imx_transmit_buffer is called, too, when using handshaking and the other
> > side starts to be ready.
> > 
> > You can count that as an Acked-by: me, preferably with the check added
> > to the while condition as suggested in a different mail of this thread.
> 
> Ok, thanks. However, I can not test this myself - Volker, can you try
> the patch Uwe sent along some days ago?
I'm currently working on an other issue with the driver that will result
in a few patches.  So I can just pick up this patch en passant and look
to get it into mainline.

Still a fixed patch or an Ack would be fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
