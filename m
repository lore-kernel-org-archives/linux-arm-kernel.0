From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Nov 2010 21:02:25 +0100
Subject: [PATCH 13/15] ARM: mxs: Add initial mx23evk support
In-Reply-To: <1290754154-9428-14-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-14-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101130200225.GZ20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 26, 2010 at 02:49:12PM +0800, Shawn Guo wrote:
> Add initial mx23evk support with duart.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/mach-mx23evk.c |   59 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 59 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/mach-mx23evk.c
> 
> diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
> new file mode 100644
> index 0000000..9048035
> --- /dev/null
> +++ b/arch/arm/mach-mxs/mach-mx23evk.c
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/irq.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/common.h>
> +#include <mach/iomux-mx23.h>
> +
> +#include "devices-mx23.h"
> +
> +static iomux_cfg_t mx23evk_pads[] = {
> +	/* duart */
> +	MX23_PAD_PWM0__DUART_RX,
> +	MX23_PAD_PWM1__DUART_TX,
> +};
> +
> +static void __init mx23evk_init(void)
> +{
> +	mxs_iomux_setup_multiple_pads(mx23evk_pads, ARRAY_SIZE(mx23evk_pads));
> +
> +	mx23_add_duart();
> +}
> +
> +static void __init mx23evk_timer_init(void)
> +{
> +	mx23_clocks_init();
> +}
> +
> +static struct sys_timer mx23evk_timer = {
> +	.init	= mx23evk_timer_init,
> +};
> +
> +MACHINE_START(MX23EVK, "Freescale MX23 EVK")
> +	/* Maintainer: Freescale Semiconductor, Inc. */
> +	.boot_params    = PHYS_OFFSET + 0x100,
MX23_PHYS_OFFSET.  Or better just don't define .boot_params at all.

> +	.map_io         = mx23_map_io,
> +	.init_irq       = mx23_init_irq,
> +	.init_machine   = mx23evk_init,
> +	.timer          = &mx23evk_timer,
> +MACHINE_END

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
