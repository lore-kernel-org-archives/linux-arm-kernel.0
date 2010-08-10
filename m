From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 10 Aug 2010 10:42:24 +0530
Subject: [PATCH 2/5] SPEAR3xx: Rename register/irq defines to remove naming
	conflicts
In-Reply-To: <1275717955-14545-3-git-send-email-ryan@bluewatersys.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
	<1275717955-14545-3-git-send-email-ryan@bluewatersys.com>
Message-ID: <4C60DFB8.20608@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Ryan,

Sorry for testing this set of patches so late. Patch is working fine.
I have few comments:

On 6/5/2010 11:35 AM, Ryan Mallon wrote:
> Prefix register and irq defintions to remove naming conflicts between
> the three SPEAr3xx platforms.
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---
>  arch/arm/mach-spear3xx/include/mach/generic.h  |    4 +-
>  arch/arm/mach-spear3xx/include/mach/irqs.h     |  195 ++++++++++++------------
>  arch/arm/mach-spear3xx/include/mach/spear300.h |   26 ++--
>  arch/arm/mach-spear3xx/include/mach/spear310.h |   44 +++---
>  arch/arm/mach-spear3xx/include/mach/spear320.h |   50 +++---
>  arch/arm/mach-spear3xx/spear300.c              |   65 ++++----
>  arch/arm/mach-spear3xx/spear310.c              |   92 ++++++------
>  arch/arm/mach-spear3xx/spear320.c              |  134 ++++++++--------
>  arch/arm/mach-spear3xx/spear3xx.c              |    4 +-
>  9 files changed, 308 insertions(+), 306 deletions(-)
> 
> diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
> index af7e02c..48dfb9c 100644
> --- a/arch/arm/mach-spear3xx/include/mach/generic.h
> +++ b/arch/arm/mach-spear3xx/include/mach/generic.h
> @@ -27,8 +27,8 @@
>   * Following GPT channels will be used as clock source and clockevent
>   */
>  #define SPEAR_GPT0_BASE		SPEAR3XX_ML1_TMR_BASE
> -#define SPEAR_GPT0_CHAN0_IRQ	IRQ_CPU_GPT1_1
> -#define SPEAR_GPT0_CHAN1_IRQ	IRQ_CPU_GPT1_2
> +#define SPEAR_GPT0_CHAN0_IRQ	SPEAR3XX_IRQ_CPU_GPT1_1
> +#define SPEAR_GPT0_CHAN1_IRQ	SPEAR3XX_IRQ_CPU_GPT1_2
>  
>  /* Add spear3xx family device structure declarations here */
>  extern struct amba_device gpio_device;
> diff --git a/arch/arm/mach-spear3xx/include/mach/irqs.h b/arch/arm/mach-spear3xx/include/mach/irqs.h
> index 7f940b8..668bf72 100644
> --- a/arch/arm/mach-spear3xx/include/mach/irqs.h
> +++ b/arch/arm/mach-spear3xx/include/mach/irqs.h
> @@ -15,138 +15,141 @@
>  #define __MACH_IRQS_H
>  

[snip...]

> -#define SPEAR_GPIO_INT_END			(SPEAR_GPIO1_INT_BASE + 8)
> +//#define SPEAR_GPIO_INT_END			(SPEAR_GPIO1_INT_BASE + 8)

wrong comment sytle. Also we can move above definition with rest of GPIO
virtual irq no.s.

>  

[snip...]

>  
> +/*
> + * GPIO pins virtual irqs
> + * Use the lowest number for the GPIO virtual IRQs base on which subarchs
> + * we have compiled in
> + */
> +#if defined(CONFIG_MACH_SPEAR310)
> +#define SPEAR_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 18)
> +#elif defined(CONFIG_MACH_SPEAR320)
> +#define SPEAR_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 17)
> +#else
> +#define SPEAR_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 9)
>  #endif

If we have all three machines enabled, then SPEAR_GPIO_INT_BASE will start from
VIRQ_START + 18, which will work for spear310 and spear320, but will not be
correct as we will skip 9 irq no.s.

It would be better to have three different base addresses
SPEAR300_GPIO_INT_BASE, etc.


viresh.
