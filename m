From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 07 Sep 2015 11:15:54 +0200
Subject: [PATCH v2 1/8] clk: imx: add common logic to detect early UART
 usage
In-Reply-To: <20150907090603.GU9999@pengutronix.de>
References: <1441382419-4343-1-git-send-email-l.stach@pengutronix.de>
 <1441382419-4343-2-git-send-email-l.stach@pengutronix.de>
 <20150907090603.GU9999@pengutronix.de>
Message-ID: <1441617354.28391.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 07.09.2015, 11:06 +0200 schrieb Uwe Kleine-K?nig:
> Hello Lucas,
> 
> On Fri, Sep 04, 2015 at 06:00:12PM +0200, Lucas Stach wrote:
> > Both earlycon and eralyprintk depend on the bootloader setup UART
> > clocks being retained. This patch adds the common logic to detect such
> > situations and make the information available to the clock drivers, as
> > well as adding the facilities to disable those clocks at the end of
> > the kernel init.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/clk/imx/clk.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/imx/clk.h |  1 +
> >  2 files changed, 47 insertions(+)
> > 
> > diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> > index df12b5307175..3357e29e43ab 100644
> > --- a/drivers/clk/imx/clk.c
> > +++ b/drivers/clk/imx/clk.c
> > @@ -73,3 +73,49 @@ void imx_cscmr1_fixup(u32 *val)
> >  	*val ^= CSCMR1_FIXUP;
> >  	return;
> >  }
> > +
> > +static int __initdata imx_keep_uart_clocks;
> > +static struct clk __initdata ***imx_uart_clocks;
> > +
> > +static int __init imx_keep_uart_clocks_param(char *str)
> > +{
> > +	imx_keep_uart_clocks = 1;
> > +
> > +	return 0;
> > +}
> > +__setup_param("earlycon", imx_keep_uart_earlycon,
> > +	      imx_keep_uart_clocks_param, 0);
> > +__setup_param("earlyprintk", imx_keep_uart_earlyprintk,
> > +	      imx_keep_uart_clocks_param, 0);
> > +
> > +void __init imx_register_uart_clocks(struct clk **clks[])
> 
> const struct clk **clks[]?
> 
Yep, will do.

> I wonder why you need an array of pointers to pointers of clocks. Isn't
> one indirection less possible and more easy?
> 
No, this is not easily possible if we want to use the auto-discarding of
the clocks array and a simple static initialization. The clock pointers
are only set up after the clock drivers probe routine has run, so if I
want to point to the actual clocks I would need to dynamically populate
the array and either dynamically allocate it, or would need to pre-size
the static array.

So this added indirection and slight complication of the the common code
cuts out some lines of code and chances to get things wrong in the
individual clock drivers. So I think the trade off I made here is
justified.

> > +{
> > +	if (imx_keep_uart_clocks) {
> > +		int i;
> > +
> > +		imx_uart_clocks = clks;
> > +		for (i = 0;; i++) {
> > +			if (imx_uart_clocks[i])
> > +				clk_prepare_enable(*imx_uart_clocks[i]);
> > +			else
> > +				break;
> > +		}
> 
> I would have written this as:
> 
> 	for (i = 0; imx_uart_clocks[i]; ++i)
> 		clk_prepare_enable(*imx_uart_clocks[i]);
> 
> but I guess that's a matter of taste.
> 
Philipp agrees with you. ;) But I like the more explicit style a bit
more.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
