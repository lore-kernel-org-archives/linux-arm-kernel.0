From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Oct 2016 15:45:39 +0100
Subject: [PATCH v14 1/9] clocksource/drivers/arm_arch_timer: Move enums
 and defines to header file
In-Reply-To: <1475086637-1914-2-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-2-git-send-email-fu.wei@linaro.org>
Message-ID: <20161020144510.GJ10234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 29, 2016 at 02:17:09AM +0800, fu.wei at linaro.org wrote:
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index caedb74..6f06481 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -19,6 +19,9 @@

Please add:

#include <linux/bitops.h>

... immediately before the includes below; it's needed to ensure that
BIT() is defined in all cases. Previously we were relying on implicit
header includes, which is not good practice.

>  #include <linux/timecounter.h>
>  #include <linux/types.h>
>  
> +#define ARCH_CP15_TIMER			BIT(0)
> +#define ARCH_MEM_TIMER			BIT(1)

If we're going to expose these in a header, it would be better to rename
them to something that makes their usage/meaning clear. These should
probably be ARCH_TIMER_TYPE_{CP15,MEM}.

I guess this can wait for subsequent cleanup.

> +enum ppi_nr {
> +	PHYS_SECURE_PPI,
> +	PHYS_NONSECURE_PPI,
> +	VIRT_PPI,
> +	HYP_PPI,
> +	MAX_TIMER_PPI
> +};

Please rename this to arch_timer_ppi_nr (updating the single user in 
drivers/clocksource/arm_arch_timer.c). That'll avoid the potential for
name clashes in files this happens to get included in (potentially
transitively via other headers).

With those changes (regardless of the ARCH_TIMER_TYPE_* bits):

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> +
>  #define ARCH_TIMER_PHYS_ACCESS		0
>  #define ARCH_TIMER_VIRT_ACCESS		1
>  #define ARCH_TIMER_MEM_PHYS_ACCESS	2
> -- 
> 2.7.4
> 
