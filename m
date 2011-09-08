From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 8 Sep 2011 20:05:41 +0200 (CEST)
Subject: [PATCH v11 0/4] Consolidating GIC per-cpu interrupts
In-Reply-To: <4E68E961.8050309@arm.com>
References: <1312883802-15022-1-git-send-email-marc.zyngier@arm.com>
	<20110815121312.GF26827@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1109081339120.2723@ionos>
	<4E68E961.8050309@arm.com>
Message-ID: <alpine.LFD.2.02.1109081855590.2723@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Thu, 8 Sep 2011, Marc Zyngier wrote:
> Thomas,
> 
> On 08/09/11 14:14, Thomas Gleixner wrote:
> 
> > Another thing, which sticks out compared to other percpu interrupt
> > users in arch/* is that you provide the ability to assign different
> > handlers on different CPUs to a given PPI interrupt number. Most other
> > percpu implementations setup the interrupt with a unique percpu aware
> > handler and just enable/disable it per core in the low level
> > setup/shutdown code. Is running different handlers on different cores
> > a real requirement or just a nice feature with no usecase?
> 
> At the moment, it sort of falls into the second category. MSM has
> "asymmetric" timers (each core has its private timer on a different
> PPI), but that doesn't mandate having separate handlers per core, unless
> someone decides to connect something on another CPU, using the same
> PPI... The architecture would probably allow it.

The question is whether we really want to allow it from the OS
side. That makes irq accounting an utter mess as you end up with
devA,B,C,D on the same interrupt line and each counts on the
corresponding CPU0,1,2,3

> But a clear requirement we have is that the handler has to be called
> with a per-cpu dev_id pointer (we use this to obtain the
> clock_event_device in the timer handler, for example). Which makes
> having something similar to request_irq() quite the natural thing.

That makes a lot of sense, but it requires your extra percpu handler
registration/free interface ....

Looking at the other PERCPU irq users there might be a general
interest for this.

If we can apply the following set of (sane) restricitions to this:

   - interrupt is never shared
   - interrupt is never threaded
   - handler is common for all CPUs

then we could do something like the patch below. Warning, this is
incomplete and requires a bunch of other changes like adding per cpu
aware enable/disable functions and excluding the other interfaces from
fiddling with such an interrupt.

So a request/setup_irq() of such an interrupt would require the
following steps.

  irq_set_percpu_devid(irq);

    This would set: IRQ_NOAUTOEN | IRQ_PER_CPU | IRQ_NOPROBE | IRQ_PER_CPU_DEVID
    and 

  irq_set_handler(irq, handle_irq_per_cpu_devid);

  setup/request_percpu_irq(irq, .....);

    The dev_id pointer for those interrupts would be a percpu pointer
    which holds the real dev_ids, e.g. the percpu clockevents

Due to the restricted nature of those interrupts we probably can
ignore nested disable/enable_percpu_irq() calls and just keep the
*_percpu_irq API to a bare minimum.

Thoughts ?

Thanks,

	tglx

Index: linux-2.6/include/linux/interrupt.h
===================================================================
--- linux-2.6.orig/include/linux/interrupt.h
+++ linux-2.6/include/linux/interrupt.h
@@ -95,6 +97,7 @@ typedef irqreturn_t (*irq_handler_t)(int
  * @flags:	flags (see IRQF_* above)
  * @name:	name of the device
  * @dev_id:	cookie to identify the device
+ * @percpu_dev_id:	cookie to identify the device
  * @next:	pointer to the next irqaction for shared interrupts
  * @irq:	interrupt number
  * @dir:	pointer to the proc/irq/NN/name entry
@@ -104,17 +107,20 @@ typedef irqreturn_t (*irq_handler_t)(int
  * @thread_mask:	bitmask for keeping track of @thread activity
  */
 struct irqaction {
-	irq_handler_t handler;
-	unsigned long flags;
-	void *dev_id;
-	struct irqaction *next;
-	int irq;
-	irq_handler_t thread_fn;
-	struct task_struct *thread;
-	unsigned long thread_flags;
-	unsigned long thread_mask;
-	const char *name;
-	struct proc_dir_entry *dir;
+	irq_handler_t		handler;
+	unsigned long		flags;
+	union {
+		void		*dev_id;
+		void __percpu	*percpu_dev_id;
+	};
+	struct irqaction	*next;
+	int			irq;
+	irq_handler_t		thread_fn;
+	struct task_struct	*thread;
+	unsigned long		thread_flags;
+	unsigned long		thread_mask;
+	const char		*name;
+	struct proc_dir_entry	*dir;
 } ____cacheline_internodealigned_in_smp;
 
 extern irqreturn_t no_action(int cpl, void *dev_id);
Index: linux-2.6/kernel/irq/chip.c
===================================================================
--- linux-2.6.orig/kernel/irq/chip.c
+++ linux-2.6/kernel/irq/chip.c
@@ -544,6 +544,37 @@ handle_percpu_irq(unsigned int irq, stru
 		chip->irq_eoi(&desc->irq_data);
 }
 
+/**
+ * handle_percpu_devid_irq - Per CPU local irq handler with per cpu dev ids
+ * @irq:	the interrupt number
+ * @desc:	the interrupt description structure for this irq
+ *
+ * Per CPU interrupts on SMP machines without locking requirements. Same as
+ * handle_percpu_irq() above but with the following extras:
+ *
+ * action->dev_id is a pointer to percpu variables which contain the
+ * real device id for the cpu on which this handler is called
+ */
+void handle_percpu_devid_irq(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	void *dev_id = __this_cpu_ptr(action->percpu_dev_id);
+	irqreturn_t res;
+
+	kstat_incr_irqs_this_cpu(irq, desc);
+
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+
+	trace_irq_handler_entry(irq, action);
+	res = action->handler(irq, dev_id);
+	trace_irq_handler_exit(irq, action, res);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+}
+
 void
 __irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
 		  const char *name)
