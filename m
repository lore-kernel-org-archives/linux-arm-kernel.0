From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Apr 2014 10:20:27 +0800
Subject: [PATCH 3/4] ARM: dts: imx6: use of_clk_get_by_name() to retrieve
 fixed-clock
In-Reply-To: <20140411084042.GF2334@dragon>
References: <1397203447-22965-1-git-send-email-shawn.guo@freescale.com>
 <1397203447-22965-4-git-send-email-shawn.guo@freescale.com>
 <20140411084042.GF2334@dragon>
Message-ID: <20140414022025.GA26807@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 04:40:44PM +0800, Shawn Guo wrote:
> On Fri, Apr 11, 2014 at 04:04:06PM +0800, Shawn Guo wrote:
> > With the dependencies of those fixed input clocks reflected in device
> > tree, we now can just call of_clk_get_by_name() to retrieve the clocks.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  arch/arm/mach-imx/clk-imx6q.c  | 6 +++---
> >  arch/arm/mach-imx/clk-imx6sl.c | 4 ++--
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> > index b0e7f9d..862c80e 100644
> > --- a/arch/arm/mach-imx/clk-imx6q.c
> > +++ b/arch/arm/mach-imx/clk-imx6q.c
> > @@ -148,9 +148,9 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
> >  	int ret;
> >  
> >  	clk[dummy] = imx_clk_fixed("dummy", 0);
> > -	clk[ckil] = imx_obtain_fixed_clock("ckil", 0);
> > -	clk[ckih] = imx_obtain_fixed_clock("ckih1", 0);
> > -	clk[osc] = imx_obtain_fixed_clock("osc", 0);
> > +	clk[ckil] = of_clk_get_by_name(ccm_node, "ckil");
> > +	clk[ckih] = of_clk_get_by_name(ccm_node, "ckih1");
> > +	clk[osc] = of_clk_get_by_name(ccm_node, "osc");
> 
> Damn.  The change will break existing DTB.  Will fix it in v2.

The code will need to be like:

	clk[ckil] = of_clk_get_by_name(ccm_node, "ckil");
	if (IS_ERR(clk[ckil]))
		clk[ckil] = imx_obtain_fixed_clock("ckil", 0);

I think the new clock driver will just need to call of_clk_get_by_name()
and stay away from imx_obtain_fixed_clock(), but it's unnecessary to
churn the existing clock drivers.  That said, I will only apply the
first patch and drop all others.

Shawn
