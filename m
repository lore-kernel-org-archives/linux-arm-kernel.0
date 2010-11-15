From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 15 Nov 2010 17:54:38 +0100
Subject: [PATCH 10/11] ARM: imx: Add initial support of machine mx28evk
In-Reply-To: <1289831795-4373-11-git-send-email-shawn.guo@freescale.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
	<1289831795-4373-11-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101115165438.GP8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 10:36:34PM +0800, Shawn Guo wrote:
> It adds machine mx28evk with initial duart and fec
> device registration.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-imx/devices-imx28.h               |   20 ++++
>  arch/arm/mach-imx/devices.c                     |   27 ++++++-
>  arch/arm/mach-imx/mach-mx28evk.c                |  109 +++++++++++++++++++++++
>  arch/arm/plat-mxc/devices/platform-duart.c      |   42 +++++++++
>  arch/arm/plat-mxc/devices/platform-fec.c        |    5 +
>  arch/arm/plat-mxc/include/mach/common.h         |    5 +
>  arch/arm/plat-mxc/include/mach/devices-common.h |   11 +++
Can you split this up into (say):

 - mx28: dynamically allocate duart devices
 - mx28: dynamically allocate fec devices
 - mx28: add gpio port definitions
 - mx28: mx28evk support

>  7 files changed, 218 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-imx/devices-imx28.h
>  create mode 100644 arch/arm/mach-imx/mach-mx28evk.c
>  create mode 100644 arch/arm/plat-mxc/devices/platform-duart.c
> 
> diff --git a/arch/arm/mach-imx/devices-imx28.h b/arch/arm/mach-imx/devices-imx28.h
> new file mode 100644
> index 0000000..f35c910
> --- /dev/null
> +++ b/arch/arm/mach-imx/devices-imx28.h
> @@ -0,0 +1,20 @@
> +/*
> + * Copyright (C) 2010 Pengutronix
> + * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> + *
> + * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +#include <mach/mx28.h>
> +#include <mach/devices-common.h>
> +
> +extern const struct imx_duart_data imx28_duart_data __initconst;
> +#define imx28_add_duart()	\
> +	imx_add_duart(&imx28_duart_data)
> +
> +extern const struct imx_fec_data imx28_fec_data __initconst;
> +#define imx28_add_fec(pdata)	\
> +	imx_add_fec(&imx28_fec_data, pdata)
> diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
> index e69e46e..946db32 100644
> --- a/arch/arm/mach-imx/devices.c
> +++ b/arch/arm/mach-imx/devices.c
> @@ -9,7 +9,7 @@
>   * licensed "as is" without any warranty of any kind, whether express
>   * or implied.
>   *
> - * Copyright 2006-2007 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2006-2010 Freescale Semiconductor, Inc. All Rights Reserved.
>   * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
>   * Copyright 2008 Sascha Hauer, kernel at pengutronix.de
>   * Copyright (c) 2008 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
> @@ -551,3 +551,28 @@ struct platform_device imx_kpp_device = {
>  };
>  
>  #endif
> +
> +#ifdef CONFIG_ARCH_MX28
> +/* gpio */
> +#define DEFINE_MXC_PINCTRL_GPIO_PORT(n)					\
> +	{								\
> +		.chip.label = "gpio-" #n,				\
> +		.irq = MX28_INT_GPIO##n,				\
> +		.base = MX28_IO_ADDRESS(MX28_PINCTRL_BASE_ADDR),	\
> +		.virtual_irq_start = MXC_GPIO_IRQ_START + n * 32,	\
> +	}
> +
> +static struct mxc_gpio_port imx28_gpio_ports[] = {
> +	DEFINE_MXC_PINCTRL_GPIO_PORT(0),
> +	DEFINE_MXC_PINCTRL_GPIO_PORT(1),
> +	DEFINE_MXC_PINCTRL_GPIO_PORT(2),
> +	DEFINE_MXC_PINCTRL_GPIO_PORT(3),
> +	DEFINE_MXC_PINCTRL_GPIO_PORT(4),
> +};
> +
> +int __init imx28_register_gpios(void)
> +{
> +	return mxc_gpio_init(imx28_gpio_ports,
> +			ARRAY_SIZE(imx28_gpio_ports));
> +}
> +#endif
In my tree I have moved this out of devices.c to plat-mxc/gpio.c.

> diff --git a/arch/arm/mach-imx/mach-mx28evk.c b/arch/arm/mach-imx/mach-mx28evk.c
> new file mode 100644
> index 0000000..d5dd940
> --- /dev/null
> +++ b/arch/arm/mach-imx/mach-mx28evk.c
> @@ -0,0 +1,109 @@
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
> +#include <mach/iomux-mx28.h>
> +
> +#include "devices-imx28.h"
> +#include "devices.h"
> +
> +#define MX28EVK_FEC_PHY_POWER	(2*32 + 15)	/* GPIO_2_15 */
> +#define MX28EVK_FEC_PHY_RESET	(4*32 + 13)	/* GPIO_4_13 */
> +
> +static iomux_pinctrl_cfg_t mx28evk_pads[] = {
> +	/* DUART */
> +	MX28_PAD_PWM0__DUART_RX,
> +	MX28_PAD_PWM1__DUART_TX,
> +
> +	/* FEC */
> +	MX28_PAD_ENET0_MDC__ENET0_MDC,
> +	MX28_PAD_ENET0_MDIO__ENET0_MDIO,
> +	MX28_PAD_ENET0_RX_EN__ENET0_RX_EN,
> +	MX28_PAD_ENET0_RXD0__ENET0_RXD0,
> +	MX28_PAD_ENET0_RXD1__ENET0_RXD1,
> +	MX28_PAD_ENET0_TX_EN__ENET0_TX_EN,
> +	MX28_PAD_ENET0_TXD0__ENET0_TXD0,
> +	MX28_PAD_ENET0_TXD1__ENET0_TXD1,
> +	MX28_PAD_ENET_CLK__ENET_CLK,
> +	/* PHY power line */
> +	MX28_PAD_SSP1_DATA3__GPIO_2_15,
> +	/* PHY reset line */
> +	MX28_PAD_ENET0_RX_CLK__GPIO_4_13,
> +};
> +
> +/* FEC */
> +static const struct fec_platform_data mx28_fec_pdata __initconst = {
> +        .phy = PHY_INTERFACE_MODE_RMII,
> +};
> +
> +static inline void mx28evk_fec_reset(void)
> +{
> +	int ret;
> +
> +	/* Power up FEC PHY */
> +	ret = gpio_request(MX28EVK_FEC_PHY_POWER, "fec-phy-power");
> +	if (ret) {
> +		pr_err("Failed to request GPIO_FEC_PHY_POWER: %d\n", ret);
> +		return;
> +	}
> +	gpio_direction_output(MX28EVK_FEC_PHY_POWER, 0);
> +
> +	/* Reset FEC PHY */
> +	ret = gpio_request(MX28EVK_FEC_PHY_RESET, "fec-phy-reset");
> +	if (ret) {
> +		pr_err("Failed to request GPIO_FEC_PHY_RESET: %d\n", ret);
> +		return;
> +	}
> +	gpio_direction_output(MX28EVK_FEC_PHY_RESET, 0);
> +	mdelay(1);
> +	gpio_set_value(MX28EVK_FEC_PHY_RESET, 1);
> +}
> +
> +static void __init mx28evk_init(void)
> +{
> +	mxc_iomux_pinctrl_setup_multiple_pads(mx28evk_pads,
> +						ARRAY_SIZE(mx28evk_pads));
> +	imx28_add_duart();
> +
> +	mx28evk_fec_reset();
> +	imx28_add_fec(&mx28_fec_pdata);
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
> +	.boot_params    = MX28_PHYS_OFFSET + 0x100,
> +	.map_io         = mx28_map_io,
> +	.init_irq       = mx28_init_irq,
> +	.init_machine   = mx28evk_init,
> +	.timer          = &mx28evk_timer,
> +MACHINE_END
> diff --git a/arch/arm/plat-mxc/devices/platform-duart.c b/arch/arm/plat-mxc/devices/platform-duart.c
> new file mode 100644
> index 0000000..2dbf199
> --- /dev/null
> +++ b/arch/arm/plat-mxc/devices/platform-duart.c
> @@ -0,0 +1,42 @@
> +/*
> + * Copyright (C) 2009-2010 Pengutronix
> + * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> + *
> + * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +#include <mach/hardware.h>
> +#include <mach/devices-common.h>
> +
> +#define imx_duart_data_entry_single(soc)				\
> +	{								\
> +		.iobase = soc ## _DUART_BASE_ADDR,			\
> +		.irq = soc ## _INT_DUART,				\
> +	}
> +
> +#ifdef CONFIG_ARCH_MX28
> +const struct imx_duart_data imx28_duart_data __initconst =
> +	imx_duart_data_entry_single(MX28);
> +#endif
> +
> +struct platform_device *__init imx_add_duart(
> +		const struct imx_duart_data *data)
> +{
> +	struct resource res[] = {
> +		{
> +			.start = data->iobase,
> +			.end = data->iobase + SZ_8K - 1,
> +			.flags = IORESOURCE_MEM,
> +		}, {
> +			.start = data->irq,
> +			.end = data->irq,
> +			.flags = IORESOURCE_IRQ,
> +		},
> +	};
> +
> +	return imx_add_platform_device("imx-duart", 0, res, ARRAY_SIZE(res),
> +					NULL, 0);
> +}
> diff --git a/arch/arm/plat-mxc/devices/platform-fec.c b/arch/arm/plat-mxc/devices/platform-fec.c
> index 11d087f..bd5a84b 100644
> --- a/arch/arm/plat-mxc/devices/platform-fec.c
> +++ b/arch/arm/plat-mxc/devices/platform-fec.c
> @@ -26,6 +26,11 @@ const struct imx_fec_data imx27_fec_data __initconst =
>  	imx_fec_data_entry_single(MX27);
>  #endif /* ifdef CONFIG_SOC_IMX27 */
>  
> +#ifdef CONFIG_ARCH_MX28
I'd prefer CONFIG_SOC_MX28 to have uniform naming.  (I already switched
MX25, MX31 and MX35 to CONFIG_SOC_MX... in my tree)

> +const struct imx_fec_data imx28_fec_data __initconst =
> +	imx_fec_data_entry_single(MX28);
> +#endif
> +
>  #ifdef CONFIG_ARCH_MX35
>  const struct imx_fec_data imx35_fec_data __initconst =
>  	imx_fec_data_entry_single(MX35);
> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index 05676fb..6a5dea7 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -18,16 +18,19 @@ extern void mx1_map_io(void);
>  extern void mx21_map_io(void);
>  extern void mx25_map_io(void);
>  extern void mx27_map_io(void);
> +extern void mx28_map_io(void);
>  extern void mx31_map_io(void);
>  extern void mx35_map_io(void);
>  extern void mx51_map_io(void);
>  extern void mxc91231_map_io(void);
>  extern void mxc_init_irq(void __iomem *);
>  extern void tzic_init_irq(void __iomem *);
> +extern void icoll_init_irq(void __iomem *);
>  extern void mx1_init_irq(void);
>  extern void mx21_init_irq(void);
>  extern void mx25_init_irq(void);
>  extern void mx27_init_irq(void);
> +extern void mx28_init_irq(void);
>  extern void mx31_init_irq(void);
>  extern void mx35_init_irq(void);
>  extern void mx51_init_irq(void);
> @@ -38,6 +41,7 @@ extern int mx1_clocks_init(unsigned long fref);
>  extern int mx21_clocks_init(unsigned long lref, unsigned long fref);
>  extern int mx25_clocks_init(void);
>  extern int mx27_clocks_init(unsigned long fref);
> +extern int mx28_clocks_init(void);
>  extern int mx31_clocks_init(unsigned long fref);
>  extern int mx35_clocks_init(void);
>  extern int mx51_clocks_init(unsigned long ckil, unsigned long osc,
> @@ -51,4 +55,5 @@ extern void mxc91231_power_off(void);
>  extern void mxc91231_arch_reset(int, const char *);
>  extern void mxc91231_prepare_idle(void);
>  extern void mx51_efikamx_reset(void);
> +extern int mxc_reset_block(void __iomem *);
>  #endif
> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
> index 8c6896f..501329d 100644
> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
> @@ -2,6 +2,8 @@
>   * Copyright (C) 2009-2010 Pengutronix
>   * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
>   *
> + * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
>   * This program is free software; you can redistribute it and/or modify it under
>   * the terms of the GNU General Public License version 2 as published by the
>   * Free Software Foundation.
> @@ -82,6 +84,15 @@ struct platform_device *__init imx_add_imx_uart_1irq(
>  		const struct imx_imx_uart_1irq_data *data,
>  		const struct imxuart_platform_data *pdata);
>  
> +struct imx_duart_data {
> +	int id;
> +	resource_size_t iobase;
> +	resource_size_t iosize;
> +	resource_size_t irq;
> +};
> +struct platform_device *__init imx_add_duart(
> +		const struct imx_duart_data *data);
> +
Can you please keep the file sorted alphabetically?

>  #include <mach/mxc_nand.h>
>  struct imx_mxc_nand_data {
>  	/*
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
