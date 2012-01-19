From: robherring2@gmail.com (Rob Herring)
Date: Thu, 19 Jan 2012 16:47:13 -0600
Subject: [PATCH] integrator: implement sched_clock across all boards
In-Reply-To: <1327008349-8652-1-git-send-email-linus.walleij@linaro.org>
References: <1327008349-8652-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4F189D71.40309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2012 03:25 PM, Linus Walleij wrote:
> Now that we can select a sched_clock at runtime, let's implement
> it for the Integrator AP, default-select the one found in all
> other board it for all plat-versatile boards and make the right
> clock kick in at runtime.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-integrator/Kconfig         |    1 +
>  arch/arm/mach-integrator/integrator_ap.c |    7 +++++++
>  arch/arm/plat-versatile/Kconfig          |    2 +-
>  3 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
> index 350e266..5a6148a 100644
> --- a/arch/arm/mach-integrator/Kconfig
> +++ b/arch/arm/mach-integrator/Kconfig
> @@ -5,6 +5,7 @@ menu "Integrator Options"
>  config ARCH_INTEGRATOR_AP
>  	bool "Support Integrator/AP and Integrator/PP2 platforms"
>  	select CLKSRC_MMIO
> +	select HAVE_SCHED_CLOCK

This can go away with Marc Z's follow-on series as HAVE_SCHED_CLOCK is
always selected for ARM.

>  	select MIGHT_HAVE_PCI
>  	select SERIAL_AMBA_PL010
>  	select SERIAL_AMBA_PL010_CONSOLE
> diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
> index 21a1d6c..4dde28b 100644
> --- a/arch/arm/mach-integrator/integrator_ap.c
> +++ b/arch/arm/mach-integrator/integrator_ap.c
> @@ -42,6 +42,7 @@
>  #include <asm/setup.h>
>  #include <asm/param.h>		/* HZ */
>  #include <asm/mach-types.h>
> +#include <asm/sched_clock.h>
>  
>  #include <mach/lm.h>
>  
> @@ -325,6 +326,11 @@ static void __init ap_init(void)
>  
>  static unsigned long timer_reload;
>  
> +static u32 notrace integrator_read_sched_clock(void)
> +{
> +	return -readl((void __iomem *) TIMER2_VA_BASE + TIMER_VALUE);
> +}
> +
>  static void integrator_clocksource_init(unsigned long inrate)
>  {
>  	void __iomem *base = (void __iomem *)TIMER2_VA_BASE;
> @@ -341,6 +347,7 @@ static void integrator_clocksource_init(unsigned long inrate)
>  
>  	clocksource_mmio_init(base + TIMER_VALUE, "timer2",
>  			rate, 200, 16, clocksource_mmio_readl_down);
> +	setup_sched_clock(integrator_read_sched_clock, 16, rate);
>  }
>  
>  static void __iomem * const clkevt_base = (void __iomem *)TIMER1_VA_BASE;
> diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
> index 52353be..aa63f38 100644
> --- a/arch/arm/plat-versatile/Kconfig
> +++ b/arch/arm/plat-versatile/Kconfig
> @@ -11,7 +11,7 @@ config PLAT_VERSATILE_LEDS
>  	depends on ARCH_REALVIEW || ARCH_VERSATILE
>  
>  config PLAT_VERSATILE_SCHED_CLOCK
> -	def_bool y if !ARCH_INTEGRATOR_AP
> +	def_bool y
>  	select HAVE_SCHED_CLOCK
>  
>  endif
