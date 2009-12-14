From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Dec 2009 16:04:25 -0000
Subject: [PATCH 2/5] arm/oprofile: reserve the PMU when starting
In-Reply-To: <1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
Message-ID: <000f01ca7cd7$1c073e10$5415ba30$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jamie Iles wrote:

> Make sure that we have access to the performance counters and
> that they aren't being used by perf events or anything else.
>
> diff --git a/arch/arm/oprofile/op_model_v6.c b/arch/arm/oprofile/op_model_v6.c
> index e468017..a22357a 100644
> --- a/arch/arm/oprofile/op_model_v6.c
> +++ b/arch/arm/oprofile/op_model_v6.c
> @@ -19,42 +19,47 @@
>  /* #define DEBUG */
>  #include <linux/types.h>
>  #include <linux/errno.h>
> +#include <linux/err.h>
>  #include <linux/sched.h>
>  #include <linux/oprofile.h>
>  #include <linux/interrupt.h>
>  #include <asm/irq.h>
>  #include <asm/system.h>
> +#include <asm/pmu.h>
> 
>  #include "op_counter.h"
>  #include "op_arm_model.h"
>  #include "op_model_arm11_core.h"
> 
> -static int irqs[] = {
> -#ifdef CONFIG_ARCH_OMAP2
> -	3,
> -#endif
> -#ifdef CONFIG_ARCH_BCMRING
> -	IRQ_PMUIRQ, /* for BCMRING, ARM PMU interrupt is 43 */
> -#endif
> -#ifdef CONFIG_ARCH_PC3XX
> -        IRQ_NPMUIRQ,
> -#endif
<snip>

These last three lines don't apply cleanly.
I think you've based this patch on top of your previous one.

Will
