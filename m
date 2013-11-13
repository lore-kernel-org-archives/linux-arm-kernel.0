From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Nov 2013 23:26:51 +0800
Subject: [PATCHv8][ 1/5] ARM i.MX35: Add devicetree support.
In-Reply-To: <1384255459-15134-1-git-send-email-denis@eukrea.com>
References: <1384255459-15134-1-git-send-email-denis@eukrea.com>
Message-ID: <20131113152622.GE17816@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 12:24:15PM +0100, Denis Carikli wrote:
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx35-dt.c
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright 2012 Steffen Trumtrar, Pengutronix
> + *
> + * based on imx27-dt.c
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +#include <asm/hardware/cache-l2x0.h>
> +#include "common.h"
> +#include "mx35.h"
> +
> +static void __init imx35_dt_init(void)
> +{
> +	mxc_arch_reset_init_dt();
> +
> +	of_platform_populate(NULL, of_default_bus_match_table,
> +			     NULL, NULL);
> +}
> +
> +static void __init imx35_timer_init(void)
> +{
> +	mx35_clocks_init_dt();
> +}
> +
> +static const char *imx35_dt_board_compat[] __initdata = {
> +	"fsl,imx35",
> +	NULL
> +};
> +
> +DT_MACHINE_START(IMX35_DT, "Freescale i.MX35 (Device Tree Support)")
> +	.map_io		= mx35_map_io,
> +	.init_early	= imx35_init_early,
> +	.init_irq	= mx35_init_irq,
> +	.handle_irq	= imx35_handle_irq,
> +	.init_time	= imx35_timer_init,

Please use CLK_OF_DECLARE() to save this hook.  You can look at imx51
clock driver for example.

Shawn

> +	.init_machine	= imx35_dt_init,
> +	.dt_compat	= imx35_dt_board_compat,
> +	.restart	= mxc_restart,
> +MACHINE_END
> -- 
> 1.7.9.5
> 
