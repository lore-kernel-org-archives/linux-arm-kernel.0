From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 2 Sep 2016 15:08:01 +0200 (CEST)
Subject: [PATCH] generic: Add the exception case checking routine for
 ppi interrupt
In-Reply-To: <57C7EEE2.7080205@arm.com>
References: <1472530639-21616-1-git-send-email-majun258@huawei.com>
 <57C548D0.3090700@arm.com> <57C5617B.6080801@huawei.com>
 <57C568F8.20802@arm.com> <20160830112113.GE1223@leverpostej>
 <57C67ABE.908@huawei.com> <57C696DA.4090301@arm.com>
 <57C7E3B6.1040605@huawei.com> <57C7EEE2.7080205@arm.com>
Message-ID: <alpine.DEB.2.20.1609021436160.5647@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Sep 2016, Marc Zyngier wrote:
> On 01/09/16 09:15, majun (F) wrote:
> Well, this issue goes way beyond the hack you wanted to add to the
> generic code, and it should probably be addressed in the GIC code
> itself, as an implementation specific workaround. Without knowing the
> details of the erratum, it is difficult to think of that would be
> required. I can come up with something like this:
> 
> 	irqnr = gic_read_iar();
> 	if (unlikely(!is_enabled(irqnr))) {
> 		gic_write_eoir(irqnr);
> 		if (static_key_true(&supports_deactivate))
> 			gic_write_dir(irqnr);
> 		set_pending(irqnr);
> 		continue;
> 	}
> 
> Performance will suffer (an extra MMIO access on the fast path). If LPIs
> are also affected, then the ITS code also needs to be involved, and
> that's not going to be pretty either. This code will have to be enabled
> at runtime, and handled like other erratum we have in this code.

So that's certainly a required workaround at the gic level. Though I really
think that we should make handle_percpu_devid_irq robust against a spurious
interrupt.

>  void handle_percpu_devid_irq(unsigned int irq, struct irq_desc *desc)
>  {
> -	struct irq_chip *chip = irq_desc_get_chip(desc);
> -	struct irqaction *action = desc->action;
> -	void *dev_id = raw_cpu_ptr(action->percpu_dev_id);
> +	struct irq_chip *chip = NULL;
> +	struct irqaction *action;
> +	void *dev_id;
>  	irqreturn_t res;
>  
> +	action = desc->action;
> +
> +	/* Unexpected interrupt in some execption case
> +	 * we just send eoi to end this interrupt
> +	 */
> +	if (unlikely(!action)) {
> +		mask_irq(desc);

This is wrong. mask_irq() does not work for percpu interrupts. Aside of that
this completely lacks any debug information which tells us that there is
something wrong in the system. I'm going to apply the patch below for
robustness sake.

Thanks,

	tglx

8<----------------------
Subject: genirq: Robustify handle_percpu_devid_irq()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 02 Sep 2016 14:45:19 +0200

The percpu_devid handler is not robust against spurious interrupts. If a
spurious interrupt happens and no action is installed then the handler crashes
with a NULL pointer dereference.

Add a sanity check for this and log the wreckage once in dmesg.

Reported-by: Majun <majun258@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -756,7 +756,6 @@ void handle_percpu_devid_irq(struct irq_
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irqaction *action = desc->action;
-	void *dev_id = raw_cpu_ptr(action->percpu_dev_id);
 	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
 
@@ -765,9 +764,20 @@ void handle_percpu_devid_irq(struct irq_
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
 
-	trace_irq_handler_entry(irq, action);
-	res = action->handler(irq, dev_id);
-	trace_irq_handler_exit(irq, action, res);
+	if (likely(action)) {
+		trace_irq_handler_entry(irq, action);
+		res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
+		trace_irq_handler_exit(irq, action, res);
+	} else {
+		unsigned int cpu = smp_processor_id();
+		bool enabled = cpumask_test_cpu(cpu, desc->percpu_enabled);
+
+		if (enabled)
+			irq_percpu_disable(desc, cpu);
+
+		pr_err_once("Spurious%s percpu IRQ%u on CPU%u\n",
+			    enabled ? " and unmasked" : "", irq, cpu);
+	}
 
 	if (chip->irq_eoi)
 		chip->irq_eoi(&desc->irq_data);
