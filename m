From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 21 Jan 2010 09:30:52 +0000
Subject: [PATCH 1/5] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <1263471256-3739-2-git-send-email-jamie.iles@picochip.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-2-git-send-email-jamie.iles@picochip.com>
Message-ID: <20100121093052.GA4908@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 12:14:12PM +0000, Jamie Iles wrote:
> To add support for perf events and to allow the hardware
> counters to be shared with oprofile, we need a way to reserve
> access to the pmu (performance monitor unit).
[snip]
> diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
> new file mode 100644
> index 0000000..688d450
> --- /dev/null
> +++ b/arch/arm/kernel/pmu.c
> @@ -0,0 +1,105 @@
> +/*
> + *  linux/arch/arm/kernel/pmu.c
> + *
> + *  Copyright (C) 2009 picoChip Designs Ltd, Jamie Iles
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/cpumask.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include <asm/pmu.h>
> +
> +/*
> + * Define the IRQs for the system. We could use something like a platform
> + * device but that seems fairly heavyweight for this. Also, the performance
> + * counters can't be removed or hotplugged.
> + *
> + * Ordering is important: init_pmu() will use the ordering to set the affinity
> + * to the corresponding core. e.g. the first interrupt will go to cpu 0, the
> + * second goes to cpu 1 etc.
> + */
> +static const int irqs[] = {
> +#ifdef CONFIG_ARCH_PC3XX
> +	IRQ_NPMUIRQ,
> +#elif defined(CONFIG_ARCH_OMAP2)
This one (ARCH_PC3XX) shouldn't have made it in here as the platform isn't in
mainline. I'll remove this before submitting the patch.

Jamie
