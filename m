From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 20 Jul 2012 10:09:43 +0530
Subject: [RFC][PATCH v2 1/1] ARM: OMAP2+: PM: Register suspend ops even
 in the presence of DT blob
In-Reply-To: <1342699728-19831-1-git-send-email-vaibhav.bedia@ti.com>
References: <1342699728-19831-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <5008E10F.4080706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 July 2012 05:38 PM, Vaibhav Bedia wrote:
> As per the comment in omap2_common_late_init() looks like the
> original intent of the DT check was to treat only the PMIC
> and SR initialization differently. Recent changes to consolidate
> the suspend-resume code across OMAP3/4 resulted into the
> registration of suspend ops also being dependent on the check
> for DT blob. Since the suspend-resume operation should not
> really be dependent on the usage of DT remove this dependency
> by wrapping the PMIC and SR init under the DT check.

So I am guessing you also tested suspend/resume on your hardware
with this patch, when booting with a DT blob, and it passed.

>
> Signed-off-by: Vaibhav Bedia<vaibhav.bedia@ti.com>
> ---
> v2->v1
>   - As suggested by Paul, Instead of moving around the suspend ops
>     registration just wrap the PMIC and SR init under the DT check.
>   - Fixed up Kevin's email address :\
>
>   arch/arm/mach-omap2/pm.c |   21 ++++++++++-----------
>   1 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 9cb5ced..46848f7 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -302,19 +302,18 @@ int __init omap2_common_pm_late_init(void)
>   	 * a completely different mechanism.
>   	 * Disable this part if a DT blob is available.
>   	 */
> -	if (of_have_populated_dt())
> -		return 0;
> +	if (!of_have_populated_dt()) {
> +		/* Init the voltage layer */
> +		omap_pmic_late_init();
> +		omap_voltage_late_init();
>
> -	/* Init the voltage layer */
> -	omap_pmic_late_init();
> -	omap_voltage_late_init();
> +		/* Initialize the voltages */
> +		omap3_init_voltages();
> +		omap4_init_voltages();
>
> -	/* Initialize the voltages */
> -	omap3_init_voltages();
> -	omap4_init_voltages();
> -
> -	/* Smartreflex device init */
> -	omap_devinit_smartreflex();
> +		/* Smartreflex device init */
> +		omap_devinit_smartreflex();
> +	}
>
>   #ifdef CONFIG_SUSPEND
>   	suspend_set_ops(&omap_pm_ops);
