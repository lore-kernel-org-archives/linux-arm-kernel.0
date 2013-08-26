From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Mon, 26 Aug 2013 17:36:25 +0200
Subject: [PATCH 3/3] irq,
 gic: Add interrupt priority to the GIC driver using already existing
 infrastructure.
In-Reply-To: <1377531385-19369-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1377531385-19369-1-git-send-email-tomasz.nowicki@linaro.org>
Message-ID: <1377531385-19369-4-git-send-email-tomasz.nowicki@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Couple of notes:
o new handler has been added irq_set_priority
o this could be an example of how to map generic priority level to
  architecture priority value (see comments in code)

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/irqchip/irq-gic.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 13b2849..97e919f 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -37,6 +37,7 @@
 #include <linux/of_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/interrupt.h>
+#include <linux/irqpriority.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/irqchip/chained_irq.h>
@@ -93,6 +94,19 @@ struct irq_chip gic_arch_extn = {
 	.irq_set_wake	= NULL,
 };
 
+/*
+ * Map generic interrupt priority levels (irqpriority_t) to GIC_DIST_PRI
+ * register value. Value should be mapped using table index assignment:
+ * [priority level] = <vale for GIC_DIST_PRI> which allow us to be compatible
+ * in case of irqpriority_t (see include/linux/irqpriority.h) further
+ * modification.
+ */
+static unsigned int priority_map [IRQP_LEVELS_NR] = {
+	[IRQP_HIGH]	= 0x00,
+	[IRQP_DEFAULT]	= 0xa0,
+	[IRQP_LOW]	= 0xe0,
+};
+
 #ifndef MAX_GIC_NR
 #define MAX_GIC_NR	1
 #endif
@@ -332,12 +346,30 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+int gic_set_priority(struct irq_data *data, irqpriority_t priority)
+{
+	unsigned int hw_irq = gic_irq(data);
+	u32 cur_priority;
+
+	if (hw_irq < 32)
+		return -EINVAL;
+
+	raw_spin_lock(&irq_controller_lock);
+	cur_priority = readl_relaxed(gic_dist_base(data) + GIC_DIST_PRI + (hw_irq / 4) * 4);
+	cur_priority &= ~(0xff << (hw_irq % 4));
+	cur_priority |= priority_map[priority] << (hw_irq % 4);
+	writel_relaxed(cur_priority, gic_dist_base(data) + GIC_DIST_PRI + (hw_irq / 4) * 4);
+	raw_spin_unlock(&irq_controller_lock);
+	return 0;
+}
+
 static struct irq_chip gic_chip = {
 	.name			= "GIC",
 	.irq_mask		= gic_mask_irq,
 	.irq_unmask		= gic_unmask_irq,
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
+	.irq_set_priority	= gic_set_priority,
 	.irq_retrigger		= gic_retrigger,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= gic_set_affinity,
-- 
1.7.9.5
