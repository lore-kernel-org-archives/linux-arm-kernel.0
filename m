From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Oct 2015 15:23:51 +0200
Subject: [PATCH 1/5] kernel: irq: implement is_enabled_percpu_irq()
In-Reply-To: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1445347435-2333-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain interrupt controller drivers have a register set that does not
make it easy to save/restore the mask of enabled/disabled interrupts
at suspend/resume time. At resume time, such drivers rely on the core
kernel irq subsystem to tell whether such or such interrupt is enabled
or not, in order to restore the proper state in the interrupt
controller register.

While the irqd_irq_disabled() provides the relevant information for
global interrupts, there is no similar function to query the
enabled/disabled state of a per-CPU interrupt.

Therefore, this commit complements the
enable_percpu_irq/disable_percpu_irq API with an
is_enabled_percpu_irq() function.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 include/linux/interrupt.h |  1 +
 kernel/irq/chip.c         |  5 +++++
 kernel/irq/internals.h    |  1 +
 kernel/irq/manage.c       | 19 +++++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index be7e75c..5ea9be5 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -193,6 +193,7 @@ extern void disable_irq(unsigned int irq);
 extern void disable_percpu_irq(unsigned int irq);
 extern void enable_irq(unsigned int irq);
 extern void enable_percpu_irq(unsigned int irq, unsigned int type);
+extern bool is_enabled_percpu_irq(unsigned int irq);
 extern void irq_wake_thread(unsigned int irq, void *dev_id);
 
 /* The following three functions are for the core kernel use only. */
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index e28169d..ebc00fc 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -246,6 +246,11 @@ void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu)
 	cpumask_set_cpu(cpu, desc->percpu_enabled);
 }
 
+bool irq_percpu_is_enabled(struct irq_desc *desc, unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, desc->percpu_enabled);
+}
+
 void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu)
 {
 	if (desc->irq_data.chip->irq_disable)
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5ef0c2d..37de1c5 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -68,6 +68,7 @@ extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
+extern bool irq_percpu_is_enabled(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
 extern void mask_irq(struct irq_desc *desc);
 extern void unmask_irq(struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f9a59f6..d4afe65 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1666,6 +1666,25 @@ out:
 }
 EXPORT_SYMBOL_GPL(enable_percpu_irq);
 
+bool is_enabled_percpu_irq(unsigned int irq)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned long flags;
+	struct irq_desc *desc =
+		irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_PERCPU);
+	bool is_enabled;
+
+	if (!desc)
+		return false;
+
+	is_enabled = irq_percpu_is_enabled(desc, cpu);
+
+	irq_put_desc_unlock(desc, flags);
+
+	return is_enabled;
+}
+EXPORT_SYMBOL_GPL(is_enabled_percpu_irq);
+
 void disable_percpu_irq(unsigned int irq)
 {
 	unsigned int cpu = smp_processor_id();
-- 
2.6.2
