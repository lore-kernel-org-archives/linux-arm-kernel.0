From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 20 Dec 2011 15:07:50 +0100
Subject: [PATCH 08/12] serial: mxs-auart: convert to
 clk_prepare/clk_unprepare
In-Reply-To: <201112201449.13420.marek.vasut@gmail.com>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
 <1324382443-4439-9-git-send-email-shawn.guo@linaro.org>
 <201112201449.13420.marek.vasut@gmail.com>
Message-ID: <20111220140750.GZ24496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Dec 20, 2011 at 02:49:13PM +0100, Marek Vasut wrote:
> > The patch converts mxs-auart driver to clk_prepare/clk_unprepare by
> > using helper functions clk_prepare_enable/clk_disable_unprepare.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Alan Cox <alan@linux.intel.com>
> > ---
> >  drivers/tty/serial/mxs-auart.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/mxs-auart.c
> > b/drivers/tty/serial/mxs-auart.c index 7e02c9c..c33500a 100644
> > --- a/drivers/tty/serial/mxs-auart.c
> > +++ b/drivers/tty/serial/mxs-auart.c
> > @@ -424,7 +424,7 @@ static int mxs_auart_startup(struct uart_port *u)
> >  {
> >  	struct mxs_auart_port *s = to_auart_port(u);
> > 
> > -	clk_enable(s->clk);
> > +	clk_prepare_enable(s->clk);
> > 
> >  	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
> > 
> > @@ -453,7 +453,7 @@ static void mxs_auart_shutdown(struct uart_port *u)
> >  	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
> >  			u->membase + AUART_INTR_CLR);
> > 
> > -	clk_disable(s->clk);
> > +	clk_disable_unprepare(s->clk);
> >  }
> > 
> >  static unsigned int mxs_auart_tx_empty(struct uart_port *u)
> > @@ -634,7 +634,7 @@ auart_console_setup(struct console *co, char *options)
> >  	if (!s)
> >  		return -ENODEV;
> > 
> > -	clk_enable(s->clk);
> > +	clk_prepare_enable(s->clk);
> > 
> >  	if (options)
> >  		uart_parse_options(options, &baud, &parity, &bits, &flow);
> > @@ -643,7 +643,7 @@ auart_console_setup(struct console *co, char *options)
> > 
> >  	ret = uart_set_options(&s->port, co, baud, parity, bits, flow);
> > 
> > -	clk_disable(s->clk);
> > +	clk_disable_unprepare(s->clk);
> > 
> >  	return ret;
> >  }
> 
> DTTO here, are you sure all of them are not called from atomic ctx?
the startup callback is called with irqs off. AFAIK clk_prepare should
be called in request_port and console_setup.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
