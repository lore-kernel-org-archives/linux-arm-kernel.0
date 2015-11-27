From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Nov 2015 11:39:36 +0000
Subject: [RFC PATCH] irq: allow percpu_devid interrupts to be requested with
 target mask
Message-ID: <1448624376-15570-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On multi-cluster platforms, a per-cpu interrupt may actually be wired on
a per-cluster basis, meaning that different devices may have the same
interrupt number depending on the CPU.

This is problematic for drivers using the percpu_device interface as
there is currently no way to request an interrupt of this type for a
subset of CPUs. Furthermore, interrupt sharing is not permitted.

This patch adds the ability to provide a CPU mask to the percpu
interrupt request/free functions such that the interrupt is only enabled
on those CPUs set in the mask. Each irqaction has a copy of the mask to
allow the percpu_devid flow handler to dispatch to the correct driver
when an interrupt occurs. Whilst interrupt sharing is still forbidden
in the usual sense, multiple actions are permitted providing that their
target CPU masks do not intersect.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/interrupt.h | 37 +++++++++++++++++---
 kernel/irq/chip.c         | 56 ++++++++++++++++++++++++++----
 kernel/irq/internals.h    |  4 +--
 kernel/irq/manage.c       | 88 ++++++++++++++++++++++++++++++++---------------
 4 files changed, 144 insertions(+), 41 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ad16809c8596..0953a4ee19d1 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -97,6 +97,7 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
  * @name:	name of the device
  * @dev_id:	cookie to identify the device
  * @percpu_dev_id:	cookie to identify the device
+ * @active_cpus: mask of CPUs for which this percpu interrupt can fire
  * @next:	pointer to the next irqaction for shared interrupts
  * @irq:	interrupt number
  * @flags:	flags (see IRQF_* above)
@@ -111,6 +112,7 @@ struct irqaction {
 	irq_handler_t		handler;
 	void			*dev_id;
 	void __percpu		*percpu_dev_id;
+	cpumask_var_t		active_cpus;
 	struct irqaction	*next;
 	irq_handler_t		thread_fn;
 	struct task_struct	*thread;
@@ -142,11 +144,26 @@ request_any_context_irq(unsigned int irq, irq_handler_t handler,
 			unsigned long flags, const char *name, void *dev_id);
 
 extern int __must_check
+request_percpu_irq_mask(unsigned int irq, irq_handler_t handler,
+			const char *devname, void __percpu *percpu_dev_id,
+			const cpumask_t *mask);
+
+static inline int __must_check
 request_percpu_irq(unsigned int irq, irq_handler_t handler,
-		   const char *devname, void __percpu *percpu_dev_id);
+		   const char *devname, void __percpu *percpu_dev_id)
+{
+	return request_percpu_irq_mask(irq, handler, devname, percpu_dev_id,
+				       cpu_possible_mask);
+}
 
 extern void free_irq(unsigned int, void *);
-extern void free_percpu_irq(unsigned int, void __percpu *);
+extern void free_percpu_irq_mask(unsigned int, void __percpu *,
+				 const cpumask_t *);
+
+static inline void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
+{
+	free_percpu_irq_mask(irq, dev_id, cpu_possible_mask);
+}
 
 struct device;
 
@@ -192,9 +209,21 @@ extern void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id);
 extern void disable_irq_nosync(unsigned int irq);
 extern bool disable_hardirq(unsigned int irq);
 extern void disable_irq(unsigned int irq);
-extern void disable_percpu_irq(unsigned int irq);
+extern void disable_percpu_irq_mask(unsigned int irq, const cpumask_t *mask);
 extern void enable_irq(unsigned int irq);
-extern void enable_percpu_irq(unsigned int irq, unsigned int type);
+extern void enable_percpu_irq_mask(unsigned int irq, unsigned int type,
+				   const cpumask_t *mask);
+
+static inline void disable_percpu_irq(unsigned int irq)
+{
+	disable_percpu_irq_mask(irq, cpumask_of(smp_processor_id()));
+}
+
+static inline void enable_percpu_irq(unsigned int irq, unsigned int type)
+{
+	enable_percpu_irq_mask(irq, type, cpumask_of(smp_processor_id()));
+}
+
 extern void irq_wake_thread(unsigned int irq, void *dev_id);
 
 /* The following three functions are for the core kernel use only. */
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 15206453b12a..9db7818c9212 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -260,22 +260,50 @@ void irq_disable(struct irq_desc *desc)
 	}
 }
 
-void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu)
+static void __irq_percpu_enable(void *info)
 {
+	struct irq_desc *desc = (struct irq_desc *)info;
+
 	if (desc->irq_data.chip->irq_enable)
 		desc->irq_data.chip->irq_enable(&desc->irq_data);
 	else
 		desc->irq_data.chip->irq_unmask(&desc->irq_data);
-	cpumask_set_cpu(cpu, desc->percpu_enabled);
 }
 
-void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu)
+void irq_percpu_enable(struct irq_desc *desc, const cpumask_t *mask)
+{
+	unsigned int cpu = get_cpu();
+
+	if (cpumask_equal(mask, cpumask_of(cpu)))
+		__irq_percpu_enable(desc);
+	else
+		on_each_cpu_mask(mask, __irq_percpu_enable, desc, 1);
+
+	put_cpu();
+	cpumask_or(desc->percpu_enabled, desc->percpu_enabled, mask);
+}
+
+static void __irq_percpu_disable(void *info)
 {
+	struct irq_desc *desc = (struct irq_desc *)info;
+
 	if (desc->irq_data.chip->irq_disable)
 		desc->irq_data.chip->irq_disable(&desc->irq_data);
 	else
 		desc->irq_data.chip->irq_mask(&desc->irq_data);
-	cpumask_clear_cpu(cpu, desc->percpu_enabled);
+}
+
+void irq_percpu_disable(struct irq_desc *desc, const cpumask_t *mask)
+{
+	unsigned int cpu = get_cpu();
+
+	if (cpumask_equal(mask, cpumask_of(cpu)))
+		__irq_percpu_disable(desc);
+	else
+		on_each_cpu_mask(mask, __irq_percpu_disable, desc, 1);
+
+	put_cpu();
+	cpumask_andnot(desc->percpu_enabled, desc->percpu_enabled, mask);
 }
 
 static inline void mask_ack_irq(struct irq_desc *desc)
@@ -715,6 +743,7 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 	struct irqaction *action = desc->action;
 	void *dev_id = raw_cpu_ptr(action->percpu_dev_id);
 	unsigned int irq = irq_desc_get_irq(desc);
+	unsigned int cpu = smp_processor_id();
 	irqreturn_t res;
 
 	kstat_incr_irqs_this_cpu(desc);
@@ -722,9 +751,22 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
 
-	trace_irq_handler_entry(irq, action);
-	res = action->handler(irq, dev_id);
-	trace_irq_handler_exit(irq, action, res);
+	do {
+		if (cpumask_test_cpu(cpu, action->active_cpus)) {
+			trace_irq_handler_entry(irq, action);
+			res = action->handler(irq, dev_id);
+			trace_irq_handler_exit(irq, action, res);
+			break;
+		}
+
+		action = action->next;
+	} while (action);
+
+	if (!action) {
+		pr_warning("Per CPU IRQ %d fired without handler on CPU %d -- disabling.\n",
+			   irq, cpu);
+		disable_percpu_irq(irq);
+	}
 
 	if (chip->irq_eoi)
 		chip->irq_eoi(&desc->irq_data);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index fcab63c66905..85d5d673bb84 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -69,8 +69,8 @@ extern int irq_startup(struct irq_desc *desc, bool resend);
 extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
-extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
-extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
+extern void irq_percpu_enable(struct irq_desc *desc, const cpumask_t *mask);
+extern void irq_percpu_disable(struct irq_desc *desc, const cpumask_t *mask);
 extern void mask_irq(struct irq_desc *desc);
 extern void unmask_irq(struct irq_desc *desc);
 extern void unmask_threaded_irq(struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 0eebaeef317b..f6b51a21041d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1158,7 +1158,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		}
 	}
 
-	if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
 		ret = -ENOMEM;
 		goto out_thread;
 	}
@@ -1201,6 +1201,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 
 		/* add new interrupt at end of irq queue */
 		do {
+			if (irq_settings_is_per_cpu_devid(desc))
+				cpumask_or(mask, mask, old->active_cpus);
+
 			/*
 			 * Or all existing action->thread_mask bits,
 			 * so we can find the next zero bit for this
@@ -1210,6 +1213,11 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 			old_ptr = &old->next;
 			old = *old_ptr;
 		} while (old);
+
+		if (irq_settings_is_per_cpu_devid(desc) &&
+		    cpumask_intersects(mask, new->active_cpus))
+			goto mismatch;
+
 		shared = 1;
 	}
 
@@ -1716,9 +1724,9 @@ int request_any_context_irq(unsigned int irq, irq_handler_t handler,
 }
 EXPORT_SYMBOL_GPL(request_any_context_irq);
 
-void enable_percpu_irq(unsigned int irq, unsigned int type)
+void enable_percpu_irq_mask(unsigned int irq, unsigned int type,
+			    const cpumask_t *mask)
 {
-	unsigned int cpu = smp_processor_id();
 	unsigned long flags;
 	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_PERCPU);
 
@@ -1737,33 +1745,33 @@ void enable_percpu_irq(unsigned int irq, unsigned int type)
 		}
 	}
 
-	irq_percpu_enable(desc, cpu);
+	irq_percpu_enable(desc, mask);
 out:
 	irq_put_desc_unlock(desc, flags);
 }
-EXPORT_SYMBOL_GPL(enable_percpu_irq);
+EXPORT_SYMBOL_GPL(enable_percpu_irq_mask);
 
-void disable_percpu_irq(unsigned int irq)
+void disable_percpu_irq_mask(unsigned int irq, const cpumask_t *mask)
 {
-	unsigned int cpu = smp_processor_id();
 	unsigned long flags;
 	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_PERCPU);
 
 	if (!desc)
 		return;
 
-	irq_percpu_disable(desc, cpu);
+	irq_percpu_disable(desc, mask);
 	irq_put_desc_unlock(desc, flags);
 }
-EXPORT_SYMBOL_GPL(disable_percpu_irq);
+EXPORT_SYMBOL_GPL(disable_percpu_irq_mask);
 
 /*
  * Internal function to unregister a percpu irqaction.
  */
-static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_id)
+static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_id,
+					   const cpumask_t *mask)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-	struct irqaction *action;
+	struct irqaction *action, **action_ptr;
 	unsigned long flags;
 
 	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
@@ -1773,26 +1781,39 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 
-	action = desc->action;
-	if (!action || action->percpu_dev_id != dev_id) {
-		WARN(1, "Trying to free already-free IRQ %d\n", irq);
-		goto bad;
+	action_ptr = &desc->action;
+	for (;;) {
+		action = *action_ptr;
+
+		if (!action) {
+			WARN(1, "Trying to free already-free IRQ %d\n", irq);
+			goto bad;
+		}
+
+		if (action->percpu_dev_id == dev_id &&
+		    cpumask_equal(action->active_cpus, mask))
+			break;
+		action_ptr = &action->next;
 	}
 
-	if (!cpumask_empty(desc->percpu_enabled)) {
+	cpumask_and(action->active_cpus, action->active_cpus, desc->percpu_enabled);
+	if (!cpumask_empty(action->active_cpus)) {
 		WARN(1, "percpu IRQ %d still enabled on CPU%d!\n",
-		     irq, cpumask_first(desc->percpu_enabled));
+		     irq, cpumask_first(action->active_cpus));
 		goto bad;
 	}
 
 	/* Found it - now remove it from the list of entries: */
-	desc->action = NULL;
+	*action_ptr = action->next;
 
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	unregister_handler_proc(irq, action);
 
 	module_put(desc->owner);
+
+	free_cpumask_var(action->active_cpus);
+
 	return action;
 
 bad:
@@ -1812,13 +1833,14 @@ void remove_percpu_irq(unsigned int irq, struct irqaction *act)
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc && irq_settings_is_per_cpu_devid(desc))
-	    __free_percpu_irq(irq, act->percpu_dev_id);
+	    __free_percpu_irq(irq, act->percpu_dev_id, act->active_cpus);
 }
 
 /**
- *	free_percpu_irq - free an interrupt allocated with request_percpu_irq
+ *	free_percpu_irq_mask - free an interrupt allocated with request_percpu_irq
  *	@irq: Interrupt line to free
  *	@dev_id: Device identity to free
+ *	@mask: Mask identifying CPUs on which to free the interrupt
  *
  *	Remove a percpu interrupt handler. The handler is removed, but
  *	the interrupt line is not disabled. This must be done on each
@@ -1827,7 +1849,8 @@ void remove_percpu_irq(unsigned int irq, struct irqaction *act)
  *
  *	This function must not be called from interrupt context.
  */
-void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
+void free_percpu_irq_mask(unsigned int irq, void __percpu *dev_id,
+			  const cpumask_t *mask)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
@@ -1835,10 +1858,10 @@ void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
 		return;
 
 	chip_bus_lock(desc);
-	kfree(__free_percpu_irq(irq, dev_id));
+	kfree(__free_percpu_irq(irq, dev_id, mask));
 	chip_bus_sync_unlock(desc);
 }
-EXPORT_SYMBOL_GPL(free_percpu_irq);
+EXPORT_SYMBOL_GPL(free_percpu_irq_mask);
 
 /**
  *	setup_percpu_irq - setup a per-cpu interrupt
@@ -1862,11 +1885,12 @@ int setup_percpu_irq(unsigned int irq, struct irqaction *act)
 }
 
 /**
- *	request_percpu_irq - allocate a percpu interrupt line
+ *	request_percpu_irq_mask - allocate a percpu interrupt line
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs.
  *	@devname: An ascii name for the claiming device
  *	@dev_id: A percpu cookie passed back to the handler function
+ *	@mask: A mask identifying the CPUs which the interrupt can target
  *
  *	This call allocates interrupt resources and enables the
  *	interrupt on the local CPU. If the interrupt is supposed to be
@@ -1877,8 +1901,9 @@ int setup_percpu_irq(unsigned int irq, struct irqaction *act)
  *	the handler gets called with the interrupted CPU's instance of
  *	that variable.
  */
-int request_percpu_irq(unsigned int irq, irq_handler_t handler,
-		       const char *devname, void __percpu *dev_id)
+int request_percpu_irq_mask(unsigned int irq, irq_handler_t handler,
+			    const char *devname, void __percpu *dev_id,
+			    const cpumask_t *mask)
 {
 	struct irqaction *action;
 	struct irq_desc *desc;
@@ -1897,20 +1922,27 @@ int request_percpu_irq(unsigned int irq, irq_handler_t handler,
 		return -ENOMEM;
 
 	action->handler = handler;
-	action->flags = IRQF_PERCPU | IRQF_NO_SUSPEND;
+	action->flags = IRQF_PERCPU | IRQF_NO_SUSPEND | IRQF_SHARED;
 	action->name = devname;
 	action->percpu_dev_id = dev_id;
 
+	if (!alloc_cpumask_var(&action->active_cpus, GFP_KERNEL)) {
+		retval = -ENOMEM;
+		goto out_action;
+	}
+	cpumask_copy(action->active_cpus, mask);
+
 	chip_bus_lock(desc);
 	retval = __setup_irq(irq, desc, action);
 	chip_bus_sync_unlock(desc);
 
+out_action:
 	if (retval)
 		kfree(action);
 
 	return retval;
 }
-EXPORT_SYMBOL_GPL(request_percpu_irq);
+EXPORT_SYMBOL_GPL(request_percpu_irq_mask);
 
 /**
  *	irq_get_irqchip_state - returns the irqchip state of a interrupt.
-- 
2.1.4
