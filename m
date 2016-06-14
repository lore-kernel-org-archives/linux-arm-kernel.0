From: dianders@chromium.org (Doug Anderson)
Date: Tue, 14 Jun 2016 09:04:43 -0700
Subject: [PATCH] clk: rockchip: add flag CLK_SET_RATE_PARENT for
 dclk_vop0_div on RK3399
In-Reply-To: <2376423.L1zs1HaIGm@diego>
References: <1465724928-14611-1-git-send-email-zhengxing@rock-chips.com>
 <2376423.L1zs1HaIGm@diego>
Message-ID: <CAD=FV=Vk9Lb8DD7dWD7eW_xhMFFwh1o=XKx38wObTOmmi94CGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Mon, Jun 13, 2016 at 3:46 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Sonntag, 12. Juni 2016, 17:48:48 schrieb Xing Zheng:
>> The functions and features VOP0 more complete than VOP1's, we need to
>> use it dclk_vop0_div operate VPLLI, and let VOP0 as the default primary
>> screen.
>>
>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
>> ---
>>
>>  drivers/clk/rockchip/clk-rk3399.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3399.c
>> b/drivers/clk/rockchip/clk-rk3399.c index 7ecb12c3..6affa75 100644
>> --- a/drivers/clk/rockchip/clk-rk3399.c
>> +++ b/drivers/clk/rockchip/clk-rk3399.c
>> @@ -1157,7 +1157,7 @@ static struct rockchip_clk_branch
>> rk3399_clk_branches[] __initdata = { GATE(HCLK_VOP0_NOC, "hclk_vop0_noc",
>> "hclk_vop0_pre", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(28), 0, GFLAGS),
>>
>> -     COMPOSITE(DCLK_VOP0_DIV, "dclk_vop0_div", mux_pll_src_vpll_cpll_gpll_p, 0,
>> +     COMPOSITE(DCLK_VOP0_DIV, "dclk_vop0_div", mux_pll_src_vpll_cpll_gpll_p,
>> CLK_SET_RATE_PARENT, RK3399_CLKSEL_CON(49), 8, 2, MFLAGS, 0, 8, DFLAGS,
>>                       RK3399_CLKGATE_CON(10), 12, GFLAGS),
>
> The vpll is a possible source for multiple clocks (cci, aclk_vop0, dclk_vop0,
> clk_vop0_pwm, aclk_vop1, dclk_vop1, clk_vop1_pwm), so allowing one clock to
> hog the rate setting, might influence the other consumers of the vpll as well.

Ah, right.  I think this gets back to your series:

  8993791 [RFC,1/3] clk: fix inconsistent use of req_rate
  8993801 [RFC,2/3] clk: adjust clocks to their requested rate after
parent changes
  8993811 [RFC,3/3] clk: rockchip: make rk3399 vop dclks keep their
rate on parent rate changes

Did you ever have any more ideas about that?  I think the last thing
in that series was a comment from me on patch #2/3.  If we can't come
up with a general CCF solution for this problem, perhaps we need to
register for notifications for all the relevant clocks that might
change?

-Doug
