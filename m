From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon,  8 Nov 2010 20:37:50 +0800
Subject: [PATCH 9/9] ARM: pxa: sanitize IRQ registers access based on offset
In-Reply-To: <1289219870-17807-8-git-send-email-haojian.zhuang@marvell.com>
References: <1289219870-17807-1-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-2-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-3-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-4-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-5-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-6-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-7-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-8-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1289219870-17807-9-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/include/mach/regs-intc.h |    4 -
 arch/arm/mach-pxa/irq.c                    |  122 ++++++++++++++++++----------
 2 files changed, 80 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-intc.h b/arch/arm/mach-pxa/include/mach/regs-intc.h
index 68464ce..662288e 100644
--- a/arch/arm/mach-pxa/include/mach/regs-intc.h
+++ b/arch/arm/mach-pxa/include/mach/regs-intc.h
@@ -27,8 +27,4 @@
 #define ICFP3		__REG(0x40D0013C)  /* Interrupt Controller FIQ Pending Register 3 */
 #define ICPR3		__REG(0x40D00140)  /* Interrupt Controller Pending Register 3 */
 
-#define IPR(x)		__REG(0x40D0001C + (x < 32 ? (x << 2)		\
-				: (x < 64 ? (0x94 + ((x - 32) << 2))	\
-				: (0x128 + ((x - 64) << 2)))))
-
 #endif /* __ASM_MACH_REGS_INTC_H */
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 40b9ee9..b1578f6 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -16,20 +16,31 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/sysdev.h>
+#include <linux/io.h>
+#include <linux/irq.h>
 
 #include <mach/hardware.h>
-#include <asm/irq.h>
-#include <asm/mach/irq.h>
+#include <mach/irqs.h>
 #include <mach/gpio.h>
-#include <mach/regs-intc.h>
 
 #include "generic.h"
 
-#define MAX_INTERNAL_IRQS	128
+#define IRQ_BASE		(void __iomem *)io_p2v(0x40d00000)
+
+#define ICIP			(0x000)
+#define ICMR			(0x004)
+#define ICLR			(0x008)
+#define ICFR			(0x00c)
+#define ICPR			(0x010)
+#define ICCR			(0x014)
+#define ICHP			(0x018)
+#define IPR(i)			(((i) < 32) ? (0x01c + ((i) << 2)) :		\
+				((i) < 64) ? (0x0b0 + (((i) - 32) << 2)) :	\
+				      (0x144 + (((i) - 64) << 2)))
+#define IPR_VALID		(1 << 31)
+#define IRQ_BIT(n)		(((n) - PXA_IRQ(0)) & 0x1f)
 
-#define IRQ_BIT(n)	(((n) - PXA_IRQ(0)) & 0x1f)
-#define _ICMR(n)	(*((((n) - PXA_IRQ(0)) & ~0x1f) ? &ICMR2 : &ICMR))
-#define _ICLR(n)	(*((((n) - PXA_IRQ(0)) & ~0x1f) ? &ICLR2 : &ICLR))
+#define MAX_INTERNAL_IRQS	128
 
 /*
  * This is for peripheral IRQs internal to the PXA chip.
@@ -39,12 +50,20 @@ static int pxa_internal_irq_nr;
 
 static void pxa_mask_irq(unsigned int irq)
 {
-	_ICMR(irq) &= ~(1 << IRQ_BIT(irq));
+	void __iomem *base = get_irq_chip_data(irq);
+	uint32_t icmr = __raw_readl(base + ICMR);
+
+	icmr &= ~(1 << IRQ_BIT(irq));
+	__raw_writel(icmr, base + ICMR);
 }
 
 static void pxa_unmask_irq(unsigned int irq)
 {
-	_ICMR(irq) |= 1 << IRQ_BIT(irq);
+	void __iomem *base = get_irq_chip_data(irq);
+	uint32_t icmr = __raw_readl(base + ICMR);
+
+	icmr |= 1 << IRQ_BIT(irq);
+	__raw_writel(icmr, base + ICMR);
 }
 
 static struct irq_chip pxa_internal_irq_chip = {
@@ -86,12 +105,16 @@ static void pxa_ack_low_gpio(unsigned int irq)
 
 static void pxa_mask_low_gpio(unsigned int irq)
 {
-	ICMR &= ~(1 << (irq - PXA_IRQ(0)));
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	desc->chip->mask(irq);
 }
 
 static void pxa_unmask_low_gpio(unsigned int irq)
 {
-	ICMR |= 1 << (irq - PXA_IRQ(0));
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	desc->chip->unmask(irq);
 }
 
 static struct irq_chip pxa_low_gpio_chip = {
@@ -120,33 +143,45 @@ static void __init pxa_init_low_gpio_irq(set_wake_t fn)
 	pxa_low_gpio_chip.set_wake = fn;
 }
 
+static inline void __iomem *irq_base(int i)
+{
+	static unsigned long phys_base[] = {
+		0x40d00000,
+		0x40d0009c,
+		0x40d00130,
+	};
+
+	return (void __iomem *)io_p2v(phys_base[i >> 5]);
+}
+
 void __init pxa_init_irq(int irq_nr, set_wake_t fn)
 {
-	int irq, i;
+	int irq, i, n;
 
 	BUG_ON(irq_nr > MAX_INTERNAL_IRQS);
 
 	pxa_internal_irq_nr = irq_nr;
 
-	for (irq = PXA_IRQ(0); irq < PXA_IRQ(irq_nr); irq += 32) {
-		_ICMR(irq) = 0;	/* disable all IRQs */
-		_ICLR(irq) = 0;	/* all IRQs are IRQ, not FIQ */
-	}
-
-	/* initialize interrupt priority */
-	if (!cpu_is_pxa25x()) {
-		for (i = 0; i < irq_nr; i++)
-			IPR(i) = i | (1 << 31);
+	for (n = 0; n < irq_nr; n += 32) {
+		void __iomem *base = irq_base(n);
+
+		__raw_writel(0, base + ICMR);	/* disable all IRQs */
+		__raw_writel(0, base + ICLR);	/* all IRQs are IRQ, not FIQ */
+		for (i = n; (i < (n + 32)) && (i < irq_nr); i++) {
+			/* initialize interrupt priority */
+			if (!cpu_is_pxa25x())
+				__raw_writel(i | IPR_VALID, IRQ_BASE + IPR(i));
+
+			irq = PXA_IRQ(i);
+			set_irq_chip(irq, &pxa_internal_irq_chip);
+			set_irq_chip_data(irq, base);
+			set_irq_handler(irq, handle_level_irq);
+			set_irq_flags(irq, IRQF_VALID);
+		}
 	}
 
 	/* only unmasked interrupts kick us out of idle */
-	ICCR = 1;
-
-	for (irq = PXA_IRQ(0); irq < PXA_IRQ(irq_nr); irq++) {
-		set_irq_chip(irq, &pxa_internal_irq_chip);
-		set_irq_handler(irq, handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID);
-	}
+	__raw_writel(1, irq_base(0) + ICCR);
 
 	pxa_internal_irq_chip.set_wake = fn;
 	pxa_init_low_gpio_irq(fn);
@@ -158,16 +193,18 @@ static unsigned long saved_ipr[MAX_INTERNAL_IRQS];
 
 static int pxa_irq_suspend(struct sys_device *dev, pm_message_t state)
 {
-	int i, irq = PXA_IRQ(0);
+	int i;
+
+	for (i = 0; i < pxa_internal_irq_nr; i += 32) {
+		void __iomem *base = irq_base(i);
 
-	for (i = 0; irq < PXA_IRQ(pxa_internal_irq_nr); i++, irq += 32) {
-		saved_icmr[i] = _ICMR(irq);
-		_ICMR(irq) = 0;
+		saved_icmr[i] = __raw_readl(base + ICMR);
+		__raw_writel(0, base + ICMR);
 	}
 
 	if (!cpu_is_pxa25x()) {
 		for (i = 0; i < pxa_internal_irq_nr; i++)
-			saved_ipr[i] = IPR(i);
+			saved_ipr[i] = __raw_readl(IRQ_BASE + IPR(i));
 	}
 
 	return 0;
@@ -175,19 +212,20 @@ static int pxa_irq_suspend(struct sys_device *dev, pm_message_t state)
 
 static int pxa_irq_resume(struct sys_device *dev)
 {
-	int i, irq = PXA_IRQ(0);
+	int i;
 
-	if (!cpu_is_pxa25x()) {
-		for (i = 0; i < pxa_internal_irq_nr; i++)
-			IPR(i) = saved_ipr[i];
-	}
+	for (i = 0; i < pxa_internal_irq_nr; i += 32) {
+		void __iomem *base = irq_base(i);
 
-	for (i = 0; irq < PXA_IRQ(pxa_internal_irq_nr); i++, irq += 32) {
-		_ICMR(irq) = saved_icmr[i];
-		_ICLR(irq) = 0;
+		__raw_writel(saved_icmr[i], base + ICMR);
+		__raw_writel(0, base + ICLR);
 	}
 
-	ICCR = 1;
+	if (!cpu_is_pxa25x())
+		for (i = 0; i < pxa_internal_irq_nr; i++)
+			__raw_writel(saved_ipr[i], IRQ_BASE + IPR(i));
+
+	__raw_writel(1, IRQ_BASE + ICCR);
 	return 0;
 }
 #else
-- 
1.5.6.5
