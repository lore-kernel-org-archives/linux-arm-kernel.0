From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Nov 2013 14:48:13 +0100
Subject: [PATCH 3/7] ARM: sa1100: refer to hardware IRQs step 1
Message-ID: <1384264093-6291-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches the references from Linux IRQ numbers to hardware
IRQ numbers in the code driving the low GPIOs and the "normal"
interrupt lines on the SA1100.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/irq.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index ac032c84763c..bf36b9abfaad 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -17,6 +17,7 @@
 #include <linux/ioport.h>
 #include <linux/syscore_ops.h>
 #include <linux/irqdomain.h>
+#include <linux/bitops.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -76,25 +77,25 @@ static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
  */
 static void sa1100_low_gpio_ack(struct irq_data *d)
 {
-	GEDR = (1 << d->irq);
+	GEDR = BIT(d->hwirq);
 }
 
 static void sa1100_low_gpio_mask(struct irq_data *d)
 {
-	ICMR &= ~(1 << d->irq);
+	ICMR &= ~BIT(d->hwirq);
 }
 
 static void sa1100_low_gpio_unmask(struct irq_data *d)
 {
-	ICMR |= 1 << d->irq;
+	ICMR |= BIT(d->hwirq);
 }
 
 static int sa1100_low_gpio_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
-		PWER |= 1 << d->irq;
+		PWER |= BIT(d->hwirq);
 	else
-		PWER &= ~(1 << d->irq);
+		PWER &= ~BIT(d->hwirq);
 	return 0;
 }
 
@@ -176,12 +177,12 @@ static int sa1100_high_gpio_wake(struct irq_data *d, unsigned int on)
  */
 static void sa1100_mask_irq(struct irq_data *d)
 {
-	ICMR &= ~(1 << d->irq);
+	ICMR &= ~BIT(d->hwirq);
 }
 
 static void sa1100_unmask_irq(struct irq_data *d)
 {
-	ICMR |= (1 << d->irq);
+	ICMR |= BIT(d->hwirq);
 }
 
 /*
@@ -189,7 +190,7 @@ static void sa1100_unmask_irq(struct irq_data *d)
  */
 static int sa1100_set_wake(struct irq_data *d, unsigned int on)
 {
-	if (d->irq == IRQ_RTCAlrm) {
+	if (d->hwirq == IRQ_RTCAlrm) {
 		if (on)
 			PWER |= PWER_RTC;
 		else
@@ -246,11 +247,11 @@ asmlinkage void __exception_irq_entry sa1100_handle_irq(struct pt_regs *regs)
 {
 	struct sa1100_sc *sc = &sa1100_sc;
 	u32 status;
-	int irq;
+	int hwirq;
 
 	while ((status = (ICIP & ICMR))) {
-		irq = ffs(status) - 1;
-		handle_IRQ(irq_find_mapping(sc->domain, irq), regs);
+		hwirq = ffs(status) - 1;
+		handle_IRQ(irq_find_mapping(sc->domain, hwirq), regs);
 	}
 }
 
-- 
1.8.3.1
