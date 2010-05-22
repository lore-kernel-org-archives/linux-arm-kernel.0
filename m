From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 22 May 2010 12:22:08 +0800
Subject: [ARM] pxa: sanitize IRQ register access based on offset
Message-ID: <AANLkTinWgJhB42OcIpi_PCO2sCXvHRJvyqBkI4gReknK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 2772230d8a9e31f4a11e3dc6f78c78c1d5ad48b8
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Fri May 21 18:29:35 2010 +0800

    [ARM] pxa: sanitize IRQ register access based on offset

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 1beb40f..a9396a9 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -16,20 +16,36 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/sysdev.h>
+#include <linux/io.h>

 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <mach/gpio.h>
-#include <mach/regs-intc.h>

 #include "generic.h"

+#define IRQ_BASE	(void __iomem *)io_p2v(0x40d00000)
+
+#define ICIP		(0x000)
+#define ICMR		(0x004)
+#define ICLR		(0x008)
+#define ICFR		(0x00c)
+#define ICPR		(0x010)
+#define ICCR		(0x014)
+#define ICHP		(0x018)
+#define IPR(i)		(((i) < 32) ? (0x01c + ((i) << 2)) :		\
+			 ((i) < 64) ? (0x0b0 + (((i) - 32) << 2)) :	\
+				      (0x144 + (((i) - 64) << 2)))
+#define IPR_VALID	(1 << 31)
+
 #define MAX_INTERNAL_IRQS	128
+#define IRQ_BIT(n)		(((n) - PXA_IRQ(0)) & 0x1f)

-#define IRQ_BIT(n)	(((n) - PXA_IRQ(0)) & 0x1f)
-#define _ICMR(n)	(*((((n) - PXA_IRQ(0)) & ~0x1f) ? &ICMR2 : &ICMR))
-#define _ICLR(n)	(*((((n) - PXA_IRQ(0)) & ~0x1f) ? &ICLR2 : &ICLR))
+static inline int cpu_has_ipr(void)
+{
+	return cpu_is_pxa27x() || cpu_is_pxa3xx();
+}

 /*
  * This is for peripheral IRQs internal to the PXA chip.
@@ -39,12 +55,20 @@ static int pxa_internal_irq_nr;

 static void pxa_mask_irq(unsigned int irq)
 {
-	_ICMR(irq) &= ~(1 << IRQ_BIT(irq));
+	void __iomem *base = get_irq_chip_data(irq);
+	uint32_t icmr = __raw_readl(base + 4);
+
+	icmr &= ~(1 << IRQ_BIT(irq));
+	__raw_writel(icmr, base + ICMR);
 }

 static void pxa_unmask_irq(unsigned int irq)
 {
-	_ICMR(irq) |= 1 << IRQ_BIT(irq);
+	void __iomem *base = get_irq_chip_data(irq);
+	uint32_t icmr = __raw_readl(base + 4);
+
+	icmr |= 1 << IRQ_BIT(irq);
+	__raw_writel(icmr, base + ICMR);
 }

 static struct irq_chip pxa_internal_irq_chip = {
@@ -86,12 +110,16 @@ static void pxa_ack_low_gpio(unsigned int irq)

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
@@ -120,6 +148,17 @@ static void __init pxa_init_low_gpio_irq(set_wake_t fn)
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
 	int irq, i;
@@ -128,25 +167,28 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)

 	pxa_internal_irq_nr = irq_nr;

-	for (irq = PXA_IRQ(0); irq < PXA_IRQ(irq_nr); irq += 32) {
-		_ICMR(irq) = 0;	/* disable all IRQs */
-		_ICLR(irq) = 0;	/* all IRQs are IRQ, not FIQ */
+	for (i = 0; i < irq_nr; i += 32) {
+		void __iomem *base = irq_base(i);
+		int max_irq = min(i + 32, irq_nr);
+
+		__raw_writel(0, base + ICMR);	/* disable all IRQs */
+		__raw_writel(0, base + ICLR);	/* all IRQs are IRQ, not FIQ */
+
+		for (irq = PXA_IRQ(i); irq < PXA_IRQ(max_irq); irq++) {
+			set_irq_chip(irq, &pxa_internal_irq_chip);
+			set_irq_chip_data(irq, irq_base(irq));
+			set_irq_handler(irq, handle_level_irq);
+			set_irq_flags(irq, IRQF_VALID);
+		}
 	}

 	/* initialize interrupt priority */
-	if (cpu_is_pxa27x() || cpu_is_pxa3xx()) {
+	if (cpu_has_ipr())
 		for (i = 0; i < irq_nr; i++)
-			IPR(i) = i | (1 << 31);
-	}
+			__raw_writel(i | IPR_VALID, IRQ_BASE + IPR(i));

 	/* only unmasked interrupts kick us out of idle */
-	ICCR = 1;
-
-	for (irq = PXA_IRQ(0); irq < PXA_IRQ(irq_nr); irq++) {
-		set_irq_chip(irq, &pxa_internal_irq_chip);
-		set_irq_handler(irq, handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID);
-	}
+	__raw_writel(1, IRQ_BASE + ICCR);

 	pxa_internal_irq_chip.set_wake = fn;
 	pxa_init_low_gpio_irq(fn);
@@ -158,36 +200,37 @@ static unsigned long saved_ipr[MAX_INTERNAL_IRQS];

 static int pxa_irq_suspend(struct sys_device *dev, pm_message_t state)
 {
-	int i, irq = PXA_IRQ(0);
+	int i;

-	for (i = 0; irq < PXA_IRQ(pxa_internal_irq_nr); i++, irq += 32) {
-		saved_icmr[i] = _ICMR(irq);
-		_ICMR(irq) = 0;
-	}
+	for (i = 0; i < pxa_internal_irq_nr; i += 32) {
+		void __iomem *base = irq_base(i);

-	if (cpu_is_pxa27x() || cpu_is_pxa3xx()) {
-		for (i = 0; i < pxa_internal_irq_nr; i++)
-			saved_ipr[i] = IPR(i);
+		saved_icmr[i] = __raw_readl(base + ICMR);
+		__raw_writel(0, base + ICMR);
 	}

+	if (cpu_has_ipr())
+		for (i = 0; i < pxa_internal_irq_nr; i++)
+			saved_ipr[i] = __raw_readl(IRQ_BASE + IPR(i));
 	return 0;
 }

 static int pxa_irq_resume(struct sys_device *dev)
 {
-	int i, irq = PXA_IRQ(0);
+	int i;

-	if (cpu_is_pxa27x() || cpu_is_pxa3xx()) {
+	if (cpu_has_ipr())
 		for (i = 0; i < pxa_internal_irq_nr; i++)
-			IPR(i) = saved_ipr[i];
-	}
+			__raw_writel(saved_ipr[i], IRQ_BASE + IPR(i));
+
+	for (i = 0; i < pxa_internal_irq_nr; i += 32) {
+		void __iomem *base = irq_base(i);

-	for (i = 0; irq < PXA_IRQ(pxa_internal_irq_nr); i++, irq += 32) {
-		_ICMR(irq) = saved_icmr[i];
-		_ICLR(irq) = 0;
+		__raw_writel(saved_icmr[i], base + ICMR);
+		__raw_writel(0, base + ICLR);
 	}

-	ICCR = 1;
+	__raw_writel(1, IRQ_BASE + ICCR);
 	return 0;
 }
 #else
