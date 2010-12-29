From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Dec 2010 11:57:09 +0100
Subject: [PATCH 10/10] ARM: mxs: add initial pm support
In-Reply-To: <1293548155-16328-11-git-send-email-shawn.guo@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-11-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101229105709.GY14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Tue, Dec 28, 2010 at 10:55:55PM +0800, Shawn Guo wrote:
> This is a very initial pm support and basically does nothing.
> With this pm support entry, drivers can start testing their own
> pm functions.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/Makefile |    2 +-
>  arch/arm/mach-mxs/pm.c     |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/pm.c
> 
> diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> index f23ebbd..020547d 100644
> --- a/arch/arm/mach-mxs/Makefile
> +++ b/arch/arm/mach-mxs/Makefile
> @@ -1,5 +1,5 @@
>  # Common support
> -obj-y := clock.o devices.o gpio.o icoll.o iomux.o ocotp.o system.o timer.o
> +obj-y := clock.o devices.o gpio.o icoll.o iomux.o ocotp.o pm.o system.o timer.o
I don't know what is usual here, but I guess doing

	obj-$(CONFIG_PM) += pm.o

is better.  (Or CONFIG_SUSPEND?)

>  obj-$(CONFIG_SOC_IMX23) += clock-mx23.o mm-mx23.o
>  obj-$(CONFIG_SOC_IMX28) += clock-mx28.o mm-mx28.o
> diff --git a/arch/arm/mach-mxs/pm.c b/arch/arm/mach-mxs/pm.c
> new file mode 100644
> index 0000000..e4f4e31
> --- /dev/null
> +++ b/arch/arm/mach-mxs/pm.c
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright (C) 2010 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/suspend.h>
> +#include <linux/io.h>
> +#include <mach/system.h>
> +
> +static int mxs_suspend_enter(suspend_state_t state)
> +{
> +	switch (state) {
> +	case PM_SUSPEND_MEM:
> +		arch_idle();
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static struct platform_suspend_ops mxs_suspend_ops = {
> +	.enter = mxs_suspend_enter,
> +	.valid = suspend_valid_only_mem,
> +};
> +
> +static int __init mxs_pm_init(void)
> +{
> +	suspend_set_ops(&mxs_suspend_ops);
> +	return 0;
> +}
> +
can you please remove this empty line?

> +device_initcall(mxs_pm_init);
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
