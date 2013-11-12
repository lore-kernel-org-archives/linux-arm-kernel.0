From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Nov 2013 14:48:05 +0100
Subject: [PATCH 2/7] ARM: sa1100: use an irqdomain for the high GPIO IRQs
Message-ID: <1384264085-6249-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the remaining high GPIO IRQs over to be mapped
using a legacy IRQ domain.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/irq.c | 47 +++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 15fd8a580391..ac032c84763c 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -170,15 +170,6 @@ static int sa1100_high_gpio_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
-static struct irq_chip sa1100_high_gpio_chip = {
-	.name		= "GPIO-h",
-	.irq_ack	= sa1100_high_gpio_ack,
-	.irq_mask	= sa1100_high_gpio_mask,
-	.irq_unmask	= sa1100_high_gpio_unmask,
-	.irq_set_type	= sa1100_gpio_type,
-	.irq_set_wake	= sa1100_high_gpio_wake,
-};
-
 /*
  * We don't need to ACK IRQs on the SA1100 unless they're GPIOs
  * this is for internal IRQs i.e. from 11 to 31.
@@ -213,11 +204,16 @@ static int sa1100_set_wake(struct irq_data *d, unsigned int on)
  * @domain: irqdomain used to map the irqs for these chips
  * @low_gpio_chip: irqchip to handle hardware IRQs 0-10
  * @normal_chip: irqchip to handle hardware IRQs 12-31
+ * @high_domain: irqdomain for the high GPIO IRQs
+ * @high_gpio_chip: irqchip handling the cascaded IRQs off
+ * IRQ 11 on the normal chip.
  */
 struct sa1100_sc {
 	struct irq_domain *domain;
 	struct irq_chip low_gpio_chip;
 	struct irq_chip normal_chip;
+	struct irq_domain *high_domain;
+	struct irq_chip high_gpio_chip;
 };
 
 static struct sa1100_sc sa1100_sc = {
@@ -236,6 +232,14 @@ static struct sa1100_sc sa1100_sc = {
 		.irq_unmask	= sa1100_unmask_irq,
 		.irq_set_wake	= sa1100_set_wake,
 	},
+	.high_gpio_chip = {
+		.name		= "GPIO-h",
+		.irq_ack	= sa1100_high_gpio_ack,
+		.irq_mask	= sa1100_high_gpio_mask,
+		.irq_unmask	= sa1100_high_gpio_unmask,
+		.irq_set_type	= sa1100_gpio_type,
+		.irq_set_wake	= sa1100_high_gpio_wake,
+	},
 };
 
 asmlinkage void __exception_irq_entry sa1100_handle_irq(struct pt_regs *regs)
@@ -266,6 +270,7 @@ static int sa1100_sc_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	if (hwirq >= 12 && hwirq <= 31)
 		irq_set_chip_and_handler(irq, &sc->normal_chip,
 					 handle_level_irq);
+
 	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	return 0;
 }
@@ -275,6 +280,22 @@ static struct irq_domain_ops sa1100_sc_irqdomain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
+static int sa1100_sc_high_irqdomain_map(struct irq_domain *d, unsigned int irq,
+					irq_hw_number_t hwirq)
+{
+	struct sa1100_sc *sc = d->host_data;
+
+	irq_set_chip_data(irq, sc);
+	irq_set_chip_and_handler(irq, &sc->high_gpio_chip,
+				 handle_edge_irq);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	return 0;
+}
+
+static struct irq_domain_ops sa1100_sc_high_irqdomain_ops = {
+	.map = sa1100_sc_high_irqdomain_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
 
 static struct resource irq_resource =
 	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
@@ -346,7 +367,6 @@ device_initcall(sa1100irq_init_devicefs);
 
 void __init sa1100_init_irq(void)
 {
-	unsigned int irq;
 	struct sa1100_sc *sc = &sa1100_sc;
 
 	request_resource(&iomem_resource, &irq_resource);
@@ -371,10 +391,7 @@ void __init sa1100_init_irq(void)
 	/* Register IRQs 0-31 using a legacy irqdomain */
 	sc->domain = irq_domain_add_legacy(NULL, 32, 0, 0,
 					   &sa1100_sc_irqdomain_ops, sc);
-	for (irq = 32; irq <= 48; irq++) {
-		irq_set_chip_and_handler(irq, &sa1100_high_gpio_chip,
-					 handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
+	sc->high_domain = irq_domain_add_legacy(NULL, 17, 32, 0,
+					   &sa1100_sc_high_irqdomain_ops, sc);
 	sa1100_init_gpio();
 }
-- 
1.8.3.1
