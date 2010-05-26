From: hjk@linutronix.de (Hans J. Koch)
Date: Wed, 26 May 2010 19:49:44 +0200
Subject: [PATCH 3/7 v6] Introduce plat-tcc irq framework
In-Reply-To: <20100526174240.GC2006@bluebox.local>
References: <20100526174240.GC2006@bluebox.local>
Message-ID: <20100526174943.GF2006@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce lowlevel interrupt routines.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/mach-tcc8k/Makefile          |    3 +-
 arch/arm/mach-tcc8k/irq.c             |  110 +++++++++++++++++++++++++++++++++
 arch/arm/plat-tcc/include/mach/irqs.h |   84 +++++++++++++++++++++++++
 3 files changed, 196 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tcc8k/irq.c
 create mode 100644 arch/arm/plat-tcc/include/mach/irqs.h

diff --git a/arch/arm/mach-tcc8k/Makefile b/arch/arm/mach-tcc8k/Makefile
index 805d850..24356e9 100644
--- a/arch/arm/mach-tcc8k/Makefile
+++ b/arch/arm/mach-tcc8k/Makefile
@@ -3,4 +3,5 @@
 #
 
 # Common support
-obj-y += clock.o
+obj-y += clock.o irq.o
+
diff --git a/arch/arm/mach-tcc8k/irq.c b/arch/arm/mach-tcc8k/irq.c
new file mode 100644
index 0000000..6427425
--- /dev/null
+++ b/arch/arm/mach-tcc8k/irq.c
@@ -0,0 +1,110 @@
+/*
+ * Copyright (C) Telechips, Inc.
+ * Copyright (C) 2009-2010 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GNU GPL version 2.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include <asm/irq.h>
+#include <asm/mach/irq.h>
+
+#include <mach/tcc8k-regs.h>
+#include <mach/irqs.h>
+
+/* Disable IRQ */
+static void tcc8000_mask_ack_irq0(unsigned int irq)
+{
+	PIC0_IEN &= ~(1 << irq);
+	PIC0_CREQ |=  (1 << irq);
+}
+
+static void tcc8000_mask_ack_irq1(unsigned int irq)
+{
+	PIC1_IEN &= ~(1 << (irq - 32));
+	PIC1_CREQ |= (1 << (irq - 32));
+}
+
+static void tcc8000_mask_irq0(unsigned int irq)
+{
+	PIC0_IEN &= ~(1 << irq);
+}
+
+static void tcc8000_mask_irq1(unsigned int irq)
+{
+	PIC1_IEN &= ~(1 << (irq - 32));
+}
+
+static void tcc8000_ack_irq0(unsigned int irq)
+{
+	PIC0_CREQ |=  (1 << irq);
+}
+
+static void tcc8000_ack_irq1(unsigned int irq)
+{
+	PIC1_CREQ |= (1 << (irq - 32));
+}
+
+/* Enable IRQ */
+static void tcc8000_unmask_irq0(unsigned int irq)
+{
+	PIC0_IEN |= (1 << irq);
+	PIC0_INTOEN |= (1 << irq);
+}
+
+static void tcc8000_unmask_irq1(unsigned int irq)
+{
+	PIC1_IEN |= (1 << (irq - 32));
+	PIC1_INTOEN |= (1 << (irq - 32));
+}
+
+static struct irq_chip tcc8000_irq_chip0 = {
+	.name		= "tcc_irq0",
+	.mask		= tcc8000_mask_irq0,
+	.ack		= tcc8000_ack_irq0,
+	.mask_ack	= tcc8000_mask_ack_irq0,
+	.unmask		= tcc8000_unmask_irq0,
+};
+
+static struct irq_chip tcc8000_irq_chip1 = {
+	.name		= "tcc_irq1",
+	.mask		= tcc8000_mask_irq1,
+	.ack		= tcc8000_ack_irq1,
+	.mask_ack	= tcc8000_mask_ack_irq1,
+	.unmask		= tcc8000_unmask_irq1,
+};
+
+void __init tcc8k_init_irq(void)
+{
+	int irqno;
+
+	/* Mask and clear all interrupts */
+	PIC0_IEN = 0x00000000;
+	PIC0_CREQ = 0xffffffff;
+	PIC1_IEN = 0x00000000;
+	PIC1_CREQ = 0xffffffff;
+
+	PIC0_MEN0 = 0x00000003;
+	PIC1_MEN1 = 0x00000003;
+	PIC1_MEN = 0x00000003;
+
+	/* let all IRQs be level triggered */
+	PIC0_TMODE = 0xffffffff;
+	PIC1_TMODE = 0xffffffff;
+	/* all IRQs are IRQs (not FIQs) */
+	PIC0_IRQSEL = 0xffffffff;
+	PIC1_IRQSEL = 0xffffffff;
+
+	for (irqno = 0; irqno < NR_IRQS; irqno++) {
+		if (irqno < 32)
+			set_irq_chip(irqno, &tcc8000_irq_chip0);
+		else
+			set_irq_chip(irqno, &tcc8000_irq_chip1);
+		set_irq_handler(irqno, handle_level_irq);
+		set_irq_flags(irqno, IRQF_VALID);
+	}
+}
+
diff --git a/arch/arm/plat-tcc/include/mach/irqs.h b/arch/arm/plat-tcc/include/mach/irqs.h
new file mode 100644
index 0000000..2e6bed8
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/irqs.h
@@ -0,0 +1,84 @@
+/*
+ * IRQ definitions for TCC8xxx
+ *
+ * Copyright (C) 2008-2009 Telechips
+ * Copyright (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GPL v2.
+ *
+ */
+
+#ifndef __ASM_ARCH_TCC_IRQS_H
+#define __ASM_ARCH_TCC_IRQS_H
+
+#define NR_IRQS 64
+
+/* PIC0 interrupts */
+#define INT_ADMA1	0
+#define INT_BDMA	1
+#define INT_ADMA0	2
+#define INT_GDMA1	3
+#define INT_I2S0RX	4
+#define INT_I2S0TX	5
+#define INT_TC		6
+#define INT_UART0	7
+#define INT_USBD	8
+#define INT_SPI0TX	9
+#define INT_UDMA	10
+#define INT_LIRQ	11
+#define INT_GDMA2	12
+#define INT_GDMA0	13
+#define INT_TC32	14
+#define INT_LCD		15
+#define INT_ADC		16
+#define INT_I2C		17
+#define INT_RTCP	18
+#define INT_RTCA	19
+#define INT_NFC		20
+#define INT_SD0		21
+#define INT_GSB0	22
+#define INT_PK		23
+#define INT_USBH0	24
+#define INT_USBH1	25
+#define INT_G2D		26
+#define INT_ECC		27
+#define INT_SPI0RX	28
+#define INT_UART1	29
+#define INT_MSCL	30
+#define INT_GSB1	31
+/* PIC1 interrupts */
+#define INT_E0		32
+#define INT_E1		33
+#define INT_E2		34
+#define INT_E3		35
+#define INT_E4		36
+#define INT_E5		37
+#define INT_E6		38
+#define INT_E7		39
+#define INT_UART2	40
+#define INT_UART3	41
+#define INT_SPI1TX	42
+#define INT_SPI1RX	43
+#define INT_GSB2	44
+#define INT_SPDIF	45
+#define INT_CDIF	46
+#define INT_VBON	47
+#define INT_VBOFF	48
+#define INT_SD1		49
+#define INT_UART4	50
+#define INT_GDMA3	51
+#define INT_I2S1RX	52
+#define INT_I2S1TX	53
+#define INT_CAN0	54
+#define INT_CAN1	55
+#define INT_GSB3	56
+#define INT_KRST	57
+#define INT_UNUSED	58
+#define INT_SD0D3	59
+#define INT_SD1D3	60
+#define INT_GPS0	61
+#define INT_GPS1	62
+#define INT_GPS2	63
+
+#endif  /* ASM_ARCH_TCC_IRQS_H */
+
-- 
1.6.3.3
