From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 30 Apr 2012 10:01:46 +0800
Subject: [PATCH 09/11] ARM: imx6q: add ssi1 clk_lookup
In-Reply-To: <20120427092529.GA20478@pengutronix.de>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-10-git-send-email-richard.zhao@freescale.com>
 <20120427080412.GW17184@pengutronix.de>
 <20120427091055.GP28063@b20223-02.ap.freescale.net>
 <20120427092529.GA20478@pengutronix.de>
Message-ID: <20120430020143.GA1857@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 11:25:29AM +0200, Sascha Hauer wrote:
> On Fri, Apr 27, 2012 at 05:10:56PM +0800, Richard Zhao wrote:
> > On Fri, Apr 27, 2012 at 10:04:12AM +0200, Sascha Hauer wrote:
> > > On Fri, Apr 27, 2012 at 03:03:03PM +0800, Richard Zhao wrote:
> > > > It's used by audio drivers.
> > > > 
> > > > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > > > ---
> > > >  arch/arm/mach-imx/clk-imx6q.c |    1 +
> > > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> > > > index f40a35d..9a03dcc 100644
> > > > --- a/arch/arm/mach-imx/clk-imx6q.c
> > > > +++ b/arch/arm/mach-imx/clk-imx6q.c
> > > > @@ -418,6 +418,7 @@ int __init mx6q_clocks_init(void)
> > > >  	clk_register_clkdev(clk[sdma], NULL, "20ec000.sdma");
> > > >  	clk_register_clkdev(clk[dummy], NULL, "20bc000.wdog");
> > > >  	clk_register_clkdev(clk[dummy], NULL, "20c0000.wdog");
> > > > +	clk_register_clkdev(clk[ssi1], NULL, "2028000.ssi");
> > > 
> > > The ssi clock needs a general cleanup on all i.MX just like I cleaned up
> > > the other units. The SSI unit has at least a register clock and a baud
> > > clock. What the driver requests and enables is the register clock.
> > > 
> > > The baud clock is currently unused and is needed only for master mode
> > > (which is not implemented in the ssi driver)
> > Are you sure for that? If I don't enable clk[ssi1], the ssi will not
> > work.
> > 
> > > 
> > > So where we want to come to is:
> > > 
> > > 	clk_register_clkdev(clk[ipg], "ipg", "2028000.ssi");
> > ssi don't have ipg gate. We can let it always on for imx6q.
> 
> Can you please ask your IC guys for clarification?
> 
> For example on i.MX5 we have a ssi ipg clock and a ssi serial clock.
> Both can be gated with two individual gate bits.
> 
> The i.MX6 datasheet (and also several other i.MX datasheets) is quite
> nebulous. The i.MX6 has only one gate bit for each SSI unit, but
> it's not clear if this bit actually gates both the ipg and serial
> clock or only one of them.
You're right. ipg and serial clocks share the same gate. How do we
handle it? I think it's not the only one and won't be last one.
> 
> My general idea is that each unit in the SoC has different input clocks.
> In the driver we need to clk_get() the input clocks. If a given SoC has
> no software control over some of the devices input clocks, then we need
> to provide a dummy for this, because other SoCs have control over the
> clock.
Great.

Thanks
Richard
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
