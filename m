From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Sun, 29 Apr 2012 10:11:51 +0000
Subject: [PATCH 1/6] ARM: OMAP4: hwmod: rename _enable_module to
 _omap4_enable_module()
In-Reply-To: <1335557140-10854-2-git-send-email-khilman@ti.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com>
 <1335557140-10854-2-git-send-email-khilman@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA024EC@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2012 at 01:35:35, Hilman, Kevin wrote:
> _enable_module is specific to OMAP4-class SoCs, so rename it to
> be consistend with the corresponding _omap4_disable_module.
> 

If we assume AM33xx device under omap4 class, then above statement makes 
sense, else its not really true.

Just wanted to remind on the fact that, we still have not concluded on 
am33xx device, whether to have separate class or OMAP3 class or OAMP4 class?

Also, I and sure that, most of the new family of devices coming 
in will use OMAP4 look-a-like PRCM block.

Also, minor spelling mistake above,
s/consistend/consistent


> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index bf86f7e..939032a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -771,13 +771,13 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
>  }
>  
>  /**
> - * _enable_module - enable CLKCTRL modulemode on OMAP4
> + * _omap4_enable_module - enable CLKCTRL modulemode on OMAP4
>   * @oh: struct omap_hwmod *
>   *
>   * Enables the PRCM module mode related to the hwmod @oh.
>   * No return value.
>   */
> -static void _enable_module(struct omap_hwmod *oh)
> +static void _omap4_enable_module(struct omap_hwmod *oh)

In that case, does it make sense to move this function to cminst44xx.c file. 
And same applies to _disable_module() as well. 

Thanks,
Vaibhav
>  {
>  	/* The module mode does not exist prior OMAP4 */
>  	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> @@ -786,8 +786,8 @@ static void _enable_module(struct omap_hwmod *oh)
>  	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
>  		return;
>  
> -	pr_debug("omap_hwmod: %s: _enable_module: %d\n",
> -		 oh->name, oh->prcm.omap4.modulemode);
> +	pr_debug("omap_hwmod: %s: %s: %d\n",
> +		 oh->name, __func__, oh->prcm.omap4.modulemode);
>  
>  	omap4_cminst_module_enable(oh->prcm.omap4.modulemode,
>  				   oh->clkdm->prcm_partition,
> @@ -1814,7 +1814,7 @@ static int _enable(struct omap_hwmod *oh)
>  	}
>  
>  	_enable_clocks(oh);
> -	_enable_module(oh);
> +	_omap4_enable_module(oh);
>  
>  	r = _wait_target_ready(oh);
>  	if (!r) {
> -- 
> 1.7.9.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
