From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 9 Jan 2014 11:58:12 +0800
Subject: [PATCH] ARM: imx6q: Add missing esai_ahb clock to current clock
 tree
In-Reply-To: <1389236699-10387-1-git-send-email-Guangyu.Chen@freescale.com>
References: <1389236699-10387-1-git-send-email-Guangyu.Chen@freescale.com>
Message-ID: <20140109035810.GB21717@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 11:04:59AM +0800, Nicolin Chen wrote:
> esai_ahb clock is derived from ahb and used to provide ESAI the capability of
> register accessing and FSYS clock source for I2S clocks dividing. Although the
> gate of this esai_ahb is duplicated with esai clock -- the baud clock, yet
> considering about the differences of their clock rates, it's quite essential
> to patch this missing clock.
> 
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> ---
>  Documentation/devicetree/bindings/clock/imx6q-clock.txt | 1 +
>  arch/arm/mach-imx/clk-imx6q.c                           | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> index 6aab72b..90ec91f 100644
> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> @@ -220,6 +220,7 @@ clocks and IDs.
>  	lvds2_sel		205
>  	lvds1_gate		206
>  	lvds2_gate		207
> +	esai_ahb		208
>  
>  Examples:
>  
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index af2e582..20215b9 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -107,7 +107,7 @@ enum mx6q_clks {
>  	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate,
>  	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div, eim_slow,
>  	spdif, cko2_sel, cko2_podf, cko2, cko, vdoa, pll4_audio_div,
> -	lvds1_sel, lvds2_sel, lvds1_gate, lvds2_gate, clk_max
> +	lvds1_sel, lvds2_sel, lvds1_gate, lvds2_gate, esai_ahb, clk_max
>  };
>  
>  static struct clk *clk[clk_max];
> @@ -355,6 +355,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  	clk[ecspi5]       = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
>  	clk[enet]         = imx_clk_gate2("enet",          "ipg",               base + 0x6c, 10);
>  	clk[esai]         = imx_clk_gate2("esai",          "esai_podf",         base + 0x6c, 16);
> +	clk[esai_ahb]     = imx_clk_gate2("esai_ahb",      "ahb",               base + 0x6c, 16);

Hmm, having two clocks operating on the same gate bit will get us
problem in clock disabling.  Clock enabling is fine, since either
one who calls clk_enable() first will just set the gate bit.  But in
case that clk_enable() is called on both clocks, and then when either
clock calls clk_disable(), the gate bit will be cleared and thus breaks
the other one that might still be in use.

Shawn

>  	clk[gpt_ipg]      = imx_clk_gate2("gpt_ipg",       "ipg",               base + 0x6c, 20);
>  	clk[gpt_ipg_per]  = imx_clk_gate2("gpt_ipg_per",   "ipg_per",           base + 0x6c, 22);
>  	if (cpu_is_imx6dl())
> -- 
> 1.8.4
> 
> 
