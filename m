From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 28 Dec 2015 13:41:14 +0100
Subject: [RESEND PATCH v1 4/4] clk: rockchip: rk3036: fix and add node id
 for emac clock
In-Reply-To: <1451293433-32392-5-git-send-email-zhengxing@rock-chips.com>
References: <1451293433-32392-1-git-send-email-zhengxing@rock-chips.com>
 <1451293433-32392-5-git-send-email-zhengxing@rock-chips.com>
Message-ID: <11997168.T384RkEsFx@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Montag, 28. Dezember 2015, 17:03:53 schrieb Xing Zheng:
> Due to referred old version TRM, there is incorrect emac clock node,
> we should fix it. The SEL_21_9 is the parent of SEL_21_4.
> 
> In the emac driver, we need to refer HCLK_MAC, and  because There are
> only 3PLLs (APLL/GPLL/DPLL) on the rk3036, most clock are under the
> GPLL, and it is unable to provide the accurate rate for mac_ref which
> need to 50MHz probability, we should let it under the APLL and are
> able to set the freq which integer multiples of 50MHz, so we add these
> emac node for reference.

I don't really follow here. While I do understand that the emac needs 50MHz, I 
don't think using the APLL as source is helpful.

The APLL is the main clocksource for the cpu-cores, including frequency 
scaling, and while it currently only lists 816MHz as sole frequency, you're 
pretty much guaranteed to not get your correct multiple of 50MHz from there 
either. And limiting the cpu to just do 600MHz to get the mac working sounds 
pretty bad ;-) .


In the rk3036 cru-node the gpll gets set to 594MHz. Is there a special reason 
why it needs to be 594MHz and cannot be a round 600MHz? Because that would 
also provide your 50MHz-multiple nicely.

> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
>  drivers/clk/rockchip/clk-rk3036.c      |   11 ++++++-----
>  include/dt-bindings/clock/rk3036-cru.h |    2 ++
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3036.c
> b/drivers/clk/rockchip/clk-rk3036.c index 7420cbe..7863c4d 100644
> --- a/drivers/clk/rockchip/clk-rk3036.c
> +++ b/drivers/clk/rockchip/clk-rk3036.c
> @@ -328,13 +328,14 @@ static struct rockchip_clk_branch
> rk3036_clk_branches[] __initdata = { RK2928_CLKSEL_CON(16), 0, 2, MFLAGS,
> 2, 5, DFLAGS,
>  			RK2928_CLKGATE_CON(10), 5, GFLAGS),
> 
> -	COMPOSITE_NOGATE(0, "mac_pll_src", mux_pll_src_3plls_p, 0,
> -			RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 4, 5, DFLAGS),
> +	MUX(SCLK_MACPLL, "mac_pll_pre", mux_pll_src_3plls_p, 0,
> +			RK2928_CLKSEL_CON(21), 0, 2, MFLAGS),
> +	DIV(0, "mac_pll_src", "mac_pll_pre", 0,
> +			RK2928_CLKSEL_CON(21), 9, 5, DFLAGS),
>  	MUX(SCLK_MACREF, "mac_clk_ref", mux_mac_p, CLK_SET_RATE_PARENT,
>  			RK2928_CLKSEL_CON(21), 3, 1, MFLAGS),
> -
>  	COMPOSITE_NOMUX(SCLK_MAC, "mac_clk", "mac_clk_ref", 0,
> -			RK2928_CLKSEL_CON(21), 9, 5, DFLAGS,
> +			RK2928_CLKSEL_CON(21), 4, 5, DFLAGS,
>  			RK2928_CLKGATE_CON(2), 6, GFLAGS),
> 
>  	MUX(SCLK_HDMI, "dclk_hdmi", mux_dclk_p, 0,
> @@ -389,7 +390,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[]
> __initdata = { GATE(HCLK_OTG1, "hclk_otg1", "hclk_peri", CLK_IGNORE_UNUSED,
> RK2928_CLKGATE_CON(7), 3, GFLAGS), GATE(HCLK_I2S, "hclk_i2s", "hclk_peri",
> 0, RK2928_CLKGATE_CON(7), 2, GFLAGS), GATE(0, "hclk_sfc", "hclk_peri",
> CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS), -	GATE(0,
> "hclk_mac", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 15,
> GFLAGS), +	GATE(HCLK_MAC, "hclk_mac", "hclk_peri", 0,
> RK2928_CLKGATE_CON(3), 5, GFLAGS),
> 
>  	/* pclk_peri gates */
>  	GATE(0, "pclk_peri_matrix", "pclk_peri", CLK_IGNORE_UNUSED,
> RK2928_CLKGATE_CON(4), 1, GFLAGS), diff --git
> a/include/dt-bindings/clock/rk3036-cru.h
> b/include/dt-bindings/clock/rk3036-cru.h index ebc7a7b..de44109 100644
> --- a/include/dt-bindings/clock/rk3036-cru.h
> +++ b/include/dt-bindings/clock/rk3036-cru.h
> @@ -54,6 +54,7 @@
>  #define SCLK_PVTM_VIDEO		125
>  #define SCLK_MAC		151
>  #define SCLK_MACREF		152
> +#define SCLK_MACPLL		153
>  #define SCLK_SFC		160
> 
>  /* aclk gates */
> @@ -92,6 +93,7 @@

please separate the hclk addition into two separate patches:
patch1: add the clock-id to the dt-binding header
patch2: use the clock in the clock-driver

>  #define HCLK_SDMMC		456
>  #define HCLK_SDIO		457
>  #define HCLK_EMMC		459
> +#define HCLK_MAC		460
>  #define HCLK_I2S		462
>  #define HCLK_LCDC		465
>  #define HCLK_ROM		467


Thanks
Heiko
