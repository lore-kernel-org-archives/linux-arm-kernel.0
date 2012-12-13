From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 13 Dec 2012 14:19:12 +0100
Subject: [PATCH v2] mxs: uart: allow setting RTS from software
In-Reply-To: <50C9ABB4.8010900@freescale.com>
References: <1355388135-3676-1-git-send-email-s.trumtrar@pengutronix.de>
 <50C9ABB4.8010900@freescale.com>
Message-ID: <20121213131912.GB27832@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 06:19:32PM +0800, Huang Shijie wrote:
> ? 2012?12?13? 16:42, Steffen Trumtrar ??:
> > With the patch "serial: mxs-auart: fix the wrong RTS hardware flow control" the
> > mainline mxs-uart driver now sets RTSEN only when hardware flow control is
> > enabled via software. It is not possible any longer to set RTS manually via
> > software. However, the manual modification is a valid operation.
> > Regain the possibility to set RTS via software and only set RTSEN when hardware
> > flow control is explicitly enabled via settermios cflag CRTSCTS.
> >
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  drivers/tty/serial/mxs-auart.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> > index 6db23b0..21d9b12 100644
> > --- a/drivers/tty/serial/mxs-auart.c
> > +++ b/drivers/tty/serial/mxs-auart.c
> > @@ -412,10 +412,12 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
> >  
> >  	u32 ctrl = readl(u->membase + AUART_CTRL2);
> >  
> > -	ctrl &= ~AUART_CTRL2_RTSEN;
> > +	ctrl &= ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
> >  	if (mctrl & TIOCM_RTS) {
> >  		if (tty_port_cts_enabled(&u->state->port))
> >  			ctrl |= AUART_CTRL2_RTSEN;
> > +		else
> > +			ctrl |= AUART_CTRL2_RTS;
> >  	}
> >  
> >  	s->ctrl = mctrl;
> > @@ -676,8 +678,10 @@ static void mxs_auart_settermios(struct uart_port *u,
> >  				ctrl2 |= AUART_CTRL2_TXDMAE | AUART_CTRL2_RXDMAE
> >  				       | AUART_CTRL2_DMAONERR;
> >  		}
> > +		u->flags |= ASYNC_CTS_FLOW;
> >  		ctrl2 |= AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
> >  	} else {
> > +		u->flags &= ~ASYNC_CTS_FLOW;
> I think these two lines is not needed.
> uart_change_speed() has set/unset ASYNC_CTS_FLOW for us.

I don't know that much of the inner workings of the serial framework, but it
seems like it is guaranteed, that uart_change_speed is called before the
mxs_auart_settermios. And therefore you are right and the two lines can be
dropped.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
