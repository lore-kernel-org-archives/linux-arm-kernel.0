From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 20 Apr 2011 18:48:36 +0800
Subject: [PATCH V2 2/3] ARM: mxs: add GPMI device for imx23
In-Reply-To: <1303123428-12266-2-git-send-email-b32955@freescale.com>
References: <1303123428-12266-1-git-send-email-b32955@freescale.com>
	<1303123428-12266-2-git-send-email-b32955@freescale.com>
Message-ID: <20110420104835.GC1965@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 06:43:47PM +0800, Huang Shijie wrote:
> add the gpmi device for imx23.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/mach-mxs/clock-mx23.c                  |    1 +
>  arch/arm/mach-mxs/devices-mx23.h                |    3 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-gpmi.c       |   71 +++++++++++++++++++++++
>  arch/arm/mach-mxs/include/mach/devices-common.h |   10 +++
>  arch/arm/mach-mxs/mach-mx23evk.c                |   28 +++++++++
>  7 files changed, 117 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi.c
> 
I guess Uwe will put a comment, saying platform-gpmi-nfc.c could be
a better naming to align with driver name.  I have already seen stuff
like gpmi-nfc.h, MXS_HAVE_PLATFORM_GPMI_NFC, imx23-gpmi-nfc,
mxs_add_gpmi_nfc well aligned.

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
> diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
> index c7e14f4..48d4766 100644
> --- a/arch/arm/mach-mxs/devices-mx23.h
> +++ b/arch/arm/mach-mxs/devices-mx23.h
> @@ -21,6 +21,9 @@ extern const struct mxs_auart_data mx23_auart_data[] __initconst;
>  #define mx23_add_auart0()		mx23_add_auart(0)
>  #define mx23_add_auart1()		mx23_add_auart(1)
>  
> +extern const struct mxs_gpmi_data mx23_gpmi_data __initconst;

Uwe will ask what about mxs_gpmi_nfc_data and mx23_gpmi_nfc_data?

> +#define mx23_add_gpmi_nfc(pdata)	mxs_add_gpmi_nfc(pdata, &mx23_gpmi_data)
> +
>  #define mx23_add_mxs_pwm(id)		mxs_add_mxs_pwm(MX23_PWM_BASE_ADDR, id)
>  
>  struct platform_device *__init mx23_add_mxsfb(
> diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
> index 1451ad0..072c8e5 100644
> --- a/arch/arm/mach-mxs/devices/Kconfig
> +++ b/arch/arm/mach-mxs/devices/Kconfig
> @@ -12,6 +12,9 @@ config MXS_HAVE_PLATFORM_FLEXCAN
>  	select HAVE_CAN_FLEXCAN if CAN
>  	bool
>  
> +config MXS_HAVE_PLATFORM_GPMI_NFC
> +	bool
> +
>  config MXS_HAVE_PLATFORM_MXS_I2C
>  	bool
>  
> diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
> index 0d9bea3..7735e45 100644
> --- a/arch/arm/mach-mxs/devices/Makefile
> +++ b/arch/arm/mach-mxs/devices/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
>  obj-y += platform-dma.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
> +obj-$(CONFIG_MXS_HAVE_PLATFORM_GPMI_NFC) += platform-gpmi.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_I2C) += platform-mxs-i2c.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_MXSFB) += platform-mxsfb.o
> diff --git a/arch/arm/mach-mxs/devices/platform-gpmi.c b/arch/arm/mach-mxs/devices/platform-gpmi.c
> new file mode 100644
> index 0000000..3c6c968
> --- /dev/null
> +++ b/arch/arm/mach-mxs/devices/platform-gpmi.c
> @@ -0,0 +1,71 @@
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

This line should be added by the next patch.

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
> +const struct mxs_gpmi_data mx23_gpmi_data __initconst = {
> +	.devid = "imx23-gpmi-nfc",
> +	.res = {
> +	/* GPMI */
> +	RES_MEM(MX23, GPMI_BASE_ADDR, SZ_8K, GPMI_NFC_GPMI_REGS_ADDR_RES_NAME),
> +	RES_IRQ(MX23, INT_GPMI_ATTENTION, GPMI_NFC_GPMI_INTERRUPT_RES_NAME),
> +	/* BCH */
> +	RES_MEM(MX23, BCH_BASE_ADDR, SZ_8K, GPMI_NFC_BCH_REGS_ADDR_RES_NAME),
> +	RES_IRQ(MX23, INT_BCH, GPMI_NFC_BCH_INTERRUPT_RES_NAME),
> +	/* DMA */
> +	RES_DMA(MX23, DMA_GPMI0, DMA_GPMI3, GPMI_NFC_DMA_CHANNELS_RES_NAME),
> +	RES_IRQ(MX23, INT_GPMI_DMA, GPMI_NFC_DMA_INTERRUPT_RES_NAME),

No indention?

> +	},
> +};
> +#endif
> +
> +struct platform_device *__init
> +mxs_add_gpmi_nfc(const struct gpmi_nfc_platform_data *pdata,
> +		const struct mxs_gpmi_data *data)
> +{
> +	return mxs_add_platform_device_dmamask(data->devid, -1,
> +				data->res, RES_SIZE,
> +				pdata, sizeof(*pdata), DMA_BIT_MASK(32));
> +}
> diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
> index 71f2448..fc59c05 100644
> --- a/arch/arm/mach-mxs/include/mach/devices-common.h
> +++ b/arch/arm/mach-mxs/include/mach/devices-common.h
> @@ -64,6 +64,16 @@ struct platform_device *__init mxs_add_flexcan(
>  		const struct mxs_flexcan_data *data,
>  		const struct flexcan_platform_data *pdata);
>  
> +/* gpmi */
> +#include <mach/gpmi-nfc.h>
> +struct mxs_gpmi_data {
> +	const char *devid;
> +	const struct resource res[RES_SIZE];
> +};
> +struct platform_device *__init
> +mxs_add_gpmi_nfc(const struct gpmi_nfc_platform_data *pdata,
> +		const struct mxs_gpmi_data *data);
> +
>  /* i2c */
>  struct mxs_i2c_data {
>  	int id;
> diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
> index a66994f..666e0f8 100644
> --- a/arch/arm/mach-mxs/mach-mx23evk.c
> +++ b/arch/arm/mach-mxs/mach-mx23evk.c
> @@ -40,6 +40,26 @@ static const iomux_cfg_t mx23evk_pads[] __initconst = {
>  	MX23_PAD_AUART1_CTS__AUART1_CTS | MXS_PAD_CTRL,
>  	MX23_PAD_AUART1_RTS__AUART1_RTS | MXS_PAD_CTRL,
>  
> +#define MXS_PAD_GPMI	(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL)
> +	/* gpmi */
> +	MX23_PAD_GPMI_D00__GPMI_D00 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D01__GPMI_D01 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D02__GPMI_D02 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D03__GPMI_D03 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D04__GPMI_D04 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D05__GPMI_D05 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D06__GPMI_D06 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D07__GPMI_D07 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_CLE__GPMI_CLE | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_ALE__GPMI_ALE | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_WPN__GPMI_WPN | MXS_PAD_GPMI,
> +	MX23_PAD_GPMI_WRN__GPMI_WRN | MXS_PAD_GPMI,
> +	MX23_PAD_GPMI_RDN__GPMI_RDN | MXS_PAD_GPMI,
> +	MX23_PAD_GPMI_RDY0__GPMI_RDY0 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_RDY1__GPMI_RDY1 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_CE0N__GPMI_CE0N | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_CE1N__GPMI_CE1N | MXS_PAD_CTRL,
> +
So you did not come along with a solution to pinmux confliction
problem?  There gpmi pads are used by mmc and fb as well.

-- 
Regards,
Shawn
