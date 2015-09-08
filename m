From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 08 Sep 2015 10:51:42 +0200
Subject: [PATCH v3 1/8] clk: imx: add common logic to detect early UART
 usage
In-Reply-To: <20150907185204.GB14598@pengutronix.de>
References: <1441638573-6701-1-git-send-email-l.stach@pengutronix.de>
 <1441638573-6701-2-git-send-email-l.stach@pengutronix.de>
 <20150907185204.GB14598@pengutronix.de>
Message-ID: <1441702302.13536.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Am Montag, den 07.09.2015, 20:52 +0200 schrieb Uwe Kleine-K?nig:
> Hello Lucas,
> 
> On Mon, Sep 07, 2015 at 05:09:26PM +0200, Lucas Stach wrote:
> > Both earlycon and earlyprintk depend on the bootloader setup UART
> > clocks being retained. This patch adds the common logic to detect such
> > situations and make the information available to the clock drivers, as
> > well as adding the facilities to disable those clocks at the end of
> > the kernel init.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/clk/imx/clk.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/imx/clk.h |  1 +
> >  2 files changed, 39 insertions(+)
> > 
> > diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> > index df12b5307175..45a073dab435 100644
> > --- a/drivers/clk/imx/clk.c
> > +++ b/drivers/clk/imx/clk.c
> > @@ -73,3 +73,41 @@ void imx_cscmr1_fixup(u32 *val)
> >  	*val ^= CSCMR1_FIXUP;
> >  	return;
> >  }
> > +
> > +static int imx_keep_uart_clocks __initdata;
> > +static struct clk ** const *imx_uart_clocks __initdata;
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
> > +void __init imx_register_uart_clocks(struct clk ** const clks[])
> > +{
> > +	if (imx_keep_uart_clocks) {
> > +		int i;
> > +
> > +		imx_uart_clocks = clks;
> > +		for (i = 0; imx_uart_clocks[i]; i++)
> > +			clk_prepare_enable(*imx_uart_clocks[i]);
> > +	}
> > +}
> > +
> > +static int __init imx_clk_disable_uart(void)
> > +{
> > +	if (imx_keep_uart_clocks) {
> > +		int i;
> > +
> > +		for (i = 0; imx_uart_clocks[i]; i++)
> > +			clk_disable_unprepare(*imx_uart_clocks[i]);
> > +	}
> > +
> > +	return 0;
> > +}
> > +late_initcall_sync(imx_clk_disable_uart);
> 
> I bet you didn't test if this works when earlyprintk (or earlycon) is
> provided on the command line but imx_register_uart_clocks isn't called
> (e.g. because this is a Samsung CPU running a multiarch kernel).
> 
Ah, damn! Thanks for spotting.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
