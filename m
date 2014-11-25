From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 25 Nov 2014 22:09:49 +0300
Subject: [PATCH v2 5/8] ARM: sa1100: introduce irqdomains support
In-Reply-To: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
References: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1416942592-23059-6-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use irqdomains to manage both system and GPIO interrupts on SA1100 SoC
family. This opens path to further cleanup and unification in sa1100 IRQ
drivers.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/Kconfig           |  1 +
 arch/arm/mach-sa1100/irq.c | 78 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f3f132..622e364 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -702,6 +702,7 @@ config ARCH_SA1100
 	select CPU_SA1100
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
+	select IRQ_DOMAIN
 	select ISA
 	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 0b29d27..2d8be03 100644
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
  * this is for internal IRQs i.e. from IRQ LCD to RTCAlrm.
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
 
-	for (irq = IRQ_GPIO0; irq <= IRQ_GPIO10; irq++) {
-		irq_set_chip_and_handler(irq, &sa1100_low_gpio_chip,
-					 handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
+	sa1100_low_gpio_irqdomain = irq_domain_add_legacy(NULL,
+			11, IRQ_GPIO0, 0,
+			&sa1100_low_gpio_irqdomain_ops, NULL);
 
-	for (irq = IRQ_LCD; irq <= IRQ_RTCAlrm; irq++) {
-		irq_set_chip_and_handler(irq, &sa1100_normal_chip,
-					 handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID);
-	}
+	sa1100_normal_irqdomain = irq_domain_add_legacy(NULL,
+			20, IRQ_LCD, 12,
+			&sa1100_normal_irqdomain_ops, NULL);
 
-	for (irq = IRQ_GPIO11; irq <= IRQ_GPIO27; irq++) {
-		irq_set_chip_and_handler(irq, &sa1100_high_gpio_chip,
-					 handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
+	sa1100_high_gpio_irqdomain = irq_domain_add_legacy(NULL,
+			17, IRQ_GPIO11, 11,
+			&sa1100_high_gpio_irqdomain_ops, NULL);
 
 	/*
 	 * Install handler for GPIO 11-27 edge detect interrupts
-- 
2.1.3
