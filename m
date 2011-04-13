From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 13 Apr 2011 09:41:39 +0200
Subject: [PATCH v5 1/4] ARM: add GPMI support for imx23/imx28
In-Reply-To: <1302675881-18862-2-git-send-email-b32955@freescale.com>
References: <1302675881-18862-1-git-send-email-b32955@freescale.com>
	<1302675881-18862-2-git-send-email-b32955@freescale.com>
Message-ID: <19877.21427.818829.518089@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Huang Shijie writes:
> add the clock and iomux initialization for GPMI in the imx23 and imx28.
> and register the gpmi driver.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/mach-mxs/Kconfig                       |    2 +
>  arch/arm/mach-mxs/clock-mx23.c                  |    3 +
>  arch/arm/mach-mxs/clock-mx28.c                  |    3 +
>  arch/arm/mach-mxs/devices-mx23.h                |    3 +
>  arch/arm/mach-mxs/devices-mx28.h                |    3 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-gpmi.c       |  134 +++++++++++++++++++++++
>  arch/arm/mach-mxs/include/mach/devices-common.h |    4 +
>  arch/arm/mach-mxs/include/mach/gpmi-nfc.h       |   65 +++++++++++
>  arch/arm/mach-mxs/mach-mx23evk.c                |   37 ++++++
>  arch/arm/mach-mxs/mach-mx28evk.c                |   37 ++++++
>  12 files changed, 295 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi.c
>  create mode 100644 arch/arm/mach-mxs/include/mach/gpmi-nfc.h
> 
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 4f6f174..e034666 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -22,6 +22,7 @@ config MACH_MX23EVK
>  	select SOC_IMX23
>  	select MXS_HAVE_AMBA_DUART
>  	select MXS_HAVE_PLATFORM_AUART
> +	select MXS_HAVE_PLATFORM_GPMI
>  	select MXS_HAVE_PLATFORM_MXSFB
>  	default y
>  	help
> @@ -35,6 +36,7 @@ config MACH_MX28EVK
>  	select MXS_HAVE_PLATFORM_AUART
>  	select MXS_HAVE_PLATFORM_FEC
>  	select MXS_HAVE_PLATFORM_FLEXCAN
> +	select MXS_HAVE_PLATFORM_GPMI
>  	select MXS_HAVE_PLATFORM_MXSFB
>  	select MXS_OCOTP
>  	default y
> diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
> index d133c7f..f3c9653 100644
> --- a/arch/arm/mach-mxs/clock-mx23.c
> +++ b/arch/arm/mach-mxs/clock-mx23.c
> @@ -29,6 +29,7 @@
>  #include <mach/mx23.h>
>  #include <mach/common.h>
>  #include <mach/clock.h>
> +#include <mach/gpmi-nfc.h>
>  
>  #include "regs-clkctrl-mx23.h"
>  
> @@ -442,6 +443,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("duart", "apb_pclk", xbus_clk)
>  	/* for amba-pl011 driver */
>  	_REGISTER_CLOCK("duart", NULL, uart_clk)
> +	_REGISTER_CLOCK(GPMI_NFC_DRIVER_MX23, NULL, gpmi_clk)
>  	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
>  	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
>  	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
> @@ -533,6 +535,7 @@ int __init mx23_clocks_init(void)
>  	clk_enable(&xbus_clk);
>  	clk_enable(&emi_clk);
>  	clk_enable(&uart_clk);
> +	clk_enable(&gpmi_clk);
>  
>  	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>  
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 5e489a2..7868d42 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -29,6 +29,7 @@
>  #include <mach/mx28.h>
>  #include <mach/common.h>
>  #include <mach/clock.h>
> +#include <mach/gpmi-nfc.h>
>  
>  #include "regs-clkctrl-mx28.h"
>  
> @@ -607,6 +608,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("duart", "apb_pclk", xbus_clk)
>  	/* for amba-pl011 driver */
>  	_REGISTER_CLOCK("duart", NULL, uart_clk)
> +	_REGISTER_CLOCK(GPMI_NFC_DRIVER_MX28, NULL, gpmi_clk)
>  	_REGISTER_CLOCK("imx28-fec.0", NULL, fec_clk)
>  	_REGISTER_CLOCK("imx28-fec.1", NULL, fec_clk)
>  	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
> @@ -749,6 +751,7 @@ int __init mx28_clocks_init(void)
>  	clk_enable(&xbus_clk);
>  	clk_enable(&emi_clk);
>  	clk_enable(&uart_clk);
> +	clk_enable(&gpmi_clk);
>  
>  	clk_set_parent(&lcdif_clk, &ref_pix_clk);
>  
> diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
> index c7e14f4..349fb1d 100644
> --- a/arch/arm/mach-mxs/devices-mx23.h
> +++ b/arch/arm/mach-mxs/devices-mx23.h
> @@ -16,6 +16,9 @@ extern const struct amba_device mx23_duart_device __initconst;
>  #define mx23_add_duart() \
>  	mxs_add_duart(&mx23_duart_device)
>  
> +extern const struct gpmi_nfc_platform_data gpmi_platform_data_imx23 __initconst;
> +#define mx23_add_gpmi() mxs_add_gpmi(&gpmi_platform_data_imx23)
>
platform_data should be passed as parameter to the mx23_add_gpmi()
call, so that it can be set per platform, not per SoC.


> diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
> index 9d08555..ed6427b 100644
> --- a/arch/arm/mach-mxs/devices-mx28.h
> +++ b/arch/arm/mach-mxs/devices-mx28.h
> @@ -16,6 +16,9 @@ extern const struct amba_device mx28_duart_device __initconst;
>  #define mx28_add_duart() \
>  	mxs_add_duart(&mx28_duart_device)
>  
> +extern const struct gpmi_nfc_platform_data gpmi_platform_data_imx28 __initconst;
> +#define	mx28_add_gpmi()	mxs_add_gpmi(&gpmi_platform_data_imx28)
> +
dito.

> diff --git a/arch/arm/mach-mxs/devices/platform-gpmi.c b/arch/arm/mach-mxs/devices/platform-gpmi.c
> new file mode 100644
> index 0000000..74ebe22
> --- /dev/null
> +++ b/arch/arm/mach-mxs/devices/platform-gpmi.c
> @@ -0,0 +1,134 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
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
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +#include <asm/sizes.h>
> +#include <mach/mx23.h>
> +#include <mach/mx28.h>
> +#include <mach/gpmi-nfc.h>
> +#include <mach/devices-common.h>
> +
> +#ifdef CONFIG_SOC_IMX23
> +const struct gpmi_nfc_platform_data  gpmi_platform_data_imx23 __initconst = {
> +	.min_prop_delay_in_ns	= 5,
> +	.max_prop_delay_in_ns	= 9,
> +	.max_chip_count		= 1,
> +};
> +
This is platform-dependent and thus should be placed in the mach-*
files (and passed to mx23_add_gpmi()).

> +const struct resource res_imx23[] __initconst = {
> +	{	/* GPMI */
> +		.start = MX23_GPMI_BASE_ADDR,
> +		.end   = MX23_GPMI_BASE_ADDR + SZ_8K - 1,
> +		.name  = GPMI_NFC_GPMI_REGS_ADDR_RES_NAME,
> +		.flags = IORESOURCE_MEM,
> +	}, {
> +		.start = MX23_INT_GPMI_ATTENTION,
> +		.end   = MX23_INT_GPMI_ATTENTION,
> +		.name  = GPMI_NFC_GPMI_INTERRUPT_RES_NAME,
> +		.flags = IORESOURCE_IRQ,
> +	}, {	/* BCH */
> +		.start = MX23_BCH_BASE_ADDR,
> +		.end   = MX23_BCH_BASE_ADDR + SZ_8K - 1,
> +		.name  = GPMI_NFC_BCH_REGS_ADDR_RES_NAME,
> +		.flags = IORESOURCE_MEM,
> +	}, {
> +		.start = MX23_INT_BCH,
> +		.end   = MX23_INT_BCH,
> +		.name  = GPMI_NFC_BCH_INTERRUPT_RES_NAME,
> +		.flags = IORESOURCE_IRQ,
> +	}, {	/* DMA */
> +		.start	= MX23_DMA_GPMI0,
> +		.end	= MX23_DMA_GPMI3,
> +		.name  = GPMI_NFC_DMA_CHANNELS_RES_NAME,
> +		.flags = IORESOURCE_DMA,
> +	}, {
> +		.start = MX23_INT_GPMI_DMA,
> +		.end   = MX23_INT_GPMI_DMA,
> +		.name  = GPMI_NFC_DMA_INTERRUPT_RES_NAME,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +#endif
> +
> +#ifdef CONFIG_SOC_IMX28
> +const struct gpmi_nfc_platform_data  gpmi_platform_data_imx28 __initconst = {
> +	.min_prop_delay_in_ns	= 5,
> +	.max_prop_delay_in_ns	= 9,
> +	.max_chip_count		= 1,
> +};
> +
dito.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
