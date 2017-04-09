From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 9 Apr 2017 09:05:32 +0800
Subject: [linux-sunxi] [PATCH 2/5] clk: sunxi-ng: allow set parent clock
 (PLL_CPUX) for CPUX clock on H3
In-Reply-To: <20170408185025.53841-3-icenowy@aosc.io>
References: <20170408185025.53841-1-icenowy@aosc.io>
 <20170408185025.53841-3-icenowy@aosc.io>
Message-ID: <CAGb2v67qxuFhN_oB4YqSTa04pb7T-7CQcmOrSUoTGTKMjW9CPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Apr 9, 2017 at 2:50 AM, Icenowy Zheng <icenowy@aosc.io> wrote:

The subject can just say "set CLK_SET_RATE_PARENT for CPUX clock on H3".

> The CPUX clock, which is the main clock of the ARM core on Allwinner H3,
> can be adjusted by changing the frequency of the PLL_CPUX clock.
>
> Allowing setting parent clock for the CPUX clock, thus the PLL_CPUX
> clock can be adjusted when adjusting the CPUX clock.
>

This paragraph needs some work, particularly the verbs you chose. In the
clk subsystem "setting parent clock" actually refers to re-parenting.

>From include/linux/clk-provider.h:

#define CLK_SET_RATE_PARENT     BIT(2) /* propagate rate change up one level */

So what you want to say is to propagate rate changes to CPUX up one
level, so PLL_CPUX gets changed as well.

The precise wording could be something like:

    The CPUX clock is the clock source for the ARM cores on the H3 SoC.
    It is a mux clock fed by, amongst other fixed clock sources, the
    configurable PLL_CPUX.

    Set CLK_SET_RATE_PARENT on the CPUX clock, so rate changes to it
    are propagated up one level to the PLL_CPUX clock.

ChenYu

> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> index 4cbc1b701b7c..90b4e26a70bc 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> @@ -135,7 +135,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk, "pll-de",
>  static const char * const cpux_parents[] = { "osc32k", "osc24M",
>                                              "pll-cpux" , "pll-cpux" };
>  static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
> -                    0x050, 16, 2, CLK_IS_CRITICAL);
> +                    0x050, 16, 2, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT);
>
>  static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x050, 0, 2, 0);
>
> --
> 2.12.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
