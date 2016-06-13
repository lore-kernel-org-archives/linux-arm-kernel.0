From: briannorris@chromium.org (Brian Norris)
Date: Mon, 13 Jun 2016 11:37:49 -0700
Subject: [PATCH] clk: rockchip: add flag CLK_SET_RATE_PARENT for
 dclk_vop0_div on RK3399
In-Reply-To: <575D3D9B.1070501@rock-chips.com>
References: <1465724928-14611-1-git-send-email-zhengxing@rock-chips.com>
 <575D3D9B.1070501@rock-chips.com>
Message-ID: <20160613183748.GA21936@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jun 12, 2016 at 06:46:51PM +0800, Yakir Yang wrote:
> On 06/12/2016 05:48 PM, Xing Zheng wrote:
> >The functions and features VOP0 more complete than VOP1's, we need to
> >use it dclk_vop0_div operate VPLLI, and let VOP0 as the default primary
> >screen.

Personally, I'd like a little better description that talks about the
rates, not just the differences between VOP0 and VOP1. Presumably the
clock rates needed by VOP0 are not achievable just by these dividers, so
we need to adjust the PLL?

FWIW, I haven't actually found this patch necessary in my own testing (I
have eDP running fine without this change), but perhaps with better
justification, this will make more sense.

> >Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> 
> Tested on RK3399 Kevin board, after apply this patch, my eDP panel
> light up normally. So
> 
> Tested-by: Yakir Yang <ykk@rock-chips.com>

For clarification: this patch isn't sufficient for that, right? Of
course eDP support hasn't fully landed upstream yet, but I presume you
have other changes to set the correct VOP frequencies?

Brian

> BR,
> - Yakir
> 
> >---
> >
> >  drivers/clk/rockchip/clk-rk3399.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> >index 7ecb12c3..6affa75 100644
> >--- a/drivers/clk/rockchip/clk-rk3399.c
> >+++ b/drivers/clk/rockchip/clk-rk3399.c
> >@@ -1157,7 +1157,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
> >  	GATE(HCLK_VOP0_NOC, "hclk_vop0_noc", "hclk_vop0_pre", CLK_IGNORE_UNUSED,
> >  			RK3399_CLKGATE_CON(28), 0, GFLAGS),
> >-	COMPOSITE(DCLK_VOP0_DIV, "dclk_vop0_div", mux_pll_src_vpll_cpll_gpll_p, 0,
> >+	COMPOSITE(DCLK_VOP0_DIV, "dclk_vop0_div", mux_pll_src_vpll_cpll_gpll_p, CLK_SET_RATE_PARENT,
> >  			RK3399_CLKSEL_CON(49), 8, 2, MFLAGS, 0, 8, DFLAGS,
> >  			RK3399_CLKGATE_CON(10), 12, GFLAGS),
> 
> 
