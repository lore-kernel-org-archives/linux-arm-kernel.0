From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 13 Mar 2014 20:50:00 +0100
Subject: [PATCH 1/3] irqchip: sun4i: Don't mask + unmask for the non oneshot
 case
In-Reply-To: <1394740202-1952-1-git-send-email-hdegoede@redhat.com>
References: <1394740202-1952-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1394740202-1952-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since sun4i and sun5i are single core SOCs there is no need to mask non
oneshot IRQs, to achieve this we use handle_fasteoi_irq with a dummy eoi.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/irqchip/irq-sun4i.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index a0ed1ea..0a71990 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -74,8 +74,17 @@ static void sun4i_irq_unmask(struct irq_data *irqd)
 	       sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 }
 
+/*
+ * Since sun4i and sun5i are single core SOCs there is no need to mask non
+ * oneshot IRQs, to achieve this we use handle_fasteoi_irq with a dummy eoi.
+ */
+static void sun4i_irq_dummy_eoi(struct irq_data *irqd)
+{
+}
+
 static struct irq_chip sun4i_irq_chip = {
 	.name		= "sun4i_irq",
+	.irq_eoi	= sun4i_irq_dummy_eoi,
 	.irq_mask	= sun4i_irq_mask,
 	.irq_unmask	= sun4i_irq_unmask,
 };
@@ -97,7 +106,7 @@ static int sun4i_irq_map(struct irq_domain *d, unsigned int virq,
 					 handle_fasteoi_irq);
 	else
 		irq_set_chip_and_handler(virq, &sun4i_irq_chip,
-					 handle_level_irq);
+					 handle_fasteoi_irq);
 
 	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
 
-- 
1.9.0
