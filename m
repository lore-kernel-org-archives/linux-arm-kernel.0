From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 15 Nov 2014 14:53:50 +0300
Subject: [PATCH 4/6] ARM: sa1100: introduce irqdomains support
In-Reply-To: <1416052432-26192-1-git-send-email-dbaryshkov@gmail.com>
References: <1416052432-26192-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1416052432-26192-5-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use irqdomains to manage both system and GPIO interrupts on SA1100 SoC
family. This opens path to further cleanup and unification in sa1100 IRQ
drivers.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 78 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 9a3bdf1..dbf7615 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/ioport.h>
 #include <linux/syscore_ops.h>
 
@@ -106,6 +107,23 @@ static struct irq_chip sa1100_low_gpio_chip = {
 	.irq_set_wake	= sa1100_low_gpio_wake,
 };
 
+static int sa1100_low_gpio_irqdomain_map(struct irq_domain *d,
+		unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &sa1100_low_gpio_chip,
+				 handle_edge_irq);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+
+	return 0;
+}
+
+static struct irq_domain_ops sa1100_low_gpio_irqdomain_ops = {
+	.map = sa1100_low_gpio_irqdomain_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
+static struct irq_domain *sa1100_low_gpio_irqdomain;
+
 /*
  * IRQ11 (GPIO11 through 27) handler.  We enter here with the
  * irq_controller_lock held, and IRQs disabled.  Decode the IRQ
@@ -187,6 +205,23 @@ static struct irq_chip sa1100_high_gpio_chip = {
 	.irq_set_wake	= sa1100_high_gpio_wake,
 };
 
+static int sa1100_high_gpio_irqdomain_map(struct irq_domain *d,
+		unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &sa1100_high_gpio_chip,
+				 handle_edge_irq);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+
+	return 0;
+}
+
+static struct irq_domain_ops sa1100_high_gpio_irqdomain_ops = {
+	.map = sa1100_high_gpio_irqdomain_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
+static struct irq_domain *sa1100_high_gpio_irqdomain;
+
 /*
  * We don't need to ACK IRQs on the SA1100 unless they're GPIOs
  * this is for internal IRQs i.e. from 11 to 31.
@@ -224,6 +259,23 @@ static struct irq_chip sa1100_normal_chip = {
 	.irq_set_wake	= sa1100_set_wake,
 };
 
+static int sa1100_normal_irqdomain_map(struct irq_domain *d,
+		unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &sa1100_normal_chip,
+				 handle_level_irq);
+	set_irq_flags(irq, IRQF_VALID);
+
+	return 0;
+}
+
+static struct irq_domain_ops sa1100_normal_irqdomain_ops = {
+	.map = sa1100_normal_irqdomain_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
+static struct irq_domain *sa1100_normal_irqdomain;
+
 static struct resource irq_resource =
 	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
 
@@ -311,8 +363,6 @@ sa1100_handle_irq(struct pt_regs *regs)
 
 void __init sa1100_init_irq(void)
 {
-	unsigned int irq;
-
 	request_resource(&iomem_resource, &irq_resource);
 
 	/* disable all IRQs */
@@ -332,23 +382,17 @@ void __init sa1100_init_irq(void)
 	 */
 	ICCR = 1;
 
-	for (irq = 0; irq <= 10; irq++) {
-		irq_set_chip_and_handler(irq, &sa1100_low_gpio_chip,
-					 handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
+	sa1100_low_gpio_irqdomain = irq_domain_add_legacy(NULL,
+			11, 0, 0,
+			&sa1100_low_gpio_irqdomain_ops, NULL);
 
-	for (irq = 12; irq <= 31; irq++) {
-		irq_set_chip_and_handler(irq, &sa1100_normal_chip,
-					 handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID);
-	}
+	sa1100_normal_irqdomain = irq_domain_add_legacy(NULL,
+			20, 12, 12,
+			&sa1100_normal_irqdomain_ops, NULL);
 
-	for (irq = 32; irq <= 48; irq++) {
-		irq_set_chip_and_handler(irq, &sa1100_high_gpio_chip,
-					 handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
+	sa1100_high_gpio_irqdomain = irq_domain_add_legacy(NULL,
+			17, 32, 11,
+			&sa1100_high_gpio_irqdomain_ops, NULL);
 
 	/*
 	 * Install handler for GPIO 11-27 edge detect interrupts
-- 
2.1.1
