From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Jan 2010 17:49:17 +0900
Subject: [PATCH v4 3/8] ARM: S5P6440: Add IRQ support
Message-ID: <1263286157-20840-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds IRQ support for S5P6440 CPU.

Signed-off-by: Adityapratap Sharma <aditya.ps@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/include/mach/irqs.h     |  111 +++++++++++++++++++++++++
 arch/arm/mach-s5p6440/include/mach/regs-irq.h |   19 ++++
 arch/arm/plat-s5p/include/plat/irqs.h         |   83 ++++++++++++++++++
 arch/arm/plat-s5p/irq.c                       |   73 ++++++++++++++++
 4 files changed, 286 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p6440/include/mach/irqs.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/regs-irq.h
 create mode 100644 arch/arm/plat-s5p/include/plat/irqs.h
 create mode 100644 arch/arm/plat-s5p/irq.c

diff --git a/arch/arm/mach-s5p6440/include/mach/irqs.h b/arch/arm/mach-s5p6440/include/mach/irqs.h
new file mode 100644
index 0000000..a4b9b40
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/irqs.h
@@ -0,0 +1,111 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/irqs.h
+ *
+ * Copyright 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6440 - IRQ definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_S5P_IRQS_H
+#define __ASM_ARCH_S5P_IRQS_H __FILE__
+
+#include <plat/irqs.h>
+
+/* VIC0 */
+
+#define IRQ_EINT0_3		S5P_IRQ_VIC0(0)
+#define IRQ_EINT4_11		S5P_IRQ_VIC0(1)
+#define IRQ_RTC_TIC		S5P_IRQ_VIC0(2)
+#define IRQ_IIC1		S5P_IRQ_VIC0(5)
+#define IRQ_I2SV40		S5P_IRQ_VIC0(6)
+#define IRQ_GPS			S5P_IRQ_VIC0(7)
+#define IRQ_POST0		S5P_IRQ_VIC0(9)
+#define IRQ_2D			S5P_IRQ_VIC0(11)
+#define IRQ_TIMER0_VIC		S5P_IRQ_VIC0(23)
+#define IRQ_TIMER1_VIC		S5P_IRQ_VIC0(24)
+#define IRQ_TIMER2_VIC		S5P_IRQ_VIC0(25)
+#define IRQ_WDT			S5P_IRQ_VIC0(26)
+#define IRQ_TIMER3_VIC		S5P_IRQ_VIC0(27)
+#define IRQ_TIMER4_VIC		S5P_IRQ_VIC0(28)
+#define IRQ_DISPCON0		S5P_IRQ_VIC0(29)
+#define IRQ_DISPCON1		S5P_IRQ_VIC0(30)
+#define IRQ_DISPCON2		S5P_IRQ_VIC0(31)
+
+/* VIC1 */
+
+#define IRQ_EINT12_15		S5P_IRQ_VIC1(0)
+#define IRQ_PCM0		S5P_IRQ_VIC1(2)
+#define IRQ_UART0		S5P_IRQ_VIC1(5)
+#define IRQ_UART1		S5P_IRQ_VIC1(6)
+#define IRQ_UART2		S5P_IRQ_VIC1(7)
+#define IRQ_UART3		S5P_IRQ_VIC1(8)
+#define IRQ_DMA0		S5P_IRQ_VIC1(9)
+#define IRQ_NFC			S5P_IRQ_VIC1(13)
+#define IRQ_SPI0		S5P_IRQ_VIC1(16)
+#define IRQ_SPI1		S5P_IRQ_VIC1(17)
+#define IRQ_IIC			S5P_IRQ_VIC1(18)
+#define IRQ_DISPCON3		S5P_IRQ_VIC1(19)
+#define IRQ_FIMGVG		S5P_IRQ_VIC1(20)
+#define IRQ_EINT_GROUPS		S5P_IRQ_VIC1(21)
+#define IRQ_PMUIRQ		S5P_IRQ_VIC1(23)
+#define IRQ_HSMMC0		S5P_IRQ_VIC1(24)
+#define IRQ_HSMMC1		S5P_IRQ_VIC1(25)
+#define IRQ_HSMMC2		IRQ_SPI1	/* shared with SPI1 */
+#define IRQ_OTG			S5P_IRQ_VIC1(26)
+#define IRQ_DSI			S5P_IRQ_VIC1(27)
+#define IRQ_RTC_ALARM		S5P_IRQ_VIC1(28)
+#define IRQ_TSI			S5P_IRQ_VIC1(29)
+#define IRQ_PENDN		S5P_IRQ_VIC1(30)
+#define IRQ_TC			IRQ_PENDN
+#define IRQ_ADC			S5P_IRQ_VIC1(31)
+
+/*
+ * Since the IRQ_EINT(x) are a linear mapping on s5p6440 we just defined
+ * them as an IRQ_EINT(x) macro from S5P_IRQ_EINT_BASE which we place
+ * after the pair of VICs.
+ */
+
+#define S5P_IRQ_EINT_BASE	(S5P_IRQ_VIC1(31) + 6)
+
+#define S5P_EINT(x)		((x) + S5P_IRQ_EINT_BASE)
+#define IRQ_EINT(x)		S5P_EINT(x)
+
+/*
+ * Next the external interrupt groups. These are similar to the IRQ_EINT(x)
+ * that they are sourced from the GPIO pins but with a different scheme for
+ * priority and source indication.
+ *
+ * The IRQ_EINT(x) can be thought of as 'group 0' of the available GPIO
+ * interrupts, but for historical reasons they are kept apart from these
+ * next interrupts.
+ *
+ * Use IRQ_EINT_GROUP(group, offset) to get the number for use in the
+ * machine specific support files.
+ */
+
+/* Actually, #6 and #7 are missing in the EINT_GROUP1 */
+#define IRQ_EINT_GROUP1_NR	(15)
+#define IRQ_EINT_GROUP2_NR	(8)
+#define IRQ_EINT_GROUP5_NR	(7)
+#define IRQ_EINT_GROUP6_NR	(10)
+/* Actually, #0, #1 and #2 are missing in the EINT_GROUP8 */
+#define IRQ_EINT_GROUP8_NR	(11)
+
+#define IRQ_EINT_GROUP_BASE	S5P_EINT(16)
+#define IRQ_EINT_GROUP1_BASE	(IRQ_EINT_GROUP_BASE + 0)
+#define IRQ_EINT_GROUP2_BASE	(IRQ_EINT_GROUP1_BASE + IRQ_EINT_GROUP1_NR)
+#define IRQ_EINT_GROUP5_BASE	(IRQ_EINT_GROUP2_BASE + IRQ_EINT_GROUP2_NR)
+#define IRQ_EINT_GROUP6_BASE	(IRQ_EINT_GROUP5_BASE + IRQ_EINT_GROUP5_NR)
+#define IRQ_EINT_GROUP8_BASE	(IRQ_EINT_GROUP6_BASE + IRQ_EINT_GROUP6_NR)
+
+#define IRQ_EINT_GROUP(grp, x)	(IRQ_EINT_GROUP##grp##_BASE + (x))
+
+/* Set the default NR_IRQS */
+
+#define NR_IRQS			(IRQ_EINT_GROUP8_BASE + IRQ_EINT_GROUP8_NR + 1)
+
+#endif /* __ASM_ARCH_S5P_IRQS_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/regs-irq.h b/arch/arm/mach-s5p6440/include/mach/regs-irq.h
new file mode 100644
index 0000000..a961f4b
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/regs-irq.h
@@ -0,0 +1,19 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/regs-irq.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6440 - IRQ register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_IRQ_H
+#define __ASM_ARCH_REGS_IRQ_H __FILE__
+
+#include <asm/hardware/vic.h>
+#include <mach/map.h>
+
+#endif /* __ASM_ARCH_REGS_IRQ_H */
diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-s5p/include/plat/irqs.h
new file mode 100644
index 0000000..5d7937d
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/irqs.h
@@ -0,0 +1,83 @@
+/* linux/arch/arm/plat-s5p/include/plat/irqs.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P Common IRQ support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_S5P_IRQS_H
+#define __ASM_PLAT_S5P_IRQS_H __FILE__
+
+/* we keep the first set of CPU IRQs out of the range of
+ * the ISA space, so that the PC104 has them to itself
+ * and we don't end up having to do horrible things to the
+ * standard ISA drivers....
+ *
+ * note, since we're using the VICs, our start must be a
+ * mulitple of 32 to allow the common code to work
+ */
+
+#define S5P_IRQ_OFFSET		(32)
+
+#define S5P_IRQ(x)		((x) + S5P_IRQ_OFFSET)
+
+#define S5P_VIC0_BASE		S5P_IRQ(0)
+#define S5P_VIC1_BASE		S5P_IRQ(32)
+
+#define IRQ_VIC0_BASE		S5P_VIC0_BASE
+#define IRQ_VIC1_BASE		S5P_VIC1_BASE
+
+/* UART interrupts, each UART has 4 intterupts per channel so
+ * use the space between the ISA and S3C main interrupts. Note, these
+ * are not in the same order as the S3C24XX series! */
+
+#define IRQ_S5P_UART_BASE0	(16)
+#define IRQ_S5P_UART_BASE1	(20)
+#define IRQ_S5P_UART_BASE2	(24)
+#define IRQ_S5P_UART_BASE3	(28)
+
+#define UART_IRQ_RXD		(0)
+#define UART_IRQ_ERR		(1)
+#define UART_IRQ_TXD		(2)
+
+#define IRQ_S5P_UART_RX0	(IRQ_S5P_UART_BASE0 + UART_IRQ_RXD)
+#define IRQ_S5P_UART_TX0	(IRQ_S5P_UART_BASE0 + UART_IRQ_TXD)
+#define IRQ_S5P_UART_ERR0	(IRQ_S5P_UART_BASE0 + UART_IRQ_ERR)
+
+#define IRQ_S5P_UART_RX1	(IRQ_S5P_UART_BASE1 + UART_IRQ_RXD)
+#define IRQ_S5P_UART_TX1	(IRQ_S5P_UART_BASE1 + UART_IRQ_TXD)
+#define IRQ_S5P_UART_ERR1	(IRQ_S5P_UART_BASE1 + UART_IRQ_ERR)
+
+#define IRQ_S5P_UART_RX2	(IRQ_S5P_UART_BASE2 + UART_IRQ_RXD)
+#define IRQ_S5P_UART_TX2	(IRQ_S5P_UART_BASE2 + UART_IRQ_TXD)
+#define IRQ_S5P_UART_ERR2	(IRQ_S5P_UART_BASE2 + UART_IRQ_ERR)
+
+#define IRQ_S5P_UART_RX3	(IRQ_S5P_UART_BASE3 + UART_IRQ_RXD)
+#define IRQ_S5P_UART_TX3	(IRQ_S5P_UART_BASE3 + UART_IRQ_TXD)
+#define IRQ_S5P_UART_ERR3	(IRQ_S5P_UART_BASE3 + UART_IRQ_ERR)
+
+/* S3C compatibilty defines */
+#define IRQ_S3CUART_RX0		IRQ_S5P_UART_RX0
+#define IRQ_S3CUART_RX1		IRQ_S5P_UART_RX1
+#define IRQ_S3CUART_RX2		IRQ_S5P_UART_RX2
+#define IRQ_S3CUART_RX3		IRQ_S5P_UART_RX3
+
+/* VIC based IRQs */
+
+#define S5P_IRQ_VIC0(x)		(S5P_VIC0_BASE + (x))
+#define S5P_IRQ_VIC1(x)		(S5P_VIC1_BASE + (x))
+
+#define S5P_TIMER_IRQ(x)	S5P_IRQ(64 + (x))
+
+#define IRQ_TIMER0		S5P_TIMER_IRQ(0)
+#define IRQ_TIMER1		S5P_TIMER_IRQ(1)
+#define IRQ_TIMER2		S5P_TIMER_IRQ(2)
+#define IRQ_TIMER3		S5P_TIMER_IRQ(3)
+#define IRQ_TIMER4		S5P_TIMER_IRQ(4)
+
+#endif /* __ASM_PLAT_S5P_IRQS_H */
diff --git a/arch/arm/plat-s5p/irq.c b/arch/arm/plat-s5p/irq.c
new file mode 100644
index 0000000..eada40d
--- /dev/null
+++ b/arch/arm/plat-s5p/irq.c
@@ -0,0 +1,73 @@
+/* arch/arm/plat-s5p/irq.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P - Interrupt handling
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <asm/hardware/vic.h>
+
+#include <linux/serial_core.h>
+#include <mach/map.h>
+#include <plat/regs-timer.h>
+#include <plat/regs-serial.h>
+#include <plat/cpu.h>
+#include <plat/irq-vic-timer.h>
+#include <plat/irq-uart.h>
+
+#define VIC_VAADDR(no)	(S5P_VA_VIC0   + ((no)*0x10000))
+#define VIC_BASE(no)	(S5P_VIC0_BASE + ((no)*32))
+
+/*
+ * Note, we make use of the fact that the parent IRQs, IRQ_UART[0..3]
+ * are consecutive when looking up the interrupt in the demux routines.
+ */
+static struct s3c_uart_irq uart_irqs[] = {
+	[0] = {
+		.regs		= S5P_VA_UART0,
+		.base_irq	= IRQ_S5P_UART_BASE0,
+		.parent_irq	= IRQ_UART0,
+	},
+	[1] = {
+		.regs		= S5P_VA_UART1,
+		.base_irq	= IRQ_S5P_UART_BASE1,
+		.parent_irq	= IRQ_UART1,
+	},
+	[2] = {
+		.regs		= S5P_VA_UART2,
+		.base_irq	= IRQ_S5P_UART_BASE2,
+		.parent_irq	= IRQ_UART2,
+	},
+	[3] = {
+		.regs		= S5P_VA_UART3,
+		.base_irq	= IRQ_S5P_UART_BASE3,
+		.parent_irq	= IRQ_UART3,
+	},
+};
+
+void __init s5p_init_irq(u32 *vic, u32 num_vic)
+{
+	int irq;
+
+	/* initialize the VICs */
+	for (irq = 0; irq < num_vic; irq++)
+		vic_init(VIC_VAADDR(irq), VIC_BASE(irq), vic[irq], 0);
+
+	s3c_init_vic_timer_irq(IRQ_TIMER0_VIC, IRQ_TIMER0);
+	s3c_init_vic_timer_irq(IRQ_TIMER1_VIC, IRQ_TIMER1);
+	s3c_init_vic_timer_irq(IRQ_TIMER2_VIC, IRQ_TIMER2);
+	s3c_init_vic_timer_irq(IRQ_TIMER3_VIC, IRQ_TIMER3);
+	s3c_init_vic_timer_irq(IRQ_TIMER4_VIC, IRQ_TIMER4);
+
+	s3c_init_uart_irqs(uart_irqs, ARRAY_SIZE(uart_irqs));
+}
-- 
1.6.2.5
