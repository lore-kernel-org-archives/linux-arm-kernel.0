From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 16:24:33 +0800
Subject: [PATCH 1/1] serial: imx: convert to clk_prepare/clk_unprepare
In-Reply-To: <20111110080641.GT16886@pengutronix.de>
References: <1320901158-13103-1-git-send-email-richard.zhao@linaro.org>
 <20111110080641.GT16886@pengutronix.de>
Message-ID: <20111110082432.GA14617@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 09:06:41AM +0100, Sascha Hauer wrote:
> On Thu, Nov 10, 2011 at 12:59:18PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  drivers/tty/serial/imx.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 163fc90..22fd9c8 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1390,6 +1390,7 @@ static int serial_imx_probe(struct platform_device *pdev)
> >  		ret = PTR_ERR(sport->clk);
> >  		goto unmap;
> >  	}
> > +	clk_prepare(sport->clk);
> >  	clk_enable(sport->clk);
> >  
> >  	sport->port.uartclk = clk_get_rate(sport->clk);
> > @@ -1415,6 +1416,7 @@ deinit:
> >  clkput:
> >  	clk_put(sport->clk);
> >  	clk_disable(sport->clk);
> > +	clk_unprepare(sport->clk);
> 
> Ouch, clk_put before clk_disable? This is is bug. Care to fix it?
hmm.. I'll fix the two bugs in my next version patch.
> 
> >  unmap:
> >  	iounmap(sport->port.membase);
> >  free:
> > @@ -1438,6 +1440,7 @@ static int serial_imx_remove(struct platform_device *pdev)
> >  	}
> >  
> >  	clk_disable(sport->clk);
> > +	clk_unprepare(sport->clk);
> >  
> 
> Here clk_put is missing, another bug.
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
