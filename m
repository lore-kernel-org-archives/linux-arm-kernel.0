From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 01 Oct 2013 19:37:43 +0200
Subject: [PATCH 5/6] ARM: EXYNOS: Minor fixes to enable EXYNOS5410 support
In-Reply-To: <1380644227-12244-6-git-send-email-v.tyrtov@samsung.com>
References: <1380644227-12244-1-git-send-email-v.tyrtov@samsung.com>
 <1380644227-12244-6-git-send-email-v.tyrtov@samsung.com>
Message-ID: <2138155.cI0KCUKyhh@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Tuesday, October 01, 2013 08:17:06 PM Vyacheslav Tyrtov wrote:
> From: Tarek Dakhran <t.dakhran@samsung.com>
> 
> Configure ARM_NR_BANKS as 16 for EXYNOS SoC.
> Enable cci_control_port_by_index for ACE_PORT.
> Add additional irqs for Exynos MCT.
> Set irq base as 256 for EXYNOS5410 SoC.

It would be better if these changes were separate patches as they touch
different code areas.

> Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
> ---
>  arch/arm/Kconfig                  |  2 +-
>  drivers/bus/arm-cci.c             |  7 +++++++
>  drivers/clocksource/exynos_mct.c  |  8 +++++++-
>  drivers/irqchip/exynos-combiner.c | 12 +++++++++++-
>  4 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3f7714d..7f88896 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1080,7 +1080,7 @@ source arch/arm/mm/Kconfig
>  
>  config ARM_NR_BANKS
>  	int
> -	default 16 if ARCH_EP93XX
> +	default 16 if ARCH_EP93XX || ARCH_EXYNOS
>  	default 8
>  
>  config IWMMXT
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 2009266..f2f5df1 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -363,8 +363,15 @@ int notrace __cci_control_port_by_index(u32 port, bool enable)
>  	 * interface (ie cci_disable_port_by_cpu(); control by general purpose
>  	 * indexing is therefore disabled for ACE ports.
>  	 */
> +
> +	/*
> +	 * Using this way to enable cci_port on EXYNOS5410 SoC
> +	 */
> +
> +#ifndef CONFIG_SOC_EXYNOS5410
>  	if (ports[port].type == ACE_PORT)
>  		return -EPERM;
> +#endif

This won't work for multiplatform kernels, please detect EXYNOS5410
at runtime using the device tree info.

>  	cci_port_control(port, enable);
>  	return 0;
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 5b34768..33884d7 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -71,6 +71,12 @@ enum {
>  	MCT_L1_IRQ,
>  	MCT_L2_IRQ,
>  	MCT_L3_IRQ,
> +#ifdef CONFIG_ARM_CCI
> +	MCT_L4_IRQ,
> +	MCT_L5_IRQ,
> +	MCT_L6_IRQ,
> +	MCT_L7_IRQ,
> +#endif
>  	MCT_NR_IRQS,
>  };
>  
> @@ -406,7 +412,7 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
>  	mevt = container_of(evt, struct mct_clock_event_device, evt);
>  
>  	mevt->base = EXYNOS4_MCT_L_BASE(cpu);
> -	sprintf(mevt->name, "mct_tick%d", cpu);
> +	snprintf(mevt->name, 10, "mct_tick%d", cpu);

What is the rationale behind this change?

Also there is nothing about it in the patch description.

>  	evt->name = mevt->name;
>  	evt->cpumask = cpumask_of(cpu);
> diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
> index 868ed40..2e056fc 100644
> --- a/drivers/irqchip/exynos-combiner.c
> +++ b/drivers/irqchip/exynos-combiner.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <asm/mach/irq.h>
> +#include <plat/cpu.h>
>  
>  #include "irqchip.h"
>  
> @@ -66,6 +67,11 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
>  	struct irq_chip *chip = irq_get_chip(irq);
>  	unsigned int cascade_irq, combiner_irq;
>  	unsigned long status;

Please add a newline here.

> +	if (unlikely(!chip || !chip_data)) {
> +		printk_once(KERN_ALERT "%s: Chip not found for IRQ %d\n"
> +				, __func__, irq);
> +		return;
> +	}

There is nothing about this change in the patch description.

>  	chained_irq_enter(chip, desc);
>  
> @@ -226,7 +232,11 @@ static int __init combiner_of_init(struct device_node *np,
>  	 * get their IRQ from DT, remove this in order to get dynamic
>  	 * allocation.
>  	 */
> -	irq_base = 160;
> +
> +	if (soc_is_exynos5410())
> +		irq_base = 256;
> +	else
> +		irq_base = 160;
>  
>  	combiner_init(combiner_base, np, max_nr, irq_base);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
