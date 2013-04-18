From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 18 Apr 2013 14:30:59 +0800
Subject: [PATCH V2] ARM: i.MX5: Allow DT clock providers
In-Reply-To: <20130415080741.20173.70704.stgit@localhost>
References: <20130415080741.20173.70704.stgit@localhost>
Message-ID: <20130418063056.GA20566@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 10:07:41AM +0200, Martin Fuzzey wrote:
> Currently clock providers defined in the DT are not registered
> on i.MX5 platforms since of_clk_init() is not called.
> 
> This is not a problem for the SOC's own clocks, which are registered
> in code,  but prevents the DT being used to define clocks for external
> hardware.
> 
> Fix this by calling of_clk_init() and actually using the DT to obtain
> the 4 SOC fixed clocks.
> These are already defined in the DT but were previously just used to
> manually obtain the rate.
> 
> Fall back to the old scheme for non DT platforms.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> 
> ---
> Changelog:
> V2: Applied comments from Sashca Hauer:
> 	* Use kasprintf instead of scnprintf to avoid length limit
> 	* Avoid use of IS_ERR_OR_NULL
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |   79 ++++++++++++++++++++---------------
>  1 files changed, 45 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index 3228b4e..4b28cfc 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -117,17 +117,56 @@ enum imx5_clks {
>  static struct clk *clk[clk_max];
>  static struct clk_onecell_data clk_data;
>  
> +
> +static struct clk * __init mx5_obtain_fixed_clock_from_dt(const char *name)
> +{
> +#ifdef CONFIG_OF

We have selected USE_OF at the sub-architecture level, so the ifdef
plays nothing here.

> +	struct of_phandle_args phandle = {0};
> +	struct clk *clk = ERR_PTR(-ENODEV);
> +	char *compatible;
> +
> +	compatible = kasprintf(GFP_KERNEL, "fsl,imx-%s", name);

What about finding the node by path as below?

	path = kasprintf(GFP_KERNEL, "/clocks/%s", name);
	phandle.np = of_find_node_by_path(path);

I have to admit that those imx custom compatibles for fixed-clock
shouldn't necessarily be there at all.  Let's stop spreading the use.

Shawn

> +	if (!compatible)
> +		return ERR_PTR(-ENOMEM);
> +
> +	phandle.np = of_find_compatible_node(NULL, NULL, compatible);
> +	kfree(compatible);
> +	if (phandle.np) {
> +		clk = of_clk_get_from_provider(&phandle);
> +		of_node_put(phandle.np);
> +	}
> +	return clk;
> +#else
> +	return ERR_PTR(-ENODEV);
> +#endif
> +}
> +
> +static struct clk * __init mx5_obtain_fixed_clock(
> +			const char *name, unsigned long rate)
> +{
> +	struct clk *clk;
> +
> +	clk = mx5_obtain_fixed_clock_from_dt(name);
> +	if (IS_ERR(clk))
> +		clk = imx_clk_fixed(name, rate);
> +	return clk;
> +}
> +
>  static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  		unsigned long rate_osc, unsigned long rate_ckih1,
>  		unsigned long rate_ckih2)
>  {
>  	int i;
>  
> +#ifdef CONFIG_OF
> +	of_clk_init(NULL);
> +#endif
> +
>  	clk[dummy] = imx_clk_fixed("dummy", 0);
> -	clk[ckil] = imx_clk_fixed("ckil", rate_ckil);
> -	clk[osc] = imx_clk_fixed("osc", rate_osc);
> -	clk[ckih1] = imx_clk_fixed("ckih1", rate_ckih1);
> -	clk[ckih2] = imx_clk_fixed("ckih2", rate_ckih2);
> +	clk[ckil] = mx5_obtain_fixed_clock("ckil", rate_ckil);
> +	clk[osc] = mx5_obtain_fixed_clock("osc", rate_osc);
> +	clk[ckih1] = mx5_obtain_fixed_clock("ckih1", rate_ckih1);
> +	clk[ckih2] = mx5_obtain_fixed_clock("ckih2", rate_ckih2);
>  
>  	clk[lp_apm] = imx_clk_mux("lp_apm", MXC_CCM_CCSR, 9, 1,
>  				lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
> @@ -540,41 +579,13 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
>  }
>  
>  #ifdef CONFIG_OF
> -static void __init clk_get_freq_dt(unsigned long *ckil, unsigned long *osc,
> -				   unsigned long *ckih1, unsigned long *ckih2)
> -{
> -	struct device_node *np;
> -
> -	/* retrieve the freqency of fixed clocks from device tree */
> -	for_each_compatible_node(np, NULL, "fixed-clock") {
> -		u32 rate;
> -		if (of_property_read_u32(np, "clock-frequency", &rate))
> -			continue;
> -
> -		if (of_device_is_compatible(np, "fsl,imx-ckil"))
> -			*ckil = rate;
> -		else if (of_device_is_compatible(np, "fsl,imx-osc"))
> -			*osc = rate;
> -		else if (of_device_is_compatible(np, "fsl,imx-ckih1"))
> -			*ckih1 = rate;
> -		else if (of_device_is_compatible(np, "fsl,imx-ckih2"))
> -			*ckih2 = rate;
> -	}
> -}
> -
>  int __init mx51_clocks_init_dt(void)
>  {
> -	unsigned long ckil, osc, ckih1, ckih2;
> -
> -	clk_get_freq_dt(&ckil, &osc, &ckih1, &ckih2);
> -	return mx51_clocks_init(ckil, osc, ckih1, ckih2);
> +	return mx51_clocks_init(0, 0, 0, 0);
>  }
>  
>  int __init mx53_clocks_init_dt(void)
>  {
> -	unsigned long ckil, osc, ckih1, ckih2;
> -
> -	clk_get_freq_dt(&ckil, &osc, &ckih1, &ckih2);
> -	return mx53_clocks_init(ckil, osc, ckih1, ckih2);
> +	return mx53_clocks_init(0, 0, 0, 0);
>  }
>  #endif
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
