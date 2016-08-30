From: majun258@huawei.com (MaJun)
Date: Tue, 30 Aug 2016 12:17:19 +0800
Subject: [PATCH] generic: Add the exception case checking routine for ppi
 interrupt
Message-ID: <1472530639-21616-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

During system booting, if the interrupt which has no action registered
is triggered, it would cause system panic when try to access the
action member.

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 kernel/irq/chip.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8114d06..9a0e872 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -766,11 +766,23 @@ handle_percpu_irq(unsigned int irq, struct irq_desc *desc)
  */
 void handle_percpu_devid_irq(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irqaction *action = desc->action;
-	void *dev_id = raw_cpu_ptr(action->percpu_dev_id);
+	struct irq_chip *chip = NULL;
+	struct irqaction *action;
+	void *dev_id;
 	irqreturn_t res;
 
+	action = desc->action;
+
+	/* Unexpected interrupt in some execption case
+	 * we just send eoi to end this interrupt
+	 */
+	if (unlikely(!action)) {
+		mask_irq(desc);
+		goto out;
+	}
+	dev_id = raw_cpu_ptr(action->percpu_dev_id);
+
+	chip = irq_desc_get_chip(desc);
 	kstat_incr_irqs_this_cpu(irq, desc);
 
 	if (chip->irq_ack)
@@ -779,7 +791,7 @@ void handle_percpu_devid_irq(unsigned int irq, struct irq_desc *desc)
 	trace_irq_handler_entry(irq, action);
 	res = action->handler(irq, dev_id);
 	trace_irq_handler_exit(irq, action, res);
-
+out:
 	if (chip->irq_eoi)
 		chip->irq_eoi(&desc->irq_data);
 }
-- 
1.7.1
