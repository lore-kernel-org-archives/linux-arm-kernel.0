From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Thu, 3 Jun 2010 15:39:08 +0300
Subject: [V2 1/3] mxc: Add support for the imx51 3-stack board
In-Reply-To: <1275566746-6510-2-git-send-email-jason77.wang@gmail.com>
References: <1275566746-6510-1-git-send-email-jason77.wang@gmail.com>
	<1275566746-6510-2-git-send-email-jason77.wang@gmail.com>
Message-ID: <20100603123908.GB3527@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two comments inline.

On 10 Jun 03, Jason Wang wrote:
> 3-stack is a reference board from Freescale for their i.MX51 SoC.
> 
> Add board definition, Kconfig and Makefile to enable Freescale 3-stack
> board.
> 
> Boot tested on a i.MX51 3-stack Rev2.0 board
> 
> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
> ---
>  arch/arm/mach-mx5/Kconfig                       |    5 +
>  arch/arm/mach-mx5/Makefile                      |    2 +-
>  arch/arm/mach-mx5/board-mx51_3ds.c              |  263 +++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/board-mx51_3ds.h |   70 ++++++
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h     |   10 +-
>  5 files changed, 345 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/mach-mx5/board-mx51_3ds.c
>  create mode 100644 arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 1576d51..6d45f44 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -15,4 +15,9 @@ config MACH_MX51_BABBAGE
>  	  u-boot. This includes specific configurations for the board and its
>  	  peripherals.
>  
> +config MACH_MX51_3DS
> +	bool "Support MX51PDK (3DS)"
> +	help
> +	  Include support for MX51PDK (3DS) platform. This includes specific
> +	  configurations for the board and its peripherals.
>  endif
> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> index bf23f86..c757c59 100644
> --- a/arch/arm/mach-mx5/Makefile
> +++ b/arch/arm/mach-mx5/Makefile
> @@ -6,4 +6,4 @@
>  obj-y   := cpu.o mm.o clock-mx51.o devices.o
>  
>  obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
> -
> +obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
> diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
> new file mode 100644
> index 0000000..5da90e9
> --- /dev/null
> +++ b/arch/arm/mach-mx5/board-mx51_3ds.c
> @@ -0,0 +1,263 @@
> +/*
> + * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright (C) 2010 Jason Wang <jason77.wang@gmail.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/smsc911x.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/common.h>
> +#include <mach/iomux-mx51.h>
> +#include <mach/board-mx51_3ds.h>
> +#include <mach/imx-uart.h>
> +
> +#include "devices.h"
> +
> +static void __iomem *brd_io;
> +
> +static void expio_ack_irq(u32 irq);
> +
> +static struct pad_desc mx51_3ds_pads[] = {
> +	/* UART1 */
> +	MX51_PAD_UART1_RXD__UART1_RXD,
> +	MX51_PAD_UART1_TXD__UART1_TXD,
> +	MX51_PAD_UART1_RTS__UART1_RTS,
> +	MX51_PAD_UART1_CTS__UART1_CTS,
> +
> +	/* UART2 */
> +	MX51_PAD_UART2_RXD__UART2_RXD,
> +	MX51_PAD_UART2_TXD__UART2_TXD,
> +	MX51_PAD_EIM_D25__UART2_CTS,
> +	MX51_PAD_EIM_D26__UART2_RTS,
> +
> +	/* UART3 */
> +	MX51_PAD_GPIO_1_22__UART3_RXD,
> +	MX51_PAD_GPIO_1_23__UART3_TXD,
> +	MX51_PAD_EIM_D24__UART3_CTS,
> +	MX51_PAD_EIM_D27__UART3_RTS,
> +
> +	/* CPLD PARENT IRQ PIN */
> +	MX51_PAD_GPIO_1_6__GPIO1_6,
> +};
> +
> +
> +#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
> +static struct resource smsc911x_resources[] = {
> +	{
> +		.start = LAN9217_BASE_ADDR,
> +		.end = LAN9217_BASE_ADDR + 0x100 - 1,
> +		.flags = IORESOURCE_MEM,
> +	} , {
> +		.start = EXPIO_INT_ENET,
> +		.end = EXPIO_INT_ENET,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct smsc911x_platform_config smsc911x_config = {
> +	.irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
> +	.flags = SMSC911X_USE_32BIT | SMSC911X_FORCE_INTERNAL_PHY,
> +};
> +
> +static struct platform_device smsc_lan9217_device = {
> +	.name = "smsc911x",
> +	.id = 0,
> +	.dev = {
> +		.platform_data = &smsc911x_config,
> +	},
> +	.num_resources = ARRAY_SIZE(smsc911x_resources),
> +	.resource = smsc911x_resources,
> +};

You forgot to move this platform_device to devices.c

> +static void mxc_init_enet(void)
> +{
> +	if (brd_io != NULL)
> +		platform_device_register(&smsc_lan9217_device);
> +}
> +#else
> +static inline void mxc_init_enet(void)
> +{
> +}
> +#endif
> +
> +static void mxc_expio_irq_handler(u32 irq, struct irq_desc *desc)
> +{
> +	u32 imr_val;
> +	u32 int_valid;
> +	u32 expio_irq;
> +
> +	desc->chip->mask(irq);	/* irq = gpio irq number */
> +
> +	imr_val = __raw_readw(brd_io + INTR_MASK_REG);
> +	int_valid = __raw_readw(brd_io + INTR_STATUS_REG) & ~imr_val;
> +
> +	expio_irq = MXC_BOARD_IRQ_START;
> +	for (; int_valid != 0; int_valid >>= 1, expio_irq++) {
> +		struct irq_desc *d;
> +		if ((int_valid & 1) == 0)
> +			continue;
> +		d = irq_desc + expio_irq;
> +		if (unlikely(!(d->handle_irq)))
> +			pr_err("\nEXPIO irq: %d unhandled\n", expio_irq);
> +		else
> +			d->handle_irq(expio_irq, d);
> +	}
> +
> +	desc->chip->ack(irq);
> +	desc->chip->unmask(irq);
> +}
> +
> +/*
> + * Disable an expio pin's interrupt by setting the bit in the imr.
> + * @param irq		an expio virtual irq number
> + */
> +static void expio_mask_irq(u32 irq)
> +{
> +	u16 reg;
> +	u32 expio = MXC_IRQ_TO_EXPIO(irq);
> +
> +	reg = __raw_readw(brd_io + INTR_MASK_REG);
> +	reg |= (1 << expio);
> +	__raw_writew(reg, brd_io + INTR_MASK_REG);
> +}
> +
> +/*
> + * Acknowledge an expanded io pin's interrupt by clearing the bit in the isr.
> + * @param irq		an expanded io virtual irq number
> + */
> +static void expio_ack_irq(u32 irq)
> +{
> +	u32 expio = MXC_IRQ_TO_EXPIO(irq);
> +
> +	__raw_writew(1 << expio, brd_io + INTR_RESET_REG);
> +	__raw_writew(0, brd_io + INTR_RESET_REG);
> +	expio_mask_irq(irq);
> +}
> +
> +/*
> + * Enable a expio pin's interrupt by clearing the bit in the imr.
> + * @param irq		a expio virtual irq number
> + */
> +static void expio_unmask_irq(u32 irq)
> +{
> +	u16 reg;
> +	u32 expio = MXC_IRQ_TO_EXPIO(irq);
> +
> +	reg = __raw_readw(brd_io + INTR_MASK_REG);
> +	reg &= ~(1 << expio);
> +	__raw_writew(reg, brd_io + INTR_MASK_REG);
> +}
> +
> +static struct irq_chip expio_irq_chip = {
> +	.ack = expio_ack_irq,
> +	.mask = expio_mask_irq,
> +	.unmask = expio_unmask_irq,
> +};
> +
> +static int __init mxc_expio_init(void)
> +{
> +	int i;
> +
> +	brd_io = ioremap(BOARD_IO_ADDR, SZ_4K);
> +	if (brd_io == NULL)
> +		return -ENOMEM;
> +
> +	if ((__raw_readw(brd_io + MAGIC_NUMBER1_REG) != 0xAAAA) ||
> +	    (__raw_readw(brd_io + MAGIC_NUMBER2_REG) != 0x5555) ||
> +	    (__raw_readw(brd_io + MAGIC_NUMBER3_REG) != 0xCAFE)) {
> +		pr_info("3-Stack Debug board not detected\n");
> +		iounmap(brd_io);
> +		brd_io = NULL;
> +		return -ENODEV;
> +	}
> +
> +	pr_info("3-Stack Debug board detected, rev = 0x%04X\n",
> +		readw(brd_io + CPLD_CODE_VER_REG));
> +
> +	/*
> +	 * Configure INT line as GPIO input
> +	 */
> +	gpio_request(MX51_3DS_CPLD_IRQ_PIN, "gpio1_6");
> +	gpio_direction_input(MX51_3DS_CPLD_IRQ_PIN);
> +
> +	/* disable the interrupt and clear the status */
> +	__raw_writew(0, brd_io + INTR_MASK_REG);
> +	__raw_writew(0xFFFF, brd_io + INTR_RESET_REG);
> +	__raw_writew(0, brd_io + INTR_RESET_REG);
> +	__raw_writew(0x1F, brd_io + INTR_MASK_REG);
> +	for (i = MXC_EXP_IO_BASE;
> +	     i < (MXC_EXP_IO_BASE + MXC_MAX_EXP_IO_LINES); i++) {
> +		set_irq_chip(i, &expio_irq_chip);
> +		set_irq_handler(i, handle_level_irq);
> +		set_irq_flags(i, IRQF_VALID);
> +	}
> +	set_irq_type(EXPIO_PARENT_INT, IRQF_TRIGGER_LOW);
> +	set_irq_chained_handler(EXPIO_PARENT_INT, mxc_expio_irq_handler);
> +
> +	return 0;
> +}
> +
> +/* Serial ports */
> +#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
> +static struct imxuart_platform_data uart_pdata = {
> +	.flags = IMXUART_HAVE_RTSCTS,
> +};
> +
> +static inline void mxc_init_imx_uart(void)
> +{
> +	mxc_register_device(&mxc_uart_device0, &uart_pdata);
> +	mxc_register_device(&mxc_uart_device1, &uart_pdata);
> +	mxc_register_device(&mxc_uart_device2, &uart_pdata);
> +}
> +#else /* !SERIAL_IMX */
> +static inline void mxc_init_imx_uart(void)
> +{
> +}
> +#endif /* SERIAL_IMX */
> +
> +/*
> + * Board specific initialization.
> + */
> +static void __init mxc_board_init(void)
> +{
> +	mxc_iomux_v3_setup_multiple_pads(mx51_3ds_pads,
> +					ARRAY_SIZE(mx51_3ds_pads));
> +	mxc_init_imx_uart();
> +	mxc_expio_init();
> +	mxc_init_enet();
> +}
> +
> +static void __init mx51_3ds_timer_init(void)
> +{
> +	mx51_clocks_init(32768, 24000000, 22579200, 0);
> +}
> +
> +static struct sys_timer mxc_timer = {
> +	.init	= mx51_3ds_timer_init,
> +};
> +
> +MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
> +	.phys_io = MX51_AIPS1_BASE_ADDR,
> +	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
> +	.boot_params = PHYS_OFFSET + 0x100,
> +	.map_io = mx51_map_io,
> +	.init_irq = mx51_init_irq,
> +	.init_machine = mxc_board_init,
> +	.timer = &mxc_timer,
> +MACHINE_END
> diff --git a/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h b/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
> new file mode 100644
> index 0000000..035f7bc
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
> @@ -0,0 +1,70 @@
> +/*
> + * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#ifndef __ASM_ARCH_MXC_BOARD_MX51_3DS_H__
> +#define __ASM_ARCH_MXC_BOARD_MX51_3DS_H__
> +
> +/*
> + * @file plat-mxc/include/mach/board-mx51_3ds.h
> + *
> + * @brief This file contains all the board level configuration options.

Remove this @file, @brief.

> + * It currently hold the options defined for MX51 3Stack Platform.
> + *
> + */
> +
> +#define DEBUG_BOARD_BASE_ADDRESS MX51_CS5_BASE_ADDR
> +/* LAN9217 ethernet base address */
> +#define LAN9217_BASE_ADDR	(DEBUG_BOARD_BASE_ADDRESS + 0x0)
> +/* External UART */
> +#define UARTA_BASE_ADDR		(DEBUG_BOARD_BASE_ADDRESS + 0x8000)
> +#define UARTB_BASE_ADDR		(DEBUG_BOARD_BASE_ADDRESS + 0x10000)
> +
> +#define BOARD_IO_ADDR		(DEBUG_BOARD_BASE_ADDRESS + 0x20000)
> +/* LED switchs */
> +#define LED_SWITCH_REG		0x00
> +/* buttons */
> +#define SWITCH_BUTTONS_REG	0x08
> +/* status, interrupt */
> +#define INTR_STATUS_REG	0x10
> +#define INTR_MASK_REG		0x38
> +#define INTR_RESET_REG		0x20
> +/* magic word for debug CPLD */
> +#define MAGIC_NUMBER1_REG	0x40
> +#define MAGIC_NUMBER2_REG	0x48
> +/* CPLD code version */
> +#define CPLD_CODE_VER_REG	0x50
> +/* magic word for debug CPLD */
> +#define MAGIC_NUMBER3_REG	0x58
> +/* module reset register*/
> +#define MODULE_RESET_REG	0x60
> +/* CPU ID and Personality ID */
> +#define MCU_BOARD_ID_REG	0x68
> +
> +#define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTA + 6)
> +
> +#define MXC_IRQ_TO_EXPIO(irq)   ((irq) - MXC_BOARD_IRQ_START)
> +
> +#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
> +#define MXC_MAX_EXP_IO_LINES	16
> +
> +/* interrupts like external uart , external ethernet etc*/
> +#define EXPIO_INT_ENET		(MXC_BOARD_IRQ_START + 0)
> +#define EXPIO_INT_XUART_A	(MXC_BOARD_IRQ_START + 1)
> +#define EXPIO_INT_XUART_B	(MXC_BOARD_IRQ_START + 2)
> +#define EXPIO_INT_BUTTON_A	(MXC_BOARD_IRQ_START + 3)
> +#define EXPIO_INT_BUTTON_B	(MXC_BOARD_IRQ_START + 4)
> +
> +/* Define CPLD interrupt pin */
> +#define MX51_3DS_CPLD_IRQ_PIN	(GPIO_PORTA + 6)
> +
> +#endif	/* __ASM_ARCH_MXC_BOARD_MX51_3DS_H__ */
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> index ab0f95d..895c750 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> @@ -70,8 +70,10 @@ typedef enum iomux_config {
>  /* Babbage UART3 */
>  #define MX51_PAD_EIM_D24__UART3_CTS	IOMUX_PAD(0x410, 0x07c, IOMUX_CONFIG_ALT3, 0x0, 0, MX51_UART3_PAD_CTRL)
>  #define MX51_PAD_EIM_D25__UART3_RXD	IOMUX_PAD(0x414, 0x080, IOMUX_CONFIG_ALT3, 0x9f4, 0, MX51_UART3_PAD_CTRL)
> +#define MX51_PAD_EIM_D25__UART2_CTS	IOMUX_PAD(0x414, 0x080, IOMUX_CONFIG_ALT4, 0x0, 0, MX51_UART2_PAD_CTRL)
>  #define MX51_PAD_EIM_D26__UART3_TXD	IOMUX_PAD(0x418, 0x084, IOMUX_CONFIG_ALT3, 0x0, 0, MX51_UART3_PAD_CTRL)
> -#define MX51_PAD_EIM_D27__UART3_RTS	IOMUX_PAD(0x41c, 0x088, IOMUX_CONFIG_ALT3, 0x9f0, 0, MX51_UART3_PAD_CTRL)
> +#define MX51_PAD_EIM_D26__UART2_RTS	IOMUX_PAD(0x418, 0x084, IOMUX_CONFIG_ALT4, 0x9e8, 3, MX51_UART2_PAD_CTRL)
> +#define MX51_PAD_EIM_D27__UART3_RTS	IOMUX_PAD(0x41c, 0x088, IOMUX_CONFIG_ALT3, 0x9f0, 3, MX51_UART3_PAD_CTRL)
>  
>  #define MX51_PAD_EIM_D28__EIM_D28	IOMUX_PAD(0x420, 0x08c, 0, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_D29__EIM_D29	IOMUX_PAD(0x424, 0x090, 0, 0x0,   0, NO_PAD_CTRL)
> @@ -202,8 +204,8 @@ typedef enum iomux_config {
>  #define MX51_PAD_UART2_RXD__UART2_RXD	IOMUX_PAD(0x628, 0x238, IOMUX_CONFIG_ALT0, 0x9ec, 2, MX51_UART2_PAD_CTRL)
>  #define MX51_PAD_UART2_TXD__UART2_TXD	IOMUX_PAD(0x62C, 0x23C, IOMUX_CONFIG_ALT0, 0x0, 0, MX51_UART2_PAD_CTRL)
>  
> -#define MX51_PAD_GPIO_1_22__UART3_RXD	IOMUX_PAD(0x630, 0x240, 3, 0x0, 0, NO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_23__UART3_TXD	IOMUX_PAD(0x634, 0x244, 3, 0x0, 0, NO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_22__UART3_RXD	IOMUX_PAD(0x630, 0x240, IOMUX_CONFIG_ALT1, 0x9f4, 4, MX51_UART3_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_23__UART3_TXD	IOMUX_PAD(0x634, 0x244, IOMUX_CONFIG_ALT1, 0x0, 0, MX51_UART3_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_24__OWIRE_LINE	IOMUX_PAD(0x638, 0x248, 3, 0x0, 0, NO_PAD_CTRL)
>  #define MX51_PAD_KEY_ROW0__KEY_ROW0	IOMUX_PAD(0x63C, 0x24C, 0, 0x0, 0, NO_PAD_CTRL)
>  #define MX51_PAD_KEY_ROW1__KEY_ROW1	IOMUX_PAD(0x640, 0x250, 0, 0x0, 0, NO_PAD_CTRL)
> @@ -306,7 +308,7 @@ typedef enum iomux_config {
>  #define MX51_PAD_PMIC_INT_REQ__PMIC_INT_REQ	IOMUX_PAD(0x7FC, 0x3D4, 0, 0x0, 0, NO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_4__GPIO1_4	IOMUX_PAD(0x804, 0x3D8, 0, 0x0, 0, NO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_5__GPIO1_5	IOMUX_PAD(0x808, 0x3DC, 0, 0x0, 0, NO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_6__GPIO1_6	IOMUX_PAD(0x80C, 0x3E0, 0, 0x0, 0, NO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_6__GPIO1_6	IOMUX_PAD(0x80C, 0x3E0, 0, 0x0, 0, MX51_GPIO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_7__GPIO1_7	IOMUX_PAD(0x810, 0x3E4, 0, 0x0, 0, MX51_GPIO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_8__GPIO1_8	IOMUX_PAD(0x814, 0x3E8, 0, 0x0, 1, \
>  						(PAD_CTL_SRE_SLOW | PAD_CTL_DSE_MED | PAD_CTL_PUS_100K_UP |  PAD_CTL_HYS))
> -- 
> 1.5.6.5
> 

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
