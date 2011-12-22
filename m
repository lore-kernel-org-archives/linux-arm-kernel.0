From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 22 Dec 2011 17:10:42 +0200
Subject: [PATCH] OMAP3: hwmod_data: register dss hwmods after dss_core
In-Reply-To: <1324562563-27119-1-git-send-email-yanok@emcraft.com>
References: <1324562563-27119-1-git-send-email-yanok@emcraft.com>
Message-ID: <4EF34872.4030700@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ilya,

Thanks for the patch.

On 12/22/11 16:02, Ilya Yanok wrote:
> dss_core has to be initialized before any other DSS hwmod. Currently
> this is broken as dss_core is listed in chip/revision specific hwmod
> lists while other DSS hwmods are listed in common list which is
> registered first.
> 
> This patch moves DSS hwmods (except for dss_core) to the separate list
> which is registered last to ensure that dss_core is already registered.

I would suggest to add an in-code comment for this
(more descriptive, than the one you did for that patch),
and describe the otherwise breakage, so next time it would be
a bit harder to break that thing...

> 
> CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
> CC: Archit Taneja <archit@ti.com>
> CC: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   20 ++++++++++++++------
>  1 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 5324e8d..85536ff 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -3523,12 +3523,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
>  	&omap3xxx_uart2_hwmod,
>  	&omap3xxx_uart3_hwmod,
>  
> -	/* dss class */
> -	&omap3xxx_dss_dispc_hwmod,
> -	&omap3xxx_dss_dsi1_hwmod,
> -	&omap3xxx_dss_rfbi_hwmod,
> -	&omap3xxx_dss_venc_hwmod,
> -
>  	/* i2c class */
>  	&omap3xxx_i2c1_hwmod,
>  	&omap3xxx_i2c2_hwmod,
> @@ -3635,6 +3629,15 @@ static __initdata struct omap_hwmod *am35xx_hwmods[] = {
>  	NULL
>  };
>  
> +static __initdata struct omap_hwmod *omap3xxx_dss_hwmods[] = {
> +	/* dss class */
> +	&omap3xxx_dss_dispc_hwmod,
> +	&omap3xxx_dss_dsi1_hwmod,
> +	&omap3xxx_dss_rfbi_hwmod,
> +	&omap3xxx_dss_venc_hwmod,
> +	NULL
> +};
> +
>  int __init omap3xxx_hwmod_init(void)
>  {
>  	int r;
> @@ -3708,6 +3711,11 @@ int __init omap3xxx_hwmod_init(void)
>  
>  	if (h)
>  		r = omap_hwmod_register(h);
> +	if (r < 0)
> +		return r;
> +
> +	/* Register common DSS hwmods later than dss_core */
> +	r = omap_hwmod_register(omap3xxx_dss_hwmods);
>  
>  	return r;
>  }

-- 
Regards,
Igor.
