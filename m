From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue,  7 Oct 2014 10:55:21 +0200
Subject: [PATCH v3 7/9] irqchip/irq-mxs.c: add asm9260 support
In-Reply-To: <1412672123-16694-1-git-send-email-linux@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <1412672123-16694-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1412672123-16694-8-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iMX23/iMX28 have similar but not identical interrupt collector with asm9260.
This patch provide some changes to reuse same code for both controller types.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 drivers/irqchip/Kconfig                    |   5 +
 drivers/irqchip/Makefile                   |   2 +-
 drivers/irqchip/alphascale,asm9260-icoll.h | 109 ++++++++++++++++++++++
 drivers/irqchip/irq-mxs.c                  | 142 +++++++++++++++++++++++++----
 4 files changed, 241 insertions(+), 17 deletions(-)
 create mode 100644 drivers/irqchip/alphascale,asm9260-icoll.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b8632bf..2ee202f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -113,3 +113,8 @@ config IRQ_CROSSBAR
 	  The primary irqchip invokes the crossbar's callback which inturn allocates
 	  a free irq and configures the IP. Thus the peripheral interrupts are
 	  routed to one of the free irqchip interrupt lines.
+
+config IRQ_MXS
+	bool
+	select IRQ_DOMAIN
+	select STMP_DEVICE
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 73052ba..89c7042 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
 obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
 obj-$(CONFIG_ARCH_MVEBU)		+= irq-armada-370-xp.o
-obj-$(CONFIG_ARCH_MXS)			+= irq-mxs.o
+obj-$(CONFIG_IRQ_MXS)			+= irq-mxs.o
 obj-$(CONFIG_ARCH_S3C24XX)		+= irq-s3c24xx.o
 obj-$(CONFIG_DW_APB_ICTL)		+= irq-dw-apb-ictl.o
 obj-$(CONFIG_METAG)			+= irq-metag-ext.o
diff --git a/drivers/irqchip/alphascale,asm9260-icoll.h b/drivers/irqchip/alphascale,asm9260-icoll.h
new file mode 100644
index 0000000..5cec108
--- /dev/null
+++ b/drivers/irqchip/alphascale,asm9260-icoll.h
@@ -0,0 +1,109 @@
+/*
+ * Copyright (C) 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _ALPHASCALE_ASM9260_ICOLL_H
+#define _ALPHASCALE_ASM9260_ICOLL_H
+
+#define ASM9260_NUM_IRQS		64
+/*
+ * this device provide 4 offsets for each register:
+ * 0x0 - plain read write mode
+ * 0x4 - set mode, OR logic.
+ * 0x8 - clr mode, XOR logic.
+ * 0xc - togle mode.
+ */
+
+#define ASM9260_HW_ICOLL_VECTOR				0x0000
+/*
+ * bits 31:2
+ * This register presents the vector address for the interrupt currently
+ * active on the CPU IRQ input. Writing to this register notifies the
+ * interrupt collector that the interrupt service routine for the current
+ * interrupt has been entered.
+ * The exception trap should have a LDPC instruction from this address:
+ * LDPC ASM9260_HW_ICOLL_VECTOR_ADDR; IRQ exception at 0xffff0018
+ */
+
+/*
+ * The Interrupt Collector Level Acknowledge Register is used by software to
+ * indicate the completion of an interrupt on a specific level.
+ * This register is written at the very end of an interrupt service routine. If
+ * nesting is used then the CPU irq must be turned on before writing to this
+ * register to avoid a race condition in the CPU interrupt hardware.
+ */
+#define ASM9260_HW_ICOLL_LEVELACK			0x0010
+#define ASM9260_BM_LEVELn(nr)				BIT(nr)
+
+#define ASM9260_HW_ICOLL_CTRL				0x0020
+/*
+ * ASM9260_BM_CTRL_SFTRST and ASM9260_BM_CTRL_CLKGATE are not available on
+ * asm9260.
+ */
+#define ASM9260_BM_CTRL_SFTRST				BIT(31)
+#define ASM9260_BM_CTRL_CLKGATE				BIT(30)
+/* disable interrupt level nesting */
+#define ASM9260_BM_CTRL_NO_NESTING			BIT(19)
+/*
+ * Set this bit to one enable the RISC32-style read side effect associated with
+ * the vector address register. In this mode, interrupt in-service is signaled
+ * by the read of the ASM9260_HW_ICOLL_VECTOR register to acquire the interrupt
+ * vector address. Set this bit to zero for normal operation, in which the ISR
+ * signals in-service explicitly by means of a write to the
+ * ASM9260_HW_ICOLL_VECTOR register.
+ * 0 - Must Write to Vector register to go in-service.
+ * 1 - Go in-service as a read side effect
+ */
+#define ASM9260_BM_CTRL_ARM_RSE_MODE			BIT(18)
+#define ASM9260_BM_CTRL_IRQ_ENABLE			BIT(16)
+
+#define ASM9260_HW_ICOLL_STAT_OFFSET			0x0030
+/*
+ * bits 5:0
+ * Vector number of current interrupt. Multiply by 4 and add to vector base
+ * address to obtain the value in ASM9260_HW_ICOLL_VECTOR.
+ */
+
+/*
+ * RAW0 and RAW1 provides a read-only view of the raw interrupt request lines
+ * coming from various parts of the chip. Its purpose is to improve diagnostic
+ * observability.
+ */
+#define ASM9260_HW_ICOLL_RAW0				0x0040
+#define ASM9260_HW_ICOLL_RAW1				0x0050
+
+#define ASM9260_HW_ICOLL_INTERRUPT0			0x0060
+#define ASM9260_HW_ICOLL_INTERRUPTn(n)		(0x0060 + ((n) >> 2) * 0x10)
+/*
+ * WARNING: Modifying the priority of an enabled interrupt may result in
+ * undefined behavior.
+ */
+#define ASM9260_BM_INT_PRIORITY_MASK			0x3
+#define ASM9260_BM_INT_ENABLE				BIT(2)
+#define ASM9260_BM_INT_SOFTIRQ				BIT(3)
+
+#define ASM9260_BM_ICOLL_INTERRUPTn_SHIFT(n)		(((n) & 0x3) << 3)
+#define ASM9260_BM_ICOLL_INTERRUPTn_ENABLE(n)		(1 << (2 + \
+			ASM9260_BM_ICOLL_INTERRUPTn_SHIFT(n)))
+
+#define ASM9260_HW_ICOLL_VBASE				0x0160
+/*
+ * bits 31:2
+ * This bitfield holds the upper 30 bits of the base address of the vector
+ * table.
+ */
+
+#define ASM9260_HW_ICOLL_CLEAR0				0x01d0
+#define ASM9260_HW_ICOLL_CLEAR1				0x01e0
+#define ASM9260_HW_ICOLL_CLEARn(n)			(((n >> 5) * 0x10) \
+							+ SET_REG)
+#define ASM9260_BM_CLEAR_BIT(n)				BIT(n & 0x1f)
+
+/* Scratchpad */
+#define ASM9260_HW_ICOLL_UNDEF_VECTOR			0x01f0
+#endif
diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index e4acf1e..b5e0358 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -1,5 +1,7 @@
 /*
  * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *	Add Alphascale ASM9260 support.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -18,6 +20,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/err.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
@@ -28,21 +31,55 @@
 #include <asm/exception.h>
 
 #include "irqchip.h"
+#include "alphascale,asm9260-icoll.h"
+
+/*
+ * this device provide 4 offsets for each register:
+ * 0x0 - plain read write mode
+ * 0x4 - set mode, OR logic.
+ * 0x8 - clr mode, XOR logic.
+ * 0xc - togle mode.
+ */
+#define SET_REG 4
+#define CLR_REG 8
 
 #define HW_ICOLL_VECTOR				0x0000
 #define HW_ICOLL_LEVELACK			0x0010
 #define HW_ICOLL_CTRL				0x0020
 #define HW_ICOLL_STAT_OFFSET			0x0070
-#define HW_ICOLL_INTERRUPTn_SET(n)		(0x0124 + (n) * 0x10)
-#define HW_ICOLL_INTERRUPTn_CLR(n)		(0x0128 + (n) * 0x10)
-#define BM_ICOLL_INTERRUPTn_ENABLE		0x00000004
+#define HW_ICOLL_INTERRUPT0			0x0120
+#define HW_ICOLL_INTERRUPTn(n)			((n) * 0x10)
+#define BM_ICOLL_INTR_ENABLE			BIT(2)
 #define BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0	0x1
 
 #define ICOLL_NUM_IRQS		128
 
-static void __iomem *icoll_base;
+struct icoll_priv {
+	void __iomem *vector;
+	void __iomem *levelack;
+	void __iomem *ctrl;
+	void __iomem *stat;
+	void __iomem *intr;
+	/* number of interrupts per register */
+	int intr_reg_num;
+	void __iomem *clear;
+};
+
+struct icoll_priv icoll_priv;
 static struct irq_domain *icoll_domain;
 
+static u32 icoll_intr_bitshift(struct irq_data *d, u32 bit)
+{
+	int n = icoll_priv.intr_reg_num - 1;
+	return bit << ((d->hwirq & n) << n);
+}
+
+static void __iomem *icoll_intr_reg(struct irq_data *d)
+{
+	int n = icoll_priv.intr_reg_num;
+	return icoll_priv.intr + ((d->hwirq / n) * 0x10);
+}
+
 static void icoll_ack_irq(struct irq_data *d)
 {
 	/*
@@ -51,19 +88,25 @@ static void icoll_ack_irq(struct irq_data *d)
 	 * BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0 unconditionally.
 	 */
 	__raw_writel(BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0,
-			icoll_base + HW_ICOLL_LEVELACK);
+			icoll_priv.levelack);
 }
 
 static void icoll_mask_irq(struct irq_data *d)
 {
-	__raw_writel(BM_ICOLL_INTERRUPTn_ENABLE,
-			icoll_base + HW_ICOLL_INTERRUPTn_CLR(d->hwirq));
+	__raw_writel(icoll_intr_bitshift(d, BM_ICOLL_INTR_ENABLE),
+			icoll_intr_reg(d) + CLR_REG);
 }
 
 static void icoll_unmask_irq(struct irq_data *d)
 {
-	__raw_writel(BM_ICOLL_INTERRUPTn_ENABLE,
-			icoll_base + HW_ICOLL_INTERRUPTn_SET(d->hwirq));
+	if (!IS_ERR(icoll_priv.clear)) {
+		__raw_writel(ASM9260_BM_CLEAR_BIT(d->hwirq),
+				icoll_priv.clear +
+				ASM9260_HW_ICOLL_CLEARn(d->hwirq));
+	}
+
+	__raw_writel(icoll_intr_bitshift(d, BM_ICOLL_INTR_ENABLE),
+			icoll_intr_reg(d) + SET_REG);
 }
 
 static struct irq_chip mxs_icoll_chip = {
@@ -76,8 +119,8 @@ asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
 
-	irqnr = __raw_readl(icoll_base + HW_ICOLL_STAT_OFFSET);
-	__raw_writel(irqnr, icoll_base + HW_ICOLL_VECTOR);
+	irqnr = __raw_readl(icoll_priv.stat);
+	__raw_writel(irqnr, icoll_priv.vector);
 	handle_domain_irq(icoll_domain, irqnr, regs);
 }
 
@@ -95,20 +138,87 @@ static struct irq_domain_ops icoll_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
+static void __init icoll_add_domain(struct device_node *np,
+			  int num)
+{
+	icoll_domain = irq_domain_add_linear(np, num,
+					     &icoll_irq_domain_ops, NULL);
+
+	if (!icoll_domain)
+		panic("%s: unable add irq domain", np->full_name);
+	irq_set_default_host(icoll_domain);
+	set_handle_irq(icoll_handle_irq);
+}
+
+static void __iomem * __init icoll_init_iobase(struct device_node *np)
+{
+	struct resource res;
+	void __iomem *icoll_base;
+
+	if (of_address_to_resource(np, 0, &res))
+		panic("%s: unable to get resource", np->full_name);
+
+	if (!request_mem_region(res.start, resource_size(&res), np->name))
+		panic("%s: unable to request mem region", np->full_name);
+
+	icoll_base = ioremap_nocache(res.start, resource_size(&res));
+	if (!icoll_base)
+		panic("%s: unable to map resource", np->full_name);
+	return icoll_base;
+}
+
 static int __init icoll_of_init(struct device_node *np,
 			  struct device_node *interrupt_parent)
 {
-	icoll_base = of_iomap(np, 0);
-	WARN_ON(!icoll_base);
+	void __iomem *icoll_base;
+
+	icoll_base		= icoll_init_iobase(np);
+	icoll_priv.vector	= icoll_base + HW_ICOLL_VECTOR;
+	icoll_priv.levelack	= icoll_base + HW_ICOLL_LEVELACK;
+	icoll_priv.ctrl		= icoll_base + HW_ICOLL_CTRL;
+	icoll_priv.stat		= icoll_base + HW_ICOLL_STAT_OFFSET;
+	icoll_priv.intr		= icoll_base + HW_ICOLL_INTERRUPT0;
+	icoll_priv.intr_reg_num	= 1;
+	icoll_priv.clear	= ERR_PTR(-ENODEV);
 
 	/*
 	 * Interrupt Collector reset, which initializes the priority
 	 * for each irq to level 0.
 	 */
-	stmp_reset_block(icoll_base + HW_ICOLL_CTRL);
+	stmp_reset_block(icoll_priv.ctrl);
+
+	icoll_add_domain(np, ICOLL_NUM_IRQS);
 
-	icoll_domain = irq_domain_add_linear(np, ICOLL_NUM_IRQS,
-					     &icoll_irq_domain_ops, NULL);
 	return icoll_domain ? 0 : -ENODEV;
 }
 IRQCHIP_DECLARE(mxs, "fsl,icoll", icoll_of_init);
+
+static int __init asm9260_of_init(struct device_node *np,
+			  struct device_node *interrupt_parent)
+{
+	void __iomem *icoll_base;
+	int i;
+
+	icoll_base = icoll_init_iobase(np);
+	icoll_priv.vector	= icoll_base + ASM9260_HW_ICOLL_VECTOR;
+	icoll_priv.levelack	= icoll_base + ASM9260_HW_ICOLL_LEVELACK;
+	icoll_priv.ctrl		= icoll_base + ASM9260_HW_ICOLL_CTRL;
+	icoll_priv.stat		= icoll_base + ASM9260_HW_ICOLL_STAT_OFFSET;
+	icoll_priv.intr		= icoll_base + ASM9260_HW_ICOLL_INTERRUPT0;
+	icoll_priv.intr_reg_num	= 4;
+	icoll_priv.clear	= icoll_base + ASM9260_HW_ICOLL_CLEAR0;
+
+	writel_relaxed(ASM9260_BM_CTRL_IRQ_ENABLE,
+			icoll_priv.ctrl);
+	/*
+	 * ASM9260 don't provide reset bit. So, we need to set level 0
+	 * manually.
+	 */
+	for (i = 0; i < 16 * 0x10; i += 0x10)
+		writel(0, icoll_priv.intr + i);
+
+	icoll_add_domain(np, ASM9260_NUM_IRQS);
+
+	return icoll_domain ? 0 : -ENODEV;
+}
+IRQCHIP_DECLARE(asm9260, "alphascale,asm9260-icoll", asm9260_of_init);
-- 
1.9.1
