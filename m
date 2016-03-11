From: caesar.upstream@gmail.com (Caesar Wang)
Date: Fri, 11 Mar 2016 20:01:10 +0800
Subject: [PATCH 5/6] clk: rockchip: rk3036: fix and add node id for emac
 clock
In-Reply-To: <2005499.uduk6By3kM@diego>
References: <1457693731-6966-1-git-send-email-wxt@rock-chips.com>
 <1457693731-6966-6-git-send-email-wxt@rock-chips.com>
 <2005499.uduk6By3kM@diego>
Message-ID: <56E2B386.7060107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

The link [0] need a bit changes if we want the emac to be happy work.

-RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 4, 5, DFLAGS),

+RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 9, 5, DFLAGS),


I will need resend the series patches with your change in link[0], OK?

Since the Mr.rebot just notice the build error, I will check and resend 
with your emac changing.




? 2016?03?11? 19:15, Heiko St?bner ??:
> Hi Caesar,
>
> Am Freitag, 11. M?rz 2016, 18:55:30 schrieb Caesar Wang:
>> From: zhengxing <zhengxing@rock-chips.com>
>>
>> In the emac driver, we need to refer HCLK_MAC since there are
>> only 3PLLs (APLL/GPLL/DPLL) on the rk3036, most clocks are under the
>> GPLL, and it is unable to provide the accurate rate for mac_ref which
>> need to 50MHz probability, we should let it under the DPLL and are
>> able to set the freq which integer multiples of 50MHz, so we add these
>> emac node for reference.
>>
>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> I think I mentioned it somewhere before, but I'd like to do this
> differently, like in [0].
>
> That should work in a similar way and at least in my tests the reported
> clock rate seems to be correct. As I said as well I haven't been able to
> make the emac detect a link on my kylin boards, so it would be cool
> if you could test if this different approach works in practice as well.

I fetch your branch patches, it doesn't work for me.
c467a5f clk: rockchip: associate SCLK_MAC_PLL and disable reparenting on 
rk3036
ae7ed09 clk: rockchip: add clock-id for rk3036 emac pll source clock
f876a7e clk: rockchip: associate the rk3036 HCLK_EMAC clock-id
5093371 clk: rockchip: add node-id for rk3036 emac hclk

f44eeee Revert "clk: rockchip: rk3036: fix and add node id for emac clock"
..

It works if the patch
c467a5f clk: rockchip: associate SCLK_MAC_PLL and disable reparenting on 
rk3036 to change as following

--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -348,8 +348,8 @@ static struct rockchip_clk_branch 
rk3036_clk_branches[] __initdata = {
                         RK2928_CLKSEL_CON(16), 0, 2, MFLAGS, 2, 5, DFLAGS,
                         RK2928_CLKGATE_CON(10), 5, GFLAGS),

-       COMPOSITE_NOGATE(0, "mac_pll_src", mux_pll_src_3plls_p, 0,
-                       RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 9, 5, DFLAGS),
+       COMPOSITE_NOGATE(SCLK_MACPLL, "mac_pll_src", 
mux_pll_src_3plls_p, CLK_SET_RATE_NO_REPARENT,
+                       RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 9, 5, DFLAGS),


>
>
> Thanks
> Heiko
>
> ------ 8< ---------
>  From e83a8b19dbf95c40d2c908727c342fbc6b167ea1 Mon Sep 17 00:00:00 2001
> From: Heiko Stuebner <heiko@sntech.de>
> Date: Fri, 19 Feb 2016 21:31:43 +0100
> Subject: [PATCH] clk: rockchip: associate SCLK_MAC_PLL and disable reparenting
>   on rk3036
>
> The emac needs constant and very specific rate but the possible PLL-sources
> are very limited, so we expect the PLL source to be set manually on per
> board and don't want it to get changed in an automatic way later.
> So add the necessary clock-id and disable reparenting on set_rate calls.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/clk/rockchip/clk-rk3036.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
> index 3c742bf..0084c57 100644
> --- a/drivers/clk/rockchip/clk-rk3036.c
> +++ b/drivers/clk/rockchip/clk-rk3036.c
> @@ -348,7 +348,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
>   			RK2928_CLKSEL_CON(16), 0, 2, MFLAGS, 2, 5, DFLAGS,
>   			RK2928_CLKGATE_CON(10), 5, GFLAGS),
>   
> -	COMPOSITE_NOGATE(0, "mac_pll_src", mux_pll_src_3plls_p, 0,
> +	COMPOSITE_NOGATE(SCLK_MACPLL, "mac_pll_src", mux_pll_src_3plls_p, CLK_SET_RATE_NO_REPARENT,
>   			RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 4, 5, DFLAGS),

-RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 4, 5, DFLAGS),

+RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 9, 5, DFLAGS),



>   	MUX(SCLK_MACREF, "mac_clk_ref", mux_mac_p, CLK_SET_RATE_PARENT,
>   			RK2928_CLKSEL_CON(21), 3, 1, MFLAGS),
>
> ------ 8< ---------
>
>
> [0] https://github.com/mmind/linux-rockchip/commit/e83a8b19dbf95c40d2c908727c342fbc6b167ea1
>
>
>> ---
>>
>>   drivers/clk/rockchip/clk-rk3036.c      | 9 ++++++---
>>   include/dt-bindings/clock/rk3036-cru.h | 2 ++
>>   2 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3036.c
>> b/drivers/clk/rockchip/clk-rk3036.c index 0703c8f..27c35fa 100644
>> --- a/drivers/clk/rockchip/clk-rk3036.c
>> +++ b/drivers/clk/rockchip/clk-rk3036.c
>> @@ -348,8 +348,11 @@ static struct rockchip_clk_branch rk3036_clk_branches[]
>> __initdata = { RK2928_CLKSEL_CON(16), 0, 2, MFLAGS, 2, 5, DFLAGS,
>>   			RK2928_CLKGATE_CON(10), 5, GFLAGS),
>>
>> -	COMPOSITE_NOGATE(0, "mac_pll_src", mux_pll_src_3plls_p, 0,
>> -			RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 9, 5, DFLAGS),
>> +	MUX(SCLK_MACPLL, "mac_pll_pre", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(21), 0, 2, MFLAGS),
>> +	DIV(0, "mac_pll_src", "mac_pll_pre", 0,
>> +			RK2928_CLKSEL_CON(21), 9, 5, DFLAGS),
>> +
>>   	MUX(SCLK_MACREF, "mac_clk_ref", mux_mac_p, CLK_SET_RATE_PARENT,
>>   			RK2928_CLKSEL_CON(21), 3, 1, MFLAGS),
>>
>> @@ -408,7 +411,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[]
>> __initdata = { GATE(HCLK_OTG1, "hclk_otg1", "hclk_peri", CLK_IGNORE_UNUSED,
>> RK2928_CLKGATE_CON(7), 3, GFLAGS), GATE(HCLK_I2S, "hclk_i2s", "hclk_peri",
>> 0, RK2928_CLKGATE_CON(7), 2, GFLAGS), GATE(0, "hclk_sfc", "hclk_peri",
>> CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS), -	GATE(0,
>> "hclk_mac", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 15,
>> GFLAGS), +	GATE(HCLK_MAC, "hclk_mac", "hclk_peri", 0,
>> RK2928_CLKGATE_CON(3), 5, GFLAGS),
>>
>>   	/* pclk_peri gates */
>>   	GATE(0, "pclk_peri_matrix", "pclk_peri", CLK_IGNORE_UNUSED,
>> RK2928_CLKGATE_CON(4), 1, GFLAGS), diff --git
>> a/include/dt-bindings/clock/rk3036-cru.h
>> b/include/dt-bindings/clock/rk3036-cru.h index ebc7a7b..de44109 100644
>> --- a/include/dt-bindings/clock/rk3036-cru.h
>> +++ b/include/dt-bindings/clock/rk3036-cru.h
>> @@ -54,6 +54,7 @@
>>   #define SCLK_PVTM_VIDEO		125
>>   #define SCLK_MAC		151
>>   #define SCLK_MACREF		152
>> +#define SCLK_MACPLL		153
>>   #define SCLK_SFC		160
>>
>>   /* aclk gates */
>> @@ -92,6 +93,7 @@
>>   #define HCLK_SDMMC		456
>>   #define HCLK_SDIO		457
>>   #define HCLK_EMMC		459
>> +#define HCLK_MAC		460
>>   #define HCLK_I2S		462
>>   #define HCLK_LCDC		465
>>   #define HCLK_ROM		467
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
Thanks,
Caesar
