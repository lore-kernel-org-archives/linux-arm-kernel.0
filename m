From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 30 Sep 2015 13:21:47 +0800
Subject: [PATCH v3 1/1] ARM: imx31: Do not call mxc_timer_init twice when
 booting with DT
In-Reply-To: <1443423799-14685-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1443423799-14685-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20150930052147.GA18468@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 09:03:19AM +0200, Alexander Stein wrote:
> mxc_timer_init must not be called from within mx31_clocks_init_dt. It will
> eventually be called by imx31_timer_init_dt
> (drivers/clocksource/timer-imx-gpt.c).
> This arranges the initialization code similar to clk-imx27.c
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Again, please use "clk: ..." instead of "ARM: ..." for clock patches,
since we have moved i.MX clock drivers from arch/arm/mach-imx into
drivers/clk/imx.

> ---
> Changes in v3:
> * Fix compilation issues
> * Actually compile tested, but still untested due to lack of hardware
> 
> * Added in v2
> * Compile tested only due to lack of hardware
> 
>  drivers/clk/imx/clk-imx31.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
> index 1f83834..a908222 100644
> --- a/drivers/clk/imx/clk-imx31.c
> +++ b/drivers/clk/imx/clk-imx31.c
> @@ -47,6 +47,8 @@ static const char *per_sel[] = { "per_div", "ipg", };
>  static const char *csi_sel[] = { "upll", "spll", };
>  static const char *fir_sel[] = { "mcu_main", "upll", "spll" };
>  
> +static u32 fref = 26000000; /* default */
> +

We should not create this variable, and it should be kept as a local
variable and passed around as an argument.

Also, the patch doesn't apply to my imx/clk branch.  Please rebase.

Shawn

>  enum mx31_clks {
>  	dummy, ckih, ckil, mpll, spll, upll, mcu_main, hsp, ahb, nfc, ipg,
>  	per_div, per, csi, fir, csi_div, usb_div_pre, usb_div_post, fir_div_pre,
> @@ -62,7 +64,7 @@ enum mx31_clks {
>  static struct clk *clk[clk_max];
>  static struct clk_onecell_data clk_data;
>  
> -int __init mx31_clocks_init(unsigned long fref)
> +static void __init _mx31_clocks_init(unsigned long fref)
>  {
>  	void __iomem *base;
>  	struct device_node *np;
> @@ -132,6 +134,12 @@ int __init mx31_clocks_init(unsigned long fref)
>  
>  	imx_check_clocks(clk, ARRAY_SIZE(clk));
>  
> +	clk_set_parent(clk[csi], clk[upll]);
> +	clk_prepare_enable(clk[emi_gate]);
> +	clk_prepare_enable(clk[iim_gate]);
> +	mx31_revision();
> +	clk_disable_unprepare(clk[iim_gate]);
> +
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx31-ccm");
>  
>  	if (np) {
> @@ -139,6 +147,11 @@ int __init mx31_clocks_init(unsigned long fref)
>  		clk_data.clk_num = ARRAY_SIZE(clk);
>  		of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>  	}
> +}
> +
> +int __init mx31_clocks_init(void)
> +{
> +	_mx31_clocks_init(fref);
>  
>  	clk_register_clkdev(clk[gpt_gate], "per", "imx-gpt.0");
>  	clk_register_clkdev(clk[ipg], "ipg", "imx-gpt.0");
> @@ -194,12 +207,6 @@ int __init mx31_clocks_init(unsigned long fref)
>  	clk_register_clkdev(clk[sdma_gate], NULL, "imx31-sdma");
>  	clk_register_clkdev(clk[iim_gate], "iim", NULL);
>  
> -	clk_set_parent(clk[csi], clk[upll]);
> -	clk_prepare_enable(clk[emi_gate]);
> -	clk_prepare_enable(clk[iim_gate]);
> -	mx31_revision();
> -	clk_disable_unprepare(clk[iim_gate]);
> -
>  	mxc_timer_init(MX31_GPT1_BASE_ADDR, MX31_INT_GPT, GPT_TYPE_IMX31);
>  
>  	return 0;
> @@ -208,7 +215,6 @@ int __init mx31_clocks_init(unsigned long fref)
>  int __init mx31_clocks_init_dt(void)
>  {
>  	struct device_node *np;
> -	u32 fref = 26000000; /* default */
>  
>  	for_each_compatible_node(np, NULL, "fixed-clock") {
>  		if (!of_device_is_compatible(np, "fsl,imx-osc26m"))
> @@ -218,5 +224,7 @@ int __init mx31_clocks_init_dt(void)
>  			break;
>  	}
>  
> -	return mx31_clocks_init(fref);
> +	_mx31_clocks_init(fref);
> +
> +	return 0;
>  }
> -- 
> 2.4.9
> 
