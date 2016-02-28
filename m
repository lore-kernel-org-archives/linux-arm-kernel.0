From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 28 Feb 2016 12:23:23 +0200
Subject: [PATCH] serial: imx: support RS-485 Rx disable on Tx
In-Reply-To: <20160228095601.GB2613@pengutronix.de>
References: <3b5ba06fdb9c1bdd0b3018bf2f623f52b2856d18.1456651551.git.baruch@tkos.co.il>
 <20160228095601.GB2613@pengutronix.de>
Message-ID: <20160228102323.GI2399@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Thanks for your prompt response.

On Sun, Feb 28, 2016 at 10:56:01AM +0100, Uwe Kleine-K?nig wrote:
> On Sun, Feb 28, 2016 at 11:25:51AM +0200, Baruch Siach wrote:
> > Some RS-232 to RS-485 transceivers require Rx to be disabled on Tx to
> > avoid echo of Tx data into the Rx buffer. Specifically, the XR3160E
> > RS-232/RS-485/RS-422 transceiver behaves this way.
> > 
> > This commit disables Rx on active Tx when SER_RS485_ENABLED is active and
> > SER_RS485_RX_DURING_TX is disabled.
> > 
> > Note that this is a change in behavior of the driver. Until now
> 
> But this change is a good one (assuming it does what it advertises :-).
> Userspace got informed before that SER_RS485_RX_DURING_TX is enabled, so
> this is not an incompatible change.

I thought it is a good idea to mention this fact in the commit log anyway. It 
is not hard to imagine broken userspace being affected by this change.

> > SER_RS485_RX_DURING_TX was enabled unconditionally even when disabled in
> > the TIOCSRS485 ioctl serial_rs485 flags field.
> > 
> > Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> >  drivers/tty/serial/imx.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 9362f54c816c..333d34ff358c 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -361,6 +361,8 @@ static void imx_stop_tx(struct uart_port *port)
> >  			imx_port_rts_inactive(sport, &temp);
> >  		else
> >  			imx_port_rts_active(sport, &temp);
> > +		if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
> > +			temp |= UCR2_RXEN;
> >  		writel(temp, port->membase + UCR2);
> >  
> >  		temp = readl(port->membase + UCR4);
> > @@ -568,6 +570,8 @@ static void imx_start_tx(struct uart_port *port)
> >  			imx_port_rts_inactive(sport, &temp);
> >  		else
> >  			imx_port_rts_active(sport, &temp);
> > +		if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
> > +			temp &= ~UCR2_RXEN;
> >  		writel(temp, port->membase + UCR2);
> 
> Can this happen:
> 
>  - SER_RS485_RX_DURING_TX is off
>  - thread A starts sending (and so disables RX)
>  - thread B sets SER_RS485_RX_DURING_TX
>  - thread A finishes sending, and doesn't restore RXEN.
> 
> ?
> 
> Even if this cannot happen it might be more robust to restore RXEN
> unconditionally in imx_stop_tx?!

Sounds like a good idea. But if I take your comment to its logical conclusion, 
thread B might just disable SER_RS485_ENABLED entirely. Would it make sense to 
restore RXEN outside the 'if (port->rs485.flags & SER_RS485_ENABLED)' block?  
Or maybe we should just set RXEN in imx_rs485_config() when 
SER_RS485_RX_DURING_TX is enabled?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
