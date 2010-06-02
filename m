From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 Jun 2010 10:52:06 +0200
Subject: [PATCH 1/3] mxc: Add support for the imx51 3-stack board
In-Reply-To: <20100602083807.GM2346@matterhorn.lan>
References: <1275405043-18230-1-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-2-git-send-email-jason77.wang@gmail.com>
	<20100602083807.GM2346@matterhorn.lan>
Message-ID: <20100602085206.GQ26820@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 02, 2010 at 11:38:07AM +0300, Amit Kucheria wrote:
> > +	.dev = {
> > +		.platform_data = &smsc911x_config,
> > +	},
> > +	.num_resources = ARRAY_SIZE(smsc911x_resources),
> > +	.resource = smsc911x_resources,
> > +};
> 
> Separate out the addition of the smsc device into a separate patch. It isn't
> really required for board bringup.

No need to do this.

> 
> > +static void mxc_init_enet(void)
> > +{
> > +	if (cpld_base_addr) {
> > +		smsc_lan9217_device.resource[0].start =
> > +		    LAN9217_BASE_ADDR(cpld_base_addr);
> > +		smsc_lan9217_device.resource[0].end =
> > +		    LAN9217_BASE_ADDR(cpld_base_addr) + 0x100;
> > +		(void)platform_device_register(&smsc_lan9217_device);
> > +	}
> > +}
> > +#else
> > +static inline void mxc_init_enet(void)
> > +{
> > +}
> > +#endif
> > +
> > +static u32 brd_io;
> > +static void expio_ack_irq(u32 irq);
> > +
> > +static void mxc_expio_irq_handler(u32 irq, struct irq_desc *desc)
> > +{
> > +	u32 imr_val;
> > +	u32 int_valid;
> > +	u32 expio_irq;
> > +
> > +	desc->chip->mask(irq);	/* irq = gpio irq number */
> > +
> > +	imr_val = __raw_readw(brd_io + INTR_MASK_REG);
> > +	int_valid = __raw_readw(brd_io + INTR_STATUS_REG) & ~imr_val;
> > +
> > +	if (unlikely(!int_valid))
> > +		goto out;
> > +
> > +	expio_irq = MXC_BOARD_IRQ_START;
> > +	for (; int_valid != 0; int_valid >>= 1, expio_irq++) {
> > +		struct irq_desc *d;
> > +		if ((int_valid & 1) == 0)
> > +			continue;
> > +		d = irq_desc + expio_irq;
> > +		if (unlikely(!(d->handle_irq))) {
> > +			pr_err("\nEXPIO irq: %d unhandled\n", expio_irq);
> > +			BUG();	/* oops */
> > +		}
> > +		d->handle_irq(expio_irq, d);
> > +	}
> > +
> > +out:
> > +	desc->chip->ack(irq);
> > +	desc->chip->unmask(irq);
> > +}
> 
> Just noticed (half-way through the review) that Sascha has commented on most
> of the major problems.
> 
> Could you document expio a little better (how debug board works, at the top of
> this section)? Also, please move expio to another patch as well, I don't
> think a debug board is required for board bringup.

No need to do split this out to another patch, but we should really think about
adding a generic debugboard file common to the 3ds boards. Something like

debugboard_3ds_init(unsigned long base, int irq)

would be nice.

> 
> > +/*
> > + * Disable an expio pin's interrupt by setting the bit in the imr.
> > + * @param irq		an expio virtual irq number
> > + */
> > +static void expio_mask_irq(u32 irq)
> > +{
> > +	u16 reg;
> > +	u32 expio = MXC_IRQ_TO_EXPIO(irq);
> > +	/* mask the interrupt */
> > +	reg = __raw_readw(brd_io + INTR_MASK_REG);
> > +	reg |= (1 << expio);
> > +	__raw_writew(reg, brd_io + INTR_MASK_REG);
> > +}
> > +
> > +/*
> > + * Acknowledge an expanded io pin's interrupt by clearing the bit in the isr.
> > + * @param irq		an expanded io virtual irq number
> > + */
> > +static void expio_ack_irq(u32 irq)
> > +{
> > +	u32 expio = MXC_IRQ_TO_EXPIO(irq);
> > +	/* clear the interrupt status */
> > +	__raw_writew(1 << expio, brd_io + INTR_RESET_REG);
> > +	__raw_writew(0, brd_io + INTR_RESET_REG);
> > +	/* mask the interrupt */
> > +	expio_mask_irq(irq);
> > +}
> > +
> > +/*
> > + * Enable a expio pin's interrupt by clearing the bit in the imr.
> > + * @param irq		a expio virtual irq number
> > + */
> > +static void expio_unmask_irq(u32 irq)
> > +{
> > +	u16 reg;
> > +	u32 expio = MXC_IRQ_TO_EXPIO(irq);
> > +	/* unmask the interrupt */
> > +	reg = __raw_readw(brd_io + INTR_MASK_REG);
> > +	reg &= ~(1 << expio);
> > +	__raw_writew(reg, brd_io + INTR_MASK_REG);
> > +}
> > +
> > +static struct irq_chip expio_irq_chip = {
> > +	.ack = expio_ack_irq,
> > +	.mask = expio_mask_irq,
> > +	.unmask = expio_unmask_irq,
> > +};
> > +
> > +static int __init mxc_expio_init(void)
> > +{
> > +	int i;
> > +
> > +	brd_io = (u32) ioremap(BOARD_IO_ADDR(MX51_CS5_BASE_ADDR), SZ_4K);
> > +	if (brd_io == 0)
> > +		return -ENOMEM;
> > +
> > +	if ((__raw_readw(brd_io + MAGIC_NUMBER1_REG) != 0xAAAA) ||
> > +	    (__raw_readw(brd_io + MAGIC_NUMBER2_REG) != 0x5555) ||
> > +	    (__raw_readw(brd_io + MAGIC_NUMBER3_REG) != 0xCAFE)) {
> > +		pr_info("3-Stack Debug board not detected\n");
> > +		cpld_base_addr = 0;
> > +		return -ENODEV;
> > +	} else {
> > +		cpld_base_addr = MX51_CS5_BASE_ADDR;
> > +	}
> > +
> > +	pr_info("3-Stack Debug board detected, rev = 0x%04X\n",
> > +		readw(brd_io + CPLD_CODE_VER_REG));
> > +
> > +	/*
> > +	 * Configure INT line as GPIO input
> > +	 */
> > +	gpio_request(MX51_3DS_CPLD_IRQ_PIN, "gpio1_6");
> > +	gpio_direction_input(MX51_3DS_CPLD_IRQ_PIN);
> > +
> > +	/* disable the interrupt and clear the status */
> > +	__raw_writew(0, brd_io + INTR_MASK_REG);
> > +	__raw_writew(0xFFFF, brd_io + INTR_RESET_REG);
> > +	__raw_writew(0, brd_io + INTR_RESET_REG);
> > +	__raw_writew(0x1F, brd_io + INTR_MASK_REG);
> > +	for (i = MXC_BOARD_IRQ_START;
> > +	     i < (MXC_BOARD_IRQ_START + MXC_BOARD_IRQS); i++) {
> > +		set_irq_chip(i, &expio_irq_chip);
> > +		set_irq_handler(i, handle_level_irq);
> > +		set_irq_flags(i, IRQF_VALID);
> > +	}
> > +	set_irq_type(EXPIO_PARENT_INT, IRQF_TRIGGER_LOW);
> > +	set_irq_chained_handler(EXPIO_PARENT_INT, mxc_expio_irq_handler);
> > +
> > +	return 0;
> > +}
> > +
> > +/* Serial ports */
> > +#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
> > +static struct imxuart_platform_data uart_pdata = {
> > +	.flags = IMXUART_HAVE_RTSCTS,
> > +};
> > +
> > +static inline void mxc_init_imx_uart(void)
> > +{
> > +	mxc_register_device(&mxc_uart_device0, &uart_pdata);
> > +	mxc_register_device(&mxc_uart_device1, &uart_pdata);
> > +	mxc_register_device(&mxc_uart_device2, &uart_pdata);
> > +}
> > +#else /* !SERIAL_IMX */
> > +static inline void mxc_init_imx_uart(void)
> > +{
> > +}
> > +#endif /* SERIAL_IMX */
> > +
> > +/*
> > + * Board specific initialization.
> > + */
> > +static void __init mxc_board_init(void)
> > +{
> > +	mxc_iomux_v3_setup_multiple_pads(mx51_3ds_pads,
> > +					ARRAY_SIZE(mx51_3ds_pads));
> > +	mxc_init_imx_uart();
> > +	mxc_expio_init();
> > +	mxc_init_enet();
> > +	mxc_init_keypad();
> > +}
> > +
> > +static void __init mx51_3ds_timer_init(void)
> > +{
> > +	mx51_clocks_init(32768, 24000000, 22579200, 24576000);
> > +}
> > +
> > +static struct sys_timer mxc_timer = {
> > +	.init	= mx51_3ds_timer_init,
> > +};
> > +
> > +MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
> > +	.phys_io = MX51_AIPS1_BASE_ADDR,
> > +	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
> > +	.boot_params = PHYS_OFFSET + 0x100,
> > +	.map_io = mx51_map_io,
> > +	.init_irq = mx51_init_irq,
> > +	.init_machine = mxc_board_init,
> > +	.timer = &mxc_timer,
> > +MACHINE_END
> > diff --git a/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h b/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
> > new file mode 100644
> > index 0000000..6900a7f
> > --- /dev/null
> > +++ b/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
> > @@ -0,0 +1,73 @@
> > +/*
> > + * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
> > + *
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#ifndef __ASM_ARCH_MXC_BOARD_MX51_3DS_H__
> > +#define __ASM_ARCH_MXC_BOARD_MX51_3DS_H__
> > +
> > +/*
> > + * @file plat-mxc/include/mach/board-mx51_3ds.h
> > + *
> > + * @brief This file contains all the board level configuration options.
> > + *
> > + * It currently hold the options defined for MX51 3Stack Platform.
> > + *
> > + */
> > +
> > +#define MXC_LL_UART_PADDR	UART1_BASE_ADDR
> > +#define MXC_LL_UART_VADDR	AIPS1_IO_ADDRESS(UART1_BASE_ADDR)
> > +
> > +#define DEBUG_BOARD_BASE_ADDRESS(n)	(n)
> > +/* LAN9217 ethernet base address */
> > +#define LAN9217_BASE_ADDR(n)	(DEBUG_BOARD_BASE_ADDRESS(n))
> > +/* External UART */
> > +#define UARTA_BASE_ADDR(n)	(DEBUG_BOARD_BASE_ADDRESS(n) + 0x8000)
> > +#define UARTB_BASE_ADDR(n)	(DEBUG_BOARD_BASE_ADDRESS(n) + 0x10000)
> > +
> > +#define BOARD_IO_ADDR(n)	(DEBUG_BOARD_BASE_ADDRESS(n) + 0x20000)
> > +/* LED switchs */
> > +#define LED_SWITCH_REG		0x00
> > +/* buttons */
> > +#define SWITCH_BUTTONS_REG	0x08
> > +/* status, interrupt */
> > +#define INTR_STATUS_REG	0x10
> > +#define INTR_MASK_REG		0x38
> > +#define INTR_RESET_REG		0x20
> > +/* magic word for debug CPLD */
> > +#define MAGIC_NUMBER1_REG	0x40
> > +#define MAGIC_NUMBER2_REG	0x48
> > +/* CPLD code version */
> > +#define CPLD_CODE_VER_REG	0x50
> > +/* magic word for debug CPLD */
> > +#define MAGIC_NUMBER3_REG	0x58
> > +/* module reset register*/
> > +#define MODULE_RESET_REG	0x60
> > +/* CPU ID and Personality ID */
> > +#define MCU_BOARD_ID_REG	0x68
> > +
> > +/* interrupts like external uart , external ethernet etc*/
> > +#define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTA + 6)
> > +
> > +#define MXC_IRQ_TO_EXPIO(irq)   ((irq) - MXC_BOARD_IRQ_START)
> > +
> > +#define EXPIO_INT_ENET		(MXC_BOARD_IRQ_START + 0)
> > +#define EXPIO_INT_XUART_A	(MXC_BOARD_IRQ_START + 1)
> > +#define EXPIO_INT_XUART_B	(MXC_BOARD_IRQ_START + 2)
> > +#define EXPIO_INT_BUTTON_A	(MXC_BOARD_IRQ_START + 3)
> > +#define EXPIO_INT_BUTTON_B	(MXC_BOARD_IRQ_START + 4)
> > +
> > +/* This is System IRQ used by LAN9217 */
> > +#define LAN9217_IRQ	EXPIO_INT_ENET
> > +
> > +/* Define CPLD interrupt pin */
> > +#define MX51_3DS_CPLD_IRQ_PIN	(GPIO_PORTA + 6)
> > +
> > +#endif	/* __ASM_ARCH_MXC_BOARD_MX51_3DS_H__ */
> > diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51-3ds.h b/arch/arm/plat-mxc/include/mach/iomux-mx51-3ds.h
> > new file mode 100644
> > index 0000000..33f1141
> 
> Get rid of this file and add what you need to the common iomux-mx51.h
> 
> > --- /dev/null
> > +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51-3ds.h
> > @@ -0,0 +1,43 @@
> > +/*
> > + * Copyright (C) 2010 Freescale Semiconductor, Inc.
> > + * Copyright (C) 2010 Jason Wang <jason77.wang@gmail.com>
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +#ifndef __MACH_IOMUX_MX51_3DS_H__
> > +#define __MACH_IOMUX_MX51_3DS_H__
> > +
> > +#include <mach/iomux-mx51.h>
> > +
> > +/* UART1 */
> > +#define MX51_3DS_PAD_UART1_RXD__UART1_RXD	MX51_PAD_UART1_RXD__UART1_RXD
> > +#define MX51_3DS_PAD_UART1_TXD__UART1_TXD	MX51_PAD_UART1_TXD__UART1_TXD
> > +#define MX51_3DS_PAD_UART1_RTS__UART1_RTS	MX51_PAD_UART1_RTS__UART1_RTS
> > +#define MX51_3DS_PAD_UART1_CTS__UART1_CTS	MX51_PAD_UART1_CTS__UART1_CTS
> > +
> > +/* UART2 */
> > +#define MX51_3DS_PAD_UART2_RXD__UART2_RXD	MX51_PAD_UART2_RXD__UART2_RXD
> > +#define MX51_3DS_PAD_UART2_TXD__UART2_TXD	MX51_PAD_UART2_TXD__UART2_TXD
> > +#define MX51_3DS_PAD_EIM_D25__UART2_CTS		IOMUX_PAD(0x414, 0x080, IOMUX_CONFIG_ALT4, 0x0, 0, \
> > +						(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST))
> > +#define MX51_3DS_PAD_EIM_D26__UART2_RTS		IOMUX_PAD(0x418, 0x084, IOMUX_CONFIG_ALT4, 0x9e8, 3, \
> > +						(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST))
> > +
> > +/* UART3 */
> > +#define MX51_3DS_PAD_GPIO_1_22__UART3_RXD	IOMUX_PAD(0x630, 0x240, IOMUX_CONFIG_ALT1, 0x9f4, 4, \
> > +						(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST))
> > +#define MX51_3DS_PAD_GPIO_1_23__UART3_TXD	IOMUX_PAD(0x634, 0x244, IOMUX_CONFIG_ALT1, 0x0, 0, \
> > +						(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST))
> > +#define MX51_3DS_PAD_EIM_D24__UART3_CTS		IOMUX_PAD(0x410, 0x07c, IOMUX_CONFIG_ALT3, 0x0, 0, \
> > +						(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST))
> > +#define MX51_3DS_PAD_EIM_D27__UART3_RTS		IOMUX_PAD(0x41c, 0x088, IOMUX_CONFIG_ALT3, 0x9f0, 3, \
> > +						(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST))
> > +/* CPLD */
> > +#define MX51_3DS_PAD_GPIO_1_6__GPIO1_6		IOMUX_PAD(0x80C, 0x3E0, 0, 0x0, 0, MX51_GPIO_PAD_CTRL)
> > +
> > +#endif /* __MACH_IOMUX_MX51_3DS_H__ */
> > -- 
> > 1.5.6.5
> > 
> 
> -- 
> ----------------------------------------------------------------------
> Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
> ----------------------------------------------------------------------
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
