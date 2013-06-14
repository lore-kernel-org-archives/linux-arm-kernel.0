From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Jun 2013 16:47:23 +0200
Subject: [PATCH 1/3] ARM: mach-moxart: add MOXA ART SoC files
In-Reply-To: <1371040448-28742-2-git-send-email-jonas.jensen@gmail.com>
References: <1371040448-28742-1-git-send-email-jonas.jensen@gmail.com>
 <1371040448-28742-2-git-send-email-jonas.jensen@gmail.com>
Message-ID: <2428901.voOA9oET8R@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013 14:34:06 Jonas Jensen wrote:

> diff --git a/arch/arm/mach-moxart/idle.c b/arch/arm/mach-moxart/idle.c
> new file mode 100644
> index 0000000..73ed844
> --- /dev/null
> +++ b/arch/arm/mach-moxart/idle.c
> @@ -0,0 +1,21 @@
> +/* Copyright (C) 2013 Jonas Jensen <jonas.jensen@gmail.com>
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License,
> + * or (at your option) any later version. */
> +
> +#include <linux/init.h>
> +#include <asm/system.h>
> +#include <asm/proc-fns.h>
> +
> +static void moxart_idle(void)
> +{
> +}
> +
> +static int __init moxart_idle_init(void)
> +{
> +	arm_pm_idle = moxart_idle;
> +	return 0;
> +}
> +
> +arch_initcall(moxart_idle_init);

IIRC Russell suggested changing cpu_fa526_do_idle() to not call WFI instead,
since the only other platform with fa526 has the same problem.

Your change above is actually wrong and breaks non-fa526 platforms in a
multiplatform kernel because it overrides arm_pm_idle without checking
what machine it currently runs on.

> diff --git a/arch/arm/mach-moxart/moxart.c b/arch/arm/mach-moxart/moxart.c
> new file mode 100644
> index 0000000..ab70386
> --- /dev/null
> +++ b/arch/arm/mach-moxart/moxart.c
> @@ -0,0 +1,23 @@
> +/* Copyright (C) 2013 Jonas Jensen <jonas.jensen@gmail.com>
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License,
> + * or (at your option) any later version. */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +#include <linux/clk-provider.h>

Most of these are probably unneeded now.

> +#include <asm/mach/arch.h>
> +
> +static const char * const moxart_dt_compat[] = {
> +	"moxa,moxart-uc-7112-lx",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(MOXART, "MOXA UC-7112-LX")
> +	.dt_compat		= moxart_dt_compat,
> +MACHINE_END

If the .dt_compat fields is the only field in the machine descriptor,
you can leave out the entire descriptor!

Olof, do you have a preference to how we want to handle this? The
only advantage of having this file at all is to have the
"MOXA UC-7112-LX" string in /proc/cpuinfo.
Should we just remove the entire directory or leave it as the trivial
file above?

	Arnd
