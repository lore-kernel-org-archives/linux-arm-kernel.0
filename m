From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 19 Jan 2012 08:53:54 +1100
Subject: [PATCH 3/4] at91 : remove wait_for_interrupt definition
In-Reply-To: <1326843620-13148-4-git-send-email-daniel.lezcano@linaro.org>
References: <1326843620-13148-1-git-send-email-daniel.lezcano@linaro.org>
 <1326843620-13148-4-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <4F173F72.3050506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/12 10:40, Daniel Lezcano wrote:

> All the "wait_for_interrupt" definition are aliases to cpu_do_idle.
> Only the rm9200 has an asm routine to switch to wfi. But the cpu_do_idle
> for this platform has exactly the same asm routine.
> 
> arch/arm/mm/proc-arm920.S
> ...
> ENTRY(cpu_arm920_do_idle)
>         mcr     p15, 0, r0, c7, c0, 4           @ Wait for interrupt
> ...
> 
> Then it is safe to invoke cpu_do_idle for this platform. As all the
> wait_for_interrupts are definition for cpu_do_idle, let's remove it
> and replace its invokation by cpu_do_idle.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>


This patch looks like an improvement. Though, because you are removing
all of the definitions of wait_for_interrupt_enable in this patch, it
doesn't seem worth fixing the coding style of them in patch 1 of this
series.

Reviewed-by: Ryan Mallon <rmallon@gmail.com>

> ---
>  arch/arm/mach-at91/pm.c |    2 +-
>  arch/arm/mach-at91/pm.h |   12 ------------
>  2 files changed, 1 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 62ad955..acf32c7 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -272,7 +272,7 @@ static int at91_pm_enter(suspend_state_t state)
>  					: /* no input */
>  					: "r0");
>  			saved_lpr = sdram_selfrefresh_enable();
> -			wait_for_interrupt_enable();
> +			cpu_do_idle();
>  			sdram_selfrefresh_disable(saved_lpr);
>  			break;
>  
> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
> index 325ef76..624c99c 100644
> --- a/arch/arm/mach-at91/pm.h
> +++ b/arch/arm/mach-at91/pm.h
> @@ -36,10 +36,6 @@ static inline u32 sdram_selfrefresh_enable(void)
>  #define sdram_selfrefresh_disable(saved_lpr) \
>  	at91_sys_write(AT91_SDRAMC_LPR, saved_lpr)
>  
> -#define wait_for_interrupt_enable() \
> -	asm volatile ("mcr p15, 0, %0, c7, c0, 4" \
> -		      : : "r" (0))
> -
>  #elif defined(CONFIG_ARCH_AT91CAP9)
>  #include <mach/at91cap9_ddrsdr.h>
>  
> @@ -58,9 +54,6 @@ static inline u32 sdram_selfrefresh_enable(void)
>  #define sdram_selfrefresh_disable(saved_lpr) \
>  	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr)
>  
> -#define wait_for_interrupt_enable() \
> -	cpu_do_idle()
> -
>  #elif defined(CONFIG_ARCH_AT91SAM9G45)
>  #include <mach/at91sam9_ddrsdr.h>
>  
> @@ -97,8 +90,6 @@ static inline u32 sdram_selfrefresh_enable(void)
>  		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1); \
>  	} while (0)
>  
> -#define wait_for_interrupt_enable()		cpu_do_idle()
> -
>  #else
>  #include <mach/at91sam9_sdramc.h>
>  
> @@ -125,9 +116,6 @@ static inline u32 sdram_selfrefresh_enable(void)
>  #define sdram_selfrefresh_disable(saved_lpr) \
>  	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr)
>  
> -#define wait_for_interrupt_enable() \
> -	cpu_do_idle()
> -
>  #endif
>  
>  #endif
