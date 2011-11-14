From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 14 Nov 2011 16:16:48 +0100
Subject: [PATCH 09/12] ARM: at91: make shutdown controler soc independent
In-Reply-To: <1321207952-13556-9-git-send-email-plagnioj@jcrosoft.com>
References: <20111113180954.GD15318@game.jcrosoft.org>
 <1321207952-13556-9-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4EC130E0.7040305@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Beware, this patch can conflict with current initiative to rework the
reboot code.


On 11/13/2011 07:12 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Check my comment below,

otherwise:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/mach-at91/at91cap9.c                 |   10 +---------
>  arch/arm/mach-at91/at91sam9260.c              |   10 +---------
>  arch/arm/mach-at91/at91sam9261.c              |   10 +---------
>  arch/arm/mach-at91/at91sam9263.c              |   10 +---------
>  arch/arm/mach-at91/at91sam9g45.c              |   10 +---------
>  arch/arm/mach-at91/at91sam9rl.c               |   10 +---------
>  arch/arm/mach-at91/generic.h                  |    3 +++
>  arch/arm/mach-at91/include/mach/at91_shdwc.h  |    6 +++---
>  arch/arm/mach-at91/include/mach/at91cap9.h    |    2 +-
>  arch/arm/mach-at91/include/mach/at91sam9260.h |    2 +-
>  arch/arm/mach-at91/include/mach/at91sam9261.h |    2 +-
>  arch/arm/mach-at91/include/mach/at91sam9263.h |    2 +-
>  arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 +-
>  arch/arm/mach-at91/include/mach/at91sam9rl.h  |    2 +-
>  arch/arm/mach-at91/setup.c                    |   15 +++++++++++++++
>  15 files changed, 33 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
> index 1ea9312..652dbe1 100644
> --- a/arch/arm/mach-at91/at91cap9.c
> +++ b/arch/arm/mach-at91/at91cap9.c
> @@ -13,7 +13,6 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/pm.h>
>  
>  #include <asm/irq.h>
>  #include <asm/mach/arch.h>
> @@ -23,7 +22,6 @@
>  #include <mach/at91cap9.h>
>  #include <mach/at91_pmc.h>
>  #include <mach/at91_rstc.h>
> -#include <mach/at91_shdwc.h>
>  
>  #include "soc.h"
>  #include "generic.h"
> @@ -319,12 +317,6 @@ static void at91cap9_reset(void)
>  	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
>  }
>  
> -static void at91cap9_poweroff(void)
> -{
> -	at91_sys_write(AT91_SHDW_CR, AT91_SHDW_KEY | AT91_SHDW_SHDW);
> -}
> -
> -
>  /* --------------------------------------------------------------------
>   *  AT91CAP9 processor initialization
>   * -------------------------------------------------------------------- */
> @@ -336,6 +328,7 @@ static void __init at91cap9_map_io(void)
>  
>  static void __init at91cap9_ioremap_registers(void)
>  {
> +	at91_ioremap_shdwc(AT91CAP9_BASE_SHDWC);
>  	at91sam926x_ioremap_pit(AT91CAP9_BASE_PIT);
>  	at91sam9_ioremap_smc(0, AT91CAP9_BASE_SMC);
>  }
> @@ -343,7 +336,6 @@ static void __init at91cap9_ioremap_registers(void)
>  static void __init at91cap9_initialize(void)
>  {
>  	at91_arch_reset = at91cap9_reset;
> -	pm_power_off = at91cap9_poweroff;
>  	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
>  
>  	/* Register GPIO subsystem */
> diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
> index fc1f734..5a17a23 100644
> --- a/arch/arm/mach-at91/at91sam9260.c
> +++ b/arch/arm/mach-at91/at91sam9260.c
> @@ -11,7 +11,6 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/pm.h>
>  
>  #include <asm/irq.h>
>  #include <asm/mach/arch.h>
> @@ -21,7 +20,6 @@
>  #include <mach/at91sam9260.h>
>  #include <mach/at91_pmc.h>
>  #include <mach/at91_rstc.h>
> -#include <mach/at91_shdwc.h>
>  
>  #include "soc.h"
>  #include "generic.h"
> @@ -287,12 +285,6 @@ static struct at91_gpio_bank at91sam9260_gpio[] = {
>  	}
>  };
>  
> -static void at91sam9260_poweroff(void)
> -{
> -	at91_sys_write(AT91_SHDW_CR, AT91_SHDW_KEY | AT91_SHDW_SHDW);
> -}
> -
> -
>  /* --------------------------------------------------------------------
>   *  AT91SAM9260 processor initialization
>   * -------------------------------------------------------------------- */
> @@ -328,6 +320,7 @@ static void __init at91sam9260_map_io(void)
>  
>  static void __init at91sam9260_ioremap_registers(void)
>  {
> +	at91_ioremap_shdwc(AT91SAM9260_BASE_SHDWC);
>  	at91sam926x_ioremap_pit(AT91SAM9260_BASE_PIT);
>  	at91sam9_ioremap_smc(0, AT91SAM9260_BASE_SMC);
>  }
> @@ -335,7 +328,6 @@ static void __init at91sam9260_ioremap_registers(void)
>  static void __init at91sam9260_initialize(void)
>  {
>  	at91_arch_reset = at91sam9_alt_reset;
> -	pm_power_off = at91sam9260_poweroff;
>  	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
>  			| (1 << AT91SAM9260_ID_IRQ2);
>  
> diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
> index 804181a..80e3e0f 100644
> --- a/arch/arm/mach-at91/at91sam9261.c
> +++ b/arch/arm/mach-at91/at91sam9261.c
> @@ -11,7 +11,6 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/pm.h>
>  
>  #include <asm/irq.h>
>  #include <asm/mach/arch.h>
> @@ -20,7 +19,6 @@
>  #include <mach/at91sam9261.h>
>  #include <mach/at91_pmc.h>
>  #include <mach/at91_rstc.h>
> -#include <mach/at91_shdwc.h>
>  
>  #include "soc.h"
>  #include "generic.h"
> @@ -268,12 +266,6 @@ static struct at91_gpio_bank at91sam9261_gpio[] = {
>  	}
>  };
>  
> -static void at91sam9261_poweroff(void)
> -{
> -	at91_sys_write(AT91_SHDW_CR, AT91_SHDW_KEY | AT91_SHDW_SHDW);
> -}
> -
> -
>  /* --------------------------------------------------------------------
>   *  AT91SAM9261 processor initialization
>   * -------------------------------------------------------------------- */
> @@ -288,6 +280,7 @@ static void __init at91sam9261_map_io(void)
>  
>  static void __init at91sam9261_ioremap_registers(void)
>  {
> +	at91_ioremap_shdwc(AT91SAM9261_BASE_SHDWC);
>  	at91sam926x_ioremap_pit(AT91SAM9261_BASE_PIT);
>  	at91sam9_ioremap_smc(0, AT91SAM9261_BASE_SMC);
>  }
> @@ -295,7 +288,6 @@ static void __init at91sam9261_ioremap_registers(void)
>  static void __init at91sam9261_initialize(void)
>  {
>  	at91_arch_reset = at91sam9_alt_reset;
> -	pm_power_off = at91sam9261_poweroff;
>  	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
>  			| (1 << AT91SAM9261_ID_IRQ2);
>  
> diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
> index b8f4996..2a42b99 100644
> --- a/arch/arm/mach-at91/at91sam9263.c
> +++ b/arch/arm/mach-at91/at91sam9263.c
> @@ -11,7 +11,6 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/pm.h>
>  
>  #include <asm/irq.h>
>  #include <asm/mach/arch.h>
> @@ -19,7 +18,6 @@
>  #include <mach/at91sam9263.h>
>  #include <mach/at91_pmc.h>
>  #include <mach/at91_rstc.h>
> -#include <mach/at91_shdwc.h>
>  
>  #include "soc.h"
>  #include "generic.h"
> @@ -288,12 +286,6 @@ static struct at91_gpio_bank at91sam9263_gpio[] = {
>  	}
>  };
>  
> -static void at91sam9263_poweroff(void)
> -{
> -	at91_sys_write(AT91_SHDW_CR, AT91_SHDW_KEY | AT91_SHDW_SHDW);
> -}
> -
> -
>  /* --------------------------------------------------------------------
>   *  AT91SAM9263 processor initialization
>   * -------------------------------------------------------------------- */
> @@ -306,6 +298,7 @@ static void __init at91sam9263_map_io(void)
>  
>  static void __init at91sam9263_ioremap_registers(void)
>  {
> +	at91_ioremap_shdwc(AT91SAM9263_BASE_SHDWC);
>  	at91sam926x_ioremap_pit(AT91SAM9263_BASE_PIT);
>  	at91sam9_ioremap_smc(0, AT91SAM9263_BASE_SMC0);
>  	at91sam9_ioremap_smc(1, AT91SAM9263_BASE_SMC1);
> @@ -314,7 +307,6 @@ static void __init at91sam9263_ioremap_registers(void)
>  static void __init at91sam9263_initialize(void)
>  {
>  	at91_arch_reset = at91sam9_alt_reset;
> -	pm_power_off = at91sam9263_poweroff;
>  	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
>  
>  	/* Register GPIO subsystem */
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index ce3233f..7fdf964 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -11,7 +11,6 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/pm.h>
>  #include <linux/dma-mapping.h>
>  
>  #include <asm/irq.h>
> @@ -20,7 +19,6 @@
>  #include <mach/at91sam9g45.h>
>  #include <mach/at91_pmc.h>
>  #include <mach/at91_rstc.h>
> -#include <mach/at91_shdwc.h>
>  #include <mach/cpu.h>
>  
>  #include "soc.h"
> @@ -323,12 +321,6 @@ static void at91sam9g45_reset(void)
>  	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
>  }
>  
> -static void at91sam9g45_poweroff(void)
> -{
> -	at91_sys_write(AT91_SHDW_CR, AT91_SHDW_KEY | AT91_SHDW_SHDW);
> -}
> -
> -
>  /* --------------------------------------------------------------------
>   *  AT91SAM9G45 processor initialization
>   * -------------------------------------------------------------------- */
> @@ -341,6 +333,7 @@ static void __init at91sam9g45_map_io(void)
>  
>  static void __init at91sam9g45_ioremap_registers(void)
>  {
> +	at91_ioremap_shdwc(AT91SAM9G45_BASE_SHDWC);
>  	at91sam926x_ioremap_pit(AT91SAM9G45_BASE_PIT);
>  	at91sam9_ioremap_smc(0, AT91SAM9G45_BASE_SMC);
>  }
> @@ -348,7 +341,6 @@ static void __init at91sam9g45_ioremap_registers(void)
>  static void __init at91sam9g45_initialize(void)
>  {
>  	at91_arch_reset = at91sam9g45_reset;
> -	pm_power_off = at91sam9g45_poweroff;
>  	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
>  
>  	/* Register GPIO subsystem */
> diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
> index 1bcccd7..6856bad 100644
> --- a/arch/arm/mach-at91/at91sam9rl.c
> +++ b/arch/arm/mach-at91/at91sam9rl.c
> @@ -10,7 +10,6 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/pm.h>
>  
>  #include <asm/irq.h>
>  #include <asm/mach/arch.h>
> @@ -20,7 +19,6 @@
>  #include <mach/at91sam9rl.h>
>  #include <mach/at91_pmc.h>
>  #include <mach/at91_rstc.h>
> -#include <mach/at91_shdwc.h>
>  
>  #include "soc.h"
>  #include "generic.h"
> @@ -264,12 +262,6 @@ static struct at91_gpio_bank at91sam9rl_gpio[] = {
>  	}
>  };
>  
> -static void at91sam9rl_poweroff(void)
> -{
> -	at91_sys_write(AT91_SHDW_CR, AT91_SHDW_KEY | AT91_SHDW_SHDW);
> -}
> -
> -
>  /* --------------------------------------------------------------------
>   *  AT91SAM9RL processor initialization
>   * -------------------------------------------------------------------- */
> @@ -293,6 +285,7 @@ static void __init at91sam9rl_map_io(void)
>  
>  static void __init at91sam9rl_ioremap_registers(void)
>  {
> +	at91_ioremap_shdwc(AT91SAM9RL_BASE_SHDWC);
>  	at91sam926x_ioremap_pit(AT91SAM9RL_BASE_PIT);
>  	at91sam9_ioremap_smc(0, AT91SAM9RL_BASE_SMC);
>  }
> @@ -300,7 +293,6 @@ static void __init at91sam9rl_ioremap_registers(void)
>  static void __init at91sam9rl_initialize(void)
>  {
>  	at91_arch_reset = at91sam9_alt_reset;
> -	pm_power_off = at91sam9rl_poweroff;
>  	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
>  
>  	/* Register GPIO subsystem */
> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> index 8196ecc..bc17764 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -60,6 +60,9 @@ extern void at91_irq_resume(void);
>  /* reset */
>  extern void at91sam9_alt_reset(void);
>  
> +/* shutdown */
> +extern void at91_ioremap_shdwc(u32 base_addr);
> +
>   /* GPIO */
>  #define AT91RM9200_PQFP		3	/* AT91RM9200 PQFP package has 3 banks */
>  #define AT91RM9200_BGA		4	/* AT91RM9200 BGA package has 4 banks */
> diff --git a/arch/arm/mach-at91/include/mach/at91_shdwc.h b/arch/arm/mach-at91/include/mach/at91_shdwc.h
> index c4ce07e..e434bd0 100644
> --- a/arch/arm/mach-at91/include/mach/at91_shdwc.h
> +++ b/arch/arm/mach-at91/include/mach/at91_shdwc.h
> @@ -16,11 +16,11 @@
>  #ifndef AT91_SHDWC_H
>  #define AT91_SHDWC_H
>  
> -#define AT91_SHDW_CR		(AT91_SHDWC + 0x00)	/* Shut Down Control Register */
> +#define AT91_SHDW_CR		0x00			/* Shut Down Control Register */
>  #define		AT91_SHDW_SHDW		(1    << 0)		/* Shut Down command */
>  #define		AT91_SHDW_KEY		(0xa5 << 24)		/* KEY Password */
>  
> -#define AT91_SHDW_MR		(AT91_SHDWC + 0x04)	/* Shut Down Mode Register */
> +#define AT91_SHDW_MR		0x04			/* Shut Down Mode Register */
>  #define		AT91_SHDW_WKMODE0	(3 << 0)		/* Wake-up 0 Mode Selection */
>  #define			AT91_SHDW_WKMODE0_NONE		0
>  #define			AT91_SHDW_WKMODE0_HIGH		1
> @@ -30,7 +30,7 @@
>  #define			AT91_SHDW_CPTWK0_(x)	((x) << 4)
>  #define		AT91_SHDW_RTTWKEN	(1   << 16)		/* Real Time Timer Wake-up Enable */
>  
> -#define AT91_SHDW_SR		(AT91_SHDWC + 0x08)	/* Shut Down Status Register */
> +#define AT91_SHDW_SR		0x08			/* Shut Down Status Register */
>  #define		AT91_SHDW_WAKEUP0	(1 <<  0)		/* Wake-up 0 Status */
>  #define		AT91_SHDW_RTTWK		(1 << 16)		/* Real-time Timer Wake-up */
>  #define		AT91_SHDW_RTCWK		(1 << 17)		/* Real-time Clock Wake-up [SAM9RL] */
> diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
> index cf8cd56..f2e7c34 100644
> --- a/arch/arm/mach-at91/include/mach/at91cap9.h
> +++ b/arch/arm/mach-at91/include/mach/at91cap9.h
> @@ -86,7 +86,6 @@
>  #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
>  #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
>  #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
> -#define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
>  #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91_GPBR	(cpu_is_at91cap9_revB() ?	\
>  			(0xfffffd50 - AT91_BASE_SYS) :	\
> @@ -100,6 +99,7 @@
>  #define AT91CAP9_BASE_PIOB	0xfffff400
>  #define AT91CAP9_BASE_PIOC	0xfffff600
>  #define AT91CAP9_BASE_PIOD	0xfffff800
> +#define AT91CAP9_BASE_SHDWC	0xfffffd10
>  #define AT91CAP9_BASE_RTT	0xfffffd20
>  #define AT91CAP9_BASE_PIT	0xfffffd30
>  
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
> index 930a7a8..6a13e9d 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9260.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
> @@ -86,7 +86,6 @@
>  #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>  #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
>  #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
> -#define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
>  #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
>  
> @@ -96,6 +95,7 @@
>  #define AT91SAM9260_BASE_PIOA	0xfffff400
>  #define AT91SAM9260_BASE_PIOB	0xfffff600
>  #define AT91SAM9260_BASE_PIOC	0xfffff800
> +#define AT91SAM9260_BASE_SHDWC	0xfffffd10
>  #define AT91SAM9260_BASE_RTT	0xfffffd20
>  #define AT91SAM9260_BASE_PIT	0xfffffd30
>  
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
> index 1ea2d6b..f9b5163 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9261.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
> @@ -71,7 +71,6 @@
>  #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>  #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
>  #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
> -#define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
>  #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
>  
> @@ -79,6 +78,7 @@
>  #define AT91SAM9261_BASE_PIOA	0xfffff400
>  #define AT91SAM9261_BASE_PIOB	0xfffff600
>  #define AT91SAM9261_BASE_PIOC	0xfffff800
> +#define AT91SAM9261_BASE_SHDWC	0xfffffd10
>  #define AT91SAM9261_BASE_RTT	0xfffffd20
>  #define AT91SAM9261_BASE_PIT	0xfffffd30
>  
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
> index 5b6b2b1..e8fb5bd 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9263.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
> @@ -81,7 +81,6 @@
>  #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
>  #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
>  #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
> -#define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
>  #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
>  
> @@ -95,6 +94,7 @@
>  #define AT91SAM9263_BASE_PIOC	0xfffff600
>  #define AT91SAM9263_BASE_PIOD	0xfffff800
>  #define AT91SAM9263_BASE_PIOE	0xfffffa00
> +#define AT91SAM9263_BASE_SHDWC	0xfffffd10
>  #define AT91SAM9263_BASE_RTT0	0xfffffd20
>  #define AT91SAM9263_BASE_PIT	0xfffffd30
>  #define AT91SAM9263_BASE_RTT1	0xfffffd50
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
> index ac051d4..5f3453e 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
> @@ -93,7 +93,6 @@
>  #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
>  #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
>  #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
> -#define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
>  #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
>  #define AT91_RTC	(0xfffffdb0 - AT91_BASE_SYS)
> @@ -106,6 +105,7 @@
>  #define AT91SAM9G45_BASE_PIOC	0xfffff600
>  #define AT91SAM9G45_BASE_PIOD	0xfffff800
>  #define AT91SAM9G45_BASE_PIOE	0xfffffa00
> +#define AT91SAM9G45_BASE_SHDWC	0xfffffd10
>  #define AT91SAM9G45_BASE_RTT	0xfffffd20
>  #define AT91SAM9G45_BASE_PIT	0xfffffd30
>  
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
> index c94e691..e012e69 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
> @@ -75,7 +75,6 @@
>  #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>  #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
>  #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
> -#define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
>  #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91_SCKCR	(0xfffffd50 - AT91_BASE_SYS)
>  #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
> @@ -89,6 +88,7 @@
>  #define AT91SAM9RL_BASE_PIOB	0xfffff600
>  #define AT91SAM9RL_BASE_PIOC	0xfffff800
>  #define AT91SAM9RL_BASE_PIOD	0xfffffa00
> +#define AT91SAM9RL_BASE_SHDWC	0xfffffd10
>  #define AT91SAM9RL_BASE_RTT	0xfffffd20
>  #define AT91SAM9RL_BASE_PIT	0xfffffd30
>  
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index 63b3ac2..8ba2790 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/mm.h>
> +#include <linux/pm.h>
>  
>  #include <asm/mach/map.h>
>  
> @@ -15,6 +16,7 @@
>  #include <mach/cpu.h>
>  #include <mach/at91_dbgu.h>
>  #include <mach/at91_pmc.h>
> +#include <mach/at91_shdwc.h>
>  
>  #include "soc.h"
>  #include "generic.h"
> @@ -285,6 +287,19 @@ void __init at91_map_io(void)
>  		at91_boot_soc.map_io();
>  }
>  
> +static void __iomem *at91_shdwc;
> +
> +static void at91sam9_poweroff(void)
> +{
> +	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW, at91_shdwc + AT91_SHDW_CR);
> +}
> +
> +void at91_ioremap_shdwc(u32 base_addr)
> +{
> +	at91_shdwc = ioremap(base_addr, 16);

Ditto: ioremap error path for debugging.

> +	pm_power_off = at91sam9_poweroff;
> +}
> +
>  void __init at91_initialize(unsigned long main_clock)
>  {
>  	at91_boot_soc.ioremap_registers();


-- 
Nicolas Ferre
