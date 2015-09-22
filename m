From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 23 Sep 2015 00:58:58 +0200
Subject: [PATCH v2 4/9] clk: rockchip: add new clock type and controller
 for rk3036
In-Reply-To: <20150922224125.GK23081@codeaurora.org>
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
 <1442478540-15068-5-git-send-email-zhengxing@rock-chips.com>
 <20150922224125.GK23081@codeaurora.org>
Message-ID: <2850967.rjRj3AZerS@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Am Dienstag, 22. September 2015, 15:41:25 schrieb Stephen Boyd:
> On 09/17, Xing Zheng wrote:
> > +
> > +static void rockchip_rk3036_pll_init(struct clk_hw *hw)
> 
> init ops are "discouraged". Could we do this through assigned
> rates instead?

really? According to Mike that was a valid use-case when we looked for an 
initial place for that on the rk3288 :-) .


> > +{
> > +	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
> > +	const struct rockchip_pll_rate_table *rate;
> > +	unsigned int fbdiv, postdiv1, refdiv, postdiv2, dsmpd, frac;
> > +	unsigned long drate;
> > +	u32 pllcon;
> > +
> > +	if (!(pll->flags & ROCKCHIP_PLL_SYNC_RATE))
> > +		return;
> 
> I don't understand what this one does though. This check isn't in
> the set rate ops.

And it shouldn't be :-)

The issue this whole thing is trying to solve is aligning the pll settings 
which what we have in the rate table, not what the bootloader set.

For example the bootloader could set up a pll at 594MHz with one set of 
parameters and after some time - when you don't want to exchange bootloaders 
on shipping devices anymore - it comes to light that a different set of 
parameters for the same frequency produces for example a more stable hdmi 
signal [I think that was the main reason for the initial change].

So we're not changing the frequency x -> y, which could be easily done [and is 
done already] via assigned-rates, but instead
	x {params a,b,c} -> x {params d,e,f}
so the rate itself stays the same, only the frequency generation is adapted.

As for the ROCKCHIP_PLL_SYNC_RATE param, we of course don't want to sync the 
ddr-pll for example for obvious hang-reasons.


Heiko
