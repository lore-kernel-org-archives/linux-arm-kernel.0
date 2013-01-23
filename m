From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 23 Jan 2013 21:46:59 +0100
Subject: [PATCH V2] ARM: imx27: add a clock gate to activate SPLL clock
In-Reply-To: <1358086501-44408-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1358086501-44408-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20130123204659.GD13025@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 13, 2013 at 03:15:01PM +0100, Gwenhael Goavec-Merou wrote:
> A clock gate is mandatory to activate SPLL clock needed, at least, for usb.
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Applied, thanks

Sascha

> ---
> V2: - Suppress patch about ehci-mxc.c. 
> 
>  arch/arm/mach-imx/clk-imx27.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
> index 4c1d1e4..4f066d13 100644
> --- a/arch/arm/mach-imx/clk-imx27.c
> +++ b/arch/arm/mach-imx/clk-imx27.c
> @@ -62,7 +62,7 @@ static const char *clko_sel_clks[] = {
>  	"32k", "usb_div", "dptc",
>  };
>  
> -static const char *ssi_sel_clks[] = { "spll", "mpll", };
> +static const char *ssi_sel_clks[] = { "spll_gate", "mpll", };
>  
>  enum mx27_clks {
>  	dummy, ckih, ckil, mpll, spll, mpll_main2, ahb, ipg, nfc_div, per1_div,
> @@ -82,7 +82,7 @@ enum mx27_clks {
>  	csi_ahb_gate, brom_ahb_gate, ata_ahb_gate, wdog_ipg_gate, usb_ipg_gate,
>  	uart6_ipg_gate, uart5_ipg_gate, uart4_ipg_gate, uart3_ipg_gate,
>  	uart2_ipg_gate, uart1_ipg_gate, ckih_div1p5, fpm, mpll_osc_sel,
> -	mpll_sel, clk_max
> +	mpll_sel, spll_gate, clk_max
>  };
>  
>  static struct clk *clk[clk_max];
> @@ -104,6 +104,7 @@ int __init mx27_clocks_init(unsigned long fref)
>  			ARRAY_SIZE(mpll_sel_clks));
>  	clk[mpll] = imx_clk_pllv1("mpll", "mpll_sel", CCM_MPCTL0);
>  	clk[spll] = imx_clk_pllv1("spll", "ckih", CCM_SPCTL0);
> +	clk[spll_gate] = imx_clk_gate("spll_gate", "spll", CCM_CSCR, 1);
>  	clk[mpll_main2] = imx_clk_fixed_factor("mpll_main2", "mpll", 2, 3);
>  
>  	if (mx27_revision() >= IMX_CHIP_REVISION_2_0) {
> @@ -121,7 +122,7 @@ int __init mx27_clocks_init(unsigned long fref)
>  	clk[per4_div] = imx_clk_divider("per4_div", "mpll_main2", CCM_PCDR1, 24, 6);
>  	clk[vpu_sel] = imx_clk_mux("vpu_sel", CCM_CSCR, 21, 1, vpu_sel_clks, ARRAY_SIZE(vpu_sel_clks));
>  	clk[vpu_div] = imx_clk_divider("vpu_div", "vpu_sel", CCM_PCDR0, 10, 6);
> -	clk[usb_div] = imx_clk_divider("usb_div", "spll", CCM_CSCR, 28, 3);
> +	clk[usb_div] = imx_clk_divider("usb_div", "spll_gate", CCM_CSCR, 28, 3);
>  	clk[cpu_sel] = imx_clk_mux("cpu_sel", CCM_CSCR, 15, 1, cpu_sel_clks, ARRAY_SIZE(cpu_sel_clks));
>  	clk[clko_sel] = imx_clk_mux("clko_sel", CCM_CCSR, 0, 5, clko_sel_clks, ARRAY_SIZE(clko_sel_clks));
>  	if (mx27_revision() >= IMX_CHIP_REVISION_2_0)
> -- 
> 1.7.12.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
