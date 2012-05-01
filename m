From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 1 May 2012 15:41:48 -0500
Subject: [PATCH v4 02/39] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <e0cf9678cb9a44d2a16401383ab8496eb825c291.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <e0cf9678cb9a44d2a16401383ab8496eb825c291.1335874494.git.afzal@ti.com>
Message-ID: <4FA04A8C.4050703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Afzal,

On 05/01/2012 07:19 AM, Afzal Mohammed wrote:
> Create API for platforms to adapt gpmc to HWMOD
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c             |   52 +++++++++++++++++++++++---------
>  arch/arm/plat-omap/include/plat/gpmc.h |    1 +
>  2 files changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 12916f3..c8d07bb 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -33,6 +33,8 @@
>  
>  #include <plat/sdrc.h>
>  
> +#include <plat/omap_device.h>
> +
>  /* GPMC register offsets */
>  #define GPMC_REVISION		0x00
>  #define GPMC_SYSCONFIG		0x10
> @@ -276,6 +278,31 @@ unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
>  	return ticks * gpmc_get_fclk_period() / 1000;
>  }
>  
> +int __init omap_init_gpmc(struct gpmc_pdata *pdata)
> +{
> +	struct omap_hwmod *oh;
> +	struct platform_device *pdev;
> +	char *name = "omap-gpmc";
> +	char *oh_name = "gpmc";
> +
> +	pdata->clk_prd = gpmc_get_fclk_period();

Does this need to be done here? May be this should be done in the probe
function. You could store the handle to the main clk in the pdata.

> +
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (!oh) {
> +		pr_err("Could not look up %s\n", oh_name);
> +		return -ENODEV;
> +	}
> +
> +	pdev = omap_device_build(name, -1, oh, pdata,
> +					sizeof(*pdata), NULL, 0, 0);
> +	if (IS_ERR(pdev)) {
> +		WARN(1, "Can't build omap_device for %s:%s.\n",
> +						name, oh->name);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
>  #ifdef DEBUG
>  static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
>  			       int time, const char *name)
> @@ -843,24 +870,19 @@ static __devinit void gpmc_mem_init(void)
>  
>  static int __init gpmc_init(void)
>  {
> -	int ret = -EINVAL;
> -	char *ck = NULL;
> -
> -	if (cpu_is_omap24xx()) {
> -		ck = "core_l3_ck";
> -	} else if (cpu_is_omap34xx()) {
> -		ck = "gpmc_fck";
> -	} else if (cpu_is_omap44xx()) {
> -		ck = "gpmc_ck";
> -	}
> +	char *oh_name = "gpmc";
> +	struct omap_hwmod *oh;
>  
> -	if (WARN_ON(!ck))
> -		return ret;
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (!oh) {
> +		pr_err("Could not look up %s\n", oh_name);
> +		return -ENODEV;
> +	}
>  
> -	gpmc_l3_clk = clk_get(NULL, ck);
> +	gpmc_l3_clk = clk_get(NULL, oh->main_clk);
>  	if (IS_ERR(gpmc_l3_clk)) {
> -		printk(KERN_ERR "Could not get GPMC clock %s\n", ck);
> -		BUG();
> +		pr_err("error: clk_get on %s\n", oh->main_clk);
> +		return -EINVAL;
>  	}
>  
>  	clk_enable(gpmc_l3_clk);

I would have thought we should be able to remove the gpmc_init function
completely by now. Most of the code should be moved to the probe function.

Also now with hwmod in place, we should be able to remove the
clk_enable/disable functions and use the pm_runtime APIs instead.

Cheers
Jon
