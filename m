From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 15 Nov 2013 12:48:00 +0400
Subject: [PATCH 9/9] ARM: sa1100: refactor irq driver
In-Reply-To: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1384505280-25389-10-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Replace direct-mapped access with proper ioremap.
* Introduce irq domain for system controller irqs
* Merge "save" state to common newly create private data.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 111 +++++++++++++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index d96f65f..a26a6a2 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -14,26 +14,50 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/ioport.h>
 #include <linux/syscore_ops.h>
 
-#include <mach/hardware.h>
 #include <asm/exception.h>
 
 #include "generic.h"
 
+#define ICIP	0x00  /* IC IRQ Pending reg.             */
+#define ICMR	0x04  /* IC Mask Reg.                    */
+#define ICLR	0x08  /* IC Level Reg.                   */
+#define ICCR	0x0C  /* IC Control Reg.                 */
+#define ICFP	0x10  /* IC FIQ Pending reg.             */
+#define ICPR	0x20  /* IC Pending Reg.                 */
+
+struct sa1100_sc {
+	struct irq_domain *domain;
+	void __iomem *regbase;
+
+	unsigned int	saved_icmr;
+	unsigned int	saved_iclr;
+	unsigned int	saved_iccr;
+};
+
 /*
  * We don't need to ACK IRQs on the SA1100 unless they're GPIOs
  * this is for internal IRQs i.e. from 11 to 31.
  */
 static void sa1100_mask_irq(struct irq_data *d)
 {
-	ICMR &= ~(1 << d->irq);
+	struct sa1100_sc *sc = irq_data_get_irq_chip_data(d);
+	uint32_t icmr = readl_relaxed(sc->regbase + ICMR);
+
+	icmr &= ~BIT(d->hwirq);
+	writel_relaxed(icmr, sc->regbase + ICMR);
 }
 
 static void sa1100_unmask_irq(struct irq_data *d)
 {
-	ICMR |= (1 << d->irq);
+	struct sa1100_sc *sc = irq_data_get_irq_chip_data(d);
+	uint32_t icmr = readl_relaxed(sc->regbase + ICMR);
+
+	icmr |= BIT(d->hwirq);
+	writel_relaxed(icmr, sc->regbase + ICMR);
 }
 
 /*
@@ -41,7 +65,7 @@ static void sa1100_unmask_irq(struct irq_data *d)
  */
 static int sa1100_set_wake(struct irq_data *d, unsigned int on)
 {
-	return sa11x0_sc_set_wake(d->irq, on);
+	return sa11x0_sc_set_wake(d->hwirq, on);
 }
 
 static struct irq_chip sa1100_normal_chip = {
@@ -55,28 +79,37 @@ static struct irq_chip sa1100_normal_chip = {
 static struct resource irq_resource =
 	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
 
-static struct sa1100irq_state {
-	unsigned int	saved;
-	unsigned int	icmr;
-	unsigned int	iclr;
-	unsigned int	iccr;
-} sa1100irq_state;
+static int sa1100_irqdomain_map(struct irq_domain *d, unsigned int irq,
+		irq_hw_number_t hwirq)
+{
+	struct sa1100_sc *sc = d->host_data;
+
+	irq_set_chip_data(irq, sc);
+	irq_set_chip_and_handler(irq, &sa1100_normal_chip, handle_level_irq);
+	set_irq_flags(irq, IRQF_VALID);
+
+	return 0;
+}
+
+static struct irq_domain_ops sa1100_irqdomain_ops = {
+	.map = sa1100_irqdomain_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
+static struct sa1100_sc state;
 
 static int sa1100irq_suspend(void)
 {
-	struct sa1100irq_state *st = &sa1100irq_state;
+	struct sa1100_sc *sc = &state;
 
-	st->saved = 1;
-	st->icmr = ICMR;
-	st->iclr = ICLR;
-	st->iccr = ICCR;
+	sc->saved_icmr = readl_relaxed(sc->regbase + ICMR);
+	sc->saved_iclr = readl_relaxed(sc->regbase + ICLR);
+	sc->saved_iccr = readl_relaxed(sc->regbase + ICCR);
 
 	/*
 	 * Disable all GPIO-based interrupts.
 	 */
-	ICMR &= ~(IC_GPIO11_27|IC_GPIO10|IC_GPIO9|IC_GPIO8|IC_GPIO7|
-		  IC_GPIO6|IC_GPIO5|IC_GPIO4|IC_GPIO3|IC_GPIO2|
-		  IC_GPIO1|IC_GPIO0);
+	writel_relaxed(sc->saved_icmr & ~0xFFF, sc->regbase + ICMR);
 
 
 	return 0;
@@ -84,13 +117,11 @@ static int sa1100irq_suspend(void)
 
 static void sa1100irq_resume(void)
 {
-	struct sa1100irq_state *st = &sa1100irq_state;
+	struct sa1100_sc *sc = &state;
 
-	if (st->saved) {
-		ICCR = st->iccr;
-		ICLR = st->iclr;
-		ICMR = st->icmr;
-	}
+	writel_relaxed(sc->saved_iccr, sc->regbase + ICCR);
+	writel_relaxed(sc->saved_iclr, sc->regbase + ICLR);
+	writel_relaxed(sc->saved_icmr, sc->regbase + ICMR);
 }
 
 static struct syscore_ops sa1100irq_syscore_ops = {
@@ -110,42 +141,42 @@ static asmlinkage void __exception_irq_entry
 sa1100_handle_irq(struct pt_regs *regs)
 {
 	uint32_t icip, icmr, mask;
+	int irq;
 
-	do {
-		icip = (ICIP);
-		icmr = (ICMR);
+	while (1) {
+		icip = readl_relaxed(state.regbase + ICIP);
+		icmr = readl_relaxed(state.regbase + ICMR);
 		mask = icip & icmr;
 
 		if (mask == 0)
 			break;
 
-		handle_IRQ(fls(mask) - 1, regs);
-	} while (1);
+		irq = fls(mask) - 1;
+		handle_IRQ(irq_find_mapping(state.domain, irq), regs);
+	}
 }
 
 void __init sa1100_init_irq(void)
 {
-	unsigned int irq;
-
 	request_resource(&iomem_resource, &irq_resource);
 
+	state.regbase = ioremap(irq_resource.start,
+			resource_size(&irq_resource));
+
 	/* disable all IRQs */
-	ICMR = 0;
+	writel_relaxed(0, state.regbase + ICMR);
 
 	/* all IRQs are IRQ, not FIQ */
-	ICLR = 0;
+	writel_relaxed(0, state.regbase + ICLR);
 
 	/*
 	 * Whatever the doc says, this has to be set for the wait-on-irq
-	 * instruction to work... on a SA1100 rev 9 at least.
+	 * instruction to work... on a SA1100 rev 9 at leastate.
 	 */
-	ICCR = 1;
+	writel_relaxed(1, state.regbase + ICCR);
 
-	for (irq = 0; irq <= 31; irq++) {
-		irq_set_chip_and_handler(irq, &sa1100_normal_chip,
-					 handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID);
-	}
+	state.domain = irq_domain_add_legacy(NULL, 32, 0, 0,
+			&sa1100_irqdomain_ops, &state);
 
 	set_handle_irq(sa1100_handle_irq);
 }
-- 
1.8.4.2
