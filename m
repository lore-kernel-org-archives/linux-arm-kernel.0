From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Dec 2011 22:24:42 +0000
Subject: [PATCH 08/12] serial: mxs-auart: convert to
 clk_prepare/clk_unprepare
In-Reply-To: <201112202228.27468.marek.vasut@gmail.com>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
 <20111220140750.GZ24496@pengutronix.de>
 <20111220211519.GF2577@n2100.arm.linux.org.uk>
 <201112202228.27468.marek.vasut@gmail.com>
Message-ID: <20111220222442.GH2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 10:28:26PM +0100, Marek Vasut wrote:
> > On Tue, Dec 20, 2011 at 03:07:50PM +0100, Uwe Kleine-K?nig wrote:
> > > Hello,
> > > 
> > > On Tue, Dec 20, 2011 at 02:49:13PM +0100, Marek Vasut wrote:
> > > > > The patch converts mxs-auart driver to clk_prepare/clk_unprepare by
> > > > > using helper functions clk_prepare_enable/clk_disable_unprepare.
> > > > > 
> > > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > Cc: Alan Cox <alan@linux.intel.com>
> > > > > ---
> > > > > 
> > > > >  drivers/tty/serial/mxs-auart.c |    8 ++++----
> > > > >  1 files changed, 4 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/tty/serial/mxs-auart.c
> > > > > b/drivers/tty/serial/mxs-auart.c index 7e02c9c..c33500a 100644
> > > > > --- a/drivers/tty/serial/mxs-auart.c
> > > > > +++ b/drivers/tty/serial/mxs-auart.c
> > > > > @@ -424,7 +424,7 @@ static int mxs_auart_startup(struct uart_port *u)
> > > > > 
> > > > >  {
> > > > >  
> > > > >  	struct mxs_auart_port *s = to_auart_port(u);
> > > > > 
> > > > > -	clk_enable(s->clk);
> > > > > +	clk_prepare_enable(s->clk);
> > > > > 
> > > > >  	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
> > > > > 
> > > > > @@ -453,7 +453,7 @@ static void mxs_auart_shutdown(struct uart_port
> > > > > *u)
> > > > > 
> > > > >  	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
> > > > >  	
> > > > >  			u->membase + AUART_INTR_CLR);
> > > > > 
> > > > > -	clk_disable(s->clk);
> > > > > +	clk_disable_unprepare(s->clk);
> > > > > 
> > > > >  }
> > > > >  
> > > > >  static unsigned int mxs_auart_tx_empty(struct uart_port *u)
> > > > > 
> > > > > @@ -634,7 +634,7 @@ auart_console_setup(struct console *co, char
> > > > > *options)
> > > > > 
> > > > >  	if (!s)
> > > > >  	
> > > > >  		return -ENODEV;
> > > > > 
> > > > > -	clk_enable(s->clk);
> > > > > +	clk_prepare_enable(s->clk);
> > > > > 
> > > > >  	if (options)
> > > > >  	
> > > > >  		uart_parse_options(options, &baud, &parity, &bits, 
> &flow);
> > > > > 
> > > > > @@ -643,7 +643,7 @@ auart_console_setup(struct console *co, char
> > > > > *options)
> > > > > 
> > > > >  	ret = uart_set_options(&s->port, co, baud, parity, bits, flow);
> > > > > 
> > > > > -	clk_disable(s->clk);
> > > > > +	clk_disable_unprepare(s->clk);
> > > > > 
> > > > >  	return ret;
> > > > >  
> > > > >  }
> > > > 
> > > > DTTO here, are you sure all of them are not called from atomic ctx?
> > > 
> > > the startup callback is called with irqs off.
> > 
> > It shouldn't be, as it has to do things like request_irq() which can
> > sleep.  The documentation in Documentation/serial/driver is now out
> > of date, and can't be relied upon.
> 
> auart_rx/tx_empty() shouldn't be called from atomic context? It
> doesn't really look that way. The name is probably misleading though.

I can't find an auart_rx nor auart_rx_empty() function.

The tx_empty function should only be called while the port is started-up,
and in any case is only called from process context.  (Functions calling
this also call put_user(), msleep() or other functions which can cause
schedule events.)
