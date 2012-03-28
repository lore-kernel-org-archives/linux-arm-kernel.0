From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 28 Mar 2012 06:32:33 +0000
Subject: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
In-Reply-To: <1332842311-12308-1-git-send-email-rnayak@ti.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83183E0CE@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 15:28:31, Nayak, Rajendra wrote:
> Some functions like _omap4_disable_module() and _omap4_wait_target_disable()
> are (will be) used on all OMAPs OMAP4 and beyond which support module level
> control. Fix the error checks in these functions to return if called on
> any platform pre OMAP4 (i.e OMAP2 and OMAP3) instead of checking for
> !cpu_is_omap44xx(). This avoids having to update the error check with a
> '&& !cpu_is_omap54xx()' when OMAP5 is introduced and possibly similar updates
> when further OMAP generations are added.
> 

Let me add some flavor here :)

AM33xx, which has module level control, but falls under OMAP3 family of 
devices. cpu_is_omap34xx() is true for AM33xx device and we have to add 
check in all these functions. And I am sure we will have many of such 
devices in the future.

Can we use some flag based option here, instead of cpu_is_xxx() check?

Thanks,
Vaibhav

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 8ac26f2..f2a9afa 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -808,7 +808,7 @@ static void _enable_module(struct omap_hwmod *oh)
>   */
>  static int _omap4_wait_target_disable(struct omap_hwmod *oh)
>  {
> -	if (!cpu_is_omap44xx())
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>  		return 0;
>  
>  	if (!oh)
> @@ -838,7 +838,7 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
>  	int v;
>  
>  	/* The module mode does not exist prior OMAP4 */
> -	if (!cpu_is_omap44xx())
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>  		return -EINVAL;
>  
>  	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
