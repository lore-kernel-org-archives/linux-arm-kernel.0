From: dianders@chromium.org (Doug Anderson)
Date: Tue, 21 Jun 2016 17:31:16 -0700
Subject: [PATCH] clk: rockchip: add flag CLK_SET_RATE_PARENT for
 dclk_vop0_div on RK3399
In-Reply-To: <2376423.L1zs1HaIGm@diego>
References: <1465724928-14611-1-git-send-email-zhengxing@rock-chips.com>
 <2376423.L1zs1HaIGm@diego>
Message-ID: <CAD=FV=V5UvQGtYQ26gZ+U7+TygEWuqRoHhiH8SiQSK7GcvkF5w@mail.gmail.com>
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

OK, so let's think this through.

1. If we want to be able to support a wide variety of devices plugged
into an external display connector, we need _some_ type of PLL that
can change dynamically when the system is up.  On rk3399 there are new
fractional clocks available (yay!) but only for low speed pixel clocks
(boo!).  On rk3288 even those weren't there.

2. There are no PLLs dedicated to be used only for the pixel clock.
No matter what PLL we choose to use we _might_ end up changing some
else's rate when we change the pixel clock since someone else could be
a child.

2a) If we are careful with our clock tree we actually _can_ totally
avoid changing people's rates.  On rk3288 there's nothing else in the
system that really _needs_ NPLL and on rk3388 nothing really _needs_
VPLL.

2b) We could also try to do something dynamic like you proposed in
<https://patchwork.kernel.org/patch/8993811>, but presumably if a
child of NPLL/VPLL is really flexible about its rate (and thus could
handle this new rate), we'd be better off just starting that child off
parented somewhere else.  This relies on the fact that nothing really
_needs_ NPLL/VPLL.  Note that in rk3399, all muxings that include vpll
also include at least cpll and gpll; in rk3288 all muxings that
include npll also include at least cpll and gpll

2c) So, this means that if we are on a system that needs to support a
wide range of pixels clocks, we should ahead of time reparent everyone
else on another PLL and leave NPLL/VPLL as dynamic.

---

Let's think about use cases.  As far as I can think of, we have these.
Note that I'll call VPLL (rk3399) / NPLL (rk3288) the "dynamic" PLL.


A) There is some other important non-pixel-clock use of the "dynamic"
PLL where it's sub-optimal (or impossible) to use another PLL.

B) No important non-pixel-clock use for the "dynamic PLL".  Support
for arbitrary pixel clocks not important at all.

C) No important non-pixel-clock use for the "dynamic PLL".  Support
for arbitrary pixel clocks important for one display, not for the
other.

D) No important non-pixel-clock use for the "dynamic PLL".  Support
for arbitrary pixel clocks important for two displays.


I don't know of anyone in use case A), but if you do then please yell.

For B) we might have other things currently parented from the
"dynamic" PLL, but presumably these clocks are either not used or
could be reparented elsewhere.

Case C) is a device with a builtin display where the builtin display
can run fine on a pixel clock derived from CPLL or GPLL.  We might
need something like
<https://chromium-review.googlesource.com/#/c/354165/2>

Case D) is a device with two external connectors which might be used
at the same time.  You either need to pick one connector to get the
dynamic pixel clock (at boot? first come first served? userspace?) or
somehow rejigger your PLLs to allow two PLLs to be dynamic (don't
laugh, potentially GPLL could run at 1188 MHz and then you could
divide by 3 and get roughly 396 MHz, so you could actually just parent
everything on GPLL and make CPLL a second dynamic PLL).

---

OK, so what do we do?  Personally I can't see us coming up with a
one-size fits all approach, can you?  That means some type of
configuration.  ...and, as seen by the assigned-clocks device tree
binding, _some_ types of configuration is allowed in the device tree
presuming it is well thought out and describing how the designers of
the hardware "intended" it to be used.

So maybe:

i) Unless there's a counter example, I see no reason to let any clocks
other than the VOP display clocks parent on the "dynamic" PLL.  If we
later find a counter example then presumably we should add a device
tree property on that board.  We could have code at boot time that
goes through all clocks parented on "dynamic" PLL and reparents them
(trying to keep the rate?), they disallows future muxing to the
"dynamic" PLL.

ii) It seems sane to me to add a device tree property to the board
that will effectively enable CLK_SET_RATE_PARENT on one of the
dclk_vop clocks and forcing it to the "dynamic" PLL (no
auto-remuxing).  Maybe we would add something to the HDMI node, for
instance, like "rockchip,intended-dclk-pll = <&...>".  Then somehow
this would need to affect whichever VOP was assigned to HDMI.

iii) If later someone can propose how to handle D) above, we can
handle it then.  Until a solution is proposed those boards would work
like today.

---

OK, what was long.  Thoughts?


-Doug
