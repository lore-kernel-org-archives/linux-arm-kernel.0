From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 11 May 2012 09:42:22 +0200
Subject: [PATCH 1/5] ARM: imx: add more imx5 ssi clocks
In-Reply-To: <1336718568-26810-2-git-send-email-shawn.guo@linaro.org>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
 <1336718568-26810-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120511074222.GC27341@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 02:42:44PM +0800, Shawn Guo wrote:
> Add more imx5 ssi clocks and lookup for device tree probe.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |   40 +++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index b8a382d..26ba1c5 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -31,6 +31,11 @@ static const char *per_lp_apm_sel[] = { "main_bus", "lp_apm", };
>  static const char *per_root_sel[] = { "per_podf", "ipg", };
>  static const char *esdhc_c_sel[] = { "esdhc_a_podf", "esdhc_b_podf", };
>  static const char *esdhc_d_sel[] = { "esdhc_a_podf", "esdhc_b_podf", };
> +static const char *ssi_apm_sels[] = { "ckih1", "lp_amp", "ckih2", };
> +static const char *ssi_clk_sels[] = { "pll1_sw", "pll2_sw", "pll3_sw", "ssi_apm", };
> +static const char *ssi3_clk_sels[] = { "ssi1_root_gate", "ssi2_root_gate", };
> +static const char *ssi_ext1_com_sels[] = { "ssi_ext1_podf", "ssi1_root_gate", };
> +static const char *ssi_ext2_com_sels[] = { "ssi_ext2_podf", "ssi2_root_gate", };
>  static const char *emi_slow_sel[] = { "main_bus", "ahb", };
>  static const char *usb_phy_sel_str[] = { "osc", "usb_phy_podf", };
>  static const char *mx51_ipu_di0_sel[] = { "di_pred", "osc", "ckih1", "tve_di", };
> @@ -71,6 +76,11 @@ enum imx5_clks {
>  	pll3_sw, ipu_di0_sel, ipu_di1_sel, tve_ext_sel, mx51_mipi, pll4_sw,
>  	ldb_di1_sel, di_pll4_podf, ldb_di0_sel, ldb_di0_gate, usb_phy1_gate,
>  	usb_phy2_gate, per_lp_apm, per_pred1, per_pred2, per_podf, per_root,
> +	ssi_apm, ssi1_root_sel, ssi2_root_sel, ssi3_root_sel, ssi_ext1_sel,
> +	ssi_ext2_sel, ssi_ext1_com_sel, ssi_ext2_com_sel, ssi1_root_pred,
> +	ssi1_root_podf, ssi2_root_pred, ssi2_root_podf, ssi_ext1_pred,
> +	ssi_ext1_podf, ssi_ext2_pred, ssi_ext2_podf, ssi1_root_gate,
> +	ssi2_root_gate, ssi3_root_gate, ssi_ext1_gate, ssi_ext2_gate,
>  	clk_max
>  };
>  
> @@ -195,6 +205,28 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk[uart5_per_gate] = imx_clk_gate2("uart5_per_gate", "uart_root", MXC_CCM_CCGR7, 14);
>  	clk[gpc_dvfs] = imx_clk_gate2("gpc_dvfs", "dummy", MXC_CCM_CCGR5, 24);
>  
> +	clk[ssi_apm] = imx_clk_mux("ssi_apm", MXC_CCM_CSCMR1, 8, 2, ssi_apm_sels, ARRAY_SIZE(ssi_apm_sels));
> +	clk[ssi1_root_sel] = imx_clk_mux("ssi1_root_sel", MXC_CCM_CSCMR1, 14, 2, ssi_clk_sels, ARRAY_SIZE(ssi_clk_sels));
> +	clk[ssi2_root_sel] = imx_clk_mux("ssi2_root_sel", MXC_CCM_CSCMR1, 12, 2, ssi_clk_sels, ARRAY_SIZE(ssi_clk_sels));
> +	clk[ssi3_root_sel] = imx_clk_mux("ssi3_root_sel", MXC_CCM_CSCMR1, 11, 1, ssi3_clk_sels, ARRAY_SIZE(ssi3_clk_sels));
> +	clk[ssi_ext1_sel] = imx_clk_mux("ssi_ext1_sel", MXC_CCM_CSCMR1, 28, 2, ssi_clk_sels, ARRAY_SIZE(ssi_clk_sels));
> +	clk[ssi_ext2_sel] = imx_clk_mux("ssi_ext2_sel", MXC_CCM_CSCMR1, 30, 2, ssi_clk_sels, ARRAY_SIZE(ssi_clk_sels));
> +	clk[ssi_ext1_com_sel] = imx_clk_mux("ssi_ext1_com_sel", MXC_CCM_CSCMR1, 0, 1, ssi_ext1_com_sels, ARRAY_SIZE(ssi_ext1_com_sels));
> +	clk[ssi_ext2_com_sel] = imx_clk_mux("ssi_ext2_com_sel", MXC_CCM_CSCMR1, 1, 1, ssi_ext2_com_sels, ARRAY_SIZE(ssi_ext2_com_sels));
> +	clk[ssi1_root_pred] = imx_clk_divider("ssi1_root_pred", "ssi1_root_sel", MXC_CCM_CS1CDR, 6, 3);
> +	clk[ssi1_root_podf] = imx_clk_divider("ssi1_root_podf", "ssi1_root_pred", MXC_CCM_CS1CDR, 0, 6);
> +	clk[ssi2_root_pred] = imx_clk_divider("ssi2_root_pred", "ssi2_root_sel", MXC_CCM_CS2CDR, 6, 3);
> +	clk[ssi2_root_podf] = imx_clk_divider("ssi2_root_podf", "ssi2_root_pred", MXC_CCM_CS2CDR, 0, 6);
> +	clk[ssi_ext1_pred] = imx_clk_divider("ssi_ext1_pred", "ssi_ext1_sel", MXC_CCM_CS1CDR, 22, 3);
> +	clk[ssi_ext1_podf] = imx_clk_divider("ssi_ext1_podf", "ssi_ext1_pred", MXC_CCM_CS1CDR, 16, 6);
> +	clk[ssi_ext2_pred] = imx_clk_divider("ssi_ext2_pred", "ssi_ext2_sel", MXC_CCM_CS2CDR, 22, 3);
> +	clk[ssi_ext2_podf] = imx_clk_divider("ssi_ext2_podf", "ssi_ext2_pred", MXC_CCM_CS2CDR, 16, 6);
> +	clk[ssi1_root_gate] = imx_clk_gate2("ssi1_root_gate", "ssi1_root_podf", MXC_CCM_CCGR3, 18);
> +	clk[ssi2_root_gate] = imx_clk_gate2("ssi2_root_gate", "ssi2_root_podf", MXC_CCM_CCGR3, 22);
> +	clk[ssi3_root_gate] = imx_clk_gate2("ssi3_root_gate", "ssi3_root_sel", MXC_CCM_CCGR3, 26);
> +	clk[ssi_ext1_gate] = imx_clk_gate2("ssi_ext1_gate", "ssi_ext1_com_sel", MXC_CCM_CCGR3, 28);
> +	clk[ssi_ext2_gate] = imx_clk_gate2("ssi_ext2_gate", "ssi_ext2_com_sel", MXC_CCM_CCGR3, 30);
> +
>  	for (i = 0; i < ARRAY_SIZE(clk); i++)
>  		if (IS_ERR(clk[i]))
>  			pr_err("i.MX5 clk %d: register failed with %ld\n",
> @@ -237,6 +269,8 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
>  	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
>  	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "imx-ssi.2");
> +	clk_register_clkdev(clk[ssi_ext1_gate], NULL, "ssi_ext.0");
> +	clk_register_clkdev(clk[ssi_ext2_gate], NULL, "ssi_ext.1");

At some point I'd like to be able to lookup a clk based on its clkname,
given that they have a unique name anyway. The clkdev mechanism does a
good job in associating devices with clocks, but it's not very suitable
to manipulate the clock tree like you want to do here.

We could simply do a

	for_each_clk() {
		clk_register_clkdev(clk, NULL, clk->name);
	}

This at least would prevent us from adding a new clkdev each time
somebody wants to do some fixups to the clock tree. I don't know if any
plans are existing to do something like this directly in the clock
framework instead.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
