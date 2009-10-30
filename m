From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 30 Oct 2009 12:08:41 +0100
Subject: [PATCH] Add KZM-ARM11-01 support
In-Reply-To: <20091030135343.b907e5de.yuasa@linux-mips.org>
References: <20091030135343.b907e5de.yuasa@linux-mips.org>
Message-ID: <20091030110841.GF11014@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yoichi,

comments inline.

  Sascha

On Fri, Oct 30, 2009 at 01:53:43PM +0900, Yoichi Yuasa wrote:
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  arch/arm/configs/kzmarm11_defconfig             |  844 +++++++++++++++++++++++
>  arch/arm/mach-mx3/Kconfig                       |    8 +
>  arch/arm/mach-mx3/Makefile                      |    1 +
>  arch/arm/mach-mx3/kzmarm11.c                    |  288 ++++++++
>  arch/arm/plat-mxc/include/mach/board-kzmarm11.h |   39 +
>  arch/arm/plat-mxc/include/mach/iomux-mx3.h      |    8 +
>  6 files changed, 1188 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/configs/kzmarm11_defconfig
>  create mode 100644 arch/arm/mach-mx3/kzmarm11.c
>  create mode 100644 arch/arm/plat-mxc/include/mach/board-kzmarm11.h
> 
> diff --git a/arch/arm/configs/kzmarm11_defconfig b/arch/arm/configs/kzmarm11_defconfig

What are your reasons to provide a defconfig for this board? The
preferred way is to add a new board to mx3_defconfig.

[snip]

> diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
> index 851f245..cde29df 100644
> --- a/arch/arm/mach-mx3/Kconfig
> +++ b/arch/arm/mach-mx3/Kconfig
> @@ -100,4 +100,12 @@ config MACH_MX35_3DS
>  	help
>  	  Include support for MX35PDK platform. This includes specific
>  	  configurations for the board and its peripherals.
> +
> +config MACH_KZM_ARM11_01
> +	bool "Support KZM-ARM11-01(Kyoto Microcomputer)"
> +	select ARCH_MX31
> +	help
> +	  Include support for KZM-ARM11-01. This includes specific
> +	  configurations for the board and its peripherals.
> +
>  endif
> diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
> index 6b97754..5537a10 100644
> --- a/arch/arm/mach-mx3/Makefile
> +++ b/arch/arm/mach-mx3/Makefile
> @@ -19,3 +19,4 @@ obj-$(CONFIG_MACH_QONG)		+= qong.o
>  obj-$(CONFIG_MACH_PCM043)	+= pcm043.o
>  obj-$(CONFIG_MACH_ARMADILLO5X0) += armadillo5x0.o
>  obj-$(CONFIG_MACH_MX35_3DS)	+= mx35pdk.o
> +obj-$(CONFIG_MACH_KZM_ARM11_01)	+= kzmarm11.o
> diff --git a/arch/arm/mach-mx3/kzmarm11.c b/arch/arm/mach-mx3/kzmarm11.c
> new file mode 100644
> index 0000000..8b70edf
> --- /dev/null
> +++ b/arch/arm/mach-mx3/kzmarm11.c
> @@ -0,0 +1,288 @@
> +/*
> + * KZM-ARM11-01 support
> + *  Copyright (C) 2009  Yoichi Yuasa <yuasa@linux-mips.org>
> + *
> + * based on code for MX31ADS,
> + *  Copyright (C) 2000 Deep Blue Solutions Ltd
> + *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
> + *  Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
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
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/serial_8250.h>
> +#include <linux/smsc911x.h>
> +#include <linux/types.h>
> +
> +#include <asm/irq.h>

linux/irq.h

> +#include <asm/mach-types.h>
> +#include <asm/setup.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/irq.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/time.h>
> +
> +#include <mach/board-kzmarm11.h>
> +#include <mach/clock.h>
> +#include <mach/common.h>
> +#include <mach/gpio.h>
> +#include <mach/imx-uart.h>
> +#include <mach/iomux-mx3.h>
> +#include <mach/memory.h>
> +
> +#include "devices.h"
> +
> +#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
> +
> +/*
> + * KZM-ARM11-01 has an external UART on FPGA
> + */
> +static struct plat_serial8250_port serial_platform_data[] = {
> +	{
> +		.membase	= IO_ADDRESS(KZM_ARM11_16550),
> +		.mapbase	= KZM_ARM11_16550,
> +		.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_1),
> +		.uartclk	= 14745600,
> +		.regshift	= 0,
> +		.iotype		= UPIO_MEM,
> +		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
> +				  UPF_BUGGY_UART,
> +	},
> +	{},
> +};
> +
> +static struct resource serial8250_resources[] = {
> +	{
> +		.start	= KZM_ARM11_16550,
> +		.end	= KZM_ARM11_16550 + 0x10,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		.start	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_1),
> +		.end	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_1),
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device serial_device = {
> +	.name		= "serial8250",
> +	.id		= PLAT8250_DEV_PLATFORM,
> +	.dev		= {
> +				.platform_data = serial_platform_data,
> +			  },
> +	.num_resources	= 2,

ARRAY_SIZE(serial8250_resources)

> +	.resource	= serial8250_resources,
> +};
> +
> +static int __init kzm_init_ext_uart(void)
> +{
> +	u8 tmp;
> +
> +	/*
> +	 * GPIO 1-1: external UART interrupt line
> +	 */
> +	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO));
> +	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1), "ext-uart-int");
> +	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
> +
> +	set_irq_type(IOMUX_TO_IRQ(MX31_PIN_GPIO1_1), IRQ_TYPE_EDGE_RISING);

Please pass IRQ_TYPE_EDGE_RISING to the irq_flags field in
plat_serial8250_port. It will do the right thing.

> +
> +	/* 
> +	 * Unmask UART interrupt 

While at it please remove the trailing whitespaces here.

> +	 */
> +        tmp = __raw_readb(IO_ADDRESS(KZM_ARM11_CTL1));
> +	tmp |= 0x2;
> +        __raw_writeb(tmp, IO_ADDRESS(KZM_ARM11_CTL1));
> +
> +	return platform_device_register(&serial_device);
> +}
> +#else
> +static inline int kzm_init_ext_uart(void)
> +{
> +	return 0;
> +}
> +#endif
> +
> +/*
> + * SMSC LAN9118
> + */
> +#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
> +
> +static struct smsc911x_platform_config kzm_smsc9118_config = {
> +	.phy_interface	= PHY_INTERFACE_MODE_MII,
> +	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
> +	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
> +	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
> +};
> +
> +static struct resource kzm_smsc9118_resources[] = {
> +	{
> +		.start	= CS5_BASE_ADDR,
> +		.end	= CS5_BASE_ADDR + SZ_128K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		.start	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_2),
> +		.end	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_2),
> +		.flags	= IORESOURCE_IRQ,

please use IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE here...

> +	},
> +};
> +
> +static struct platform_device kzm_smsc9118_device = {
> +	.name		= "smsc911x",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(kzm_smsc9118_resources),
> +	.resource	= kzm_smsc9118_resources,
> +	.dev		= {
> +				.platform_data = &kzm_smsc9118_config,
> +			  },
> +};
> +
> +static int kzm_init_smsc9118(void)
> +{
> +	/*
> +	 * GPIO 1-2: SMSC9118 interrupt line
> +	 */
> +	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_GPIO1_2, IOMUX_CONFIG_GPIO));
> +	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2), "smsc9118-int");
> +	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
> +
> +	set_irq_type(IOMUX_TO_IRQ(MX31_PIN_GPIO1_2), IRQ_TYPE_EDGE_RISING);

...then you can remove this.

> +
> +	return platform_device_register(&kzm_smsc9118_device);
> +}
> +#else
> +static inline void kzm_init_smsc9118(void)
> +{
> +}
> +#endif
> +
> +#ifdef CONFIG_SERIAL_IMX
> +static int mxc_uart0_pins[] = {
> +	MX31_PIN_CTS1__CTS1,
> +	MX31_PIN_RTS1__RTS1,
> +	MX31_PIN_TXD1__TXD1,
> +	MX31_PIN_RXD1__RXD1,
> +	MX31_PIN_DCD_DCE1__DCD_DCE1,
> +	MX31_PIN_RI_DCE1__RI_DCE1,
> +	MX31_PIN_DSR_DCE1__DSR_DCE1,
> +	MX31_PIN_DTR_DCE1__DTR_DCE1,
> +};
> +
> +static int mxc_uart1_pins[] = {
> +	MX31_PIN_CTS2__CTS2,
> +	MX31_PIN_RTS2__RTS2,
> +	MX31_PIN_TXD2__TXD2,
> +	MX31_PIN_RXD2__RXD2,
> +	MX31_PIN_DCD_DTE1__DCD_DTE2,
> +	MX31_PIN_RI_DTE1__RI_DTE2,
> +	MX31_PIN_DSR_DTE1__DSR_DTE2,
> +	MX31_PIN_DTR_DTE1__DTR_DTE2,
> +};

You can combine these two arrays into one. Also, I would prefer not to
setup the pins depending on CONFIG_SERIAL_IMX.

> +
> +static struct imxuart_platform_data uart_pdata = {
> +        .flags = IMXUART_HAVE_RTSCTS,
> +};
> +
> +static void kzm_init_imx_uart(void)
> +{
> +	mxc_iomux_setup_multiple_pins(mxc_uart0_pins,
> +				      ARRAY_SIZE(mxc_uart0_pins), "uart-0");
> +	mxc_register_device(&mxc_uart_device0, &uart_pdata);
> +
> +	mxc_iomux_setup_multiple_pins(mxc_uart1_pins,
> +				      ARRAY_SIZE(mxc_uart1_pins), "uart-1");
> +	mxc_register_device(&mxc_uart_device1, &uart_pdata);
> +}
> +#else
> +static inline void kzm_init_imx_uart(void)
> +{
> +}
> +#endif
> +
> +
> +/*
> + * Board specific initialization.
> + */
> +static void __init kzm_board_init(void)
> +{
> +	kzm_init_ext_uart();
> +	kzm_init_smsc9118();
> +	kzm_init_imx_uart();
> +
> +	pr_info("Clock input source is 26MHz\n");
> +}
> +
> +/*
> + * This structure defines static mappings for the kzm-arm11-01 board.
> + */
> +static struct map_desc kzm_io_desc[] __initdata = {
> +	{
> +		.virtual        = AIPS1_BASE_ADDR_VIRT,
> +		.pfn            = __phys_to_pfn(AIPS1_BASE_ADDR),
> +		.length         = AIPS1_SIZE,
> +		.type           = MT_DEVICE_NONSHARED
> +	}, {

This duplicates a mapping already done in mx31_map_io()

> +		.virtual        = AIPS2_BASE_ADDR_VIRT,
> +		.pfn            = __phys_to_pfn(AIPS2_BASE_ADDR),
> +		.length         = AIPS2_SIZE,
> +		.type           = MT_DEVICE_NONSHARED
> +	}, {

ditto

> +		.virtual	= CS4_BASE_ADDR_VIRT,
> +		.pfn		= __phys_to_pfn(CS4_BASE_ADDR),
> +		.length		= CS4_SIZE,
> +		.type		= MT_DEVICE
> +	},
> +	{
> +		.virtual	= CS5_BASE_ADDR_VIRT,
> +		.pfn		= __phys_to_pfn(CS5_BASE_ADDR),
> +		.length		= CS5_SIZE,
> +		.type		= MT_DEVICE
> +	},
> +};
> +
> +/*
> + * Set up static virtual mappings.
> + */
> +void __init kzm_map_io(void)

static

> +{
> +	mx31_map_io();
> +	iotable_init(kzm_io_desc, ARRAY_SIZE(kzm_io_desc));
> +}
> +
> +static void __init kzm_timer_init(void)
> +{
> +	mx31_clocks_init(26000000);
> +}
> +
> +struct sys_timer kzm_timer = {

static

> +	.init   = kzm_timer_init,
> +};
> +
> +/*
> + * The following uses standard kernel macros define in arch.h in order to
> + * initialize __mach_desc_KZM_ARM11_01 data structure.
> + */
> +MACHINE_START(KZM_ARM11_01, "Kyoto Microcomputer Co., Ltd. KZM-ARM11-01")
> +	.phys_io        = AIPS1_BASE_ADDR,
> +	.io_pg_offst    = ((AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
> +	.boot_params    = PHYS_OFFSET + 0x100,
> +	.map_io         = kzm_map_io,
> +	.init_irq       = mx31_init_irq,
> +	.init_machine   = kzm_board_init,
> +	.timer          = &kzm_timer,
> +MACHINE_END
> diff --git a/arch/arm/plat-mxc/include/mach/board-kzmarm11.h b/arch/arm/plat-mxc/include/mach/board-kzmarm11.h
> new file mode 100644
> index 0000000..05ff2f3
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/board-kzmarm11.h
> @@ -0,0 +1,39 @@
> +/*
> + *  Copyright (C) 2009  Yoichi Yuasa <yuasa@linux-mips.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +#ifndef __ARM_ARCH_BOARD_KZM_ARM11_H
> +#define __ARM_ARCH_BOARD_KZM_ARM11_H
> +
> +/*
> + *  KZM-ARM11-01 Board Control Registers on FPGA
> + */
> +#define KZM_ARM11_CTL1		(CS4_BASE_ADDR + 0x1000)
> +#define KZM_ARM11_CTL2		(CS4_BASE_ADDR + 0x1001)
> +#define KZM_ARM11_RSW1		(CS4_BASE_ADDR + 0x1002)
> +#define KZM_ARM11_BACK_LIGHT	(CS4_BASE_ADDR + 0x1004)
> +#define KZM_ARM11_FPGA_REV	(CS4_BASE_ADDR + 0x1008)
> +#define KZM_ARM11_7SEG_LED	(CS4_BASE_ADDR + 0x1010)
> +#define KZM_ARM11_LEDS		(CS4_BASE_ADDR + 0x1020)
> +#define KZM_ARM11_DIPSW2	(CS4_BASE_ADDR + 0x1003)
> +
> +/*
> + * External UART for touch panel on FPGA
> + */
> +#define KZM_ARM11_16550		(CS4_BASE_ADDR + 0x1050)
> +
> +#endif /* __ARM_ARCH_BOARD_KZM_ARM11_H */
> +
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
> index 446f867..c9ef1ec 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx3.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
> @@ -524,10 +524,18 @@ enum iomux_pins {
>  #define MX31_PIN_RTS1__RTS1		IOMUX_MODE(MX31_PIN_RTS1, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_TXD1__TXD1		IOMUX_MODE(MX31_PIN_TXD1, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_RXD1__RXD1		IOMUX_MODE(MX31_PIN_RXD1, IOMUX_CONFIG_FUNC)
> +#define MX31_PIN_DCD_DCE1__DCD_DCE1	IOMUX_MODE(MX31_PIN_DCD_DCE1, IOMUX_CONFIG_FUNC)
> +#define MX31_PIN_RI_DCE1__RI_DCE1	IOMUX_MODE(MX31_PIN_RI_DCE1, IOMUX_CONFIG_FUNC)
> +#define MX31_PIN_DSR_DCE1__DSR_DCE1	IOMUX_MODE(MX31_PIN_DSR_DCE1, IOMUX_CONFIG_FUNC)
> +#define MX31_PIN_DTR_DCE1__DTR_DCE1	IOMUX_MODE(MX31_PIN_DTR_DCE1, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_CTS2__CTS2		IOMUX_MODE(MX31_PIN_CTS2, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_RTS2__RTS2		IOMUX_MODE(MX31_PIN_RTS2, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_TXD2__TXD2		IOMUX_MODE(MX31_PIN_TXD2, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_RXD2__RXD2		IOMUX_MODE(MX31_PIN_RXD2, IOMUX_CONFIG_FUNC)
> +#define MX31_PIN_DCD_DTE1__DCD_DTE2	IOMUX_MODE(MX31_PIN_DCD_DTE1, IOMUX_CONFIG_ALT1)
> +#define MX31_PIN_RI_DTE1__RI_DTE2	IOMUX_MODE(MX31_PIN_RI_DTE1, IOMUX_CONFIG_ALT1)
> +#define MX31_PIN_DSR_DTE1__DSR_DTE2	IOMUX_MODE(MX31_PIN_DSR_DTE1, IOMUX_CONFIG_ALT1)
> +#define MX31_PIN_DTR_DTE1__DTR_DTE2	IOMUX_MODE(MX31_PIN_DTR_DTE1, IOMUX_OCONFIG_ALT3 | IOMUX_ICONFIG_NONE)
>  #define MX31_PIN_PC_RST__CTS5		IOMUX_MODE(MX31_PIN_PC_RST, IOMUX_CONFIG_ALT2)
>  #define MX31_PIN_PC_VS2__RTS5		IOMUX_MODE(MX31_PIN_PC_VS2, IOMUX_CONFIG_ALT2)
>  #define MX31_PIN_PC_BVD2__TXD5		IOMUX_MODE(MX31_PIN_PC_BVD2, IOMUX_CONFIG_ALT2)
> -- 
> 1.6.5.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
