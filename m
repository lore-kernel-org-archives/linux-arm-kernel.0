From: jason77.wang@gmail.com (Jason Wang)
Date: Tue,  1 Jun 2010 23:10:41 +0800
Subject: [PATCH 1/3] mxc: Add support for the imx51 3-stack board
In-Reply-To: <1275405043-18230-1-git-send-email-jason77.wang@gmail.com>
References: <1275405043-18230-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <1275405043-18230-2-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

3-stack is a reference board from Freescale for their i.MX51 SoC.

Add board definition, Kconfig and Makefile to enable Freescale 3-stack
board.

Boot tested on a i.MX51 3-stack Rev2.0 board

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/mach-mx5/Kconfig                       |    5 +
 arch/arm/mach-mx5/Makefile                      |    2 +-
 arch/arm/mach-mx5/board-mx51_3ds.c              |  356 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/board-mx51_3ds.h |   73 +++++
 arch/arm/plat-mxc/include/mach/iomux-mx51-3ds.h |   43 +++
 5 files changed, 478 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-mx51_3ds.c
 create mode 100644 arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
 create mode 100644 arch/arm/plat-mxc/include/mach/iomux-mx51-3ds.h

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 1576d51..6d45f44 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -15,4 +15,9 @@ config MACH_MX51_BABBAGE
 	  u-boot. This includes specific configurations for the board and its
 	  peripherals.
 
+config MACH_MX51_3DS
+	bool "Support MX51PDK (3DS)"
+	help
+	  Include support for MX51PDK (3DS) platform. This includes specific
+	  configurations for the board and its peripherals.
 endif
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index bf23f86..c757c59 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -6,4 +6,4 @@
 obj-y   := cpu.o mm.o clock-mx51.o devices.o
 
 obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
-
+obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
new file mode 100644
index 0000000..604fb26
--- /dev/null
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -0,0 +1,356 @@
+/*
+ * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2010 Jason Wang <jason77.wang@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/smsc911x.h>
+#include <linux/input/matrix_keypad.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include <mach/hardware.h>
+#include <mach/common.h>
+#include <mach/iomux-mx51-3ds.h>
+#include <mach/board-mx51_3ds.h>
+#include <mach/gpio.h>
+#include <mach/imx-uart.h>
+
+#include "devices.h"
+
+static struct pad_desc mx51_3ds_pads[] = {
+	/* UART1 */
+	MX51_3DS_PAD_UART1_RXD__UART1_RXD,
+	MX51_3DS_PAD_UART1_TXD__UART1_TXD,
+	MX51_3DS_PAD_UART1_RTS__UART1_RTS,
+	MX51_3DS_PAD_UART1_CTS__UART1_CTS,
+
+	/* UART2 */
+	MX51_3DS_PAD_UART2_RXD__UART2_RXD,
+	MX51_3DS_PAD_UART2_TXD__UART2_TXD,
+	MX51_3DS_PAD_EIM_D25__UART2_CTS,
+	MX51_3DS_PAD_EIM_D26__UART2_RTS,
+
+	/* UART3 */
+	MX51_3DS_PAD_GPIO_1_22__UART3_RXD,
+	MX51_3DS_PAD_GPIO_1_23__UART3_TXD,
+	MX51_3DS_PAD_EIM_D24__UART3_CTS,
+	MX51_3DS_PAD_EIM_D27__UART3_RTS,
+
+	/* CPLD PARENT IRQ PIN */
+	MX51_3DS_PAD_GPIO_1_6__GPIO1_6,
+
+	/* KPP */
+	MX51_PAD_KEY_ROW0__KEY_ROW0,
+	MX51_PAD_KEY_ROW1__KEY_ROW1,
+	MX51_PAD_KEY_ROW2__KEY_ROW2,
+	MX51_PAD_KEY_ROW3__KEY_ROW3,
+	MX51_PAD_KEY_COL0__KEY_COL0,
+	MX51_PAD_KEY_COL1__KEY_COL1,
+	MX51_PAD_KEY_COL2__KEY_COL2,
+	MX51_PAD_KEY_COL3__KEY_COL3,
+	MX51_PAD_KEY_COL4__KEY_COL4,
+	MX51_PAD_KEY_COL5__KEY_COL5,
+};
+
+#if defined(CONFIG_KEYBOARD_IMX) || defined(CONFIG_KEYBOARD_IMX_MODULE)
+static int mx51_3ds_board_keymap[] = {
+	KEY(0, 0, KEY_1),
+	KEY(0, 1, KEY_2),
+	KEY(0, 2, KEY_3),
+	KEY(0, 3, KEY_F1),
+	KEY(0, 4, KEY_UP),
+	KEY(0, 5, KEY_F2),
+
+	KEY(1, 0, KEY_4),
+	KEY(1, 1, KEY_5),
+	KEY(1, 2, KEY_6),
+	KEY(1, 3, KEY_LEFT),
+	KEY(1, 4, KEY_SELECT),
+	KEY(1, 5, KEY_RIGHT),
+
+	KEY(2, 0, KEY_7),
+	KEY(2, 1, KEY_8),
+	KEY(2, 2, KEY_9),
+	KEY(2, 3, KEY_F3),
+	KEY(2, 4, KEY_DOWN),
+	KEY(2, 5, KEY_F4),
+
+	KEY(3, 0, KEY_0),
+	KEY(3, 1, KEY_OK),
+	KEY(3, 2, KEY_ESC),
+	KEY(3, 3, KEY_ENTER),
+	KEY(3, 4, KEY_MENU),
+	KEY(3, 5, KEY_BACK)
+};
+
+static struct resource mx51_3ds_kpp_resources[] = {
+	{
+		.start = MX51_MXC_INT_KPP,
+		.end = MX51_MXC_INT_KPP,
+		.flags = IORESOURCE_IRQ,
+	} , {
+		.start = MX51_KPP_BASE_ADDR,
+		.end = MX51_KPP_BASE_ADDR + 0x8 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct matrix_keymap_data mx51_3ds_map_data = {
+	.keymap		= mx51_3ds_board_keymap,
+	.keymap_size	= ARRAY_SIZE(mx51_3ds_board_keymap),
+};
+
+static struct platform_device mx51_3ds_keypad_device = {
+	.name = "imx-keypad",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(mx51_3ds_kpp_resources),
+	.resource = mx51_3ds_kpp_resources,
+	.dev = {
+		.platform_data = &mx51_3ds_map_data,
+	},
+};
+
+static void mxc_init_keypad(void)
+{
+	(void)platform_device_register(&mx51_3ds_keypad_device);
+}
+#else
+static inline void mxc_init_keypad(void)
+{
+}
+#endif
+
+
+static u32 cpld_base_addr;
+
+#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
+static struct resource smsc911x_resources[] = {
+	{
+		.flags = IORESOURCE_MEM,
+	} , {
+		.start = LAN9217_IRQ,
+		.end = LAN9217_IRQ,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct smsc911x_platform_config smsc911x_config = {
+	.irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.flags = SMSC911X_USE_32BIT | SMSC911X_FORCE_INTERNAL_PHY,
+};
+
+static struct platform_device smsc_lan9217_device = {
+	.name = "smsc911x",
+	.id = 0,
+	.dev = {
+		.platform_data = &smsc911x_config,
+	},
+	.num_resources = ARRAY_SIZE(smsc911x_resources),
+	.resource = smsc911x_resources,
+};
+
+static void mxc_init_enet(void)
+{
+	if (cpld_base_addr) {
+		smsc_lan9217_device.resource[0].start =
+		    LAN9217_BASE_ADDR(cpld_base_addr);
+		smsc_lan9217_device.resource[0].end =
+		    LAN9217_BASE_ADDR(cpld_base_addr) + 0x100;
+		(void)platform_device_register(&smsc_lan9217_device);
+	}
+}
+#else
+static inline void mxc_init_enet(void)
+{
+}
+#endif
+
+static u32 brd_io;
+static void expio_ack_irq(u32 irq);
+
+static void mxc_expio_irq_handler(u32 irq, struct irq_desc *desc)
+{
+	u32 imr_val;
+	u32 int_valid;
+	u32 expio_irq;
+
+	desc->chip->mask(irq);	/* irq = gpio irq number */
+
+	imr_val = __raw_readw(brd_io + INTR_MASK_REG);
+	int_valid = __raw_readw(brd_io + INTR_STATUS_REG) & ~imr_val;
+
+	if (unlikely(!int_valid))
+		goto out;
+
+	expio_irq = MXC_BOARD_IRQ_START;
+	for (; int_valid != 0; int_valid >>= 1, expio_irq++) {
+		struct irq_desc *d;
+		if ((int_valid & 1) == 0)
+			continue;
+		d = irq_desc + expio_irq;
+		if (unlikely(!(d->handle_irq))) {
+			pr_err("\nEXPIO irq: %d unhandled\n", expio_irq);
+			BUG();	/* oops */
+		}
+		d->handle_irq(expio_irq, d);
+	}
+
+out:
+	desc->chip->ack(irq);
+	desc->chip->unmask(irq);
+}
+
+/*
+ * Disable an expio pin's interrupt by setting the bit in the imr.
+ * @param irq		an expio virtual irq number
+ */
+static void expio_mask_irq(u32 irq)
+{
+	u16 reg;
+	u32 expio = MXC_IRQ_TO_EXPIO(irq);
+	/* mask the interrupt */
+	reg = __raw_readw(brd_io + INTR_MASK_REG);
+	reg |= (1 << expio);
+	__raw_writew(reg, brd_io + INTR_MASK_REG);
+}
+
+/*
+ * Acknowledge an expanded io pin's interrupt by clearing the bit in the isr.
+ * @param irq		an expanded io virtual irq number
+ */
+static void expio_ack_irq(u32 irq)
+{
+	u32 expio = MXC_IRQ_TO_EXPIO(irq);
+	/* clear the interrupt status */
+	__raw_writew(1 << expio, brd_io + INTR_RESET_REG);
+	__raw_writew(0, brd_io + INTR_RESET_REG);
+	/* mask the interrupt */
+	expio_mask_irq(irq);
+}
+
+/*
+ * Enable a expio pin's interrupt by clearing the bit in the imr.
+ * @param irq		a expio virtual irq number
+ */
+static void expio_unmask_irq(u32 irq)
+{
+	u16 reg;
+	u32 expio = MXC_IRQ_TO_EXPIO(irq);
+	/* unmask the interrupt */
+	reg = __raw_readw(brd_io + INTR_MASK_REG);
+	reg &= ~(1 << expio);
+	__raw_writew(reg, brd_io + INTR_MASK_REG);
+}
+
+static struct irq_chip expio_irq_chip = {
+	.ack = expio_ack_irq,
+	.mask = expio_mask_irq,
+	.unmask = expio_unmask_irq,
+};
+
+static int __init mxc_expio_init(void)
+{
+	int i;
+
+	brd_io = (u32) ioremap(BOARD_IO_ADDR(MX51_CS5_BASE_ADDR), SZ_4K);
+	if (brd_io == 0)
+		return -ENOMEM;
+
+	if ((__raw_readw(brd_io + MAGIC_NUMBER1_REG) != 0xAAAA) ||
+	    (__raw_readw(brd_io + MAGIC_NUMBER2_REG) != 0x5555) ||
+	    (__raw_readw(brd_io + MAGIC_NUMBER3_REG) != 0xCAFE)) {
+		pr_info("3-Stack Debug board not detected\n");
+		cpld_base_addr = 0;
+		return -ENODEV;
+	} else {
+		cpld_base_addr = MX51_CS5_BASE_ADDR;
+	}
+
+	pr_info("3-Stack Debug board detected, rev = 0x%04X\n",
+		readw(brd_io + CPLD_CODE_VER_REG));
+
+	/*
+	 * Configure INT line as GPIO input
+	 */
+	gpio_request(MX51_3DS_CPLD_IRQ_PIN, "gpio1_6");
+	gpio_direction_input(MX51_3DS_CPLD_IRQ_PIN);
+
+	/* disable the interrupt and clear the status */
+	__raw_writew(0, brd_io + INTR_MASK_REG);
+	__raw_writew(0xFFFF, brd_io + INTR_RESET_REG);
+	__raw_writew(0, brd_io + INTR_RESET_REG);
+	__raw_writew(0x1F, brd_io + INTR_MASK_REG);
+	for (i = MXC_BOARD_IRQ_START;
+	     i < (MXC_BOARD_IRQ_START + MXC_BOARD_IRQS); i++) {
+		set_irq_chip(i, &expio_irq_chip);
+		set_irq_handler(i, handle_level_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
+	set_irq_type(EXPIO_PARENT_INT, IRQF_TRIGGER_LOW);
+	set_irq_chained_handler(EXPIO_PARENT_INT, mxc_expio_irq_handler);
+
+	return 0;
+}
+
+/* Serial ports */
+#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static inline void mxc_init_imx_uart(void)
+{
+	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+	mxc_register_device(&mxc_uart_device2, &uart_pdata);
+}
+#else /* !SERIAL_IMX */
+static inline void mxc_init_imx_uart(void)
+{
+}
+#endif /* SERIAL_IMX */
+
+/*
+ * Board specific initialization.
+ */
+static void __init mxc_board_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx51_3ds_pads,
+					ARRAY_SIZE(mx51_3ds_pads));
+	mxc_init_imx_uart();
+	mxc_expio_init();
+	mxc_init_enet();
+	mxc_init_keypad();
+}
+
+static void __init mx51_3ds_timer_init(void)
+{
+	mx51_clocks_init(32768, 24000000, 22579200, 24576000);
+}
+
+static struct sys_timer mxc_timer = {
+	.init	= mx51_3ds_timer_init,
+};
+
+MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
+	.phys_io = MX51_AIPS1_BASE_ADDR,
+	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params = PHYS_OFFSET + 0x100,
+	.map_io = mx51_map_io,
+	.init_irq = mx51_init_irq,
+	.init_machine = mxc_board_init,
+	.timer = &mxc_timer,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h b/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
new file mode 100644
index 0000000..6900a7f
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
@@ -0,0 +1,73 @@
+/*
+ * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __ASM_ARCH_MXC_BOARD_MX51_3DS_H__
+#define __ASM_ARCH_MXC_BOARD_MX51_3DS_H__
+
+/*
+ * @file plat-mxc/include/mach/board-mx51_3ds.h
+ *
+ * @brief This file contains all the board level configuration options.
+ *
+ * It currently hold the options defined for MX51 3Stack Platform.
+ *
+ */
+
+#define MXC_LL_UART_PADDR	UART1_BASE_ADDR
+#define MXC_LL_UART_VADDR	AIPS1_IO_ADDRESS(UART1_BASE_ADDR)
+
+#define DEBUG_BOARD_BASE_ADDRESS(n)	(n)
+/* LAN9217 ethernet base address */
+#define LAN9217_BASE_ADDR(n)	(DEBUG_BOARD_BASE_ADDRESS(n))
+/* External UART */
+#define UARTA_BASE_ADDR(n)	(DEBUG_BOARD_BASE_ADDRESS(n) + 0x8000)
+#define UARTB_BASE_ADDR(n)	(DEBUG_BOARD_BASE_ADDRESS(n) + 0x10000)
+
+#define BOARD_IO_ADDR(n)	(DEBUG_BOARD_BASE_ADDRESS(n) + 0x20000)
+/* LED switchs */
+#define LED_SWITCH_REG		0x00
+/* buttons */
+#define SWITCH_BUTTONS_REG	0x08
+/* status, interrupt */
+#define INTR_STATUS_REG	0x10
+#define INTR_MASK_REG		0x38
+#define INTR_RESET_REG		0x20
+/* magic word for debug CPLD */
+#define MAGIC_NUMBER1_REG	0x40
+#define MAGIC_NUMBER2_REG	0x48
+/* CPLD code version */
+#define CPLD_CODE_VER_REG	0x50
+/* magic word for debug CPLD */
+#define MAGIC_NUMBER3_REG	0x58
+/* module reset register*/
+#define MODULE_RESET_REG	0x60
+/* CPU ID and Personality ID */
+#define MCU_BOARD_ID_REG	0x68
+
+/* interrupts like external uart , external ethernet etc*/
+#define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTA + 6)
+
+#define MXC_IRQ_TO_EXPIO(irq)   ((irq) - MXC_BOARD_IRQ_START)
+
+#define EXPIO_INT_ENET		(MXC_BOARD_IRQ_START + 0)
+#define EXPIO_INT_XUART_A	(MXC_BOARD_IRQ_START + 1)
+#define EXPIO_INT_XUART_B	(MXC_BOARD_IRQ_START + 2)
+#define EXPIO_INT_BUTTON_A	(MXC_BOARD_IRQ_START + 3)
+#define EXPIO_INT_BUTTON_B	(MXC_BOARD_IRQ_START + 4)
+
+/* This is System IRQ used by LAN9217 */
+#define LAN9217_IRQ	EXPIO_INT_ENET
+
+/* Define CPLD interrupt pin */
+#define MX51_3DS_CPLD_IRQ_PIN	(GPIO_PORTA + 6)
+
+#endif	/* __ASM_ARCH_MXC_BOARD_MX51_3DS_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51-3ds.h b/arch/arm/plat-mxc/include/mach/iomux-mx51-3ds.h
new file mode 100644
index 0000000..33f1141
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51-3ds.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2010 Freescale Semiconductor, Inc.
+ * Copyright (C) 2010 Jason Wang <jason77.wang@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#ifndef __MACH_IOMUX_MX51_3DS_H__
+#define __MACH_IOMUX_MX51_3DS_H__
+
+#include <mach/iomux-mx51.h>
+
+/* UART1 */
+#define MX51_3DS_PAD_UART1_RXD__UART1_RXD	MX51_PAD_UART1_RXD__UART1_RXD
+#define MX51_3DS_PAD_UART1_TXD__UART1_TXD	MX51_PAD_UART1_TXD__UART1_TXD
+#define MX51_3DS_PAD_UART1_RTS__UART1_RTS	MX51_PAD_UART1_RTS__UART1_RTS
+#define MX51_3DS_PAD_UART1_CTS__UART1_CTS	MX51_PAD_UART1_CTS__UART1_CTS
+
+/* UART2 */
+#define MX51_3DS_PAD_UART2_RXD__UART2_RXD	MX51_PAD_UART2_RXD__UART2_RXD
+#define MX51_3DS_PAD_UART2_TXD__UART2_TXD	MX51_PAD_UART2_TXD__UART2_TXD
+#define MX51_3DS_PAD_EIM_D25__UART2_CTS		IOMUX_PAD(0x414, 0x080, IOMUX_CONFIG_ALT4, 0x0, 0, \
+						(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST))
+#define MX51_3DS_PAD_EIM_D26__UART2_RTS		IOMUX_PAD(0x418, 0x084, IOMUX_CONFIG_ALT4, 0x9e8, 3, \
+						(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST))
+
+/* UART3 */
+#define MX51_3DS_PAD_GPIO_1_22__UART3_RXD	IOMUX_PAD(0x630, 0x240, IOMUX_CONFIG_ALT1, 0x9f4, 4, \
+						(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST))
+#define MX51_3DS_PAD_GPIO_1_23__UART3_TXD	IOMUX_PAD(0x634, 0x244, IOMUX_CONFIG_ALT1, 0x0, 0, \
+						(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST))
+#define MX51_3DS_PAD_EIM_D24__UART3_CTS		IOMUX_PAD(0x410, 0x07c, IOMUX_CONFIG_ALT3, 0x0, 0, \
+						(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST))
+#define MX51_3DS_PAD_EIM_D27__UART3_RTS		IOMUX_PAD(0x41c, 0x088, IOMUX_CONFIG_ALT3, 0x9f0, 3, \
+						(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST))
+/* CPLD */
+#define MX51_3DS_PAD_GPIO_1_6__GPIO1_6		IOMUX_PAD(0x80C, 0x3E0, 0, 0x0, 0, MX51_GPIO_PAD_CTRL)
+
+#endif /* __MACH_IOMUX_MX51_3DS_H__ */
-- 
1.5.6.5
