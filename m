From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 20 Jun 2014 16:15:47 +0800
Subject: [PATCH 1/1] clk-imx35: Add clko clock support
In-Reply-To: <1402990063-26908-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1402990063-26908-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20140620081546.GG28225@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 09:27:43AM +0200, Alexander Stein wrote:
> This adds a new clk which is programmable using different sources and
> dividers.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> I know some (most) of the new lines are larger than 80 characters, but I kept
> the same layout as the other lines.
> Also lots of the clock sources are not used in linux, so I have given them
> a descriptive name though.
> 
>  arch/arm/mach-imx/clk-imx35.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
> index 71c86a2..acf821c 100644
> --- a/arch/arm/mach-imx/clk-imx35.c
> +++ b/arch/arm/mach-imx/clk-imx35.c
> @@ -49,6 +49,13 @@ static struct clk_onecell_data clk_data;
>  
>  static const char *std_sel[] = {"ppll", "arm"};
>  static const char *ipg_per_sel[] = {"ahb_per_div", "arm_per_div"};
> +static const char *clko_select[] = {"ckil", "osc", "osc_audio", "dummy",
> +				 "mpll_075", "mpll", "ppll", "arm",
> +				 "ahb", "ipg", "ipg_per", "usbdiv",
> +				 "esdhc1_div", "ssi1_div_post", "mlb_gate",
> +				 "mshc_gate", "mpll_lock", "csi_div",
> +				 "spdif_div_post", "uart1_gate", "asrc",
> +				 "dptc", "arm_ungated", "nfc_div", "hsp"};

Any new string you add here should have a corresponding clk in clock
framework.

>  
>  enum mx35_clks {
>  	ckih, mpll, ppll, mpll_075, arm, hsp, hsp_div, hsp_sel, ahb, ipg,
> @@ -64,7 +71,7 @@ enum mx35_clks {
>  	rtc_gate, rtic_gate, scc_gate, sdma_gate, spba_gate, spdif_gate,
>  	ssi1_gate, ssi2_gate, uart1_gate, uart2_gate, uart3_gate, usbotg_gate,
>  	wdog_gate, max_gate, admux_gate, csi_gate, csi_div, csi_sel, iim_gate,
> -	gpu2d_gate, clk_max
> +	gpu2d_gate, clko_sel, clko_div1, clko_div, clko_gate, clk_max
>  };
>  
>  static struct clk *clk[clk_max];
> @@ -146,6 +153,10 @@ int __init mx35_clocks_init(void)
>  	clk[csi_sel] = imx_clk_mux("csi_sel", base + MX35_CCM_PDR2, 7, 1, std_sel, ARRAY_SIZE(std_sel));
>  	clk[csi_div] = imx_clk_divider("csi_div", "csi_sel", base + MX35_CCM_PDR2, 16, 6);
>  
> +	clk[clko_sel] = imx_clk_mux("clko_sel", base + MX35_CCM_COSR, 0, 5, clko_select, ARRAY_SIZE(clko_select));
> +	clk[clko_div1] = imx_clk_divider("clko_div1", "clko_sel", base + MX35_CCM_COSR, 6, 1);
> +	clk[clko_div] = imx_clk_divider("clko_div", "clko_div1", base + MX35_CCM_COSR, 10, 6);
> +
>  	clk[asrc_gate] = imx_clk_gate2("asrc_gate", "ipg", base + MX35_CCM_CGR0,  0);
>  	clk[pata_gate] = imx_clk_gate2("pata_gate", "ipg", base + MX35_CCM_CGR0,  2);
>  	clk[audmux_gate] = imx_clk_gate2("audmux_gate", "ipg", base + MX35_CCM_CGR0,  4);
> @@ -200,6 +211,8 @@ int __init mx35_clocks_init(void)
>  	clk[iim_gate] = imx_clk_gate2("iim_gate", "ipg", base + MX35_CCM_CGR3,  2);
>  	clk[gpu2d_gate] = imx_clk_gate2("gpu2d_gate", "ahb", base + MX35_CCM_CGR3,  4);
>  
> +	clk[clko_gate] = imx_clk_gate("clko_gate", "clko_div", base + MX35_CCM_COSR,  5);
> +
>  	for (i = 0; i < ARRAY_SIZE(clk); i++)
>  		if (IS_ERR(clk[i]))
>  			pr_err("i.MX35 clk %d: register failed with %ld\n",
> @@ -260,6 +273,7 @@ int __init mx35_clocks_init(void)
>  	clk_register_clkdev(clk[nfc_div], NULL, "imx25-nand.0");
>  	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
>  	clk_register_clkdev(clk[admux_gate], "audmux", NULL);
> +	clk_register_clkdev(clk[clko_gate], NULL, "clko.0");

Will this lookup be used somewhere?

Shawn

>  
>  	clk_prepare_enable(clk[spba_gate]);
>  	clk_prepare_enable(clk[gpio1_gate]);
> @@ -286,6 +300,11 @@ int __init mx35_clocks_init(void)
>  	mxc_timer_init(MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR), MX35_INT_GPT);
>  #endif
>  
> +	/*
> +	 * Let's initially set up CLKO parent as arm.
> +	 */
> +	clk_set_parent(clk[clko_sel], clk[arm]);
> +
>  	return 0;
>  }
>  
> -- 
> 1.8.5.5
> 
