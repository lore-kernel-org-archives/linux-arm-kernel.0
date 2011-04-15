From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 15 Apr 2011 10:12:23 +0200
Subject: [PATCH 2/2] ARM: mxs: add GPMI device for imx23/imx28
In-Reply-To: <1302854508-13652-2-git-send-email-b32955@freescale.com>
References: <1302854508-13652-1-git-send-email-b32955@freescale.com>
	<1302854508-13652-2-git-send-email-b32955@freescale.com>
Message-ID: <20110415081223.GM31990@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 04:01:48PM +0800, Huang Shijie wrote:
> add the gpmi device for imx23 and imx28.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/mach-mxs/clock-mx23.c                  |    1 +
>  arch/arm/mach-mxs/clock-mx28.c                  |    1 +
>  arch/arm/mach-mxs/devices-mx23.h                |    4 +
>  arch/arm/mach-mxs/devices-mx28.h                |    4 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-gpmi.c       |   82 +++++++++++++++++++++++
>  arch/arm/mach-mxs/include/mach/devices-common.h |    6 ++
>  arch/arm/mach-mxs/mach-mx23evk.c                |   28 ++++++++
>  arch/arm/mach-mxs/mach-mx28evk.c                |   28 ++++++++
Can you please split out the changes to arch/arm/mach-mxs/mach-* into
one or two seperate changes?

>  10 files changed, 158 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi.c
> 
> diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
> index d133c7f..81d54bf 100644
> --- a/arch/arm/mach-mxs/clock-mx23.c
> +++ b/arch/arm/mach-mxs/clock-mx23.c
> @@ -454,6 +454,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("mxs-pwm.3", NULL, pwm_clk)
>  	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
>  	_REGISTER_CLOCK("imx23-fb", NULL, lcdif_clk)
> +	_REGISTER_CLOCK("imx23-gpmi-nfc", NULL, gpmi_clk)
>  };
>  
>  static int clk_misc_init(void)
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 5e489a2..9dbd2d5 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -609,6 +609,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("duart", NULL, uart_clk)
>  	_REGISTER_CLOCK("imx28-fec.0", NULL, fec_clk)
>  	_REGISTER_CLOCK("imx28-fec.1", NULL, fec_clk)
> +	_REGISTER_CLOCK("imx28-gpmi-nfc", NULL, gpmi_clk)
>  	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
>  	_REGISTER_CLOCK("mxs-auart.1", NULL, uart_clk)
>  	_REGISTER_CLOCK("mxs-auart.2", NULL, uart_clk)
> diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
> index c7e14f4..03bd234 100644
> --- a/arch/arm/mach-mxs/devices-mx23.h
> +++ b/arch/arm/mach-mxs/devices-mx23.h
> @@ -21,6 +21,10 @@ extern const struct mxs_auart_data mx23_auart_data[] __initconst;
>  #define mx23_add_auart0()		mx23_add_auart(0)
>  #define mx23_add_auart1()		mx23_add_auart(1)
>  
> +extern const struct resource res_imx23[RES_SIZE] __initconst;
This doesn't have a namespace, but see below.

> +#define mx23_add_gpmi(pdata)	\
> +	mxs_add_gpmi(pdata, res_imx23, RES_SIZE, GPMI_NFC_DRIVER_MX23)
The less arguments mxs_add_gpmi takes the easier it's to call it. (I.e.
the machine code to set the arguments and call the function is shorter
when there are only two arguments to pass.) See platform-spi_imx.c for
an example to pass a device id.

> +
>  #define mx23_add_mxs_pwm(id)		mxs_add_mxs_pwm(MX23_PWM_BASE_ADDR, id)
>  
>  struct platform_device *__init mx23_add_mxsfb(
> diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
> index 9d08555..64458fd 100644
> --- a/arch/arm/mach-mxs/devices-mx28.h
> +++ b/arch/arm/mach-mxs/devices-mx28.h
> @@ -34,6 +34,10 @@ extern const struct mxs_flexcan_data mx28_flexcan_data[] __initconst;
>  #define mx28_add_flexcan0(pdata)	mx28_add_flexcan(0, pdata)
>  #define mx28_add_flexcan1(pdata)	mx28_add_flexcan(1, pdata)
>  
> +extern const struct resource res_imx28[RES_SIZE] __initconst;
> +#define mx28_add_gpmi(pdata)	\
> +	mxs_add_gpmi(pdata, res_imx28, RES_SIZE, GPMI_NFC_DRIVER_MX28)
> +
ditto
>  extern const struct mxs_i2c_data mx28_mxs_i2c_data[] __initconst;
>  #define mx28_add_mxs_i2c(id)		mxs_add_mxs_i2c(&mx28_mxs_i2c_data[id])
>  
> diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
> index 1451ad0..e9a9a8b 100644
> --- a/arch/arm/mach-mxs/devices/Kconfig
> +++ b/arch/arm/mach-mxs/devices/Kconfig
> @@ -12,6 +12,9 @@ config MXS_HAVE_PLATFORM_FLEXCAN
>  	select HAVE_CAN_FLEXCAN if CAN
>  	bool
>  
> +config MXS_HAVE_PLATFORM_GPMI
> +	bool
> +
>  config MXS_HAVE_PLATFORM_MXS_I2C
>  	bool
>  
> diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
> index 0d9bea3..4f2f66c 100644
> --- a/arch/arm/mach-mxs/devices/Makefile
> +++ b/arch/arm/mach-mxs/devices/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
>  obj-y += platform-dma.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
> +obj-$(CONFIG_MXS_HAVE_PLATFORM_GPMI) += platform-gpmi.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_I2C) += platform-mxs-i2c.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_MXSFB) += platform-mxsfb.o
> diff --git a/arch/arm/mach-mxs/devices/platform-gpmi.c b/arch/arm/mach-mxs/devices/platform-gpmi.c
> new file mode 100644
> index 0000000..46f5e52
> --- /dev/null
> +++ b/arch/arm/mach-mxs/devices/platform-gpmi.c
> @@ -0,0 +1,82 @@
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
> +#include <mach/devices-common.h>
> +
> +#define RES_MEM(soc, _id, _s, _n)			\
> +	{						\
> +		.start = soc ##_## _id,			\
> +		.end   = soc ##_## _id + (_s) - 1,	\
> +		.name  = (_n),				\
> +		.flags = IORESOURCE_MEM,		\
> +	}
> +
> +#define RES_IRQ(soc, _id, _n)			\
> +	{					\
> +		.start = soc ##_## _id,		\
> +		.end   = soc ##_## _id,		\
> +		.name  = (_n),			\
> +		.flags = IORESOURCE_IRQ,	\
> +	}
> +
> +#define RES_DMA(soc, _i_s, _i_e, _n)		\
> +	{					\
> +		.start = soc ##_## _i_s,	\
> +		.end   = soc ##_## _i_e,	\
> +		.name  = (_n),			\
> +		.flags = IORESOURCE_DMA,	\
> +	}
> +
> +#ifdef CONFIG_SOC_IMX23
> +const struct resource res_imx23[RES_SIZE] __initconst = {
> +	/* GPMI */
> +	RES_MEM(MX23, GPMI_BASE_ADDR, SZ_8K, GPMI_NFC_GPMI_REGS_ADDR_RES_NAME),
> +	RES_IRQ(MX23, INT_GPMI_ATTENTION, GPMI_NFC_GPMI_INTERRUPT_RES_NAME),
> +	/* BCH */
> +	RES_MEM(MX23, BCH_BASE_ADDR, SZ_8K, GPMI_NFC_BCH_REGS_ADDR_RES_NAME),
> +	RES_IRQ(MX23, INT_BCH, GPMI_NFC_BCH_INTERRUPT_RES_NAME),
> +	/* DMA */
> +	RES_DMA(MX23, DMA_GPMI0, DMA_GPMI3, GPMI_NFC_DMA_CHANNELS_RES_NAME),
> +	RES_IRQ(MX23, INT_GPMI_DMA, GPMI_NFC_DMA_INTERRUPT_RES_NAME),
> +};
> +#endif
> +
> +#ifdef CONFIG_SOC_IMX28
> +const struct resource res_imx28[RES_SIZE] __initconst = {
> +	/* GPMI */
> +	RES_MEM(MX28, GPMI_BASE_ADDR, SZ_8K, GPMI_NFC_GPMI_REGS_ADDR_RES_NAME),
> +	RES_IRQ(MX28, INT_GPMI, GPMI_NFC_GPMI_INTERRUPT_RES_NAME),
> +	/* BCH */
> +	RES_MEM(MX28, BCH_BASE_ADDR, SZ_8K, GPMI_NFC_BCH_REGS_ADDR_RES_NAME),
> +	RES_IRQ(MX28, INT_BCH, GPMI_NFC_BCH_INTERRUPT_RES_NAME),
> +	/* DMA */
> +	RES_DMA(MX28, DMA_GPMI0, DMA_GPMI7, GPMI_NFC_DMA_CHANNELS_RES_NAME),
> +	RES_IRQ(MX28, INT_GPMI_DMA, GPMI_NFC_DMA_INTERRUPT_RES_NAME),
> +};
> +#endif
See how this is done in platform-spi_imx.c.

> +
> +struct platform_device *__init
> +mxs_add_gpmi(const struct gpmi_nfc_platform_data *data,
> +		const struct resource *res, int res_size, const char *name)
> +{
> +	return mxs_add_platform_device_dmamask(name, -1,
> +				res, res_size,
> +				data, sizeof(*data), DMA_BIT_MASK(32));
> +}
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
