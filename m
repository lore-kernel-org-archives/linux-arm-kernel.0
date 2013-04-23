From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Apr 2013 20:20:10 +0800
Subject: [PATCH V4] ARM: i.MX5: Allow DT clock providers
In-Reply-To: <20130423091633.22088.58225.stgit@localhost>
References: <20130423091633.22088.58225.stgit@localhost>
Message-ID: <20130423122007.GE27475@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 11:16:33AM +0200, Martin Fuzzey wrote:
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
> Since the same method may be useful for other i.MX platforms
> implement the imx_obtain_fixed_clock() function in common code.
> 
> Actually changing other i.MX platforms to use this should be done
> later by someone with access to the appropriate hardware.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied with a small fixup below.

> 
> ---
> Changelog:
> V2: Applied comments from Sascha Hauer:
> 	* Use kasprintf instead of scnprintf to avoid length limit
> 	* Avoid use of IS_ERR_OR_NULL
> 
> V3: Applied comments from Shawn Guo:
> 	* Find clocks by path rather than compatible string
> 	* Remove unnecessary #ifdef CONFIG_OF
> 
> V4:
> 	* Moved clock obtention function to mach-imx/clk.c to allow use by
> 		other imx platforms (request from Sascha)
> 	* Added Tested-by from Fabio Estevam
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |   44 ++++++-----------------------------
>  arch/arm/mach-imx/clk.c             |   37 +++++++++++++++++++++++++++++
>  arch/arm/mach-imx/clk.h             |    3 ++
>  3 files changed, 48 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index 3228b4e..debd76d 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -123,11 +123,13 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  {
>  	int i;
>  
> +	of_clk_init(NULL);
> +
>  	clk[dummy] = imx_clk_fixed("dummy", 0);
> -	clk[ckil] = imx_clk_fixed("ckil", rate_ckil);
> -	clk[osc] = imx_clk_fixed("osc", rate_osc);
> -	clk[ckih1] = imx_clk_fixed("ckih1", rate_ckih1);
> -	clk[ckih2] = imx_clk_fixed("ckih2", rate_ckih2);
> +	clk[ckil] = imx_obtain_fixed_clock("ckil", rate_ckil);
> +	clk[osc] = imx_obtain_fixed_clock("osc", rate_osc);
> +	clk[ckih1] = imx_obtain_fixed_clock("ckih1", rate_ckih1);
> +	clk[ckih2] = imx_obtain_fixed_clock("ckih2", rate_ckih2);
>  
>  	clk[lp_apm] = imx_clk_mux("lp_apm", MXC_CCM_CCSR, 9, 1,
>  				lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
> @@ -539,42 +541,12 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
>  	return of_clk_configure();
>  }
>  
> -#ifdef CONFIG_OF
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
> -#endif
> diff --git a/arch/arm/mach-imx/clk.c b/arch/arm/mach-imx/clk.c
> index f5e8be8..f2c73f2 100644
> --- a/arch/arm/mach-imx/clk.c
> +++ b/arch/arm/mach-imx/clk.c
> @@ -1,3 +1,40 @@
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
> +#include "clk.h"
> +
>  DEFINE_SPINLOCK(imx_ccm_lock);
> +
> +static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
> +{
> +	struct of_phandle_args phandle = {0};
> +	struct clk *clk = ERR_PTR(-ENODEV);
> +	char *path;
> +
> +	path = kasprintf(GFP_KERNEL, "/clocks/%s", name);
> +	if (!path)
> +		return ERR_PTR(-ENOMEM);
> +
> +	phandle.np = of_find_node_by_path(path);
> +	kfree(path);
> +
> +	if (phandle.np) {
> +		clk = of_clk_get_from_provider(&phandle);
> +		of_node_put(phandle.np);
> +	}
> +	return clk;
> +}
> +
> +struct clk * __init imx_obtain_fixed_clock(
> +			const char *name, unsigned long rate)
> +{
> +	struct clk *clk;
> +
> +	clk = imx_obtain_fixed_clock_from_dt(name);
> +	if (IS_ERR(clk))
> +		clk = imx_clk_fixed(name, rate);
> +	return clk;
> +}
> diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
> index d9d9d9c..780fd67 100644
> --- a/arch/arm/mach-imx/clk.h
> +++ b/arch/arm/mach-imx/clk.h
> @@ -29,6 +29,9 @@ struct clk *clk_register_gate2(struct device *dev, const char *name,
>  		void __iomem *reg, u8 bit_idx,
>  		u8 clk_gate_flags, spinlock_t *lock);
>  
> +struct clk * __init imx_obtain_fixed_clock(

The __init annotation is not needed for function declaration, so I just
removed it.

Shawn

> +			const char *name, unsigned long rate);
> +
>  static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
>  		void __iomem *reg, u8 shift)
>  {
> 
