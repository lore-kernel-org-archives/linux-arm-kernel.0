From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 9 Jul 2010 09:18:13 +0200
Subject: [PATCH v2 5/5] colibri-pxa3xx: add touchscreen support
In-Reply-To: <201007082249.59852.pieterg@gmx.com>
References: <201007082249.59852.pieterg@gmx.com>
Message-ID: <20100709071813.GT17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 08, 2010 at 10:49:59PM +0200, pieterg wrote:
> Signed-off-by: pieter <p.grimmerink@inepro.com>

Acked-by: Daniel Mack <daniel@caiaq.de>


> ---
>  arch/arm/mach-pxa/colibri-pxa300.c       |    2 +
>  arch/arm/mach-pxa/colibri-pxa320.c       |    1 +
>  arch/arm/mach-pxa/colibri-pxa3xx.c       |   31 
> ++++++++++++++++++++++++++++++
>  arch/arm/mach-pxa/include/mach/colibri.h |    6 +++++
>  4 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/colibri-pxa300.c 
> b/arch/arm/mach-pxa/colibri-pxa300.c
> index 27f403d..3e50466 100644
> --- a/arch/arm/mach-pxa/colibri-pxa300.c
> +++ b/arch/arm/mach-pxa/colibri-pxa300.c
> @@ -229,6 +229,8 @@ void __init colibri_pxa300_init(void)
>  				mfp_to_gpio(MFP_PIN_GPIO13));
>  	colibri_pxa300_init_uart();
>  	colibri_pxa300_init_i2c();
> +	if (cpu_is_pxa310())
> +		colibri_pxa3xx_init_touchscreen();
>  }
>  
>  MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
> diff --git a/arch/arm/mach-pxa/colibri-pxa320.c 
> b/arch/arm/mach-pxa/colibri-pxa320.c
> index 0755087..43fadf6 100644
> --- a/arch/arm/mach-pxa/colibri-pxa320.c
> +++ b/arch/arm/mach-pxa/colibri-pxa320.c
> @@ -229,6 +229,7 @@ void __init colibri_pxa320_init(void)
>  				mfp_to_gpio(MFP_PIN_GPIO28));
>  	colibri_pxa320_init_uart();
>  	colibri_pxa320_init_i2c();
> +	colibri_pxa3xx_init_touchscreen();
>  }
>  
>  MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
> diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c 
> b/arch/arm/mach-pxa/colibri-pxa3xx.c
> index 199afa2..097aef5 100644
> --- a/arch/arm/mach-pxa/colibri-pxa3xx.c
> +++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
> @@ -198,3 +198,34 @@ void __init colibri_pxa3xx_init_nand(void)
>  }
>  #endif
>  
> +#if defined(CONFIG_INPUT_TOUCHSCREEN)
> +
> +#if defined(CONFIG_TOUCHSCREEN_WM97XX) || \
> +	defined(CONFIG_TOUCHSCREEN_WM97XX_MODULE)
> +static struct platform_device colibri_ts_wm97xx_device = {
> +	.name	= "wm97xx-ts",
> +	.id	= -1,
> +};
> +#endif
> +
> +#if defined(CONFIG_TOUCHSCREEN_UCB1400) || \
> +	defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
> +static struct platform_device colibri_ts_ucb1400_device = {
> +	.name	= "ucb1400_core",
> +	.id	= -1,
> +};
> +#endif
> +
> +void __init colibri_pxa3xx_init_touchscreen(void)
> +{
> +#if defined(CONFIG_TOUCHSCREEN_WM97XX) || \
> +	defined(CONFIG_TOUCHSCREEN_WM97XX_MODULE)
> +	platform_device_register(&colibri_ts_wm97xx_device);
> +#endif
> +#if defined(CONFIG_TOUCHSCREEN_UCB1400) || \
> +	defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
> +	platform_device_register(&colibri_ts_ucb1400_device);
> +#endif
> +}
> +
> +#endif
> diff --git a/arch/arm/mach-pxa/include/mach/colibri.h 
> b/arch/arm/mach-pxa/include/mach/colibri.h
> index 5f2ba8d..299dab9 100644
> --- a/arch/arm/mach-pxa/include/mach/colibri.h
> +++ b/arch/arm/mach-pxa/include/mach/colibri.h
> @@ -30,6 +30,12 @@ extern void colibri_pxa3xx_init_nand(void);
>  static inline void colibri_pxa3xx_init_nand(void) {}
>  #endif
>  
> +#if defined(CONFIG_INPUT_TOUCHSCREEN)
> +extern void colibri_pxa3xx_init_touchscreen(void);
> +#else
> +static inline void colibri_pxa3xx_init_touchscreen(void) {}
> +#endif
> +
>  /* physical memory regions */
>  #define COLIBRI_SDRAM_BASE	0xa0000000      /* SDRAM region */
>  
> -- 
> 1.6.5.rc1.44.ga1675
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
