From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 22 Dec 2011 18:23:53 +0200
Subject: [PATCH 2/2] OMAP4: mcbsp: Clock reparenting support
In-Reply-To: <alpine.DEB.2.00.1112161730080.12660@utopia.booyaka.com>
References: <1323941859-7946-1-git-send-email-peter.ujfalusi@ti.com>
 <1323941859-7946-3-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.00.1112161730080.12660@utopia.booyaka.com>
Message-ID: <4EF35999.5040607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 12/17/2011 02:37 AM, Paul Walmsley wrote:
> What do you think about using clkdev alias lines and hwmod optional clks 
> for this instead?  With these mechanisms, you can give clocks a consistent 
> "role name" for a given device, even if the underlying clock changes on 
> different platforms.

I need to look into the clock framework, but sounds promising.
I can see quite big difference between the clock3xxx_data, and
clock44xx_data regarding to McBSPs.
Need to understand why, and what need to be changed to achieve what I want.

> So in the mach-omap2/clock*_data.c files, you'd do something like
> 
> 	CLK("omap-mcbsp.1",	"pad_fck",	&mcbsp_clks,  CK_3XXX),
> 
> for OMAP3, and 
> 
> 	CLK("omap-mcbsp.1",	"pad_fck",	&pad_clks_clk,  CK_44XX),
> 
> for OMAP4.
> 
> Then in the hwmod data files, you'd add them as optional clocks - 
> something like:
> 
> static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] = {
> 	{ .role = "pad_fck", .clk = "mcbsp_clks" },
> };
> 
> for OMAP3, and
> 
> static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] = {
> 	{ .role = "pad_fck", .clk = "pad_clks_clk" },
> };
> 
> for OMAP4.
> 
> I think this might work for your needs?

Is it OK if I do this as an incremental patch as soon as I figured out
the way to do it nicely?

Thank you,
P?ter
