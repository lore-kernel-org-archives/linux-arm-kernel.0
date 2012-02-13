From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 13 Feb 2012 18:03:15 -0500
Subject: [PATCH v2 1/4] ARM: local timers: Add A15 architected timer
 support
In-Reply-To: <1328115575-24866-2-git-send-email-marc.zyngier@arm.com>
References: <1328115575-24866-1-git-send-email-marc.zyngier@arm.com>
 <1328115575-24866-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <4F3996B3.1040503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 02/01/2012 11:59 AM, Marc Zyngier wrote:
> Add support for the A15 generic timer and clocksource.
> As the timer generates interrupts on a different PPI depending
> on the execution mode (normal or secure), it is possible to
> register two different PPIs.

[snip]

> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> new file mode 100644
> index 0000000..680cf1e
> --- /dev/null
> +++ b/arch/arm/kernel/arch_timer.c
> @@ -0,0 +1,286 @@
> +/*
> + *  linux/arch/arm/kernel/arch_timer.c
> + *
> + *  Copyright (C) 2011 ARM Ltd.
> + *  All Rights Reserved
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/smp.h>
> +#include <linux/cpu.h>
> +#include <linux/jiffies.h>
> +#include <linux/clockchips.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +
> +#include <asm/cputype.h>
> +#include <asm/localtimer.h>
> +#include <asm/arch_timer.h>
> +
> +static unsigned long arch_timer_rate;
> +static int arch_timer_ppi;
> +static int arch_timer_ppi2;
> +
> +static struct clock_event_device __percpu **arch_timer_evt;
> +
> +/*
> + * Architected system timer support.
> + */
> +
> +#define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
> +#define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
> +
> +#define ARCH_TIMER_REG_CTRL		0
> +#define ARCH_TIMER_REG_FREQ		1
> +#define ARCH_TIMER_REG_TVAL		2

[snip]

> +static irqreturn_t arch_timer_handler(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = *(struct clock_event_device **)dev_id;
> +	unsigned long ctrl;
> +
> +	ctrl = arch_timer_reg_read(ARCH_TIMER_REG_CTRL);
> +	if (ctrl & 0x4) {

Perhaps this bit could be given a name like the others.

[snip]

> +static inline cycle_t arch_counter_get_cntpct(void)
> +{
> +	u32 cvall, cvalh;
> +
> +	asm volatile("mrrc p15, 0, %0, %1, c14" : "=r" (cvall), "=r" (cvalh));
> +
> +	return ((u64) cvalh << 32) | cvall;

Would it not be better to cast to cycle_t?

> +}
> +
> +static inline cycle_t arch_counter_get_cntvct(void)
> +{
> +	u32 cvall, cvalh;
> +
> +	asm volatile("mrrc p15, 1, %0, %1, c14" : "=r" (cvall), "=r" (cvalh));
> +
> +	return ((u64) cvalh << 32) | cvall;

Ditto.

> +}

[snip]

> +out_free_irq:
> +	free_percpu_irq(arch_timer_ppi, arch_timer_evt);
> +	if (arch_timer_ppi2)
> +		free_percpu_irq(arch_timer_ppi2, arch_timer_evt);
> +	

Trailing whitespace.

> +out_free:
> +	free_percpu(arch_timer_evt);
> +
> +	return err;
> +}

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
