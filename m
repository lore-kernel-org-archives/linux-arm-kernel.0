From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 4 Nov 2015 12:15:59 -0800
Subject: [PATCH v2 1/2] genirq: Add irq_pm_(get|put) callbacks to the irqchip
In-Reply-To: <1446668160-17522-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1446668160-17522-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1446668160-17522-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two new IRQ chip callbacks for power management purposes. These
callbacks are supposed to bring the HW into a state that allows it to
generate interrupts. The callbacks are called in request_irq and
free_irq, respectively, from normal context.

Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v2:
 - report errors up the callchain
 - add error handling (needed some refactoring of the existing error
   handling in request_threaded_irq)
---
 include/linux/irq.h    |  4 ++++
 kernel/irq/internals.h | 14 ++++++++++++++
 kernel/irq/manage.c    | 20 ++++++++++++++++----
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3c1c96786248..279f6b7118c8 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -341,6 +341,8 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_get_irqchip_state:	return the internal state of an interrupt
  * @irq_set_irqchip_state:	set the internal state of a interrupt
  * @irq_set_vcpu_affinity:	optional to target a vCPU in a virtual machine
+ * @irq_pm_get:	optional to bring the HW in a state that enables IRQ generation
+ * @irq_pm_put:	undo any effects of @irq_pm_get
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -384,6 +386,8 @@ struct irq_chip {
 	int		(*irq_set_irqchip_state)(struct irq_data *data, enum irqchip_irq_state which, bool state);
 
 	int		(*irq_set_vcpu_affinity)(struct irq_data *data, void *vcpu_info);
+	int		(*irq_pm_get)(struct irq_data *data);
+	void		(*irq_pm_put)(struct irq_data *data);
 
 	unsigned long	flags;
 };
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 05c2188271b8..8a5842431d6c 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -112,6 +112,20 @@ extern void irq_set_thread_affinity(struct irq_desc *desc);
 extern int irq_do_set_affinity(struct irq_data *data,
 			       const struct cpumask *dest, bool force);
 
+static inline int chip_pm_get(struct irq_desc *desc)
+{
+	if (unlikely(desc->irq_data.chip->irq_pm_get))
+		return desc->irq_data.chip->irq_pm_get(&desc->irq_data);
+
+	return 0;
+}
+
+static inline void chip_pm_put(struct irq_desc *desc)
+{
+	if (unlikely(desc->irq_data.chip->irq_pm_put))
+		desc->irq_data.chip->irq_pm_put(&desc->irq_data);
+}
+
 /* Inline functions for support of irq chips on slow busses */
 static inline void chip_bus_lock(struct irq_desc *desc)
 {
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 0eebaeef317b..0f6dee35afaa 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1556,6 +1556,7 @@ void free_irq(unsigned int irq, void *dev_id)
 	chip_bus_lock(desc);
 	kfree(__free_irq(irq, dev_id));
 	chip_bus_sync_unlock(desc);
+	chip_pm_put(desc);
 }
 EXPORT_SYMBOL(free_irq);
 
@@ -1647,14 +1648,16 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 	action->name = devname;
 	action->dev_id = dev_id;
 
+	retval = chip_pm_get(desc);
+	if (retval < 0)
+		goto err_pm_get;
+
 	chip_bus_lock(desc);
 	retval = __setup_irq(irq, desc, action);
 	chip_bus_sync_unlock(desc);
 
-	if (retval) {
-		kfree(action->secondary);
-		kfree(action);
-	}
+	if (retval)
+		goto err_setup_irq;
 
 #ifdef CONFIG_DEBUG_SHIRQ_FIXME
 	if (!retval && (irqflags & IRQF_SHARED)) {
@@ -1675,6 +1678,15 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 		enable_irq(irq);
 	}
 #endif
+
+	return 0;
+
+err_setup_irq:
+	chip_pm_put(desc);
+err_pm_get:
+	kfree(action->secondary);
+	kfree(action);
+
 	return retval;
 }
 EXPORT_SYMBOL(request_threaded_irq);
-- 
2.6.2.3.ga463a5b
