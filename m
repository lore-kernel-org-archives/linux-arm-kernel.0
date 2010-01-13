From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 13 Jan 2010 00:12:48 +0000
Subject: [PATCH 3/3] ARM: SAMSUNG: Add idle support
In-Reply-To: <1263203072-29282-1-git-send-email-kgene.kim@samsung.com>
References: <1263203072-29282-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100113001248.GI18532@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 06:44:32PM +0900, Kukjin Kim wrote:
> This patch adds common idle functionality for all Samsung SoC's.

Kukjin, for expediency please do as Russell suggested and hook the pm_idle
call for the s5p6440 case.
 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/plat-samsung/include/mach/idle.h   |   18 +++++++++++++
>  arch/arm/plat-samsung/include/mach/system.h |   36 +++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-samsung/include/mach/idle.h
>  create mode 100644 arch/arm/plat-samsung/include/mach/system.h
> 
> diff --git a/arch/arm/plat-samsung/include/mach/idle.h b/arch/arm/plat-samsung/include/mach/idle.h
> new file mode 100644
> index 0000000..f3b5034
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/mach/idle.h
> @@ -0,0 +1,18 @@
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
> +
> +#endif /* __ASM_PLAT_IDLE_H */
> diff --git a/arch/arm/plat-samsung/include/mach/system.h b/arch/arm/plat-samsung/include/mach/system.h
> new file mode 100644
> index 0000000..5377792
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/mach/system.h
> @@ -0,0 +1,36 @@
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
> +static void s3c_default_idle(void)
> +{
> +	/* nothing here yet */
> +}
> +
> +static void arch_idle(void)
> +{
> +	if (s3c_idle_fn != NULL)
> +		(s3c_idle_fn)();
> +	else
> +		s3c_default_idle();
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
