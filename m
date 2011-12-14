From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 13 Dec 2011 20:04:11 -0700 (MST)
Subject: [PATCHv11 2/8] ARM: OMAP2+: hwmod: Add API to check IO PAD wakeup
 status
In-Reply-To: <1323713733-13115-3-git-send-email-t-kristo@ti.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-3-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1112132002070.12046@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero

looking at this patch:

On Mon, 12 Dec 2011, Tero Kristo wrote:

> From: R, Govindraj <govindraj.raja@ti.com>
> 
> Add API to determine IO-PAD wakeup event status for a given
> hwmod dynamic_mux pad.
> 
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

It seems that your last patch drops the following code that this patch 
adds:

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 8d37d83..d7f4623 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2721,3 +2721,10 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
>  
>  	return 0;
>  }
> +
> +int omap_hwmod_pad_get_wakeup_status(struct omap_hwmod *oh)
> +{
> +	if (oh && oh->mux)
> +		return omap_hwmod_mux_get_wake_status(oh->mux);
> +	return -EINVAL;
> +}
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 8b372ed..1b81dfb 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -604,6 +604,7 @@ int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>  
>  int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
>  
> +int omap_hwmod_pad_get_wakeup_status(struct omap_hwmod *oh);
>  /*
>   * Chip variant-specific hwmod init routines - XXX should be converted
>   * to use initcalls once the initial boot ordering is straightened out

It's best in these circumstances to modify this patch not to add the code 
in the first place.  Otherwise this creates needless churn which plenty of 
people are quite sensitized to.  So, dropping these from patch 2.


- Paul
