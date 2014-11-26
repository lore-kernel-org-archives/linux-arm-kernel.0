From: dianders@chromium.org (Doug Anderson)
Date: Wed, 26 Nov 2014 15:05:53 -0800
Subject: [PATCH] clk: rockchip: rk3288 export i2s0_clkout for use in DT
In-Reply-To: <13759993.X1UzQR0utx@diego>
References: <1416381319-31117-1-git-send-email-sonnyrao@chromium.org>
 <13759993.X1UzQR0utx@diego>
Message-ID: <CAD=FV=W_t813jFgPgkxq7g3Bn5+MHj_t-G7=OP4xFmDnaMjF7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, Nov 26, 2014 at 10:09 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Sonny,
>
> Am Dienstag, 18. November 2014, 23:15:19 schrieb Sonny Rao:
>> This exposes the clock that comes out of the i2s block which generally
>> goes to the audio codec.
>>
>> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>> ---
>>  drivers/clk/rockchip/clk-rk3288.c      | 3 ++-
>>  include/dt-bindings/clock/rk3288-cru.h | 1 +
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3288.c
>> b/drivers/clk/rockchip/clk-rk3288.c index 2327829..8777737 100644
>> --- a/drivers/clk/rockchip/clk-rk3288.c
>> +++ b/drivers/clk/rockchip/clk-rk3288.c
>> @@ -305,7 +305,8 @@ static struct rockchip_clk_branch rk3288_clk_branches[]
>> __initdata = { RK3288_CLKGATE_CON(4), 2, GFLAGS),
>>       MUX(0, "i2s_pre", mux_i2s_pre_p, CLK_SET_RATE_PARENT,
>>                       RK3288_CLKSEL_CON(4), 8, 2, MFLAGS),
>> -     COMPOSITE_NODIV(0, "i2s0_clkout", mux_i2s_clkout_p, CLK_SET_RATE_PARENT,
>> +     COMPOSITE_NODIV(SCLK_I2S0_OUT, "i2s0_clkout", mux_i2s_clkout_p,
>> +                     CLK_SET_RATE_PARENT,
>
> this patch fails to apply, as the current i2s_clkout definition does not have
> the CLK_SET_RATE_PARENT yet. I'm not sure if I missed a patch somewhere but my
> search in my inbox for _not yet handled_ patches has come up empty so far.

I don't think it has been sent.


> But having CLK_SET_RATE_PARENT there will probably cause problems anyway.
> i2s0_clkout is sourced by either i2s_pre or xin12m. i2s_pre also is the source
> for the core SCLK_I2S0 going to the i2s controller. So having both SCLK_I2S0
> and (the new) SCLK_I2S0_OUT fiddling with the i2s_pre rate calls for trouble.
>
> So I think the i2s0_clkout should limit itself to selecting the best frequency
> from its sources without changing i2s_pre.

Probably this is my fault.  At some point I had the thought process
that this might be a nice way to make it so that we didn't need to add
special handling to the i2s driver.  AKA, we wouldn't need
<https://patchwork.kernel.org/patch/5334971/>.

See my comments on
<https://chromium-review.googlesource.com/#/c/230347/3>.  For those
that don't want to follow links, that would be:

> An alternative that might require no code changes to the i2s driver (untested!):
>
> clock-names = "i2s_hclk", "i2s_clk";
> clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0_CLKOUT>;
> assigned-clocks = <&cru SCLK_I2S0>, <&cru SCLK_I2S0_OUT>;
> assigned-clock-parents = <&cru SCLK_I2S0>;
>
> Then you'd add CLK_SET_RATE_PARENT to SCLK_I2S0_CLKOUT.
> You might need to disable the auto-remuxing on SCLK_I2S0_CLKOUT too.
>
> Basically the idea is to pass the child in as the main clock and the parent will
> get set implicitly.
>
> I have no idea if that's better or worse than what you have here...

I'm no longer convinced that's a good idea, so we should just axe the
CLK_SET_RATE_PARENT.


If timing is working out well and Sonny isn't available to spin this
right now (it's Thanksgiving holidays here in the US), I doubt he
would mind if you fixed up the patch and submitted it.


-Doug
