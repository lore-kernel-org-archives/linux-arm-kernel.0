From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Feb 2013 17:20:15 +0200
Subject: [PATCH] ARM: OMAP2+: PM: Fix the dt return condition in
 pm_late_init()
In-Reply-To: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130208152015.GH23979@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 08:41:44PM +0530, Santosh Shilimkar wrote:
> Commit 1416408d {ARM: OMAP2+: PM: share some suspend-related functions
> across OMAP2, 3, 4} moved suspend code to common place but now with
> that change, for DT build on OMAP4, suspend hooks are not getting
> registered which results in no suspend support.
> 
> The DT return condition is limited to PMIC and smartreflex
> initialization and hence restrict it so that suspend ops gets
> registered.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

makes sense to me, we still need to set the global suspend_ops pointer
to something valid in DT boots:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/pm.c |   20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index f4b3143..1ec4299 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -345,19 +345,19 @@ int __init omap2_common_pm_late_init(void)
>  	 * a completely different mechanism.
>  	 * Disable this part if a DT blob is available.
>  	 */
> -	if (of_have_populated_dt())
> -		return 0;
> +	if (!of_have_populated_dt()) {
>  
> -	/* Init the voltage layer */
> -	omap_pmic_late_init();
> -	omap_voltage_late_init();
> +		/* Init the voltage layer */
> +		omap_pmic_late_init();
> +		omap_voltage_late_init();
>  
> -	/* Initialize the voltages */
> -	omap3_init_voltages();
> -	omap4_init_voltages();
> +		/* Initialize the voltages */
> +		omap3_init_voltages();
> +		omap4_init_voltages();
>  
> -	/* Smartreflex device init */
> -	omap_devinit_smartreflex();
> +		/* Smartreflex device init */
> +		omap_devinit_smartreflex();
> +	}
>  
>  #ifdef CONFIG_SUSPEND
>  	suspend_set_ops(&omap_pm_ops);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130208/f9d23752/attachment.sig>
