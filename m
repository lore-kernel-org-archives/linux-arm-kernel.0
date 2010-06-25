From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jun 2010 23:27:13 +0900
Subject: [PATCH 4/8] ARM: S5PV310: Add IRQ support
In-Reply-To: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
References: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1277476037-8806-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch adds IRQ support for S5PV310.
ARM GIC is installed in S5PV310 instead of VIC which is in every other CPUs
in S5P series. Several irq combiners are used to resolve the lack of irq
lines in current implementation.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/include/mach/irqs.h     |   74 ++++++++++++++
 arch/arm/mach-s5pv310/include/mach/regs-irq.h |   19 ++++
 arch/arm/mach-s5pv310/irq-combiner.c          |  129 +++++++++++++++++++++++++
 arch/arm/plat-s5p/irq.c                       |    2 +
 4 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/include/mach/irqs.h
 create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-irq.h
 create mode 100644 arch/arm/mach-s5pv310/irq-combiner.c

diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
new file mode 100644
index 0000000..56885ca
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -0,0 +1,74 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/irqs.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - IRQ definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_IRQS_H
+#define __ASM_ARCH_IRQS_H __FILE__
+
+#include <plat/irqs.h>
+
+/* Private Peripheral Interrupt */
+#define IRQ_PPI(x)		S5P_IRQ(x+16)
+
+#define IRQ_LOCALTIMER		IRQ_PPI(13)
+
+/* Shared Peripheral Interrupt */
+#define IRQ_SPI(x)		S5P_IRQ(x+32)
+
+#define IRQ_EINT0		IRQ_SPI(40)
+#define IRQ_EINT1		IRQ_SPI(41)
+#define IRQ_EINT2		IRQ_SPI(42)
+#define IRQ_EINT3		IRQ_SPI(43)
+#define IRQ_USB_HSOTG		IRQ_SPI(44)
+#define IRQ_USB_HOST		IRQ_SPI(45)
+#define IRQ_MODEM_IF		IRQ_SPI(46)
+#define IRQ_ROTATOR		IRQ_SPI(47)
+#define IRQ_JPEG		IRQ_SPI(48)
+#define IRQ_2D			IRQ_SPI(49)
+#define IRQ_PCIE		IRQ_SPI(50)
+#define IRQ_SYSTEM_TIMER	IRQ_SPI(51)
+#define IRQ_MFC			IRQ_SPI(52)
+#define IRQ_WTD			IRQ_SPI(53)
+#define IRQ_AUDIO_SS		IRQ_SPI(54)
+#define IRQ_AC97		IRQ_SPI(55)
+#define IRQ_SPDIF		IRQ_SPI(56)
+#define IRQ_KEYPAD		IRQ_SPI(57)
+#define IRQ_INTFEEDCTRL_SSS	IRQ_SPI(58)
+#define IRQ_SLIMBUS		IRQ_SPI(59)
+#define IRQ_PMU			IRQ_SPI(60)
+#define IRQ_TSI			IRQ_SPI(61)
+#define IRQ_SATA		IRQ_SPI(62)
+#define IRQ_GPS			IRQ_SPI(63)
+
+#define MAX_IRQ_IN_COMBINER	8
+#define COMBINER_GROUP(x)	((x) * MAX_IRQ_IN_COMBINER + IRQ_SPI(64))
+#define COMBINER_IRQ(x, y)	(COMBINER_GROUP(x) + y)
+
+#define IRQ_TIMER0_VIC		COMBINER_IRQ(22, 0)
+#define IRQ_TIMER1_VIC		COMBINER_IRQ(22, 1)
+#define IRQ_TIMER2_VIC		COMBINER_IRQ(22, 2)
+#define IRQ_TIMER3_VIC		COMBINER_IRQ(22, 3)
+#define IRQ_TIMER4_VIC		COMBINER_IRQ(22, 4)
+
+#define IRQ_UART0		COMBINER_IRQ(26, 0)
+#define IRQ_UART1		COMBINER_IRQ(26, 1)
+#define IRQ_UART2		COMBINER_IRQ(26, 2)
+#define IRQ_UART3		COMBINER_IRQ(26, 3)
+#define IRQ_UART4		COMBINER_IRQ(26, 4)
+
+#define IRQ_IIC			COMBINER_IRQ(27, 0)
+
+/* Set the default NR_IRQS */
+#define NR_IRQS			COMBINER_IRQ(MAX_COMBINER_NR, 0)
+
+#define MAX_COMBINER_NR		39
+
+#endif /* ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-irq.h b/arch/arm/mach-s5pv310/include/mach/regs-irq.h
new file mode 100644
index 0000000..c6e09c7
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/regs-irq.h
@@ -0,0 +1,19 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/regs-irq.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV310 - IRQ register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_IRQ_H
+#define __ASM_ARCH_REGS_IRQ_H __FILE__
+
+#include <asm/hardware/gic.h>
+#include <mach/map.h>
+
+#endif /* __ASM_ARCH_REGS_IRQ_H */
diff --git a/arch/arm/mach-s5pv310/irq-combiner.c b/arch/arm/mach-s5pv310/irq-combiner.c
new file mode 100644
index 0000000..6d6b4f9
--- /dev/null
+++ b/arch/arm/mach-s5pv310/irq-combiner.c
@@ -0,0 +1,129 @@
+/* linux/arch/arm/mach-s5pv310/irq-combiner.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Based on arch/arm/common/gic.c
+ *
+ * IRQ COMBINER support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/io.h>
+
+#include <asm/mach/irq.h>
+
+#define COMBINER_ENABLE_SET	0x0
+#define COMBINER_ENABLE_CLEAR	0x4
+#define COMBINER_INT_STATUS	0xC
+
+static DEFINE_SPINLOCK(irq_controller_lock);
+
+struct combiner_chip_data {
+	unsigned int irq_offset;
+	void __iomem *base;
+};
+
+static struct combiner_chip_data combiner_data[MAX_COMBINER_NR];
+
+static inline void __iomem *combiner_base(unsigned int irq)
+{
+	struct combiner_chip_data *combiner_data = get_irq_chip_data(irq);
+	return combiner_data->base;
+}
+
+static void combiner_mask_irq(unsigned int irq)
+{
+	u32 mask = 1 << (irq % 32);
+
+	spin_lock(&irq_controller_lock);
+	__raw_writel(mask, combiner_base(irq) + COMBINER_ENABLE_CLEAR);
+	spin_unlock(&irq_controller_lock);
+}
+
+static void combiner_unmask_irq(unsigned int irq)
+{
+	u32 mask = 1 << (irq % 32);
+
+	spin_lock(&irq_controller_lock);
+	__raw_writel(mask, combiner_base(irq) + COMBINER_ENABLE_SET);
+	spin_unlock(&irq_controller_lock);
+}
+
+static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
+{
+	struct combiner_chip_data *chip_data = get_irq_data(irq);
+	struct irq_chip *chip = get_irq_chip(irq);
+	unsigned int cascade_irq, combiner_irq;
+	unsigned long status;
+
+	/* primary controller ack'ing */
+	chip->ack(irq);
+
+	spin_lock(&irq_controller_lock);
+	status = __raw_readl(chip_data->base + COMBINER_INT_STATUS);
+	spin_unlock(&irq_controller_lock);
+
+	if (status == 0)
+		goto out;
+
+	for (combiner_irq = 0; combiner_irq < 32; combiner_irq++) {
+		if (status & 0x1)
+			break;
+		status >>= 1;
+	}
+
+	cascade_irq = combiner_irq + (chip_data->irq_offset & ~31);
+	if (unlikely(cascade_irq >= NR_IRQS))
+		do_bad_IRQ(cascade_irq, desc);
+	else
+		generic_handle_irq(cascade_irq);
+
+ out:
+	/* primary controller unmasking */
+	chip->unmask(irq);
+}
+
+static struct irq_chip combiner_chip = {
+	.name		= "COMBINER",
+	.mask		= combiner_mask_irq,
+	.unmask		= combiner_unmask_irq,
+};
+
+void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq)
+{
+	if (combiner_nr >= MAX_COMBINER_NR)
+		BUG();
+	if (set_irq_data(irq, &combiner_data[combiner_nr]) != 0)
+		BUG();
+	set_irq_chained_handler(irq, combiner_handle_cascade_irq);
+}
+
+void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
+			  unsigned int irq_start)
+{
+	unsigned int i;
+
+	if (combiner_nr >= MAX_COMBINER_NR)
+		BUG();
+
+	combiner_data[combiner_nr].base = base;
+	combiner_data[combiner_nr].irq_offset = irq_start;
+
+	/* Disable all interrupts */
+
+	__raw_writel(0xffffffff, base + COMBINER_ENABLE_CLEAR);
+
+	/* Setup the Linux IRQ subsystem */
+
+	for (i = irq_start; i < combiner_data[combiner_nr].irq_offset
+				+ MAX_IRQ_IN_COMBINER; i++) {
+		set_irq_chip(i, &combiner_chip);
+		set_irq_chip_data(i, &combiner_data[combiner_nr]);
+		set_irq_handler(i, handle_level_irq);
+		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+	}
+}
diff --git a/arch/arm/plat-s5p/irq.c b/arch/arm/plat-s5p/irq.c
index 25e1eb6..5560b12 100644
--- a/arch/arm/plat-s5p/irq.c
+++ b/arch/arm/plat-s5p/irq.c
@@ -56,11 +56,13 @@ static struct s3c_uart_irq uart_irqs[] = {
 
 void __init s5p_init_irq(u32 *vic, u32 num_vic)
 {
+#ifdef CONFIG_ARM_VIC
 	int irq;
 
 	/* initialize the VICs */
 	for (irq = 0; irq < num_vic; irq++)
 		vic_init(VA_VIC(irq), VIC_BASE(irq), vic[irq], 0);
+#endif
 
 	s3c_init_vic_timer_irq(IRQ_TIMER0_VIC, IRQ_TIMER0);
 	s3c_init_vic_timer_irq(IRQ_TIMER1_VIC, IRQ_TIMER1);
-- 
1.6.2.5
