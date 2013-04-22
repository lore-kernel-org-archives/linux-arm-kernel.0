From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 22 Apr 2013 19:25:35 +0800
Subject: [PATCH] ARM i.MX6: correct MLB clock configuration
In-Reply-To: <1366610434-23042-1-git-send-email-dirk.behme@de.bosch.com>
References: <1366610434-23042-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20130422112534.GH10647@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 08:00:34AM +0200, Dirk Behme wrote:
> From: Dirk Behme <dirk.behme@gmail.com>
> 
> According to the i.MX6 Dual/Quad technical reference manual
> (Figure 18-2. Clock Tree - Part 1) the MLB clock is directly
> feed by the AXI_CLK_ROOT. This is called 'axi' in our code.
> 
> Note that the clock of the MLB IP block on the i.MX6 is completely
> independent of the PLL8 (MLB PLL). The MLB PLL isn't responsible
> for feeding the MLB IP block with a clock. Instead, it's used
> internally by the MLB module to sync the bus clock in case the MLB
> 6-pin interface is enabled:
> 
> MediaLB Control 0 Register, MLB150_MLBC0[5], MLBPEN:
> 1 MediaLB 6-pin interface enabled. MLB PLL and MLB PHY is enabled in this case.
> 
> I.e. the PLL8 MLB PLL has to be handled by the MLB driver and isn't needed
> for clocking the MLB module itself.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: Jiada Wang <Jiada_Wang@mentor.com>

Applied, thanks.

> ---
>  arch/arm/mach-imx/clk-imx6q.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index d38e54f..fd0189d 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -399,7 +399,7 @@ int __init mx6q_clocks_init(void)
>  	clk[ldb_di1]      = imx_clk_gate2("ldb_di1",       "ldb_di1_podf",      base + 0x74, 14);
>  	clk[ipu2_di1]     = imx_clk_gate2("ipu2_di1",      "ipu2_di1_sel",      base + 0x74, 10);
>  	clk[hsi_tx]       = imx_clk_gate2("hsi_tx",        "hsi_tx_podf",       base + 0x74, 16);
> -	clk[mlb]          = imx_clk_gate2("mlb",           "pll8_mlb",          base + 0x74, 18);
> +	clk[mlb]          = imx_clk_gate2("mlb",           "axi",               base + 0x74, 18);
>  	clk[mmdc_ch0_axi] = imx_clk_gate2("mmdc_ch0_axi",  "mmdc_ch0_axi_podf", base + 0x74, 20);
>  	clk[mmdc_ch1_axi] = imx_clk_gate2("mmdc_ch1_axi",  "mmdc_ch1_axi_podf", base + 0x74, 22);
>  	clk[ocram]        = imx_clk_gate2("ocram",         "ahb",               base + 0x74, 28);
> -- 
> 1.8.2
> 
