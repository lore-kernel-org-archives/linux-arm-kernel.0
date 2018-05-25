From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 25 May 2018 10:49:31 +0100
Subject: [PATCH v4 25/26] irqchip/gic-v3: Provide NMI handlers
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1527241772-48007-26-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide irqchip handlers that are NMI safe for PPIs and SPIs.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 4be5996..fa23d12 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -34,6 +34,8 @@
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irqchip/irq-partition-percpu.h>
 
+#include <trace/events/irq.h>
+
 #include <asm/cputype.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
@@ -261,6 +263,48 @@ static inline bool gic_supports_nmi(void)
 	       && static_branch_likely(&have_non_secure_prio_view);
 }
 
+/*
+ * Chip flow handler for SPIs set as NMI
+ */
+static void handle_fasteoi_nmi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	unsigned int irq = irq_desc_get_irq(desc);
+	irqreturn_t res;
+
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+
+	trace_irq_handler_entry(irq, action);
+	res = action->handler(irq, action->dev_id);
+	trace_irq_handler_exit(irq, action, res);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+}
+
+/*
+ * Chip flow handler for PPIs set as NMI
+ */
+static void handle_percpu_devid_nmi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	unsigned int irq = irq_desc_get_irq(desc);
+	irqreturn_t res;
+
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+
+	trace_irq_handler_entry(irq, action);
+	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
+	trace_irq_handler_exit(irq, action, res);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+}
+
 static int gic_irq_set_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool val)
 {
-- 
1.9.1
