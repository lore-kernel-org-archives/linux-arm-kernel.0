From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 30 Dec 2010 10:46:36 +0100
Subject: [PATCH v3 7/8] arm: mx50: add mx50 reference design board support
In-Reply-To: <1293684968-7338-7-git-send-email-richard.zhao@freescale.com>
References: <1293684968-7338-1-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-2-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-3-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-4-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-5-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-6-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-7-git-send-email-richard.zhao@freescale.com>
Message-ID: <20101230094636.GU14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Richard,

On Thu, Dec 30, 2010 at 12:56:08PM +0800, Richard Zhao wrote:
> Add basic function and uart device support.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/mach-mx5/Kconfig                   |   11 ++
>  arch/arm/mach-mx5/Makefile                  |    1 +
>  arch/arm/mach-mx5/board-mx50_rdp.c          |  206 +++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/uncompress.h |    4 +
>  4 files changed, 222 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mx5/board-mx50_rdp.c
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 8e04a68..12073a7 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -111,4 +111,15 @@ config MACH_MX51_EFIKAMX
>  	  Include support for Genesi Efika MX nettop. This includes specific
>  	  configurations for the board and its peripherals.
>  
> +config MACH_MX50_RDP
> +	bool "Support MX50 reference design platform"
	depends on BROKEN

> +	select SOC_IMX50
> +	select IMX_HAVE_PLATFORM_IMX_I2C
> +	select IMX_HAVE_PLATFORM_IMX_UART
> +	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
> +	select IMX_HAVE_PLATFORM_SPI_IMX
> +	help
> +	  Include support for MX50 reference design platform (RDP) board. This
> +	  includes specific configurations for the board and its peripherals.
> +
>  endif
> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> index e059c30..d99d7ab 100644
> --- a/arch/arm/mach-mx5/Makefile
> +++ b/arch/arm/mach-mx5/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
>  obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += board-cpuimx51sd.o
>  obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd-baseboard.o
>  obj-$(CONFIG_MACH_MX51_EFIKAMX) += board-mx51_efikamx.o
> +obj-$(CONFIG_MACH_MX50_RDP) += board-mx50_rdp.o
> diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
> new file mode 100644
> index 0000000..9a031ea
> --- /dev/null
> +++ b/arch/arm/mach-mx5/board-mx50_rdp.c
> @@ -0,0 +1,206 @@
> +/*
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/fsl_devices.h>
> +
> +#include <mach/common.h>
> +#include <mach/hardware.h>
> +#include <mach/iomux-mx50.h>
> +
> +#include <asm/irq.h>
> +#include <asm/setup.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +
> +#include "devices-mx50.h"
> +
> +static iomux_v3_cfg_t mx50rdp_pads[] __initdata = {
can you use either mx50_rdp or mx50rdp as prefix please?  I'd prefer the
former because it matches the machid.

> +	/* SD1 */
> +	MX50_PAD_ECSPI2_SS0__GPIO_4_19,
> +	MX50_PAD_EIM_CRE__GPIO_1_27,
> +	MX50_PAD_SD1_CMD__SD1_CMD,
> +
> +	MX50_PAD_SD1_CLK__SD1_CLK,
> +	MX50_PAD_SD1_D0__SD1_D0,
> +	MX50_PAD_SD1_D1__SD1_D1,
> +	MX50_PAD_SD1_D2__SD1_D2,
> +	MX50_PAD_SD1_D3__SD1_D3,
> +
> +	/* SD2 */
> +	MX50_PAD_SD2_CD__GPIO_5_17,
> +	MX50_PAD_SD2_WP__GPIO_5_16,
> +	MX50_PAD_SD2_CMD__SD2_CMD,
> +	MX50_PAD_SD2_CLK__SD2_CLK,
> +	MX50_PAD_SD2_D0__SD2_D0,
> +	MX50_PAD_SD2_D1__SD2_D1,
> +	MX50_PAD_SD2_D2__SD2_D2,
> +	MX50_PAD_SD2_D3__SD2_D3,
> +	MX50_PAD_SD2_D4__SD2_D4,
> +	MX50_PAD_SD2_D5__SD2_D5,
> +	MX50_PAD_SD2_D6__SD2_D6,
> +	MX50_PAD_SD2_D7__SD2_D7,
> +
> +	/* SD3 */
> +	MX50_PAD_SD3_CMD__SD3_CMD,
> +	MX50_PAD_SD3_CLK__SD3_CLK,
> +	MX50_PAD_SD3_D0__SD3_D0,
> +	MX50_PAD_SD3_D1__SD3_D1,
> +	MX50_PAD_SD3_D2__SD3_D2,
> +	MX50_PAD_SD3_D3__SD3_D3,
> +	MX50_PAD_SD3_D4__SD3_D4,
> +	MX50_PAD_SD3_D5__SD3_D5,
> +	MX50_PAD_SD3_D6__SD3_D6,
> +	MX50_PAD_SD3_D7__SD3_D7,
> +
> +	/* PWR_INT */
> +	MX50_PAD_ECSPI2_MISO__GPIO_4_18,
> +
> +	/* UART pad setting */
> +	MX50_PAD_UART1_TXD__UART1_TXD,
> +	MX50_PAD_UART1_RXD__UART1_RXD,
> +	MX50_PAD_UART1_RTS__UART1_RTS,
> +	MX50_PAD_UART2_TXD__UART2_TXD,
> +	MX50_PAD_UART2_RXD__UART2_RXD,
> +	MX50_PAD_UART2_CTS__UART2_CTS,
> +	MX50_PAD_UART2_RTS__UART2_RTS,
> +
> +	MX50_PAD_I2C1_SCL__I2C1_SCL,
> +	MX50_PAD_I2C1_SDA__I2C1_SDA,
> +	MX50_PAD_I2C2_SCL__I2C2_SCL,
> +	MX50_PAD_I2C2_SDA__I2C2_SDA,
> +
> +	MX50_PAD_EPITO__USBH1_PWR,
> +	/* Need to comment below line if
> +	 * one needs to debug owire.
> +	 */
> +	MX50_PAD_OWIRE__USBH1_OC,
> +	/* using gpio to control otg pwr */
> +	MX50_PAD_PWM2__GPIO_6_25,
> +	MX50_PAD_I2C3_SCL__USBOTG_OC,
> +
> +	MX50_PAD_SSI_RXC__FEC_MDIO,
> +	MX50_PAD_SSI_RXC__FEC_MDIO,
> +	MX50_PAD_DISP_D0__FEC_TXCLK,
> +	MX50_PAD_DISP_D1__FEC_RX_ER,
> +	MX50_PAD_DISP_D2__FEC_RX_DV,
> +	MX50_PAD_DISP_D3__FEC_RXD1,
> +	MX50_PAD_DISP_D4__FEC_RXD0,
> +	MX50_PAD_DISP_D5__FEC_TX_EN,
> +	MX50_PAD_DISP_D6__FEC_TXD1,
> +	MX50_PAD_DISP_D7__FEC_TXD0,
> +	MX50_PAD_SSI_RXFS__FEC_MDC,
> +	MX50_PAD_I2C3_SDA__GPIO_6_23,
> +	MX50_PAD_ECSPI1_SCLK__GPIO_4_12,
> +
> +	MX50_PAD_CSPI_SS0__CSPI_SS0,
> +	MX50_PAD_ECSPI1_MOSI__CSPI_SS1,
> +	MX50_PAD_CSPI_MOSI__CSPI_MOSI,
> +	MX50_PAD_CSPI_MISO__CSPI_MISO,
> +
> +	/* SGTL500_OSC_EN */
> +	MX50_PAD_UART1_CTS__GPIO_6_8,
> +
> +	/* SGTL_AMP_SHDN */
> +	MX50_PAD_UART3_RXD__GPIO_6_15,
> +
> +	/* Keypad */
> +	MX50_PAD_KEY_COL0__KEY_COL0,
> +	MX50_PAD_KEY_ROW0__KEY_ROW0,
> +	MX50_PAD_KEY_COL1__KEY_COL1,
> +	MX50_PAD_KEY_ROW1__KEY_ROW1,
> +	MX50_PAD_KEY_COL2__KEY_COL2,
> +	MX50_PAD_KEY_ROW2__KEY_ROW2,
> +	MX50_PAD_KEY_COL3__KEY_COL3,
> +	MX50_PAD_KEY_ROW3__KEY_ROW3,
> +	MX50_PAD_EIM_DA0__KEY_COL4,
> +	MX50_PAD_EIM_DA1__KEY_ROW4,
> +	MX50_PAD_EIM_DA2__KEY_COL5,
> +	MX50_PAD_EIM_DA3__KEY_ROW5,
> +	MX50_PAD_EIM_DA4__KEY_COL6,
> +	MX50_PAD_EIM_DA5__KEY_ROW6,
> +	MX50_PAD_EIM_DA6__KEY_COL7,
> +	MX50_PAD_EIM_DA7__KEY_ROW7,
> +	/*EIM pads */
> +	MX50_PAD_EIM_DA8__GPIO_1_8,
> +	MX50_PAD_EIM_DA9__GPIO_1_9,
> +	MX50_PAD_EIM_DA10__GPIO_1_10,
> +	MX50_PAD_EIM_DA11__GPIO_1_11,
> +	MX50_PAD_EIM_DA12__GPIO_1_12,
> +	MX50_PAD_EIM_DA13__GPIO_1_13,
> +	MX50_PAD_EIM_DA14__GPIO_1_14,
> +	MX50_PAD_EIM_DA15__GPIO_1_15,
> +	MX50_PAD_EIM_CS2__GPIO_1_16,
> +	MX50_PAD_EIM_CS1__GPIO_1_17,
> +	MX50_PAD_EIM_CS0__GPIO_1_18,
> +	MX50_PAD_EIM_EB0__GPIO_1_19,
> +	MX50_PAD_EIM_EB1__GPIO_1_20,
> +	MX50_PAD_EIM_WAIT__GPIO_1_21,
> +	MX50_PAD_EIM_BCLK__GPIO_1_22,
> +	MX50_PAD_EIM_RDY__GPIO_1_23,
> +	MX50_PAD_EIM_OE__GPIO_1_24,
> +};
> +
> +/* Serial ports */
> +static const struct imxuart_platform_data uart_pdata __initconst = {
> +	.flags = IMXUART_HAVE_RTSCTS,
> +};
> +
> +static inline void mxc_init_imx_uart(void)
can you please rename the function to (say) mx50_rdp_init_imx_uart (or
just fold it into mx50_rdp_board_init below.

> +{
> +	imx50_add_imx_uart(0, &uart_pdata);
> +	imx50_add_imx_uart(1, &uart_pdata);
> +}
> +
> +/*
> + * Board specific initialization.
> + */
> +static void __init mxc_board_init(void)
mx50_rdp_board_init please

> +{
> +	mxc_iomux_v3_setup_multiple_pads(mx50rdp_pads,
> +					ARRAY_SIZE(mx50rdp_pads));
> +	mxc_init_imx_uart();
> +
> +}
> +
> +static void __init mx50_rdp_timer_init(void)
> +{
> +	/* TODO: call clock init here */
If you ask me, add it here already.  This increases the chance that you
only need to remove the depends on BROKEN above when the clock stuff is
settled.

> +}
> +
> +static struct sys_timer mxc_timer = {
machine prefix please

> +	.init	= mx50_rdp_timer_init,
> +};
> +
> +/*
> + * The following uses standard kernel macros define in arch.h in order to
> + * initialize __mach_desc_MX50_RDP data structure.
hmm, this is pretty standard, IMHO this is not needed.

> + */
> +MACHINE_START(MX50_RDP, "Freescale MX50 Reference Design Platform")
> +	.map_io = mx50_map_io,
> +	.init_irq = mx50_init_irq,
> +	.init_machine = mxc_board_init,
> +	.timer = &mxc_timer,
> +MACHINE_END
> diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
> index 9dd9c20..5ccf3ef 100644
> --- a/arch/arm/plat-mxc/include/mach/uncompress.h
> +++ b/arch/arm/plat-mxc/include/mach/uncompress.h
> @@ -63,6 +63,7 @@ static inline void flush(void)
>  #define MX3X_UART1_BASE_ADDR	0x43F90000
>  #define MX3X_UART2_BASE_ADDR	0x43F94000
>  #define MX51_UART1_BASE_ADDR	0x73fbc000
> +#define MX50_UART1_BASE_ADDR	0x53fbc000
>  
>  static __inline__ void __arch_decomp_setup(unsigned long arch_id)
>  {
> @@ -102,6 +103,9 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
>  	case MACH_TYPE_EUKREA_CPUIMX51SD:
>  		uart_base = MX51_UART1_BASE_ADDR;
>  		break;
> +	case MACH_TYPE_MX50_RDP:
> +		uart_base = MX50_UART1_BASE_ADDR;
> +		break;
>  	default:
>  		break;
>  	}
> -- 

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
