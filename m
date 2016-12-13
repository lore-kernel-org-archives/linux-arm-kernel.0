From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 13 Dec 2016 15:28:35 -0800
Subject: [PATCH 03/11] driver: clk: imx: Add clock driver for imx6sll
In-Reply-To: <AM3PR04MB5302BE33BE1F2C9913FF61587980@AM3PR04MB530.eurprd04.prod.outlook.com>
References: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
 <1480660774-25055-4-git-send-email-ping.bai@nxp.com>
 <20161208225257.GP5423@codeaurora.org>
 <AM3PR04MB5302BE33BE1F2C9913FF61587980@AM3PR04MB530.eurprd04.prod.outlook.com>
Message-ID: <20161213232835.GR5423@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12, Jacky Bai wrote:
> > On 12/02, Bai Ping wrote:
> > > diff --git a/drivers/clk/imx/clk-imx6sll.c
> > > b/drivers/clk/imx/clk-imx6sll.c new file mode 100644 index
> > > 0000000..c5219e1
> > > --- /dev/null
> > > +++ b/drivers/clk/imx/clk-imx6sll.c
> > > +0x20, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels),
> > > +CLK_SET_RATE_PARENT);
> > > +
> > > +	/* Do not bypass PLLs initially */
> > > +	clk_set_parent(clks[IMX6SLL_PLL1_BYPASS], clks[IMX6SLL_CLK_PLL1]);
> > > +	clk_set_parent(clks[IMX6SLL_PLL2_BYPASS], clks[IMX6SLL_CLK_PLL2]);
> > > +	clk_set_parent(clks[IMX6SLL_PLL3_BYPASS], clks[IMX6SLL_CLK_PLL3]);
> > > +	clk_set_parent(clks[IMX6SLL_PLL4_BYPASS], clks[IMX6SLL_CLK_PLL4]);
> > > +	clk_set_parent(clks[IMX6SLL_PLL5_BYPASS], clks[IMX6SLL_CLK_PLL5]);
> > > +	clk_set_parent(clks[IMX6SLL_PLL6_BYPASS], clks[IMX6SLL_CLK_PLL6]);
> > > +	clk_set_parent(clks[IMX6SLL_PLL7_BYPASS], clks[IMX6SLL_CLK_PLL7]);
> > 
> > Can we just put raw register writes here instead? I'd prefer we didn't use clk
> > consumer APIs to do things to the clk tree from the providers. The problem
> > there being that:
> > 
> >  1) We're trying to move away from using consumer APIs in  provider drivers.
> > It's ok if they're used during probe, but  inside clk_ops is not preferred.
> > 
> >  2) Even if you have a clk pointer, it may be "orphaned" at the  time of
> > registration and so calling the APIs here works now but  eventually we may
> > want to return an EPROBE_DEFER error in that  case and this may block that
> > effort.
> > 
> > I suppose if this is the only clk driver on this machine then this last point isn't a
> > concern and things are probably ok here.
> > 
> 
> Using raw register writing has an issue.  The register is modified, but it seems the clock 'parent-child' relationship can 
> not match the register setting. The register setting is not bypass the pll, but in debug 'clk_summary', the
> pll is bypassed.  

So program the register settings before registering the clocks
with the framework?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
