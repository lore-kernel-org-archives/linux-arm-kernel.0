From: robherring2@gmail.com (Rob Herring)
Date: Wed, 04 Jan 2012 11:31:05 -0600
Subject: [PATCH 1/2][RFC] at91 : move pm.h header to include/mach
In-Reply-To: <1325696147-14058-1-git-send-email-daniel.lezcano@linaro.org>
References: <1325696147-14058-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <4F048CD9.1050601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2012 10:55 AM, Daniel Lezcano wrote:
> Move the location of the pm.h header file to the include directory,
> so it can be included from another place from the current one.
> 
> That will allow the next patch which moves the cpuidle code to the
> drivers/cpuidle directory.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-at91/cpuidle.c         |    2 +-
>  arch/arm/mach-at91/include/mach/pm.h |  107 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/pm.c              |    2 +-
>  arch/arm/mach-at91/pm.h              |  107 ----------------------------------

You should use -M git option when doing moves to avoid the large diff.

This header should probably be named something more specific like
at91_pm.h or at91_sdram.h. This will be needed to avoid name collisions
with mach headers on a single kernel binary.

Rob

>  4 files changed, 109 insertions(+), 109 deletions(-)
>  create mode 100644 arch/arm/mach-at91/include/mach/pm.h
>  delete mode 100644 arch/arm/mach-at91/pm.h
> 
> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
> index a851e6c..f658154 100644
> --- a/arch/arm/mach-at91/cpuidle.c
> +++ b/arch/arm/mach-at91/cpuidle.c
> @@ -21,7 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/export.h>
>  
> -#include "pm.h"
> +#include <mach/pm.h>
>  
>  #define AT91_MAX_STATES	2
>  
> diff --git a/arch/arm/mach-at91/include/mach/pm.h b/arch/arm/mach-at91/include/mach/pm.h
> new file mode 100644
> index 0000000..ce9a206
> --- /dev/null
> +++ b/arch/arm/mach-at91/include/mach/pm.h
> @@ -0,0 +1,107 @@
> +#ifdef CONFIG_ARCH_AT91RM9200
> +#include <mach/at91rm9200_mc.h>
> +
> +/*
> + * The AT91RM9200 goes into self-refresh mode with this command, and will
> + * terminate self-refresh automatically on the next SDRAM access.
> + *
> + * Self-refresh mode is exited as soon as a memory access is made, but we don't
> + * know for sure when that happens. However, we need to restore the low-power
> + * mode if it was enabled before going idle. Restoring low-power mode while
> + * still in self-refresh is "not recommended", but seems to work.
> + */
> +
> +static inline u32 sdram_selfrefresh_enable(void)
> +{
> +	u32 saved_lpr = at91_sys_read(AT91_SDRAMC_LPR);
> +
> +	at91_sys_write(AT91_SDRAMC_LPR, 0);
> +	at91_sys_write(AT91_SDRAMC_SRR, 1);
> +	return saved_lpr;
> +}
> +
> +#define sdram_selfrefresh_disable(saved_lpr)	at91_sys_write(AT91_SDRAMC_LPR, saved_lpr)
> +#define wait_for_interrupt_enable()		asm volatile ("mcr p15, 0, %0, c7, c0, 4" \
> +								: : "r" (0))
> +
> +#elif defined(CONFIG_ARCH_AT91CAP9)
> +#include <mach/at91cap9_ddrsdr.h>
> +
> +
> +static inline u32 sdram_selfrefresh_enable(void)
> +{
> +	u32 saved_lpr, lpr;
> +
> +	saved_lpr = at91_ramc_read(0, AT91_DDRSDRC_LPR);
> +
> +	lpr = saved_lpr & ~AT91_DDRSDRC_LPCB;
> +	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr | AT91_DDRSDRC_LPCB_SELF_REFRESH);
> +	return saved_lpr;
> +}
> +
> +#define sdram_selfrefresh_disable(saved_lpr)	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr)
> +#define wait_for_interrupt_enable()		cpu_do_idle()
> +
> +#elif defined(CONFIG_ARCH_AT91SAM9G45)
> +#include <mach/at91sam9_ddrsdr.h>
> +
> +/* We manage both DDRAM/SDRAM controllers, we need more than one value to
> + * remember.
> + */
> +static u32 saved_lpr1;
> +
> +static inline u32 sdram_selfrefresh_enable(void)
> +{
> +	/* Those tow values allow us to delay self-refresh activation
> +	 * to the maximum. */
> +	u32 lpr0, lpr1;
> +	u32 saved_lpr0;
> +
> +	saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
> +	lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
> +	lpr1 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
> +
> +	saved_lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
> +	lpr0 = saved_lpr0 & ~AT91_DDRSDRC_LPCB;
> +	lpr0 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
> +
> +	/* self-refresh mode now */
> +	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0);
> +	at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
> +
> +	return saved_lpr0;
> +}
> +
> +#define sdram_selfrefresh_disable(saved_lpr0)	\
> +	do { \
> +		at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0); \
> +		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1); \
> +	} while (0)
> +#define wait_for_interrupt_enable()		cpu_do_idle()
> +
> +#else
> +#include <mach/at91sam9_sdramc.h>
> +
> +#ifdef CONFIG_ARCH_AT91SAM9263
> +/*
> + * FIXME either or both the SDRAM controllers (EB0, EB1) might be in use;
> + * handle those cases both here and in the Suspend-To-RAM support.
> + */
> +#warning Assuming EB1 SDRAM controller is *NOT* used
> +#endif
> +
> +static inline u32 sdram_selfrefresh_enable(void)
> +{
> +	u32 saved_lpr, lpr;
> +
> +	saved_lpr = at91_ramc_read(0, AT91_SDRAMC_LPR);
> +
> +	lpr = saved_lpr & ~AT91_SDRAMC_LPCB;
> +	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr | AT91_SDRAMC_LPCB_SELF_REFRESH);
> +	return saved_lpr;
> +}
> +
> +#define sdram_selfrefresh_disable(saved_lpr)	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr)
> +#define wait_for_interrupt_enable()		cpu_do_idle()
> +
> +#endif
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 62ad955..7efac37 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -27,9 +27,9 @@
>  
>  #include <mach/at91_pmc.h>
>  #include <mach/cpu.h>
> +#include <mach/pm.h>
>  
>  #include "generic.h"
> -#include "pm.h"
>  
>  /*
>   * Show the reason for the previous system reset.
> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
> deleted file mode 100644
> index ce9a206..0000000
> --- a/arch/arm/mach-at91/pm.h
> +++ /dev/null
> @@ -1,107 +0,0 @@
> -#ifdef CONFIG_ARCH_AT91RM9200
> -#include <mach/at91rm9200_mc.h>
> -
> -/*
> - * The AT91RM9200 goes into self-refresh mode with this command, and will
> - * terminate self-refresh automatically on the next SDRAM access.
> - *
> - * Self-refresh mode is exited as soon as a memory access is made, but we don't
> - * know for sure when that happens. However, we need to restore the low-power
> - * mode if it was enabled before going idle. Restoring low-power mode while
> - * still in self-refresh is "not recommended", but seems to work.
> - */
> -
> -static inline u32 sdram_selfrefresh_enable(void)
> -{
> -	u32 saved_lpr = at91_sys_read(AT91_SDRAMC_LPR);
> -
> -	at91_sys_write(AT91_SDRAMC_LPR, 0);
> -	at91_sys_write(AT91_SDRAMC_SRR, 1);
> -	return saved_lpr;
> -}
> -
> -#define sdram_selfrefresh_disable(saved_lpr)	at91_sys_write(AT91_SDRAMC_LPR, saved_lpr)
> -#define wait_for_interrupt_enable()		asm volatile ("mcr p15, 0, %0, c7, c0, 4" \
> -								: : "r" (0))
> -
> -#elif defined(CONFIG_ARCH_AT91CAP9)
> -#include <mach/at91cap9_ddrsdr.h>
> -
> -
> -static inline u32 sdram_selfrefresh_enable(void)
> -{
> -	u32 saved_lpr, lpr;
> -
> -	saved_lpr = at91_ramc_read(0, AT91_DDRSDRC_LPR);
> -
> -	lpr = saved_lpr & ~AT91_DDRSDRC_LPCB;
> -	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr | AT91_DDRSDRC_LPCB_SELF_REFRESH);
> -	return saved_lpr;
> -}
> -
> -#define sdram_selfrefresh_disable(saved_lpr)	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr)
> -#define wait_for_interrupt_enable()		cpu_do_idle()
> -
> -#elif defined(CONFIG_ARCH_AT91SAM9G45)
> -#include <mach/at91sam9_ddrsdr.h>
> -
> -/* We manage both DDRAM/SDRAM controllers, we need more than one value to
> - * remember.
> - */
> -static u32 saved_lpr1;
> -
> -static inline u32 sdram_selfrefresh_enable(void)
> -{
> -	/* Those tow values allow us to delay self-refresh activation
> -	 * to the maximum. */
> -	u32 lpr0, lpr1;
> -	u32 saved_lpr0;
> -
> -	saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
> -	lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
> -	lpr1 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
> -
> -	saved_lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
> -	lpr0 = saved_lpr0 & ~AT91_DDRSDRC_LPCB;
> -	lpr0 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
> -
> -	/* self-refresh mode now */
> -	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0);
> -	at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
> -
> -	return saved_lpr0;
> -}
> -
> -#define sdram_selfrefresh_disable(saved_lpr0)	\
> -	do { \
> -		at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0); \
> -		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1); \
> -	} while (0)
> -#define wait_for_interrupt_enable()		cpu_do_idle()
> -
> -#else
> -#include <mach/at91sam9_sdramc.h>
> -
> -#ifdef CONFIG_ARCH_AT91SAM9263
> -/*
> - * FIXME either or both the SDRAM controllers (EB0, EB1) might be in use;
> - * handle those cases both here and in the Suspend-To-RAM support.
> - */
> -#warning Assuming EB1 SDRAM controller is *NOT* used
> -#endif
> -
> -static inline u32 sdram_selfrefresh_enable(void)
> -{
> -	u32 saved_lpr, lpr;
> -
> -	saved_lpr = at91_ramc_read(0, AT91_SDRAMC_LPR);
> -
> -	lpr = saved_lpr & ~AT91_SDRAMC_LPCB;
> -	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr | AT91_SDRAMC_LPCB_SELF_REFRESH);
> -	return saved_lpr;
> -}
> -
> -#define sdram_selfrefresh_disable(saved_lpr)	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr)
> -#define wait_for_interrupt_enable()		cpu_do_idle()
> -
> -#endif
