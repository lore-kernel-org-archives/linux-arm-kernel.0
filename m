From: yangyingliang@huawei.com (Yang Yingliang)
Date: Sun, 6 Sep 2015 12:23:38 +0800
Subject: [RFC PATCH v1 1/4] genirq: Introduce irq_settings_set_move_pcntxt()
 helper
In-Reply-To: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
References: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1441513421-8092-2-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's expected to use the helper when interrupt can be moved
in process.

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 include/linux/irq.h   |  1 +
 kernel/irq/irqdesc.c  | 12 ++++++++++++
 kernel/irq/settings.h |  5 +++++
 3 files changed, 18 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 6f8b340..f4ecfb9 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -514,6 +514,7 @@ static inline void irq_set_chip_and_handler(unsigned int irq, struct irq_chip *c
 }
 
 extern int irq_set_percpu_devid(unsigned int irq);
+extern int irq_set_move_pcntxt(unsigned int irq);
 
 extern void
 __irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 0a2a4b6..c036a1a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -580,6 +580,18 @@ int irq_set_percpu_devid(unsigned int irq)
 	return 0;
 }
 
+int irq_set_move_pcntxt(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (!desc)
+		return -EINVAL;
+
+	irq_settings_set_move_pcntxt(desc);
+
+	return 0;
+}
+
 void kstat_incr_irq_this_cpu(unsigned int irq)
 {
 	kstat_incr_irqs_this_cpu(irq_to_desc(irq));
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 3320b84..ea58bc2 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -135,6 +135,11 @@ static inline void irq_settings_set_noprobe(struct irq_desc *desc)
 	desc->status_use_accessors |= _IRQ_NOPROBE;
 }
 
+static inline void irq_settings_set_move_pcntxt(struct irq_desc *desc)
+{
+	desc->status_use_accessors |= _IRQ_MOVE_PCNTXT;
+}
+
 static inline bool irq_settings_can_move_pcntxt(struct irq_desc *desc)
 {
 	return desc->status_use_accessors & _IRQ_MOVE_PCNTXT;
-- 
2.5.0
