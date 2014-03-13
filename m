From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 13 Mar 2014 20:50:01 +0100
Subject: [PATCH 2/3] irqchip: sun4i: Simplify irq mapping
In-Reply-To: <1394740202-1952-1-git-send-email-hdegoede@redhat.com>
References: <1394740202-1952-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1394740202-1952-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we're using handle_fasteio_irq for all interrupts, we can get rid
of having 2 irq_chip structs by making sun4i_irq_ack a nop for all irqs
except irq 0.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/irqchip/irq-sun4i.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 0a71990..6a8c88d 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -45,6 +45,9 @@ static void sun4i_irq_ack(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
+	if (irq != 0)
+		return; /* Only IRQ 0 / the ENMI needs to be acked */
+
 	val = readl(sun4i_irq_base + SUN4I_IRQ_PENDING_REG(reg));
 	writel(val | (1 << irq_off),
 	       sun4i_irq_base + SUN4I_IRQ_PENDING_REG(reg));
@@ -74,24 +77,8 @@ static void sun4i_irq_unmask(struct irq_data *irqd)
 	       sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 }
 
-/*
- * Since sun4i and sun5i are single core SOCs there is no need to mask non
- * oneshot IRQs, to achieve this we use handle_fasteoi_irq with a dummy eoi.
- */
-static void sun4i_irq_dummy_eoi(struct irq_data *irqd)
-{
-}
-
 static struct irq_chip sun4i_irq_chip = {
 	.name		= "sun4i_irq",
-	.irq_eoi	= sun4i_irq_dummy_eoi,
-	.irq_mask	= sun4i_irq_mask,
-	.irq_unmask	= sun4i_irq_unmask,
-};
-
-/* IRQ 0 / the ENMI needs a late eoi call */
-static struct irq_chip sun4i_irq_chip_enmi = {
-	.name		= "sun4i_irq",
 	.irq_eoi	= sun4i_irq_ack,
 	.irq_mask	= sun4i_irq_mask,
 	.irq_unmask	= sun4i_irq_unmask,
@@ -101,13 +88,7 @@ static struct irq_chip sun4i_irq_chip_enmi = {
 static int sun4i_irq_map(struct irq_domain *d, unsigned int virq,
 			 irq_hw_number_t hw)
 {
-	if (hw == 0)
-		irq_set_chip_and_handler(virq, &sun4i_irq_chip_enmi,
-					 handle_fasteoi_irq);
-	else
-		irq_set_chip_and_handler(virq, &sun4i_irq_chip,
-					 handle_fasteoi_irq);
-
+	irq_set_chip_and_handler(virq, &sun4i_irq_chip, handle_fasteoi_irq);
 	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
 
 	return 0;
-- 
1.9.0
