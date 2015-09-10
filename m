From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Sep 2015 10:59:20 +0100
Subject: [PATCH] arm/ls1021a: Add Sleep feature for ls1021
In-Reply-To: <1441877796-32232-1-git-send-email-dongsheng.wang@freescale.com>
References: <1441877796-32232-1-git-send-email-dongsheng.wang@freescale.com>
Message-ID: <20150910095920.GB29293@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 10:36:36AM +0100, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Based on PSCI framework, add system STANDBY implement for ls1021 platform.
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index fb689d8..d7a2d1d 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -90,6 +90,7 @@ ifeq ($(CONFIG_SUSPEND),y)
>  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
>  obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
>  obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o
> +obj-$(CONFIG_SOC_LS1021A) += pm-ls1.o
>  endif
>  obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
>  
> diff --git a/arch/arm/mach-imx/pm-ls1.c b/arch/arm/mach-imx/pm-ls1.c
> new file mode 100644
> index 0000000..f80b24d
> --- /dev/null
> +++ b/arch/arm/mach-imx/pm-ls1.c
> @@ -0,0 +1,222 @@
> +/*
> + * Support Power Management Control for LS1
> + *
> + * Copyright 2015 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute	it and/or modify it
> + * under  the terms of	the GNU General	 Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/psci.h>
> +#include <linux/suspend.h>
> +
> +#include <uapi/linux/psci.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/psci.h>

NAK.

No new platform code should be calling the PSCI functions directly; you
should not need to include these files in platform code.

Thanks,
Mark.
