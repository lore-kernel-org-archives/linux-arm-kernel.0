From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 21:28:22 +0100
Subject: [PATCH v2 14/15] ARM: mxs: Add initial mx28evk support
In-Reply-To: <1291739523-25077-11-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-11-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101208202822.GD17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Wed, Dec 08, 2010 at 12:32:02AM +0800, Shawn Guo wrote:
> Add initial mx28evk support with duart and fec0.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v2:
>  - Change function mx28evk_fec_reset() from inline to __init
>  - Enable pll2 clock before phy operation
>  - Add error checking for gpio_direction_output()
>  - Save bytes by passing parameter into pr_err format string
>  - Change mx28_add_fec0() to mx28_add_fec(0)
>  - Remove boot_params
> 
>  arch/arm/mach-mxs/mach-mx28evk.c |  126 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 126 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/mach-mx28evk.c
> 
> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
> new file mode 100644
> index 0000000..3e8e37a
> --- /dev/null
> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> @@ -0,0 +1,126 @@
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
> +#include <linux/clk.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/common.h>
> +#include <mach/iomux-mx28.h>
> +
> +#include "devices-mx28.h"
> +#include "gpio.h"
> +
> +#define MX28EVK_FEC_PHY_POWER	MXS_GPIO_NR(2, 15)
> +#define MX28EVK_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
> +
> +static iomux_cfg_t mx28evk_pads[] = {
This can be const and __initconst, ditto for mx23evk

> +	/* duart */
> +	MX28_PAD_PWM0__DUART_RX,
> +	MX28_PAD_PWM1__DUART_TX,
> +
> +	/* fec0 */
> +	MX28_PAD_ENET0_MDC__ENET0_MDC,
> +	MX28_PAD_ENET0_MDIO__ENET0_MDIO,
> +	MX28_PAD_ENET0_RX_EN__ENET0_RX_EN,
> +	MX28_PAD_ENET0_RXD0__ENET0_RXD0,
> +	MX28_PAD_ENET0_RXD1__ENET0_RXD1,
> +	MX28_PAD_ENET0_TX_EN__ENET0_TX_EN,
> +	MX28_PAD_ENET0_TXD0__ENET0_TXD0,
> +	MX28_PAD_ENET0_TXD1__ENET0_TXD1,
> +	MX28_PAD_ENET_CLK__ENET_CLK,
> +	/* phy power line */
> +	MX28_PAD_SSP1_DATA3__GPIO_2_15,
> +	/* phy reset line */
> +	MX28_PAD_ENET0_RX_CLK__GPIO_4_13,
> +};
> +
> +/* fec */
> +static void __init mx28evk_fec_reset(void)
> +{
> +	int ret;
> +	struct clk *clk;
> +
> +	/* Enable fec phy clock */
> +	clk = clk_get_sys("pll2", NULL);
> +	if (!IS_ERR(clk))
> +		clk_enable(clk);
> +
> +	/* Power up fec phy */
> +	ret = gpio_request(MX28EVK_FEC_PHY_POWER, "fec-phy-power");
> +	if (ret) {
> +		pr_err("Failed to request gpio fec-phy-%s: %d\n", "power", ret);
> +		return;
> +	}
> +
> +	ret = gpio_direction_output(MX28EVK_FEC_PHY_POWER, 0);
> +	if (ret) {
> +		pr_err("Failed to drive gpio fec-phy-%s: %d\n", "power", ret);
> +		return;
> +	}
> +
> +	/* Reset fec phy */
> +	ret = gpio_request(MX28EVK_FEC_PHY_RESET, "fec-phy-reset");
> +	if (ret) {
> +		pr_err("Failed to request gpio fec-phy-%s: %d\n", "reset", ret);
> +		return;
> +	}
> +
> +	gpio_direction_output(MX28EVK_FEC_PHY_RESET, 0);
> +	if (ret) {
> +		pr_err("Failed to drive gpio fec-phy-%s: %d\n", "reset", ret);
> +		return;
> +	}
> +
> +	mdelay(1);
> +	gpio_set_value(MX28EVK_FEC_PHY_RESET, 1);
> +}
> +
> +static const struct fec_platform_data mx28_fec_pdata __initconst = {
> +        .phy = PHY_INTERFACE_MODE_RMII,
> +};
> +
> +static void __init mx28evk_init(void)
> +{
> +	mxs_iomux_setup_multiple_pads(mx28evk_pads, ARRAY_SIZE(mx28evk_pads));
> +
> +	mx28_add_duart();
> +
> +	mx28evk_fec_reset();
> +	mx28_add_fec(0, &mx28_fec_pdata);
> +}
> +
> +static void __init mx28evk_timer_init(void)
> +{
> +	mx28_clocks_init();
> +}
> +
> +static struct sys_timer mx28evk_timer = {
> +	.init	= mx28evk_timer_init,
> +};
> +
> +MACHINE_START(MX28EVK, "Freescale MX28 EVK")
> +	/* Maintainer: Freescale Semiconductor, Inc. */
> +	.map_io         = mx28_map_io,
> +	.init_irq       = mx28_init_irq,
> +	.init_machine   = mx28evk_init,
> +	.timer          = &mx28evk_timer,
> +MACHINE_END
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
