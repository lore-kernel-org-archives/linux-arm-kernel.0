From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 25 Aug 2014 19:21:52 +0800
Subject: [PATCH V3 3/3] ARM: clk-imx6q: Add missing lvds and anaclk clock
 to the clock tree
In-Reply-To: <20140825073957.GA7740@audiosh1>
References: <cover.1407481023.git.shengjiu.wang@freescale.com>
 <9ecf6480464cffb3b4347ad3fd8ec5f07462a0fc.1407481023.git.shengjiu.wang@freescale.com>
 <20140809135841.GB8849@dragon> <20140811030935.GB13158@audiosh1>
 <20140818060521.GA2114@dragon> <20140825073957.GA7740@audiosh1>
Message-ID: <20140825112151.GD6928@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 03:40:20PM +0800, Shengjiu Wang wrote:
> On Mon, Aug 18, 2014 at 02:06:07PM +0800, Shawn Guo wrote:
> > On Mon, Aug 11, 2014 at 11:09:36AM +0800, Shengjiu Wang wrote:
> > > On Sat, Aug 09, 2014 at 09:58:42PM +0800, Shawn Guo wrote:
> > > > On Fri, Aug 08, 2014 at 03:02:49PM +0800, Shengjiu Wang wrote:
> > > > > @@ -176,8 +182,12 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
> > > > >  	 * the "output_enable" bit as a gate, even though it's really just
> > > > >  	 * enabling clock output.
> > > > >  	 */
> > > > > -	clk[IMX6QDL_CLK_LVDS1_GATE] = imx_clk_gate("lvds1_gate", "lvds1_sel", base + 0x160, 10);
> > > > > -	clk[IMX6QDL_CLK_LVDS2_GATE] = imx_clk_gate("lvds2_gate", "lvds2_sel", base + 0x160, 11);
> > > > > +	clk[IMX6QDL_CLK_LVDS1_GATE] = imx_clk_gate2("lvds1_gate", "lvds1_sel", base + 0x160, 10);
> > > > > +	clk[IMX6QDL_CLK_LVDS2_GATE] = imx_clk_gate2("lvds2_gate", "lvds2_sel", base + 0x160, 11);
> > > > 
> > > > I do not think you can simply change to use imx_clk_gate2() here.  It's
> > > > designed for those CCGR gate clocks, each of which is controlled by two
> > > > bits.
> > > > 
> > > > Shawn
> > > >
> > > As Lucas Stach's suggestion, we need to do add some method for mutually exclusive clock, 
> > > lvds1_gate with lvds1_in, lvds2_gate with lvds2_in. I add imx_clk_gate2_exclusive() function in clk-gate2.c.
> > > So I change imx_clk_gate() to imx_clk_gate2() here.
> > > As you said, this is not good solution.
> > 
> > It's not just a "not good" solution but wrong and broken one.  The net
> > result of that is if you call clk_enable() on lvds1_gate, both bit 10
> > and 11 will be set.
> > 
> > > So I need your suggestion, how can I do?
> > 
> > I guess we will need a new clock type to handle such mutually exclusive
> > clocks, rather than patching clk-gate2.
> > 
> Could you please help to implement this feature?

Okay, I will give it a try soon.

> 
> Furthermore, I'd like to drop patch 2 and patch 3, wait the implementation from
> you.
> 
> Could you please review the patch 1?  do you have any comments?

Just applied #1.

Shawn
