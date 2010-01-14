From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 14 Jan 2010 00:28:23 +0000
Subject: [PATCH v2 3/3] ARM: SAMSUNG: Add idle support
In-Reply-To: <1263426347-13668-1-git-send-email-kgene.kim@samsung.com>
References: <1263426347-13668-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100114002823.GL18532@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 08:45:47AM +0900, Kukjin Kim wrote:
> This patch adds common idle functionality for all Samsung SoC's.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/plat-samsung/include/mach/idle.h   |   19 +++++++++++++
>  arch/arm/plat-samsung/include/mach/system.h |   39 +++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-samsung/include/mach/idle.h
>  create mode 100644 arch/arm/plat-samsung/include/mach/system.h
> 
> diff --git a/arch/arm/plat-samsung/include/mach/idle.h b/arch/arm/plat-samsung/include/mach/idle.h
> new file mode 100644
> index 0000000..b5b92d2
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/mach/idle.h
> @@ -0,0 +1,19 @@
> +/* linux/arch/arm/plat-samsung/include/mach/idle.h
> + *
> + * Copyright (c) 2009 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * Idle support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_PLAT_IDLE_H
> +#define __ASM_PLAT_IDLE_H __FILE__
> +
> +extern void (*s3c_idle_fn)(void);
> +extern void samsung_idle(void);
> +
> +#endif /* __ASM_PLAT_IDLE_H */

Sorry, but I beliveve Russell's original statement was that pm_idle shoudl be
used instead of having another idle pointer, so the s5p6440 idle code
will need to be changed to hook pm_idle and this patch removed from the
series.

> diff --git a/arch/arm/plat-samsung/include/mach/system.h b/arch/arm/plat-samsung/include/mach/system.h
> new file mode 100644
> index 0000000..1e49fb3
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/mach/system.h
> @@ -0,0 +1,39 @@
> +/* linux/arch/arm/plat-samsung/include/mach/idle.h
> + *
> + * Copyright (c) 2009 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * Idle support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_PLAT_SYSTEM_H
> +#define __ASM_PLAT_SYSTEM_H __FILE__
> +
> +void (*s3c_idle_fn)(void);
> +
> +void samsung_idle(void)
> +{
> +	/* can add generic idle functionality here, if any */
> +
> +	if (!need_resched()) {
> +		if (s3c_idle_fn != NULL)
> +			(s3c_idle_fn)();
> +	}
> +	local_irq_enable();
> +}
> +
> +static void arch_idle(void)
> +{
> +	/* nothing */
> +}
> +
> +static void arch_reset(char mode, const char *cmd)
> +{
> +	/* nothing here yet */
> +}
> +
> +#endif /* __ASM_PLAT_SYSTEM_H */
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
