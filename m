From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 15 Jul 2013 09:47:18 +0800
Subject: [PATCH 1/1] ARM: imx: clk-pllv3: move the timeout just before
 the comparison
In-Reply-To: <20130714183347.GJ12139@pengutronix.de>
References: <1373763528-20792-1-git-send-email-peter.chen@freescale.com>
 <20130714183347.GJ12139@pengutronix.de>
Message-ID: <20130715014717.GA23444@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 14, 2013 at 08:33:47PM +0200, Uwe Kleine-K?nig wrote:
> On Sun, Jul 14, 2013 at 08:58:48AM +0800, Peter Chen wrote:
> > It can let the timeout value be more precise.
> > 
> > Suggested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Whoever applies this patch, can you make the ? an ? (or at least "oe")?

Oh, sorry.

> 
> Peter, does this fix anything for you? Would be nice to mention that in
> the commit log.

The root cause of this PLL lock timeout problem is:

http://marc.info/?l=linux-arm-kernel&m=137109340222931&w=2

If causes the jiffies is not precise sometimes. This commit is just an
improvement.

> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  arch/arm/mach-imx/clk-pllv3.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
> > index a9fad5f..e2c026f 100644
> > --- a/arch/arm/mach-imx/clk-pllv3.c
> > +++ b/arch/arm/mach-imx/clk-pllv3.c
> > @@ -48,7 +48,7 @@ struct clk_pllv3 {
> >  static int clk_pllv3_prepare(struct clk_hw *hw)
> >  {
> >  	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> > -	unsigned long timeout = jiffies + msecs_to_jiffies(10);
> > +	unsigned long timeout;
> >  	u32 val;
> >  
> >  	val = readl_relaxed(pll->base);
> > @@ -59,6 +59,7 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
> >  		val &= ~BM_PLL_POWER;
> >  	writel_relaxed(val, pll->base);
> >  
> > +	timeout = jiffies + msecs_to_jiffies(10);
> >  	/* Wait for PLL to lock */
> >  	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK))
> >  		if (time_after(jiffies, timeout))
> > -- 
> > 1.7.0.4
> > 
> > 
> > 
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 

-- 

Best Regards,
Peter Chen
