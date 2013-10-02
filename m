From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 02 Oct 2013 23:07:21 +0200
Subject: [PATCH 5/6] ARM: EXYNOS: Minor fixes to enable EXYNOS5410 support
In-Reply-To: <1380644227-12244-6-git-send-email-v.tyrtov@samsung.com>
References: <1380644227-12244-1-git-send-email-v.tyrtov@samsung.com>
 <1380644227-12244-6-git-send-email-v.tyrtov@samsung.com>
Message-ID: <2780639.2cMZyXdSOA@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vyacheslav, Tarek,

On Tuesday 01 of October 2013 20:17:06 Vyacheslav Tyrtov wrote:
> From: Tarek Dakhran <t.dakhran@samsung.com>
> 
> Configure ARM_NR_BANKS as 16 for EXYNOS SoC.
> Enable cci_control_port_by_index for ACE_PORT.
> Add additional irqs for Exynos MCT.
> Set irq base as 256 for EXYNOS5410 SoC.
> 
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

Could you explain why this is needed, please?

>  	default 8
> 
>  config IWMMXT
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 2009266..f2f5df1 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -363,8 +363,15 @@ int notrace __cci_control_port_by_index(u32 port,
> bool enable) * interface (ie cci_disable_port_by_cpu(); control by
> general purpose * indexing is therefore disabled for ACE ports.
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

Huh? Could you explain a) why this is needed b) why this can't be detected 
at runtime? Any new code being added must be ready for multiplatform 
builds and this clearly isn't.

I'd recommend extending the CCI binding with a boolean property that makes 
the driver bypass this check, but I'd like to see an answer to question a) 
first.

> 
>  	cci_port_control(port, enable);
>  	return 0;
> diff --git a/drivers/clocksource/exynos_mct.c
> b/drivers/clocksource/exynos_mct.c index 5b34768..33884d7 100644
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

This #ifdef is useless.

Basically this whole enum is, as it is a remnant of legacy non-DT support, 
but it is a material for separate patch.

>  	MCT_NR_IRQS,
>  };
> 
> @@ -406,7 +412,7 @@ static int exynos4_local_timer_setup(struct
> clock_event_device *evt) mevt = container_of(evt, struct
> mct_clock_event_device, evt);
> 
>  	mevt->base = EXYNOS4_MCT_L_BASE(cpu);
> -	sprintf(mevt->name, "mct_tick%d", cpu);
> +	snprintf(mevt->name, 10, "mct_tick%d", cpu);

Is this really necessary to enable EXYNOS5410 support?

> 
>  	evt->name = mevt->name;
>  	evt->cpumask = cpumask_of(cpu);
> diff --git a/drivers/irqchip/exynos-combiner.c
> b/drivers/irqchip/exynos-combiner.c index 868ed40..2e056fc 100644
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
> @@ -66,6 +67,11 @@ static void combiner_handle_cascade_irq(unsigned int
> irq, struct irq_desc *desc) struct irq_chip *chip = irq_get_chip(irq);
>  	unsigned int cascade_irq, combiner_irq;
>  	unsigned long status;
> +	if (unlikely(!chip || !chip_data)) {
> +		printk_once(KERN_ALERT "%s: Chip not found for IRQ %d\n"
> +				, __func__, irq);
> +		return;
> +	}

What is the reason for this change?

> 
>  	chained_irq_enter(chip, desc);
> 
> @@ -226,7 +232,11 @@ static int __init combiner_of_init(struct
> device_node *np, * get their IRQ from DT, remove this in order to get
> dynamic * allocation.
>  	 */
> -	irq_base = 160;
> +
> +	if (soc_is_exynos5410())
> +		irq_base = 256;
> +	else
> +		irq_base = 160;
> 
>  	combiner_init(combiner_base, np, max_nr, irq_base);

There was a patch floating on the ML, possibly already merged, removing 
static IRQ base assignment for combiner (which is a remnant of legacy non-
DT support) and moving the driver to normal linear IRQ domain. That patch 
is what you need instead of this change.

Best regards,
Tomasz
