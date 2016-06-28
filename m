From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 28 Jun 2016 17:17:05 +0200
Subject: [PATCH 1/2] clk: clk-rk3*: set CLK_IS_CRITICAL flag to critical
 clocks
In-Reply-To: <1467125137-25999-2-git-send-email-andi@etezian.org>
References: <1467125137-25999-1-git-send-email-andi@etezian.org>
 <1467125137-25999-2-git-send-email-andi@etezian.org>
Message-ID: <29356205.Gk5k6xKH6K@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andi,

Am Dienstag, 28. Juni 2016, 17:45:36 schrieb andi.shyti at gmail.com:
> From: Andi Shyti <andi@etezian.org>
> 
> Patch 32b9b1096 has introduced a generalized concept of critical
> clock. Clocks are marked with the CLK_IS_CRITICAL, enabled during
> boot and never gated.
> 
> Use the CLK_IS_CRITICAL instead of declaring a local array of
> critical clock enabled during boot.
> 
> CC: Heiko Stuebner <heiko@sntech.de>
> CC: Jeffy Chen <jeffy.chen@rock-chips.com>
> CC: Xing Zheng <zhengxing@rock-chips.com>
> Signed-off-by: Andi Shyti <andi@etezian.org>
> ---
>  drivers/clk/rockchip/clk-rk3036.c |  18 ++-----
>  drivers/clk/rockchip/clk-rk3188.c |  25 +++-------
>  drivers/clk/rockchip/clk-rk3228.c |  17 ++-----
>  drivers/clk/rockchip/clk-rk3288.c |  21 +++-----
>  drivers/clk/rockchip/clk-rk3368.c |  22 ++-------
>  drivers/clk/rockchip/clk-rk3399.c | 101
> ++++++++++++++++---------------------- 6 files changed, 69 insertions(+),
> 135 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3036.c
> b/drivers/clk/rockchip/clk-rk3036.c index 924f560..5734f8c 100644
> --- a/drivers/clk/rockchip/clk-rk3036.c
> +++ b/drivers/clk/rockchip/clk-rk3036.c
> @@ -205,7 +205,8 @@ static struct rockchip_clk_branch
> rk3036_clk_branches[] __initdata = { GATE(0, "gpll_cpu", "gpll", 0,
> RK2928_CLKGATE_CON(0), 1, GFLAGS), COMPOSITE_NOGATE(0, "aclk_cpu_src",
> mux_busclk_p, 0,
>  			RK2928_CLKSEL_CON(0), 14, 2, MFLAGS, 8, 5, DFLAGS),
> -	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src", CLK_IGNORE_UNUSED,
> +	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src",
> +			CLK_IS_CRITICAL | CLK_IGNORE_UNUSED,

- you'll never need both critical and ignore_unused
- please keep the lines intact and do not introduce new line-breaks ... as 
it makes reading the clock-tree way easier if the blocks share the same 
format

Happens in some more cases below, but otherwise looks ok ... as written in 
the cover-letter I'm just still trying to make up my mind if it's worth 
waiting for the handoff mechanism.


Heiko
