From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Aug 2010 16:12:49 +0300
Subject: [PATCH 2/4] omap4: l2x0: Override the default l2x0_disable
In-Reply-To: <1280598348-4721-1-git-send-email-santosh.shilimkar@ti.com>
References: <1280598348-4721-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20100802131246.GM12293@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100731 20:38]:
> The machine_kexec() calls outer_disable which can crash on OMAP4
> becasue of trustzone restrictions.
> 
> This patch overrides the default l2x0_disable with a OMAP4
> specific implementation taking care of trustzone

Do you need different handling on GP omaps compared to HS omaps?

Tony
 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap4-common.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 13dc979..b557cc2 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -44,6 +44,13 @@ void __init gic_init_irq(void)
>  }
>  
>  #ifdef CONFIG_CACHE_L2X0
> +
> +static void omap4_l2x0_disable(void)
> +{
> +	/* Disable PL310 L2 Cache controller */
> +	omap_smc1(0x102, 0x0);
> +}
> +
>  static int __init omap_l2_cache_init(void)
>  {
>  	/*
> @@ -66,6 +73,12 @@ static int __init omap_l2_cache_init(void)
>  	 */
>  	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
>  
> +	/*
> +	 * Override default outer_cache.disable with a OMAP4
> +	 * specific one
> +	*/
> +	outer_cache.disable = omap4_l2x0_disable;
> +
>  	return 0;
>  }
>  early_initcall(omap_l2_cache_init);
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
