From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Mon, 26 Aug 2013 17:36:23 +0200
Subject: [PATCH 1/3] kernel,
 irq: Initial implementation of interrupt prioritization
 infrastructure.
In-Reply-To: <1377531385-19369-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1377531385-19369-1-git-send-email-tomasz.nowicki@linaro.org>
Message-ID: <1377531385-19369-2-git-send-email-tomasz.nowicki@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the interrupt controller allow to prioritize interrupts.
All of interrupts have equal priority so far. This commit add
infrastructure to manipulate interrupt signaling order which means
that some of them can take precedence over the others.

Initial implementation assume three priority level:
HIGH - interrupt which need to be served ASAP
DEFAULT - default interrupt priority
LOW - interrupt which doesn't care about response latency

Such generic priority levels approach require mapping to the architecture
specific value. It could be done using static allocated table like:

static unsigned int priority_map [SIZE] = {
	[IRQP_HIGH]	= 0x00,
	[IRQP_DEFAULT]	= 0xa0,
	[IRQP_LOW]	= 0xe0,
};
It allow us to be compatible in case of irqpriority_t (see include/linux/irqpriority.h)
further modification.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 include/linux/irq.h         |    3 +++
 include/linux/irqpriority.h |   24 ++++++++++++++++++++++++
 kernel/irq/chip.c           |    9 +++++++++
 kernel/irq/internals.h      |    1 +
 4 files changed, 37 insertions(+)
 create mode 100644 include/linux/irqpriority.h

diff --git a/include/linux/irq.h b/include/linux/irq.h
index f04d3ba..21d2776 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -17,6 +17,7 @@
 #include <linux/gfp.h>
 #include <linux/irqreturn.h>
 #include <linux/irqnr.h>
+#include <linux/irqpriority.h>
 #include <linux/errno.h>
 #include <linux/topology.h>
 #include <linux/wait.h>
@@ -289,6 +290,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_retrigger:	resend an IRQ to the CPU
  * @irq_set_type:	set the flow type (IRQ_TYPE_LEVEL/etc.) of an IRQ
  * @irq_set_wake:	enable/disable power-management wake-on of an IRQ
+ * @irq_set_priority:	set IRQ priority
  * @irq_bus_lock:	function to lock access to slow bus (i2c) chips
  * @irq_bus_sync_unlock:function to sync and unlock slow bus (i2c) chips
  * @irq_cpu_online:	configure an interrupt source for a secondary CPU
@@ -317,6 +319,7 @@ struct irq_chip {
 	int		(*irq_retrigger)(struct irq_data *data);
 	int		(*irq_set_type)(struct irq_data *data, unsigned int flow_type);
 	int		(*irq_set_wake)(struct irq_data *data, unsigned int on);
+	int		(*irq_set_priority)(struct irq_data *data, irqpriority_t priority);
 
 	void		(*irq_bus_lock)(struct irq_data *data);
 	void		(*irq_bus_sync_unlock)(struct irq_data *data);
diff --git a/include/linux/irqpriority.h b/include/linux/irqpriority.h
new file mode 100644
index 0000000..cf6bf8d
--- /dev/null
+++ b/include/linux/irqpriority.h
@@ -0,0 +1,24 @@
+#ifndef _LINUX_IRQPRIORITY_H
+#define _LINUX_IRQPRIORITY_H
+
+/**
+ * enum irqpriority
+ * @IRQP_HIGH		address to low response latency interrupt e.g. error
+ * 			signaling
+ * @IRQP_DEFAULT	default priority and set for all interrupt sources
+ * 			during interrupt controller initialization
+ * @IRQP_LOW		interrupt which doesn't really care about response
+ * 			latency
+ * @...			place for priority extension
+ */
+enum irqpriority {
+	IRQP_HIGH = 0,
+	IRQP_DEFAULT,
+	IRQP_LOW,
+
+	IRQP_LEVELS_NR
+};
+
+typedef enum irqpriority irqpriority_t;
+
+#endif /* _LINUX_IRQPRIORITY_H */
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index a3bb14f..74a3af8 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -14,6 +14,7 @@
 #include <linux/msi.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irqpriority.h>
 #include <linux/kernel_stat.h>
 
 #include <trace/events/irq.h>
@@ -281,6 +282,14 @@ void unmask_irq(struct irq_desc *desc)
 	}
 }
 
+int irq_set_priority(struct irq_desc *desc, irqpriority_t priority)
+{
+	if (!desc->irq_data.chip->irq_set_priority)
+		return -ENOSYS;
+
+	return desc->irq_data.chip->irq_set_priority(&desc->irq_data, priority);
+}
+
 /*
  *	handle_nested_irq - Handle a nested irq from a irq thread
  *	@irq:	the interrupt number
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 001fa5b..c264f5f 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -73,6 +73,7 @@ extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
 extern void mask_irq(struct irq_desc *desc);
 extern void unmask_irq(struct irq_desc *desc);
+extern int irq_set_priority(struct irq_desc *desc, irqpriority_t priority);
 
 extern void init_kstat_irqs(struct irq_desc *desc, int node, int nr);
 
-- 
1.7.9.5
