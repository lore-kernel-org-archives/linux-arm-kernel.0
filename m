From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Jul 2012 07:26:38 -0700
Subject: [PATCH v1 03/14] ARM: OMAP5: id: Add cpu id for ES versions
In-Reply-To: <1341490136-25901-6-git-send-email-santosh.shilimkar@ti.com>
References: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
 <1341490136-25901-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20120705142637.GD1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120705 05:13]:
> From: R Sricharan <r.sricharan@ti.com>
> 
> Adding the OMAP5 ES1.0, 2.0 and OMAP5432 cpu revision
> detection support.
> 
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -50,6 +50,11 @@ int omap_type(void)
>  		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
>  	} else if (cpu_is_omap44xx()) {
>  		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
> +	} else if (cpu_is_omap54xx()) {
> +		val = omap_ctrl_readl(OMAP5XXX_CONTROL_STATUS);
> +		val &= OMAP5_DEVICETYPE_MASK;
> +		val >>= 6;
> +		goto out;
>  	} else {
>  		pr_err("Cannot detect omap type!\n");
>  		goto out;
> @@ -100,7 +105,7 @@ static u16 tap_prod_id;
>  
>  void omap_get_die_id(struct omap_die_id *odi)
>  {
> -	if (cpu_is_omap44xx()) {
> +	if (cpu_is_omap44xx() || cpu_is_omap54xx()) {

Please update all these patches to use soc_is_omap54xx()
instead of cpu_is_omap54xx() as that's where we are heading.

Regards,

Tony
