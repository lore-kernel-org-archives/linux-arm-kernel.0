From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 12 Sep 2013 12:24:52 +0100
Subject: [PATCH 3/4] Add physical count arch timer support for
 clocksource in ARMv7.
In-Reply-To: <1378968687-8200-4-git-send-email-cinifr@gmail.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-4-git-send-email-cinifr@gmail.com>
Message-ID: <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 07:51:26AM +0100, Fan Rong wrote:
> Signed-off-by: Fan Rong <cinifr@gmail.com>
> ---
>  arch/arm/include/asm/arch_timer.h    |   11 +++++++++++
>  drivers/clocksource/Kconfig          |    8 ++++++++
>  drivers/clocksource/arm_arch_timer.c |   10 +++++++++-
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 5665134..24c904a 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -87,6 +87,17 @@ static inline u64 arch_counter_get_cntvct(void)
>  	return cval;
>  }
>  
> +static inline u64 arch_counter_get_cntpct(void)
> +{
> +	u64 cval;
> +
> +	isb();
> +	asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (cval));
> +	return cval;
> +}
> +
> +
> +
>  static inline void arch_counter_set_user_access(void)
>  {
>  	u32 cntkctl;
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 41c6946..a4981d2 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -109,3 +109,11 @@ config VF_PIT_TIMER
>  	bool
>  	help
>  	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
> +menu "Clock Source"
> +
> +config ARM_ARCH_TIMER_USE_PHYCNT
> +	bool "Use Physical Count Timer"
> +	depends on ARM_ARCH_TIMER
> +	help
> +          If bootloader dont set Virtual Offset register,Physical Count Timer is needed to replace Virtual Count Timer.
> +endmenu

This cannot be a compile-time option as above in a multiplatform build.
Other paltforms (e.g. KVM guests) *must* use the virtual counters to get
any semblance of a consistent view of time.

Why can the bootloader not be fixed to set CNTVOFF (or to boot the
kernel in Hyp mode)?

Thanks,
Mark.

> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index fbd9ccd..884e4d1 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -372,7 +372,11 @@ static u64 arch_counter_get_cntvct_mem(void)
>   * to exist on arm64. arm doesn't use this before DT is probed so even
>   * if we don't have the cp15 accessors we won't have a problem.
>   */
> -u64 (*arch_timer_read_counter)(void) = arch_counter_get_cntvct;
> +#ifdef CONFIG_ARM_ARCH_TIMER_USE_PHYCNT
> +	u64 (*arch_timer_read_counter)(void) = arch_counter_get_cntpct;
> +#else
> +	u64 (*arch_timer_read_counter)(void) = arch_counter_get_cntvct;
> +#endif
>  
>  static cycle_t arch_counter_read(struct clocksource *cs)
>  {
> @@ -410,7 +414,11 @@ static void __init arch_counter_register(unsigned type)
>  
>  	/* Register the CP15 based counter if we have one */
>  	if (type & ARCH_CP15_TIMER)
> +#ifdef CONFIG_ARM_ARCH_TIMER_USE_PHYCNT
> +		arch_timer_read_counter = arch_counter_get_cntpct;
> +#else
>  		arch_timer_read_counter = arch_counter_get_cntvct;
> +#endif
>  	else
>  		arch_timer_read_counter = arch_counter_get_cntvct_mem;
>  
> -- 
> 1.7.9.5
> 
> 
