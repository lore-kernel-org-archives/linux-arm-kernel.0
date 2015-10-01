From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Sep 2015 17:51:56 -0700
Subject: [PATCH v2 4/9] clk: rockchip: add new clock type and controller
 for rk3036
In-Reply-To: <4123121.bNYOPIrL2s@diego>
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
 <2850967.rjRj3AZerS@diego> <20150922231900.GL23081@codeaurora.org>
 <4123121.bNYOPIrL2s@diego>
Message-ID: <20151001005156.GA19319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01, Heiko St?bner wrote:
> Hi Stephen,
> 
> Am Dienstag, 22. September 2015, 16:19:00 schrieb Stephen Boyd:
> > On 09/23, Heiko St?bner wrote:
> > > Am Dienstag, 22. September 2015, 15:41:25 schrieb Stephen Boyd:
> > > > On 09/17, Xing Zheng wrote:
> > > > > +{
> > > > > +	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
> > > > > +	const struct rockchip_pll_rate_table *rate;
> > > > > +	unsigned int fbdiv, postdiv1, refdiv, postdiv2, dsmpd, frac;
> > > > > +	unsigned long drate;
> > > > > +	u32 pllcon;
> > > > > +
> > > > > +	if (!(pll->flags & ROCKCHIP_PLL_SYNC_RATE))
> > > > > +		return;
> > > > 
> > > > I don't understand what this one does though. This check isn't in
> > > > the set rate ops.
> > > 
> > > And it shouldn't be :-)
> > > 
> > > The issue this whole thing is trying to solve is aligning the pll settings
> > > which what we have in the rate table, not what the bootloader set.
> > > 
> > > For example the bootloader could set up a pll at 594MHz with one set of
> > > parameters and after some time - when you don't want to exchange
> > > bootloaders on shipping devices anymore - it comes to light that a
> > > different set of parameters for the same frequency produces for example a
> > > more stable hdmi signal [I think that was the main reason for the initial
> > > change].
> > > 
> > > So we're not changing the frequency x -> y, which could be easily done
> > > [and is done already] via assigned-rates, but instead
> > > 
> > > 	x {params a,b,c} -> x {params d,e,f}
> > > 
> > > so the rate itself stays the same, only the frequency generation is
> > > adapted.
> > Ok. It would be nice if this sort of information was made into a
> > comment and put in the code. Or at least the commit text for the
> > change.
> > 
> > And is there any reason that we need to get the parent clock and
> > parent rate to align the PLL settings?
> > It would be nice if we
> > avoided using clk_* APIs in here, by extracting the pll set rate
> > code into another function that we can call from init to make the
> > values the same without all the fallback to old rates, etc.
> 
> I guess you want Xing Zheng to change his pll code somewhat like the
> following, right? While starting off as proof-of-concept, that change
> below actually does work quite nicely on rk3288 boards.
> 
> ---------------- 8< --------------------
> From: Heiko Stuebner <heiko@sntech.de>
> Subject: [PATCH] clk: rockchip: don't use clk_ APIs in the pll init-callback
> 
> Separate the update of pll registers from the actual set_rate function
> so that the init callback does not need to access clk-API functions.
> 
> As we now have separated the getting and setting of the pll parameters
> we can also directly use these new functions in other places too.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Yep, it looks much better this way.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
