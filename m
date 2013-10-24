From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 24 Oct 2013 23:11:09 +0800
Subject: [PATCH 2/8] ARM: imx: add clocking support code for the IMX50 SoC
In-Reply-To: <1382076260-6422-3-git-send-email-gerg@uclinux.org>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <1382076260-6422-3-git-send-email-gerg@uclinux.org>
Message-ID: <20131024151106.GB14529@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 04:04:14PM +1000, gerg at uclinux.org wrote:
> From: Greg Ungerer <gerg@uclinux.org>
> 
> Add code to support the specific clock tree of the Freescale IMX50 SoC.
> It can use much of the common IMX51/IMX53 clocking code.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c | 79 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/common.h          |  3 ++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index 7c0dc45..ea4523a 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -363,6 +363,80 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk_prepare_enable(clk[tmax3]); /* esdhc1, esdhc4 */
>  }
>  
> +int __init mx50_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
> +			unsigned long rate_ckih1, unsigned long rate_ckih2)
> +{
> +	int i;
> +	unsigned long r;
> +	struct device_node *np;
> +
> +	clk[pll1_sw] = imx_clk_pllv2("pll1_sw", "osc", MX53_DPLL1_BASE);
> +	clk[pll2_sw] = imx_clk_pllv2("pll2_sw", "osc", MX53_DPLL2_BASE);
> +	clk[pll3_sw] = imx_clk_pllv2("pll3_sw", "osc", MX53_DPLL3_BASE);
> +
> +	clk[esdhc1_per_gate] = imx_clk_gate2("esdhc1_per_gate", "esdhc_a_podf", MXC_CCM_CCGR3, 2);
> +	clk[esdhc2_per_gate] = imx_clk_gate2("esdhc2_per_gate", "esdhc_c_sel", MXC_CCM_CCGR3, 6);
> +	clk[esdhc3_per_gate] = imx_clk_gate2("esdhc3_per_gate", "esdhc_b_podf", MXC_CCM_CCGR3, 10);
> +	clk[esdhc4_per_gate] = imx_clk_gate2("esdhc4_per_gate", "esdhc_d_sel", MXC_CCM_CCGR3, 14);
> +	clk[usb_phy1_gate] = imx_clk_gate2("usb_phy1_gate", "usb_phy_sel", MXC_CCM_CCGR4, 10);
> +	clk[usb_phy2_gate] = imx_clk_gate2("usb_phy2_gate", "usb_phy_sel", MXC_CCM_CCGR4, 12);
> +	clk[i2c3_gate] = imx_clk_gate2("i2c3_gate", "per_root", MXC_CCM_CCGR1, 22);
> +
> +	clk[cko1_sel] = imx_clk_mux("cko1_sel", MXC_CCM_CCOSR, 0, 4,
> +				mx53_cko1_sel, ARRAY_SIZE(mx53_cko1_sel));
> +	clk[cko1_podf] = imx_clk_divider("cko1_podf", "cko1_sel", MXC_CCM_CCOSR, 4, 3);
> +	clk[cko1] = imx_clk_gate2("cko1", "cko1_podf", MXC_CCM_CCOSR, 7);
> +
> +	clk[cko2_sel] = imx_clk_mux("cko2_sel", MXC_CCM_CCOSR, 16, 5,
> +				mx53_cko2_sel, ARRAY_SIZE(mx53_cko2_sel));
> +	clk[cko2_podf] = imx_clk_divider("cko2_podf", "cko2_sel", MXC_CCM_CCOSR, 21, 3);
> +	clk[cko2] = imx_clk_gate2("cko2", "cko2_podf", MXC_CCM_CCOSR, 24);
> +
> +	for (i = 0; i < ARRAY_SIZE(clk); i++)
> +		if (IS_ERR(clk[i]))
> +			pr_err("i.MX50 clk %d: register failed with %ld\n",
> +				i, PTR_ERR(clk[i]));
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx50-ccm");
> +	clk_data.clks = clk;
> +	clk_data.clk_num = ARRAY_SIZE(clk);
> +	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +
> +	mx5_clocks_common_init(rate_ckil, rate_osc, rate_ckih1, rate_ckih2);
> +
> +	clk_register_clkdev(clk[i2c3_gate], NULL, "imx21-i2c.2");
> +	clk_register_clkdev(clk[fec_gate], NULL, "imx25-fec.0");
> +	clk_register_clkdev(clk[usb_phy1_gate], "usb_phy1", "mxc-ehci.0");
> +	clk_register_clkdev(clk[esdhc1_ipg_gate], "ipg", "sdhci-esdhc-imx50.0");
> +	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx50.0");
> +	clk_register_clkdev(clk[esdhc1_per_gate], "per", "sdhci-esdhc-imx50.0");
> +	clk_register_clkdev(clk[esdhc2_ipg_gate], "ipg", "sdhci-esdhc-imx50.1");
> +	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx50.1");
> +	clk_register_clkdev(clk[esdhc2_per_gate], "per", "sdhci-esdhc-imx50.1");
> +	clk_register_clkdev(clk[esdhc3_ipg_gate], "ipg", "sdhci-esdhc-imx50.2");
> +	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx50.2");
> +	clk_register_clkdev(clk[esdhc3_per_gate], "per", "sdhci-esdhc-imx50.2");
> +	clk_register_clkdev(clk[esdhc4_ipg_gate], "ipg", "sdhci-esdhc-imx50.3");
> +	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx50.3");
> +	clk_register_clkdev(clk[esdhc4_per_gate], "per", "sdhci-esdhc-imx50.3");
> +
> +	/* set SDHC root clock to 200MHZ*/
> +	clk_set_rate(clk[esdhc_a_podf], 200000000);
> +	clk_set_rate(clk[esdhc_b_podf], 200000000);
> +
> +	/* System timer */
> +	mxc_timer_init(MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR), MX53_INT_GPT);

Oh, no.  These macros will eventually go away.  For device tree platform,
all these resources should be retrieved from device tree.  If you look
at clk-imx51-imx53.c on my for-next branch, you will see imx53 clock
code has been updated regarding that.

> +
> +	clk_prepare_enable(clk[iim_gate]);
> +	imx_print_silicon_rev("i.MX50", IMX_CHIP_REVISION_1_1);
> +	clk_disable_unprepare(clk[iim_gate]);
> +
> +	r = clk_round_rate(clk[usboh3_per_gate], 54000000);
> +	clk_set_rate(clk[usboh3_per_gate], r);
> +
> +	return 0;
> +}
> +
>  int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
>  			unsigned long rate_ckih1, unsigned long rate_ckih2)
>  {
> @@ -570,6 +644,11 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
>  	return 0;
>  }
>  
> +int __init mx50_clocks_init_dt(void)
> +{
> +	return mx50_clocks_init(0, 0, 0, 0);
> +}
> +

As Rob has just pointed out, we should use CLK_OF_DECLARE() for clock
initialization, so that .init_timer hook can be saved for DT machines.
Again, take a look at the imx53 code on my for-next branch for example.

Shawn

>  int __init mx51_clocks_init_dt(void)
>  {
>  	return mx51_clocks_init(0, 0, 0, 0);
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 4517fd7..afa56cb 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -61,6 +61,8 @@ extern int mx25_clocks_init(void);
>  extern int mx27_clocks_init(unsigned long fref);
>  extern int mx31_clocks_init(unsigned long fref);
>  extern int mx35_clocks_init(void);
> +extern int mx50_clocks_init(unsigned long ckil, unsigned long osc,
> +			unsigned long ckih1, unsigned long ckih2);
>  extern int mx51_clocks_init(unsigned long ckil, unsigned long osc,
>  			unsigned long ckih1, unsigned long ckih2);
>  extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
> @@ -68,6 +70,7 @@ extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
>  extern int mx25_clocks_init_dt(void);
>  extern int mx27_clocks_init_dt(void);
>  extern int mx31_clocks_init_dt(void);
> +extern int mx50_clocks_init_dt(void);
>  extern int mx51_clocks_init_dt(void);
>  extern int mx53_clocks_init_dt(void);
>  extern struct platform_device *mxc_register_gpio(char *name, int id,
> -- 
> 1.8.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
