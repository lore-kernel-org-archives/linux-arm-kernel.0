From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 06 May 2011 14:02:45 +0900
Subject: [PATCH] ARM: SAMSUNG: Add support for pre-sleep/post-restore gpio
	control
In-Reply-To: <1303925654-27715-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1303925654-27715-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <00fc01cc0baa$d7d94cb0$878be610$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> From: Ben Dooks <ben-linux@fluff.org>
> 
> Add a callback so that per-arch can do pre-sleep and post-resume
> gpio configuration so that for the S3C64XX, the GPIO configuration
> is restored before the sleep mode is cleared.
> 
> For the S3C64XX case, it means that the GPIOs get set back to normal
> operation after the restore code puts the original configurations
> back in after the
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c2410/include/mach/pm-core.h |    3 +++
>  arch/arm/mach-s3c64xx/include/mach/pm-core.h |   17 +++++++++++++++++
>  arch/arm/mach-s5pv210/include/mach/pm-core.h |    3 +++
>  arch/arm/plat-samsung/pm.c                   |    2 ++
>  4 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/include/mach/pm-core.h b/arch/arm/mach-
> s3c2410/include/mach/pm-core.h
> index 70a83b2..45eea52 100644
> --- a/arch/arm/mach-s3c2410/include/mach/pm-core.h
> +++ b/arch/arm/mach-s3c2410/include/mach/pm-core.h
> @@ -62,3 +62,6 @@ static inline void s3c_pm_arch_update_uart(void __iomem
> *regs,
>  					   struct pm_uart_save *save)
>  {
>  }
> +
> +static inline void s3c_pm_restored_gpios(void) { }
> +static inline void s3c_pm_saved_gpios(void) { }
> diff --git a/arch/arm/mach-s3c64xx/include/mach/pm-core.h b/arch/arm/mach-
> s3c64xx/include/mach/pm-core.h
> index 4ed0f58..38659be 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/pm-core.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
> @@ -96,3 +96,20 @@ static inline void s3c_pm_arch_update_uart(void __iomem
> *regs,
>  		save->ucon = new_ucon;
>  	}
>  }
> +
> +static inline void s3c_pm_restored_gpios(void)
> +{
> +	/* ensure sleep mode has been cleared from the system */
> +
> +	__raw_writel(0, S3C64XX_SLPEN);
> +}
> +
> +static inline void s3c_pm_saved_gpios(void)
> +{
> +	/* turn on the sleep mode and keep it there, as it seems that during
> +	 * suspend the xCON registers get re-set and thus you can end up
with
> +	 * problems between going to sleep and resuming.
> +	 */
> +
> +	__raw_writel(S3C64XX_SLPEN_USE_xSLP, S3C64XX_SLPEN);
> +}
> diff --git a/arch/arm/mach-s5pv210/include/mach/pm-core.h b/arch/arm/mach-
> s5pv210/include/mach/pm-core.h
> index e8d394f..3e22109 100644
> --- a/arch/arm/mach-s5pv210/include/mach/pm-core.h
> +++ b/arch/arm/mach-s5pv210/include/mach/pm-core.h
> @@ -41,3 +41,6 @@ static inline void s3c_pm_arch_update_uart(void __iomem
> *regs,
>  {
>  	/* nothing here yet */
>  }
> +
> +static inline void s3c_pm_restored_gpios(void) { }
> +static inline void s3c_pm_saved_gpios(void) { }
> diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
> index 5c0a440..4f9a951 100644
> --- a/arch/arm/plat-samsung/pm.c
> +++ b/arch/arm/plat-samsung/pm.c
> @@ -268,6 +268,7 @@ static int s3c_pm_enter(suspend_state_t state)
>  	/* save all necessary core registers not covered by the drivers */
> 
>  	s3c_pm_save_gpios();
> +	s3c_pm_saved_gpios();
>  	s3c_pm_save_uarts();
>  	s3c_pm_save_core();
> 
> @@ -309,6 +310,7 @@ static int s3c_pm_enter(suspend_state_t state)
>  	s3c_pm_restore_core();
>  	s3c_pm_restore_uarts();
>  	s3c_pm_restore_gpios();
> +	s3c_pm_restored_gpios();
> 
>  	s3c_pm_debug_init();
> 
> --
> 1.7.4.1

Ok, will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
