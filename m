From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed,  9 Nov 2011 10:47:23 +0800
Subject: [PATCH v7 03/11] ARM: pxa: use chained interrupt for GPIO0 and GPIO1
In-Reply-To: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1320806851-13928-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO0 and GPIO1 are linked to unique interrupt line in PXA series,
others are linked to another interrupt line. All GPIO are linked to one
interrupt line in MMP series.

Since gpio driver is shared between PXA series and MMP series, define
GPIO0 and GPIO1 as chained interrupt chip. So we can move out gpio code
from irq.c to gpio-pxa.c.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-pxa/include/mach/gpio.h |   15 +--------
 arch/arm/mach-pxa/include/mach/irqs.h |    4 +--
 arch/arm/mach-pxa/irq.c               |   58 ---------------------------------
 drivers/gpio/gpio-pxa.c               |   14 ++++++++
 4 files changed, 16 insertions(+), 75 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
index 07fa3ba..13b9039 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -29,20 +29,7 @@
 #include "gpio-pxa.h"
 
 #define gpio_to_irq(gpio)	PXA_GPIO_TO_IRQ(gpio)
-
-static inline int irq_to_gpio(unsigned int irq)
-{
-	int gpio;
-
-	if (irq == IRQ_GPIO0 || irq == IRQ_GPIO1)
-		return irq - IRQ_GPIO0;
-
-	gpio = irq - PXA_GPIO_IRQ_BASE;
-	if (gpio >= 2 && gpio < NR_BUILTIN_GPIO)
-		return gpio;
-
-	return -1;
-}
+#define irq_to_gpio(irq)	(irq - PXA_GPIO_TO_IRQ(0))
 
 #include <plat/gpio.h>
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 1f99664..b83d8ff 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -89,9 +89,7 @@
 
 #define PXA_GPIO_IRQ_BASE	PXA_IRQ(96)
 #define PXA_GPIO_IRQ_NUM	(192)
-
-#define GPIO_2_x_TO_IRQ(x)	(PXA_GPIO_IRQ_BASE + (x))
-#define PXA_GPIO_TO_IRQ(x)	(((x) < 2) ? (IRQ_GPIO0 + (x)) : GPIO_2_x_TO_IRQ(x))
+#define PXA_GPIO_TO_IRQ(x)	(PXA_GPIO_IRQ_BASE + (x))
 
 /*
  * The following interrupts are for board specific purposes. Since
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 532c5d3..36c538f 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -92,44 +92,6 @@ static struct irq_chip pxa_internal_irq_chip = {
 	.irq_unmask	= pxa_unmask_irq,
 };
 
-/*
- * GPIO IRQs for GPIO 0 and 1
- */
-static int pxa_set_low_gpio_type(struct irq_data *d, unsigned int type)
-{
-	int gpio = d->irq - IRQ_GPIO0;
-
-	if (__gpio_is_occupied(gpio)) {
-		pr_err("%s failed: GPIO is configured\n", __func__);
-		return -EINVAL;
-	}
-
-	if (type & IRQ_TYPE_EDGE_RISING)
-		GRER0 |= GPIO_bit(gpio);
-	else
-		GRER0 &= ~GPIO_bit(gpio);
-
-	if (type & IRQ_TYPE_EDGE_FALLING)
-		GFER0 |= GPIO_bit(gpio);
-	else
-		GFER0 &= ~GPIO_bit(gpio);
-
-	return 0;
-}
-
-static void pxa_ack_low_gpio(struct irq_data *d)
-{
-	GEDR0 = (1 << (d->irq - IRQ_GPIO0));
-}
-
-static struct irq_chip pxa_low_gpio_chip = {
-	.name		= "GPIO-l",
-	.irq_ack	= pxa_ack_low_gpio,
-	.irq_mask	= pxa_mask_irq,
-	.irq_unmask	= pxa_unmask_irq,
-	.irq_set_type	= pxa_set_low_gpio_type,
-};
-
 asmlinkage void __exception_irq_entry icip_handle_irq(struct pt_regs *regs)
 {
 	uint32_t icip, icmr, mask;
@@ -160,25 +122,6 @@ asmlinkage void __exception_irq_entry ichp_handle_irq(struct pt_regs *regs)
 	} while (1);
 }
 
-static void __init pxa_init_low_gpio_irq(set_wake_t fn)
-{
-	int irq;
-
-	/* clear edge detection on GPIO 0 and 1 */
-	GFER0 &= ~0x3;
-	GRER0 &= ~0x3;
-	GEDR0 = 0x3;
-
-	for (irq = IRQ_GPIO0; irq <= IRQ_GPIO1; irq++) {
-		irq_set_chip_and_handler(irq, &pxa_low_gpio_chip,
-					 handle_edge_irq);
-		irq_set_chip_data(irq, irq_base(0));
-		set_irq_flags(irq, IRQF_VALID);
-	}
-
-	pxa_low_gpio_chip.irq_set_wake = fn;
-}
-
 void __init pxa_init_irq(int irq_nr, set_wake_t fn)
 {
 	int irq, i, n;
@@ -209,7 +152,6 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)
 	__raw_writel(1, irq_base(0) + ICCR);
 
 	pxa_internal_irq_chip.irq_set_wake = fn;
-	pxa_init_low_gpio_irq(fn);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index ee13771..a4121bb 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -283,6 +283,20 @@ void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
 		__raw_writel(~0,c->regbase + GEDR_OFFSET);
 	}
 
+#ifdef CONFIG_ARCH_PXA
+	irq = gpio_to_irq(0);
+	irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
+				 handle_edge_irq);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	irq_set_chained_handler(IRQ_GPIO0, pxa_gpio_demux_handler);
+
+	irq = gpio_to_irq(1);
+	irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
+				 handle_edge_irq);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	irq_set_chained_handler(IRQ_GPIO1, pxa_gpio_demux_handler);
+#endif
+
 	for (irq  = gpio_to_irq(start); irq <= gpio_to_irq(end); irq++) {
 		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
 					 handle_edge_irq);
-- 
1.7.4.1
