From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 16 Oct 2013 12:54:11 -0700
Subject: [PATCH v3 2/2] serial: mxs-auart: wait for FIFO to flush before
 shutdown
In-Reply-To: <20131003181740.GB10079@pengutronix.de>
References: <1380785524-20490-1-git-send-email-hector.palacios@digi.com>
 <1380785524-20490-3-git-send-email-hector.palacios@digi.com>
 <20131003181740.GB10079@pengutronix.de>
Message-ID: <20131016195411.GA21020@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 08:17:40PM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> there is only a single concern left and probably only the Freescale guys
> can comment here ...
> On Thu, Oct 03, 2013 at 09:32:04AM +0200, Hector Palacios wrote:
> > The shutdown function was not waiting for the FIFO (which may be the
> > real 16 byte FIFO or the DMA buffer, if DMA is enabled) to flush
> > before disabling the AUART.
> > This lead to many bytes not being transferred (specially at low
> > baudrates), as they were still in the DMA buffer when the AUART was
> > shutdown.
> > This patch also adds the check for the BUSY flag on the tx_empty
> > callback.
> > 
> > Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> > ---
> >  drivers/tty/serial/mxs-auart.c | 25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> > index 9f046177..30edb91 100644
> > --- a/drivers/tty/serial/mxs-auart.c
> > +++ b/drivers/tty/serial/mxs-auart.c
> > @@ -757,9 +757,26 @@ static int mxs_auart_startup(struct uart_port *u)
> >  	return 0;
> >  }
> >  
> > +static unsigned int mxs_auart_tx_empty(struct uart_port *u)
> > +{
> > +	unsigned long stat;
> > +
> > +	stat = readl(u->membase + AUART_STAT);
> > +	if ((stat & (AUART_STAT_BUSY | AUART_STAT_TXFE)) == AUART_STAT_TXFE)
> > +		return TIOCSER_TEMT;
> Can it happen that both the fifo and the shifter are empty but there are
> still some chars pending to be transfered via DMA? If you were checking
> if dma is still setup you'd be on the safe side.

I'm deleting this from my queue until this gets resolved.  Someone
please resend it when it does.

thanks,

greg k-h
