From: jason77.wang@gmail.com (Jason Wang)
Date: Tue, 22 Jun 2010 22:27:30 +0800
Subject: [PATCH V2 1/2] mxc: add common debug board for 3-stack platforms
In-Reply-To: <1277216851-15782-1-git-send-email-jason77.wang@gmail.com>
References: <1277216851-15782-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <1277216851-15782-2-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debug board is little different for all mxc 3-stack(PDK)
platforms, it is possible here to add a common implementation to
support this board.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/plat-mxc/3ds_debugboard.c              |  205 +++++++++++++++++++++++
 arch/arm/plat-mxc/Kconfig                       |   11 ++
 arch/arm/plat-mxc/Makefile                      |    1 +
 arch/arm/plat-mxc/include/mach/3ds_debugboard.h |   19 ++
 4 files changed, 236 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/3ds_debugboard.c
 create mode 100644 arch/arm/plat-mxc/include/mach/3ds_debugboard.h

diff --git a/arch/arm/plat-mxc/3ds_debugboard.c b/arch/arm/plat-mxc/3ds_debugboard.c
new file mode 100644
index 0000000..7b193c3
--- /dev/null
+++ b/arch/arm/plat-mxc/3ds_debugboard.c
@@ -0,0 +1,205 @@
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
+#include <linux/gpio.h>
+#include <linux/smsc911x.h>
+
+#include <mach/hardware.h>
+
+/* LAN9217 ethernet base address */
+#define LAN9217_BASE_ADDR(n)	(n + 0x0)
+/* External UART */
+#define UARTA_BASE_ADDR(n)	(n + 0x8000)
+#define UARTB_BASE_ADDR(n)	(n + 0x10000)
+
+#define BOARD_IO_ADDR(n)	(n + 0x20000)
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
+#define MXC_IRQ_TO_EXPIO(irq)   ((irq) - MXC_BOARD_IRQ_START)
+#define MXC_IRQ_TO_GPIO(irq)	((irq) - MXC_INTERNAL_IRQS)
+
+#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
+#define MXC_MAX_EXP_IO_LINES	16
+
+/* interrupts like external uart , external ethernet etc*/
+#define EXPIO_INT_ENET		(MXC_BOARD_IRQ_START + 0)
+#define EXPIO_INT_XUART_A	(MXC_BOARD_IRQ_START + 1)
+#define EXPIO_INT_XUART_B	(MXC_BOARD_IRQ_START + 2)
+#define EXPIO_INT_BUTTON_A	(MXC_BOARD_IRQ_START + 3)
+#define EXPIO_INT_BUTTON_B	(MXC_BOARD_IRQ_START + 4)
+
+static void __iomem *brd_io;
+static void expio_ack_irq(u32 irq);
+
+static struct resource smsc911x_resources[] = {
+	{
+		.flags = IORESOURCE_MEM,
+	} , {
+		.start = EXPIO_INT_ENET,
+		.end = EXPIO_INT_ENET,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct smsc911x_platform_config smsc911x_config = {
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
+	expio_irq = MXC_BOARD_IRQ_START;
+	for (; int_valid != 0; int_valid >>= 1, expio_irq++) {
+		struct irq_desc *d;
+		if ((int_valid & 1) == 0)
+			continue;
+		d = irq_desc + expio_irq;
+		if (unlikely(!(d->handle_irq)))
+			pr_err("\nEXPIO irq: %d unhandled\n", expio_irq);
+		else
+			d->handle_irq(expio_irq, d);
+	}
+
+	desc->chip->ack(irq);
+	desc->chip->unmask(irq);
+}
+
+/*
+ * Disable an expio pin's interrupt by setting the bit in the imr.
+ * Irq is an expio virtual irq number
+ */
+static void expio_mask_irq(u32 irq)
+{
+	u16 reg;
+	u32 expio = MXC_IRQ_TO_EXPIO(irq);
+
+	reg = __raw_readw(brd_io + INTR_MASK_REG);
+	reg |= (1 << expio);
+	__raw_writew(reg, brd_io + INTR_MASK_REG);
+}
+
+static void expio_ack_irq(u32 irq)
+{
+	u32 expio = MXC_IRQ_TO_EXPIO(irq);
+
+	__raw_writew(1 << expio, brd_io + INTR_RESET_REG);
+	__raw_writew(0, brd_io + INTR_RESET_REG);
+	expio_mask_irq(irq);
+}
+
+static void expio_unmask_irq(u32 irq)
+{
+	u16 reg;
+	u32 expio = MXC_IRQ_TO_EXPIO(irq);
+
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
+void __init mxc_expio_lan_init(void)
+{
+	platform_device_register(&smsc_lan9217_device);
+}
+
+int __init mxc_expio_init(u32 base, u32 p_irq)
+{
+	int i;
+
+	brd_io = ioremap(BOARD_IO_ADDR(base), SZ_4K);
+	if (brd_io == NULL)
+		return -ENOMEM;
+
+	if ((__raw_readw(brd_io + MAGIC_NUMBER1_REG) != 0xAAAA) ||
+	    (__raw_readw(brd_io + MAGIC_NUMBER2_REG) != 0x5555) ||
+	    (__raw_readw(brd_io + MAGIC_NUMBER3_REG) != 0xCAFE)) {
+		pr_info("3-Stack Debug board not detected\n");
+		iounmap(brd_io);
+		brd_io = NULL;
+		return -ENODEV;
+	}
+
+	pr_info("3-Stack Debug board detected, rev = 0x%04X\n",
+		readw(brd_io + CPLD_CODE_VER_REG));
+
+	smsc911x_resources[0].start = LAN9217_BASE_ADDR(base);
+	smsc911x_resources[0].end = LAN9217_BASE_ADDR(base) + 0x100 - 1;
+
+	/*
+	 * Configure INT line as GPIO input
+	 */
+	gpio_request(MXC_IRQ_TO_GPIO(p_irq), "expio_pirq");
+	gpio_direction_input(MXC_IRQ_TO_GPIO(p_irq));
+
+	/* disable the interrupt and clear the status */
+	__raw_writew(0, brd_io + INTR_MASK_REG);
+	__raw_writew(0xFFFF, brd_io + INTR_RESET_REG);
+	__raw_writew(0, brd_io + INTR_RESET_REG);
+	__raw_writew(0x1F, brd_io + INTR_MASK_REG);
+	for (i = MXC_EXP_IO_BASE;
+	     i < (MXC_EXP_IO_BASE + MXC_MAX_EXP_IO_LINES); i++) {
+		set_irq_chip(i, &expio_irq_chip);
+		set_irq_handler(i, handle_level_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
+	set_irq_type(p_irq, IRQF_TRIGGER_LOW);
+	set_irq_chained_handler(p_irq, mxc_expio_irq_handler);
+
+	return 0;
+}
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 7f7ad6f..8bf917e 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -81,6 +81,17 @@ config MXC_PWM
 	help
 	  Enable support for the i.MX PWM controller(s).
 
+config MXC_DEBUG_BOARD
+	bool "Enable MXC debug board(for 3-stack)"
+	help
+	  The debug board is an integral part of the MXC 3-stack(PDK)
+	  platforms, it can be attached or removed from the peripheral
+	  board. On debug board, several debug devices(ethernet, UART,
+	  buttons, LEDs and JTAG) are implemented. Between the MCU and
+	  these devices, a CPLD is added as a bridge which performs
+	  data/address de-multiplexing and decode, signal level shift,
+	  interrupt control and various board functions.
+
 config MXC_ULPI
 	bool
 
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 895bc3c..c4a24f2 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_USB_EHCI_MXC) += ehci.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
+obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
diff --git a/arch/arm/plat-mxc/include/mach/3ds_debugboard.h b/arch/arm/plat-mxc/include/mach/3ds_debugboard.h
new file mode 100644
index 0000000..25a12e9
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/3ds_debugboard.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later@the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __ASM_ARCH_MXC_3DS_DB_H__
+#define __ASM_ARCH_MXC_3DS_DB_H__
+
+extern int __init mxc_expio_init(u32 base, u32 p_irq);
+extern void __init mxc_expio_lan_init(void);
+
+#endif /* __ASM_ARCH_MXC_3DS_DB_H__ */
-- 
1.5.6.5
