From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Oct 2015 11:04:43 +0200
Subject: [PATCH 05/13 v2] irqchip/gic: assign irqchip dynamically
Message-ID: <1445591083-22494-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of having the irqchip being a static struct, make it part
of the per-instance data so we can assign it a dynamic name. This
has the usable side effect of displaying the GIC with an instance
number as GIC0, GIC1 ... GICn in /proc/interrupts, which is helpful
when debugging cascaded GICs, such as on the ARM PB11MPCore.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Keep the static structs around, just delete the .name
  field assign them to the chips at registration time, updating
  the name field with the instance number.
- Also enumerate the EOIMODE1 sub-chips.

Marc: can't test the EOIMODE1 thing, it's far above me, but it
"should work". Is it correct that there is one unique and coupled
EOIMODE1 instance per GIC instance like this?
---
 drivers/irqchip/irq-gic.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index bd021e1e4847..8c93ff80ec52 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -58,6 +58,8 @@ union gic_base {
 };
 
 struct gic_chip_data {
+	struct irq_chip chip;
+	struct irq_chip eoimode1_chip;
 	union gic_base dist_base;
 	union gic_base cpu_base;
 #ifdef CONFIG_CPU_PM
@@ -370,7 +372,6 @@ static void gic_handle_cascade_irq(struct irq_desc *desc)
 }
 
 static struct irq_chip gic_chip = {
-	.name			= "GIC",
 	.irq_mask		= gic_mask_irq,
 	.irq_unmask		= gic_unmask_irq,
 	.irq_eoi		= gic_eoi_irq,
@@ -386,7 +387,6 @@ static struct irq_chip gic_chip = {
 };
 
 static struct irq_chip gic_eoimode1_chip = {
-	.name			= "GICv2",
 	.irq_mask		= gic_eoimode1_mask_irq,
 	.irq_unmask		= gic_unmask_irq,
 	.irq_eoi		= gic_eoimode1_eoi_irq,
@@ -880,11 +880,12 @@ void __init gic_init_physaddr(struct device_node *node)
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
-	struct irq_chip *chip = &gic_chip;
+	struct gic_chip_data *gic = d->host_data;
+	struct irq_chip *chip = &gic->chip;
 
 	if (static_key_true(&supports_deactivate)) {
 		if (d->host_data == (void *)&gic_data[0])
-			chip = &gic_eoimode1_chip;
+			chip = &gic->eoimode1_chip;
 	}
 
 	if (hw < 32) {
@@ -989,6 +990,13 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 	BUG_ON(gic_nr >= MAX_GIC_NR);
 
 	gic = &gic_data[gic_nr];
+
+	/* Initialize irq_chip */
+	gic->chip = gic_chip;
+	gic->eoimode1_chip = gic_eoimode1_chip;
+	gic->chip.name = kasprintf(GFP_KERNEL, "GIC%d", gic_nr);
+	gic->eoimode1_chip.name = kasprintf(GFP_KERNEL, "GICv2%d", gic_nr);
+
 #ifdef CONFIG_GIC_NON_BANKED
 	if (percpu_offset) { /* Frankein-GIC without banked registers... */
 		unsigned int cpu;
-- 
2.4.3
