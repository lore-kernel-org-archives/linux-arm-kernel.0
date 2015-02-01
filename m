From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun,  1 Feb 2015 19:20:16 +0100
Subject: [PATCH v2] ARM: pxa: fix pxa interrupts handling in DT
In-Reply-To: <1422743783-32511-1-git-send-email-robert.jarzmik@free.fr>
References: <1422743783-32511-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1422814816-23887-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit "ARM: pxa: arbitrarily set first interrupt number" changed
the first pxa interrupt to 16.

As a consequence, device-tree builds got broken, because :
 - pxa_mask_irq() and pxa_unmask_irq() are using IRQ_BIT()
 - IRQ_BIT(x) calculates the interrupts as : x - PXA_IRQ(0)

Before the commit, the first interrupt shift, PXA_IRQ(0) was 0,
therefore IRQ_BIT(x) was x. After the change, it is necessary that the
same shift of 16 is applied between the virtual interrupt number and the
hardware irq number.

This situation comes from the common irq_chip shared between legacy
platform builds and device-tree builds.

Fix the broken interrupts in DT case by adding this shift in the DT case
too.

As a consequence of the IRQ_BIT() is removed alltogether from interrupts
handling, even in the platform data types of platforms :
 - a legacy irq domain is used
 - the irq_chip handles hardware interrupts
 - the virtual to hardware interrupt conversion is fully handled by irq
   domain mechanics

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: add irq domain to legacy platforms (not DT) irq handling
---
 arch/arm/mach-pxa/irq.c | 111 +++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 0eecd83..9c14365 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -11,6 +11,7 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
+#include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -40,7 +41,6 @@
 #define ICHP_VAL_IRQ		(1 << 31)
 #define ICHP_IRQ(i)		(((i) >> 16) & 0x7fff)
 #define IPR_VALID		(1 << 31)
-#define IRQ_BIT(n)		(((n) - PXA_IRQ(0)) & 0x1f)
 
 #define MAX_INTERNAL_IRQS	128
 
@@ -51,6 +51,7 @@
 static void __iomem *pxa_irq_base;
 static int pxa_internal_irq_nr;
 static bool cpu_has_ipr;
+static struct irq_domain *pxa_irq_domain;
 
 static inline void __iomem *irq_base(int i)
 {
@@ -66,18 +67,20 @@ static inline void __iomem *irq_base(int i)
 void pxa_mask_irq(struct irq_data *d)
 {
 	void __iomem *base = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t irq = irqd_to_hwirq(d);
 	uint32_t icmr = __raw_readl(base + ICMR);
 
-	icmr &= ~(1 << IRQ_BIT(d->irq));
+	icmr &= ~BIT(irq);
 	__raw_writel(icmr, base + ICMR);
 }
 
 void pxa_unmask_irq(struct irq_data *d)
 {
 	void __iomem *base = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t irq = irqd_to_hwirq(d);
 	uint32_t icmr = __raw_readl(base + ICMR);
 
-	icmr |= 1 << IRQ_BIT(d->irq);
+	icmr |= BIT(irq);
 	__raw_writel(icmr, base + ICMR);
 }
 
@@ -118,40 +121,63 @@ asmlinkage void __exception_irq_entry ichp_handle_irq(struct pt_regs *regs)
 	} while (1);
 }
 
-void __init pxa_init_irq(int irq_nr, int (*fn)(struct irq_data *, unsigned int))
+static int pxa_irq_map(struct irq_domain *h, unsigned int virq,
+		       irq_hw_number_t hw)
 {
-	int irq, i, n;
+	void __iomem *base = irq_base(hw / 32);
 
-	BUG_ON(irq_nr > MAX_INTERNAL_IRQS);
+	/* initialize interrupt priority */
+	if (cpu_has_ipr)
+		__raw_writel(hw | IPR_VALID, pxa_irq_base + IPR(hw));
+
+	irq_set_chip_and_handler(virq, &pxa_internal_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(virq, base);
+	set_irq_flags(virq, IRQF_VALID);
+
+	return 0;
+}
+
+static struct irq_domain_ops pxa_irq_ops = {
+	.map    = pxa_irq_map,
+	.xlate  = irq_domain_xlate_onecell,
+};
+
+static __init void
+pxa_init_irq_common(struct device_node *node, int irq_nr,
+		    int (*fn)(struct irq_data *, unsigned int))
+{
+	int n;
 
 	pxa_internal_irq_nr = irq_nr;
-	cpu_has_ipr = !cpu_is_pxa25x();
-	pxa_irq_base = io_p2v(0x40d00000);
+	pxa_irq_domain = irq_domain_add_legacy(node, irq_nr,
+					       PXA_IRQ(0), 0,
+					       &pxa_irq_ops, NULL);
+	if (!pxa_irq_domain)
+		panic("Unable to add PXA IRQ domain\n");
+	irq_set_default_host(pxa_irq_domain);
 
 	for (n = 0; n < irq_nr; n += 32) {
 		void __iomem *base = irq_base(n >> 5);
 
 		__raw_writel(0, base + ICMR);	/* disable all IRQs */
 		__raw_writel(0, base + ICLR);	/* all IRQs are IRQ, not FIQ */
-		for (i = n; (i < (n + 32)) && (i < irq_nr); i++) {
-			/* initialize interrupt priority */
-			if (cpu_has_ipr)
-				__raw_writel(i | IPR_VALID, pxa_irq_base + IPR(i));
-
-			irq = PXA_IRQ(i);
-			irq_set_chip_and_handler(irq, &pxa_internal_irq_chip,
-						 handle_level_irq);
-			irq_set_chip_data(irq, base);
-			set_irq_flags(irq, IRQF_VALID);
-		}
 	}
-
 	/* only unmasked interrupts kick us out of idle */
 	__raw_writel(1, irq_base(0) + ICCR);
 
 	pxa_internal_irq_chip.irq_set_wake = fn;
 }
 
+void __init pxa_init_irq(int irq_nr, int (*fn)(struct irq_data *, unsigned int))
+{
+	BUG_ON(irq_nr > MAX_INTERNAL_IRQS);
+
+	pxa_irq_base = io_p2v(0x40d00000);
+	cpu_has_ipr = !cpu_is_pxa25x();
+	pxa_init_irq_common(NULL, irq_nr, fn);
+}
+
 #ifdef CONFIG_PM
 static unsigned long saved_icmr[MAX_INTERNAL_IRQS/32];
 static unsigned long saved_ipr[MAX_INTERNAL_IRQS];
@@ -203,30 +229,6 @@ struct syscore_ops pxa_irq_syscore_ops = {
 };
 
 #ifdef CONFIG_OF
-static struct irq_domain *pxa_irq_domain;
-
-static int pxa_irq_map(struct irq_domain *h, unsigned int virq,
-		       irq_hw_number_t hw)
-{
-	void __iomem *base = irq_base(hw / 32);
-
-	/* initialize interrupt priority */
-	if (cpu_has_ipr)
-		__raw_writel(hw | IPR_VALID, pxa_irq_base + IPR(hw));
-
-	irq_set_chip_and_handler(hw, &pxa_internal_irq_chip,
-				 handle_level_irq);
-	irq_set_chip_data(hw, base);
-	set_irq_flags(hw, IRQF_VALID);
-
-	return 0;
-}
-
-static struct irq_domain_ops pxa_irq_ops = {
-	.map    = pxa_irq_map,
-	.xlate  = irq_domain_xlate_onecell,
-};
-
 static const struct of_device_id intc_ids[] __initconst = {
 	{ .compatible = "marvell,pxa-intc", },
 	{}
@@ -236,7 +238,7 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
 {
 	struct device_node *node;
 	struct resource res;
-	int n, ret;
+	int ret;
 
 	node = of_find_matching_node(NULL, intc_ids);
 	if (!node) {
@@ -267,23 +269,6 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
 		return;
 	}
 
-	pxa_irq_domain = irq_domain_add_legacy(node, pxa_internal_irq_nr, 0, 0,
-					       &pxa_irq_ops, NULL);
-	if (!pxa_irq_domain)
-		panic("Unable to add PXA IRQ domain\n");
-
-	irq_set_default_host(pxa_irq_domain);
-
-	for (n = 0; n < pxa_internal_irq_nr; n += 32) {
-		void __iomem *base = irq_base(n >> 5);
-
-		__raw_writel(0, base + ICMR);	/* disable all IRQs */
-		__raw_writel(0, base + ICLR);	/* all IRQs are IRQ, not FIQ */
-	}
-
-	/* only unmasked interrupts kick us out of idle */
-	__raw_writel(1, irq_base(0) + ICCR);
-
-	pxa_internal_irq_chip.irq_set_wake = fn;
+	pxa_init_irq_common(node, pxa_internal_irq_nr, fn);
 }
 #endif /* CONFIG_OF */
-- 
2.1.0
