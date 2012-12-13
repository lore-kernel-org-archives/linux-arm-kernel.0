From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 13 Dec 2012 09:40:17 +0100
Subject: [PATCH] mxs: uart: allow setting RTS from software
In-Reply-To: <50C93B6B.7090206@freescale.com>
References: <1355329913-27666-1-git-send-email-s.trumtrar@pengutronix.de>
 <50C93B6B.7090206@freescale.com>
Message-ID: <20121213084017.GA27832@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 13, 2012 at 10:20:27AM +0800, Huang Shijie wrote:
> ? 2012?12?13? 00:31, Steffen Trumtrar ??:
> > With the patch "serial: mxs-auart: fix the wrong RTS hardware flow control" the
> > mainline mxs-uart driver now sets RTSEN only when hardware flow control is
> > enabled via software. It is not possible any longer to set RTS manually via
> > software. However, the manual modification is a valid operation.
> > Regain the possibility to set RTS via software and only set RTSEN when hardware
> Is there any user case to set the RTS via software?
> I am confused at this.

there are cases where the RTS is used in a non-standard way. And the always-on
hardware flowcontrol breaks these (e.g. Echelon FT5000).
And as stated in the commit message, it is a valid operation to use software
flow control.

> > flow control is explicitly enabled via settermios cflag CRTSCTS.
> >
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  drivers/tty/serial/mxs-auart.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> > index 6db23b0..9b62c4b 100644
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
> > @@ -678,6 +680,10 @@ static void mxs_auart_settermios(struct uart_port *u,
> >  		}
> >  		ctrl2 |= AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
> >  	} else {
> > +		u->flags |= ASYNC_CTS_FLOW;
> > +		ctrl2 |= AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
> > +	} else {
> > +		u->flags &= ~ASYNC_CTS_FLOW;
> bug.
> 
> Your code adds TWO "else" here.
> 

Oops, wrong merge resolution. Will fix that.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
