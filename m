From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Aug 2013 12:15:31 +0100
Subject: [PATCH 10/10] ARM: clps711x: Add initial DT support
In-Reply-To: <1374172501-26796-11-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-11-git-send-email-shc_work@mail.ru>
Message-ID: <20130802111531.GH2884@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 07:35:01PM +0100, Alexander Shiyan wrote:
> This patch adds initial support for Cirrus Logic CLPS711X based platforms
> using the device tree for discovery.
> The basic devices is not yet DT-capable, so the CLPS711X DT option is marked
> as experimental.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-clps711x/Kconfig    |  7 +++++
>  arch/arm/mach-clps711x/Makefile   |  1 +
>  arch/arm/mach-clps711x/board-dt.c | 56 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+)
>  create mode 100644 arch/arm/mach-clps711x/board-dt.c
> 
> diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
> index bea6295..8ef38c6 100644
> --- a/arch/arm/mach-clps711x/Kconfig
> +++ b/arch/arm/mach-clps711x/Kconfig
> @@ -33,6 +33,13 @@ config ARCH_P720T
>  	  Say Y here if you intend to run this kernel on the ARM Prospector
>  	  720T.
>  
> +config CLPS711X_DT
> +	bool "Support CLPS711X platforms from device tree (Very Experimental!)"
> +	depends on USE_OF
> +	help
> +	  Include support for Cirrus Logic CLPS711X based platforms
> +	  using the device tree for discovery.
> +
>  config EP72XX_ROM_BOOT
>  	bool "EP721x/EP731x ROM boot"
>  	help
> diff --git a/arch/arm/mach-clps711x/Makefile b/arch/arm/mach-clps711x/Makefile
> index f04151e..77d3a76 100644
> --- a/arch/arm/mach-clps711x/Makefile
> +++ b/arch/arm/mach-clps711x/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_ARCH_CDB89712)	+= board-cdb89712.o
>  obj-$(CONFIG_ARCH_CLEP7312)	+= board-clep7312.o
>  obj-$(CONFIG_ARCH_EDB7211)	+= board-edb7211.o
>  obj-$(CONFIG_ARCH_P720T)	+= board-p720t.o
> +obj-$(CONFIG_CLPS711X_DT)	+= board-dt.o
> diff --git a/arch/arm/mach-clps711x/board-dt.c b/arch/arm/mach-clps711x/board-dt.c
> new file mode 100644
> index 0000000..5b6f3f1
> --- /dev/null
> +++ b/arch/arm/mach-clps711x/board-dt.c
> @@ -0,0 +1,56 @@
> +/*
> + *  CLPS711X Generic DT board
> + *
> + *  Author: Alexander Shiyan <shc_work@mail.ru>, 2013
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/clocksource.h>
> +#include <linux/clk-provider.h>
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/mach/arch.h>
> +
> +#include <mach/hardware.h>
> +
> +#include "common.h"
> +
> +void __init clps711x_timer_init_dt(void)
> +{
> +	of_clk_init(NULL);
> +	clocksource_of_init();
> +}

Doesn't generic code do that now if you don't provide this callback?

> +
> +static struct of_dev_auxdata clps711x_auxdata_lookup[] __initdata = {
> +	OF_DEV_AUXDATA("cirrus,clps711x-syscon", CLPS711X_PHYS_BASE + SYSCON1,
> +		       "syscon.1", NULL),
> +	OF_DEV_AUXDATA("cirrus,clps711x-syscon", CLPS711X_PHYS_BASE + SYSCON2,
> +		       "syscon.2", NULL),
> +	OF_DEV_AUXDATA("cirrus,clps711x-syscon", CLPS711X_PHYS_BASE + SYSCON3,
> +		       "syscon.3", NULL),
> +	{ }
> +};

Is there any reason these can't sit in the syscon driver? What are they
used for?

> +
> +static void __init clps711x_init_dt(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table,
> +			     clps711x_auxdata_lookup, NULL);
> +}

Depending on the answer to the above, you may not need this.

Thanks,
Mark.

> +
> +static const char *clps711x_dt_compat[] __initdata = {
> +	"cirrus,clps711x",
> +	NULL
> +};
> +
> +DT_MACHINE_START(CLPS711X_DT, "Cirrus Logic CLPS711X (Device Tree Support)")
> +	.dt_compat	= clps711x_dt_compat,
> +	.map_io		= clps711x_map_io,
> +	.init_time	= clps711x_timer_init,
> +	.init_machine	= clps711x_init_dt,
> +	.restart	= clps711x_restart,
> +MACHINE_END
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
