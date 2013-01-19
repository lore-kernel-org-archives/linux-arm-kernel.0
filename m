From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 19 Jan 2013 04:04:55 +0100
Subject: [PATCH v3 1/9] ARM: S3C24XX: transform irq handling into a
 declarative form
In-Reply-To: <201301190403.50317.heiko@sntech.de>
References: <201301190403.50317.heiko@sntech.de>
Message-ID: <201301190404.55731.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irqs available on the machine and even the bit settings in the
irq registers differ a lot through all the s3c24xx subarchitectures.
This results in each subarch having its own irq init which adds its
specific irqs to the base ones created in plat-s3c24xx/irq.c.

This of course makes a future move to devicetree hard to implement.

Therefore this patch transforms the base irq handling to a declarative
style, where the irq types as well as its parent/child relationship
gets read from a predefined datastructure, which later on can hopefully
be easily represented in devicetree too.

It should also be easy to include the subarch specific irqs here
in later patches, reducing code size and duplication.

It should not affect anything outside of the file, as the original
irq numbers and their handling are preserved (hopefully) correctly.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes since v2:
- redo the initialization, move parts of the upcoming dt init here
  to enable both init variants to share the code
changes since v1:
- more generalized irq types, resulting in only types for
  none, eint, edge and level being needed
- use chained_irq_enter/exit to simplify subirq handling

 arch/arm/plat-s3c24xx/Kconfig |    1 +
 arch/arm/plat-s3c24xx/irq.c   |  930 ++++++++++++++++++++---------------------
 2 files changed, 445 insertions(+), 486 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index eef3b6a..3bb5c8f 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -9,6 +9,7 @@ config PLAT_S3C24XX
 	select ARCH_REQUIRE_GPIOLIB
 	select NO_IOPORT
 	select S3C_DEV_NAND
+	select IRQ_DOMAIN
 	help
 	  Base platform code for any Samsung S3C24XX device
 
diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index fe57bbb..9e24ef5 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -1,7 +1,9 @@
-/* linux/arch/arm/plat-s3c24xx/irq.c
+/*
+ * S3C24XX IRQ handling
  *
  * Copyright (c) 2003-2004 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
+ * Copyright (c) 2012 Heiko Stuebner <heiko@sntech.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -12,175 +14,124 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 
 #include <linux/init.h>
+#include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/io.h>
+#include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/device.h>
 #include <linux/syscore_ops.h>
+#include <linux/irqdomain.h>
 
-#include <asm/irq.h>
 #include <asm/mach/irq.h>
 
-#include <plat/regs-irqtype.h>
+#include <mach/regs-irq.h>
+#include <mach/regs-gpio.h>
 
 #include <plat/cpu.h>
+#include <plat/regs-irqtype.h>
 #include <plat/pm.h>
 #include <plat/irq.h>
 
-static void
-s3c_irq_mask(struct irq_data *data)
-{
-	unsigned int irqno = data->irq - IRQ_EINT0;
-	unsigned long mask;
-
-	mask = __raw_readl(S3C2410_INTMSK);
-	mask |= 1UL << irqno;
-	__raw_writel(mask, S3C2410_INTMSK);
-}
-
-static inline void
-s3c_irq_ack(struct irq_data *data)
-{
-	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
-
-	__raw_writel(bitval, S3C2410_SRCPND);
-	__raw_writel(bitval, S3C2410_INTPND);
-}
-
-static inline void
-s3c_irq_maskack(struct irq_data *data)
-{
-	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
-	unsigned long mask;
+#define S3C_IRQTYPE_NONE	0
+#define S3C_IRQTYPE_EINT	1
+#define S3C_IRQTYPE_EDGE	2
+#define S3C_IRQTYPE_LEVEL	3
 
-	mask = __raw_readl(S3C2410_INTMSK);
-	__raw_writel(mask|bitval, S3C2410_INTMSK);
+struct s3c_irq_data {
+	unsigned int type;
+	unsigned long parent_irq;
 
-	__raw_writel(bitval, S3C2410_SRCPND);
-	__raw_writel(bitval, S3C2410_INTPND);
-}
-
-
-static void
-s3c_irq_unmask(struct irq_data *data)
-{
-	unsigned int irqno = data->irq;
-	unsigned long mask;
-
-	if (irqno != IRQ_TIMER4 && irqno != IRQ_EINT8t23)
-		irqdbf2("s3c_irq_unmask %d\n", irqno);
-
-	irqno -= IRQ_EINT0;
-
-	mask = __raw_readl(S3C2410_INTMSK);
-	mask &= ~(1UL << irqno);
-	__raw_writel(mask, S3C2410_INTMSK);
-}
-
-struct irq_chip s3c_irq_level_chip = {
-	.name		= "s3c-level",
-	.irq_ack	= s3c_irq_maskack,
-	.irq_mask	= s3c_irq_mask,
-	.irq_unmask	= s3c_irq_unmask,
-	.irq_set_wake	= s3c_irq_wake
+	/* data gets filled during init */
+	struct s3c_irq_intc *intc;
+	unsigned long sub_bits;
+	struct s3c_irq_intc *sub_intc;
 };
 
-struct irq_chip s3c_irq_chip = {
-	.name		= "s3c",
-	.irq_ack	= s3c_irq_ack,
-	.irq_mask	= s3c_irq_mask,
-	.irq_unmask	= s3c_irq_unmask,
-	.irq_set_wake	= s3c_irq_wake
+/*
+ * Sructure holding the controller data
+ * @reg_pending		register holding pending irqs
+ * @reg_intpnd		special register intpnd in main intc
+ * @reg_mask		mask register
+ * @domain		irq_domain of the controller
+ * @parent		parent controller for ext and sub irqs
+ * @irqs		irq-data, always s3c_irq_data[32]
+ */
+struct s3c_irq_intc {
+	void __iomem		*reg_pending;
+	void __iomem		*reg_intpnd;
+	void __iomem		*reg_mask;
+	struct irq_domain	*domain;
+	struct s3c_irq_intc	*parent;
+	struct s3c_irq_data	*irqs;
 };
 
-static void
-s3c_irqext_mask(struct irq_data *data)
+static void s3c_irq_mask(struct irq_data *data)
 {
-	unsigned int irqno = data->irq - EXTINT_OFF;
+	struct s3c_irq_intc *intc = data->domain->host_data;
+	struct s3c_irq_intc *parent_intc = intc->parent;
+	struct s3c_irq_data *irq_data = &intc->irqs[data->hwirq];
+	struct s3c_irq_data *parent_data;
 	unsigned long mask;
+	unsigned int irqno;
+
+	mask = __raw_readl(intc->reg_mask);
+	mask |= (1UL << data->hwirq);
+	__raw_writel(mask, intc->reg_mask);
+
+	if (parent_intc && irq_data->parent_irq) {
+		parent_data = &parent_intc->irqs[irq_data->parent_irq];
 
-	mask = __raw_readl(S3C24XX_EINTMASK);
-	mask |= ( 1UL << irqno);
-	__raw_writel(mask, S3C24XX_EINTMASK);
+		/* check to see if we need to mask the parent IRQ */
+		if ((mask & parent_data->sub_bits) == parent_data->sub_bits) {
+			irqno = irq_find_mapping(parent_intc->domain,
+					 irq_data->parent_irq);
+			s3c_irq_mask(irq_get_irq_data(irqno));
+		}
+	}
 }
 
-static void
-s3c_irqext_ack(struct irq_data *data)
+static void s3c_irq_unmask(struct irq_data *data)
 {
-	unsigned long req;
-	unsigned long bit;
+	struct s3c_irq_intc *intc = data->domain->host_data;
+	struct s3c_irq_intc *parent_intc = intc->parent;
+	struct s3c_irq_data *irq_data = &intc->irqs[data->hwirq];
 	unsigned long mask;
+	unsigned int irqno;
 
-	bit = 1UL << (data->irq - EXTINT_OFF);
-
-	mask = __raw_readl(S3C24XX_EINTMASK);
-
-	__raw_writel(bit, S3C24XX_EINTPEND);
-
-	req = __raw_readl(S3C24XX_EINTPEND);
-	req &= ~mask;
-
-	/* not sure if we should be acking the parent irq... */
+	mask = __raw_readl(intc->reg_mask);
+	mask &= ~(1UL << data->hwirq);
+	__raw_writel(mask, intc->reg_mask);
 
-	if (data->irq <= IRQ_EINT7) {
-		if ((req & 0xf0) == 0)
-			s3c_irq_ack(irq_get_irq_data(IRQ_EINT4t7));
-	} else {
-		if ((req >> 8) == 0)
-			s3c_irq_ack(irq_get_irq_data(IRQ_EINT8t23));
+	if (parent_intc && irq_data->parent_irq) {
+		irqno = irq_find_mapping(parent_intc->domain,
+					 irq_data->parent_irq);
+		s3c_irq_unmask(irq_get_irq_data(irqno));
 	}
 }
 
-static void
-s3c_irqext_unmask(struct irq_data *data)
+static inline void s3c_irq_ack(struct irq_data *data)
 {
-	unsigned int irqno = data->irq - EXTINT_OFF;
-	unsigned long mask;
+	struct s3c_irq_intc *intc = data->domain->host_data;
+	unsigned long bitval = 1UL << data->hwirq;
 
-	mask = __raw_readl(S3C24XX_EINTMASK);
-	mask &= ~(1UL << irqno);
-	__raw_writel(mask, S3C24XX_EINTMASK);
+	__raw_writel(bitval, intc->reg_pending);
+	if (intc->reg_intpnd)
+		__raw_writel(bitval, intc->reg_intpnd);
 }
 
-int
-s3c_irqext_type(struct irq_data *data, unsigned int type)
+static int s3c_irqext_type_set(void __iomem *gpcon_reg,
+			       void __iomem *extint_reg,
+			       unsigned long gpcon_offset,
+			       unsigned long extint_offset,
+			       unsigned int type)
 {
-	void __iomem *extint_reg;
-	void __iomem *gpcon_reg;
-	unsigned long gpcon_offset, extint_offset;
 	unsigned long newvalue = 0, value;
 
-	if ((data->irq >= IRQ_EINT0) && (data->irq <= IRQ_EINT3)) {
-		gpcon_reg = S3C2410_GPFCON;
-		extint_reg = S3C24XX_EXTINT0;
-		gpcon_offset = (data->irq - IRQ_EINT0) * 2;
-		extint_offset = (data->irq - IRQ_EINT0) * 4;
-	} else if ((data->irq >= IRQ_EINT4) && (data->irq <= IRQ_EINT7)) {
-		gpcon_reg = S3C2410_GPFCON;
-		extint_reg = S3C24XX_EXTINT0;
-		gpcon_offset = (data->irq - (EXTINT_OFF)) * 2;
-		extint_offset = (data->irq - (EXTINT_OFF)) * 4;
-	} else if ((data->irq >= IRQ_EINT8) && (data->irq <= IRQ_EINT15)) {
-		gpcon_reg = S3C2410_GPGCON;
-		extint_reg = S3C24XX_EXTINT1;
-		gpcon_offset = (data->irq - IRQ_EINT8) * 2;
-		extint_offset = (data->irq - IRQ_EINT8) * 4;
-	} else if ((data->irq >= IRQ_EINT16) && (data->irq <= IRQ_EINT23)) {
-		gpcon_reg = S3C2410_GPGCON;
-		extint_reg = S3C24XX_EXTINT2;
-		gpcon_offset = (data->irq - IRQ_EINT8) * 2;
-		extint_offset = (data->irq - IRQ_EINT16) * 4;
-	} else {
-		return -1;
-	}
-
 	/* Set the GPIO to external interrupt mode */
 	value = __raw_readl(gpcon_reg);
 	value = (value & ~(3 << gpcon_offset)) | (0x02 << gpcon_offset);
@@ -190,7 +141,7 @@ s3c_irqext_type(struct irq_data *data, unsigned int type)
 	switch (type)
 	{
 		case IRQ_TYPE_NONE:
-			printk(KERN_WARNING "No edge setting!\n");
+			pr_warn("No edge setting!\n");
 			break;
 
 		case IRQ_TYPE_EDGE_RISING:
@@ -214,8 +165,8 @@ s3c_irqext_type(struct irq_data *data, unsigned int type)
 			break;
 
 		default:
-			printk(KERN_ERR "No such irq type %d", type);
-			return -1;
+			pr_err("No such irq type %d", type);
+			return -EINVAL;
 	}
 
 	value = __raw_readl(extint_reg);
@@ -225,265 +176,113 @@ s3c_irqext_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
-static struct irq_chip s3c_irqext_chip = {
-	.name		= "s3c-ext",
-	.irq_mask	= s3c_irqext_mask,
-	.irq_unmask	= s3c_irqext_unmask,
-	.irq_ack	= s3c_irqext_ack,
-	.irq_set_type	= s3c_irqext_type,
-	.irq_set_wake	= s3c_irqext_wake
-};
-
-static struct irq_chip s3c_irq_eint0t4 = {
-	.name		= "s3c-ext0",
-	.irq_ack	= s3c_irq_ack,
-	.irq_mask	= s3c_irq_mask,
-	.irq_unmask	= s3c_irq_unmask,
-	.irq_set_wake	= s3c_irq_wake,
-	.irq_set_type	= s3c_irqext_type,
-};
-
-/* mask values for the parent registers for each of the interrupt types */
-
-#define INTMSK_UART0	 (1UL << (IRQ_UART0 - IRQ_EINT0))
-#define INTMSK_UART1	 (1UL << (IRQ_UART1 - IRQ_EINT0))
-#define INTMSK_UART2	 (1UL << (IRQ_UART2 - IRQ_EINT0))
-#define INTMSK_ADCPARENT (1UL << (IRQ_ADCPARENT - IRQ_EINT0))
-
-
-/* UART0 */
-
-static void
-s3c_irq_uart0_mask(struct irq_data *data)
+/* FIXME: make static when it's out of plat-samsung/irq.h */
+int s3c_irqext_type(struct irq_data *data, unsigned int type)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_UART0, 7);
-}
+	void __iomem *extint_reg;
+	void __iomem *gpcon_reg;
+	unsigned long gpcon_offset, extint_offset;
 
-static void
-s3c_irq_uart0_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_UART0);
-}
+	if ((data->hwirq >= 4) && (data->hwirq <= 7)) {
+		gpcon_reg = S3C2410_GPFCON;
+		extint_reg = S3C24XX_EXTINT0;
+		gpcon_offset = (data->hwirq) * 2;
+		extint_offset = (data->hwirq) * 4;
+	} else if ((data->hwirq >= 8) && (data->hwirq <= 15)) {
+		gpcon_reg = S3C2410_GPGCON;
+		extint_reg = S3C24XX_EXTINT1;
+		gpcon_offset = (data->hwirq - 8) * 2;
+		extint_offset = (data->hwirq - 8) * 4;
+	} else if ((data->hwirq >= 16) && (data->hwirq <= 23)) {
+		gpcon_reg = S3C2410_GPGCON;
+		extint_reg = S3C24XX_EXTINT2;
+		gpcon_offset = (data->hwirq - 8) * 2;
+		extint_offset = (data->hwirq - 16) * 4;
+	} else {
+		return -EINVAL;
+	}
 
-static void
-s3c_irq_uart0_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_UART0, 7);
+	return s3c_irqext_type_set(gpcon_reg, extint_reg, gpcon_offset,
+				   extint_offset, type);
 }
 
-static struct irq_chip s3c_irq_uart0 = {
-	.name		= "s3c-uart0",
-	.irq_mask	= s3c_irq_uart0_mask,
-	.irq_unmask	= s3c_irq_uart0_unmask,
-	.irq_ack	= s3c_irq_uart0_ack,
-};
-
-/* UART1 */
-
-static void
-s3c_irq_uart1_mask(struct irq_data *data)
+static int s3c_irqext0_type(struct irq_data *data, unsigned int type)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_UART1, 7 << 3);
-}
+	void __iomem *extint_reg;
+	void __iomem *gpcon_reg;
+	unsigned long gpcon_offset, extint_offset;
 
-static void
-s3c_irq_uart1_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_UART1);
-}
+	if ((data->hwirq >= 0) && (data->hwirq <= 3)) {
+		gpcon_reg = S3C2410_GPFCON;
+		extint_reg = S3C24XX_EXTINT0;
+		gpcon_offset = (data->hwirq) * 2;
+		extint_offset = (data->hwirq) * 4;
+	} else {
+		return -EINVAL;
+	}
 
-static void
-s3c_irq_uart1_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_UART1, 7 << 3);
+	return s3c_irqext_type_set(gpcon_reg, extint_reg, gpcon_offset,
+				   extint_offset, type);
 }
 
-static struct irq_chip s3c_irq_uart1 = {
-	.name		= "s3c-uart1",
-	.irq_mask	= s3c_irq_uart1_mask,
-	.irq_unmask	= s3c_irq_uart1_unmask,
-	.irq_ack	= s3c_irq_uart1_ack,
+struct irq_chip s3c_irq_chip = {
+	.name		= "s3c",
+	.irq_ack	= s3c_irq_ack,
+	.irq_mask	= s3c_irq_mask,
+	.irq_unmask	= s3c_irq_unmask,
+	.irq_set_wake	= s3c_irq_wake
 };
 
-/* UART2 */
-
-static void
-s3c_irq_uart2_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_UART2, 7 << 6);
-}
-
-static void
-s3c_irq_uart2_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_UART2);
-}
-
-static void
-s3c_irq_uart2_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_UART2, 7 << 6);
-}
-
-static struct irq_chip s3c_irq_uart2 = {
-	.name		= "s3c-uart2",
-	.irq_mask	= s3c_irq_uart2_mask,
-	.irq_unmask	= s3c_irq_uart2_unmask,
-	.irq_ack	= s3c_irq_uart2_ack,
+struct irq_chip s3c_irq_level_chip = {
+	.name		= "s3c-level",
+	.irq_mask	= s3c_irq_mask,
+	.irq_unmask	= s3c_irq_unmask,
+	.irq_ack	= s3c_irq_ack,
 };
 
-/* ADC and Touchscreen */
-
-static void
-s3c_irq_adc_mask(struct irq_data *d)
-{
-	s3c_irqsub_mask(d->irq, INTMSK_ADCPARENT, 3 << 9);
-}
-
-static void
-s3c_irq_adc_unmask(struct irq_data *d)
-{
-	s3c_irqsub_unmask(d->irq, INTMSK_ADCPARENT);
-}
-
-static void
-s3c_irq_adc_ack(struct irq_data *d)
-{
-	s3c_irqsub_ack(d->irq, INTMSK_ADCPARENT, 3 << 9);
-}
-
-static struct irq_chip s3c_irq_adc = {
-	.name		= "s3c-adc",
-	.irq_mask	= s3c_irq_adc_mask,
-	.irq_unmask	= s3c_irq_adc_unmask,
-	.irq_ack	= s3c_irq_adc_ack,
+static struct irq_chip s3c_irqext_chip = {
+	.name		= "s3c-ext",
+	.irq_mask	= s3c_irq_mask,
+	.irq_unmask	= s3c_irq_unmask,
+	.irq_ack	= s3c_irq_ack,
+	.irq_set_type	= s3c_irqext_type,
+	.irq_set_wake	= s3c_irqext_wake
 };
 
-/* irq demux for adc */
-static void s3c_irq_demux_adc(unsigned int irq,
-			      struct irq_desc *desc)
-{
-	unsigned int subsrc, submsk;
-	unsigned int offset = 9;
-
-	/* read the current pending interrupts, and the mask
-	 * for what it is available */
-
-	subsrc = __raw_readl(S3C2410_SUBSRCPND);
-	submsk = __raw_readl(S3C2410_INTSUBMSK);
-
-	subsrc &= ~submsk;
-	subsrc >>= offset;
-	subsrc &= 3;
-
-	if (subsrc != 0) {
-		if (subsrc & 1) {
-			generic_handle_irq(IRQ_TC);
-		}
-		if (subsrc & 2) {
-			generic_handle_irq(IRQ_ADC);
-		}
-	}
-}
-
-static void s3c_irq_demux_uart(unsigned int start)
-{
-	unsigned int subsrc, submsk;
-	unsigned int offset = start - IRQ_S3CUART_RX0;
-
-	/* read the current pending interrupts, and the mask
-	 * for what it is available */
-
-	subsrc = __raw_readl(S3C2410_SUBSRCPND);
-	submsk = __raw_readl(S3C2410_INTSUBMSK);
-
-	irqdbf2("s3c_irq_demux_uart: start=%d (%d), subsrc=0x%08x,0x%08x\n",
-		start, offset, subsrc, submsk);
-
-	subsrc &= ~submsk;
-	subsrc >>= offset;
-	subsrc &= 7;
-
-	if (subsrc != 0) {
-		if (subsrc & 1)
-			generic_handle_irq(start);
-
-		if (subsrc & 2)
-			generic_handle_irq(start+1);
-
-		if (subsrc & 4)
-			generic_handle_irq(start+2);
-	}
-}
-
-/* uart demux entry points */
-
-static void
-s3c_irq_demux_uart0(unsigned int irq,
-		    struct irq_desc *desc)
-{
-	irq = irq;
-	s3c_irq_demux_uart(IRQ_S3CUART_RX0);
-}
-
-static void
-s3c_irq_demux_uart1(unsigned int irq,
-		    struct irq_desc *desc)
-{
-	irq = irq;
-	s3c_irq_demux_uart(IRQ_S3CUART_RX1);
-}
-
-static void
-s3c_irq_demux_uart2(unsigned int irq,
-		    struct irq_desc *desc)
-{
-	irq = irq;
-	s3c_irq_demux_uart(IRQ_S3CUART_RX2);
-}
+static struct irq_chip s3c_irq_eint0t4 = {
+	.name		= "s3c-ext0",
+	.irq_ack	= s3c_irq_ack,
+	.irq_mask	= s3c_irq_mask,
+	.irq_unmask	= s3c_irq_unmask,
+	.irq_set_wake	= s3c_irq_wake,
+	.irq_set_type	= s3c_irqext0_type,
+};
 
-static void
-s3c_irq_demux_extint8(unsigned int irq,
-		      struct irq_desc *desc)
+static void s3c_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
-	unsigned long eintpnd = __raw_readl(S3C24XX_EINTPEND);
-	unsigned long eintmsk = __raw_readl(S3C24XX_EINTMASK);
-
-	eintpnd &= ~eintmsk;
-	eintpnd &= ~0xff;	/* ignore lower irqs */
-
-	/* we may as well handle all the pending IRQs here */
-
-	while (eintpnd) {
-		irq = __ffs(eintpnd);
-		eintpnd &= ~(1<<irq);
-
-		irq += (IRQ_EINT4 - 4);
-		generic_handle_irq(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct s3c_irq_intc *intc = desc->irq_data.domain->host_data;
+	struct s3c_irq_data *irq_data = &intc->irqs[desc->irq_data.hwirq];
+	struct s3c_irq_intc *sub_intc = irq_data->sub_intc;
+	unsigned long src;
+	unsigned long msk;
+	unsigned int n;
+
+	chained_irq_enter(chip, desc);
+
+	src = __raw_readl(sub_intc->reg_pending);
+	msk = __raw_readl(sub_intc->reg_mask);
+
+	src &= ~msk;
+	src &= irq_data->sub_bits;
+
+	while (src) {
+		n = __ffs(src);
+		src &= ~(1 << n);
+		generic_handle_irq(irq_find_mapping(sub_intc->domain, n));
 	}
 
-}
-
-static void
-s3c_irq_demux_extint4t7(unsigned int irq,
-			struct irq_desc *desc)
-{
-	unsigned long eintpnd = __raw_readl(S3C24XX_EINTPEND);
-	unsigned long eintmsk = __raw_readl(S3C24XX_EINTMASK);
-
-	eintpnd &= ~eintmsk;
-	eintpnd &= 0xff;	/* only lower irqs */
-
-	/* we may as well handle all the pending IRQs here */
-
-	while (eintpnd) {
-		irq = __ffs(eintpnd);
-		eintpnd &= ~(1<<irq);
-
-		irq += (IRQ_EINT4 - 4);
-
-		generic_handle_irq(irq);
-	}
+	chained_irq_exit(chip, desc);
 }
 
 #ifdef CONFIG_FIQ
@@ -519,155 +318,314 @@ int s3c24xx_set_fiq(unsigned int irq, bool on)
 EXPORT_SYMBOL_GPL(s3c24xx_set_fiq);
 #endif
 
-
-/* s3c24xx_init_irq
- *
- * Initialise S3C2410 IRQ system
-*/
-
-void __init s3c24xx_init_irq(void)
+static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
+							irq_hw_number_t hw)
 {
-	unsigned long pend;
-	unsigned long last;
-	int irqno;
-	int i;
-
-#ifdef CONFIG_FIQ
-	init_FIQ(FIQ_START);
-#endif
-
-	irqdbf("s3c2410_init_irq: clearing interrupt status flags\n");
-
-	/* first, clear all interrupts pending... */
+	struct s3c_irq_intc *intc = h->host_data;
+	struct s3c_irq_data *irq_data = &intc->irqs[hw];
+	struct s3c_irq_intc *parent_intc;
+	struct s3c_irq_data *parent_irq_data;
+	unsigned int irqno;
+
+	if (!intc) {
+		pr_err("irq-s3c24xx: no controller found for hwirq %lu\n", hw);
+		return -EINVAL;
+	}
 
-	last = 0;
-	for (i = 0; i < 4; i++) {
-		pend = __raw_readl(S3C24XX_EINTPEND);
+	if (!irq_data) {
+		pr_err("irq-s3c24xx: no irq data found for hwirq %lu\n", hw);
+		return -EINVAL;
+	}
 
-		if (pend == 0 || pend == last)
-			break;
+	/* attach controller pointer to irq_data */
+	irq_data->intc = intc;
 
-		__raw_writel(pend, S3C24XX_EINTPEND);
-		printk("irq: clearing pending ext status %08x\n", (int)pend);
-		last = pend;
+	/* set handler and flags */
+	switch (irq_data->type) {
+	case S3C_IRQTYPE_NONE:
+		return 0;
+	case S3C_IRQTYPE_EINT:
+		if (irq_data->parent_irq)
+			irq_set_chip_and_handler(virq, &s3c_irqext_chip,
+						 handle_edge_irq);
+		else
+			irq_set_chip_and_handler(virq, &s3c_irq_eint0t4,
+						 handle_edge_irq);
+		break;
+	case S3C_IRQTYPE_EDGE:
+		if (irq_data->parent_irq)
+			irq_set_chip_and_handler(virq, &s3c_irq_level_chip,
+						 handle_edge_irq);
+		else
+			irq_set_chip_and_handler(virq, &s3c_irq_chip,
+						 handle_edge_irq);
+		break;
+	case S3C_IRQTYPE_LEVEL:
+		if (irq_data->parent_irq)
+			irq_set_chip_and_handler(virq, &s3c_irq_level_chip,
+						 handle_level_irq);
+		else
+			irq_set_chip_and_handler(virq, &s3c_irq_chip,
+						 handle_level_irq);
+		break;
+	default:
+		pr_err("irq-s3c24xx: unsupported irqtype %d\n", irq_data->type);
+		return -EINVAL;
 	}
+	set_irq_flags(virq, IRQF_VALID);
+
+	if (irq_data->parent_irq) {
+		parent_intc = intc->parent;
+		if (!parent_intc) {
+			pr_err("irq-s3c24xx: no parent controller found for hwirq %lu\n",
+			       hw);
+			goto err;
+		}
 
-	last = 0;
-	for (i = 0; i < 4; i++) {
-		pend = __raw_readl(S3C2410_INTPND);
+		parent_irq_data = &parent_intc->irqs[irq_data->parent_irq];
+		if (!irq_data) {
+			pr_err("irq-s3c24xx: no irq data found for hwirq %lu\n",
+			       hw);
+			goto err;
+		}
 
-		if (pend == 0 || pend == last)
-			break;
+		parent_irq_data->sub_intc = intc;
+		parent_irq_data->sub_bits |= (1UL << hw);
 
-		__raw_writel(pend, S3C2410_SRCPND);
-		__raw_writel(pend, S3C2410_INTPND);
-		printk("irq: clearing pending status %08x\n", (int)pend);
-		last = pend;
+		/* attach the demuxer to the parent irq */
+		irqno = irq_find_mapping(parent_intc->domain,
+					 irq_data->parent_irq);
+		if (!irqno) {
+			pr_err("irq-s3c24xx: could not find mapping for parent irq %lu\n",
+			       irq_data->parent_irq);
+			goto err;
+		}
+		irq_set_chained_handler(irqno, s3c_irq_demux);
 	}
 
-	last = 0;
-	for (i = 0; i < 4; i++) {
-		pend = __raw_readl(S3C2410_SUBSRCPND);
+	return 0;
 
-		if (pend == 0 || pend == last)
-			break;
+err:
+	set_irq_flags(virq, 0);
 
-		printk("irq: clearing subpending status %08x\n", (int)pend);
-		__raw_writel(pend, S3C2410_SUBSRCPND);
-		last = pend;
-	}
+	/* the only error can result from bad mapping data*/
+	return -EINVAL;
+}
 
-	/* register the main interrupts */
+static struct irq_domain_ops s3c24xx_irq_ops = {
+	.map = s3c24xx_irq_map,
+	.xlate = irq_domain_xlate_twocell,
+};
 
-	irqdbf("s3c2410_init_irq: registering s3c2410 interrupt handlers\n");
+static void s3c24xx_clear_intc(struct s3c_irq_intc *intc)
+{
+	void __iomem *reg_source;
+	unsigned long pend;
+	unsigned long last;
+	int i;
 
-	for (irqno = IRQ_EINT4t7; irqno <= IRQ_ADCPARENT; irqno++) {
-		/* set all the s3c2410 internal irqs */
+	/* if intpnd is set, read the next pending irq from there */
+	reg_source = intc->reg_intpnd ? intc->reg_intpnd : intc->reg_pending;
 
-		switch (irqno) {
-			/* deal with the special IRQs (cascaded) */
+	last = 0;
+	for (i = 0; i < 4; i++) {
+		pend = __raw_readl(reg_source);
 
-		case IRQ_EINT4t7:
-		case IRQ_EINT8t23:
-		case IRQ_UART0:
-		case IRQ_UART1:
-		case IRQ_UART2:
-		case IRQ_ADCPARENT:
-			irq_set_chip_and_handler(irqno, &s3c_irq_level_chip,
-						 handle_level_irq);
+		if (pend == 0 || pend == last)
 			break;
 
-		case IRQ_RESERVED6:
-		case IRQ_RESERVED24:
-			/* no IRQ here */
-			break;
+		__raw_writel(pend, intc->reg_pending);
+		if (intc->reg_intpnd)
+			__raw_writel(pend, intc->reg_intpnd);
 
-		default:
-			//irqdbf("registering irq %d (s3c irq)\n", irqno);
-			irq_set_chip_and_handler(irqno, &s3c_irq_chip,
-						 handle_edge_irq);
-			set_irq_flags(irqno, IRQF_VALID);
-		}
+		pr_info("irq: clearing pending status %08x\n", (int)pend);
+		last = pend;
 	}
+}
 
-	/* setup the cascade irq handlers */
-
-	irq_set_chained_handler(IRQ_EINT4t7, s3c_irq_demux_extint4t7);
-	irq_set_chained_handler(IRQ_EINT8t23, s3c_irq_demux_extint8);
+struct s3c_irq_intc *s3c24xx_init_intc(struct device_node *np,
+				       struct s3c_irq_data *irq_data,
+				       struct s3c_irq_intc *parent,
+				       unsigned long address)
+{
+	struct s3c_irq_intc *intc;
+	void __iomem *base = (void *)0xf6000000; /* static mapping */
+	int irq_num;
+	int irq_start;
+	int irq_offset;
+	int ret;
+
+	intc = kzalloc(sizeof(struct s3c_irq_intc), GFP_KERNEL);
+	if (!intc)
+		return ERR_PTR(-ENOMEM);
+
+	intc->irqs = irq_data;
+
+	if (parent)
+		intc->parent = parent;
+
+	/* select the correct data for the controller.
+	 * Need to hard code the irq num start and offset
+	 * to preserve the static mapping for now
+	 */
+	switch (address) {
+	case 0x4a000000:
+		pr_debug("irq: found main intc\n");
+		intc->reg_pending = base;
+		intc->reg_mask = base + 0x08;
+		intc->reg_intpnd = base + 0x10;
+		irq_num = 32;
+		irq_start = S3C2410_IRQ(0);
+		irq_offset = 0;
+		break;
+	case 0x4a000018:
+		pr_debug("irq: found subintc\n");
+		intc->reg_pending = base + 0x18;
+		intc->reg_mask = base + 0x1c;
+		irq_num = 29;
+		irq_start = S3C2410_IRQSUB(0);
+		irq_offset = 0;
+		break;
+	case 0x4a000040:
+		pr_debug("irq: found intc2\n");
+		intc->reg_pending = base + 0x40;
+		intc->reg_mask = base + 0x48;
+		intc->reg_intpnd = base + 0x50;
+		irq_num = 8;
+		irq_start = S3C2416_IRQ(0);
+		irq_offset = 0;
+		break;
+	case 0x560000a4:
+		pr_debug("irq: found eintc\n");
+		base = (void *)0xfd000000;
+
+		intc->reg_mask = base + 0xa4;
+		intc->reg_pending = base + 0x08;
+		irq_num = 20;
+		irq_start = S3C2410_IRQ(32);
+		irq_offset = 4;
+		break;
+	default:
+		pr_err("irq: unsupported controller address\n");
+		ret = -EINVAL;
+		goto err;
+	}
 
-	irq_set_chained_handler(IRQ_UART0, s3c_irq_demux_uart0);
-	irq_set_chained_handler(IRQ_UART1, s3c_irq_demux_uart1);
-	irq_set_chained_handler(IRQ_UART2, s3c_irq_demux_uart2);
-	irq_set_chained_handler(IRQ_ADCPARENT, s3c_irq_demux_adc);
+	/* now that all the data is complete, init the irq-domain */
+	s3c24xx_clear_intc(intc);
+	intc->domain = irq_domain_add_legacy(np, irq_num, irq_start,
+					     irq_offset, &s3c24xx_irq_ops,
+					     intc);
+	if (!intc->domain) {
+		pr_err("irq: could not create irq-domain\n");
+		ret = -EINVAL;
+		goto err;
+	}
 
-	/* external interrupts */
+	return intc;
 
-	for (irqno = IRQ_EINT0; irqno <= IRQ_EINT3; irqno++) {
-		irqdbf("registering irq %d (ext int)\n", irqno);
-		irq_set_chip_and_handler(irqno, &s3c_irq_eint0t4,
-					 handle_edge_irq);
-		set_irq_flags(irqno, IRQF_VALID);
-	}
+err:
+	kfree(intc);
+	return ERR_PTR(ret);
+}
 
-	for (irqno = IRQ_EINT4; irqno <= IRQ_EINT23; irqno++) {
-		irqdbf("registering irq %d (extended s3c irq)\n", irqno);
-		irq_set_chip_and_handler(irqno, &s3c_irqext_chip,
-					 handle_edge_irq);
-		set_irq_flags(irqno, IRQF_VALID);
-	}
+/* s3c24xx_init_irq
+ *
+ * Initialise S3C2410 IRQ system
+*/
 
-	/* register the uart interrupts */
+struct s3c_irq_data init_base[32] = {
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT0 */
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT1 */
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT2 */
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT3 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT4to7 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT8to23 */
+	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* nBATT_FLT */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TICK */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* WDT */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TIMER0 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TIMER1 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TIMER2 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TIMER3 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TIMER4 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* UART2 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* LCD */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* DMA0 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* DMA1 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* DMA2 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* DMA3 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* SDI */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* SPI0 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* UART1 */
+	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* USBD */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* USBH */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* IIC */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* UART0 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* SPI1 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* RTC */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* ADCPARENT */
+};
 
-	irqdbf("s3c2410: registering external interrupts\n");
+struct s3c_irq_data init_eint[32] = {
+	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
+	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
+	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
+	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT4 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT5 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT6 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT7 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT8 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT9 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT10 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT11 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT12 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT13 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT14 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT15 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT16 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT17 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT18 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT19 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT20 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT21 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT22 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT23 */
+};
 
-	for (irqno = IRQ_S3CUART_RX0; irqno <= IRQ_S3CUART_ERR0; irqno++) {
-		irqdbf("registering irq %d (s3c uart0 irq)\n", irqno);
-		irq_set_chip_and_handler(irqno, &s3c_irq_uart0,
-					 handle_level_irq);
-		set_irq_flags(irqno, IRQF_VALID);
-	}
+struct s3c_irq_data init_subint[32] = {
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-RX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-TX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-ERR */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 23 }, /* UART1-RX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 23 }, /* UART1-TX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 23 }, /* UART1-ERR */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-RX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-TX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-ERR */
+	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* TC */
+	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* ADC */
+};
 
-	for (irqno = IRQ_S3CUART_RX1; irqno <= IRQ_S3CUART_ERR1; irqno++) {
-		irqdbf("registering irq %d (s3c uart1 irq)\n", irqno);
-		irq_set_chip_and_handler(irqno, &s3c_irq_uart1,
-					 handle_level_irq);
-		set_irq_flags(irqno, IRQF_VALID);
-	}
+void __init s3c24xx_init_irq(void)
+{
+	struct s3c_irq_intc *main_intc;
 
-	for (irqno = IRQ_S3CUART_RX2; irqno <= IRQ_S3CUART_ERR2; irqno++) {
-		irqdbf("registering irq %d (s3c uart2 irq)\n", irqno);
-		irq_set_chip_and_handler(irqno, &s3c_irq_uart2,
-					 handle_level_irq);
-		set_irq_flags(irqno, IRQF_VALID);
-	}
+#ifdef CONFIG_FIQ
+	init_FIQ(FIQ_START);
+#endif
 
-	for (irqno = IRQ_TC; irqno <= IRQ_ADC; irqno++) {
-		irqdbf("registering irq %d (s3c adc irq)\n", irqno);
-		irq_set_chip_and_handler(irqno, &s3c_irq_adc, handle_edge_irq);
-		set_irq_flags(irqno, IRQF_VALID);
+	main_intc = s3c24xx_init_intc(NULL, &init_base[0], NULL, 0x4a000000);
+	if (IS_ERR(main_intc)) {
+		pr_err("irq: could not create main interrupt controller\n");
+		return;
 	}
 
-	irqdbf("s3c2410: registered interrupt handlers\n");
+	s3c24xx_init_intc(NULL, &init_subint[0], main_intc, 0x4a000018);
+	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
 }
 
 struct syscore_ops s3c24xx_irq_syscore_ops = {
-- 
1.7.2.3
